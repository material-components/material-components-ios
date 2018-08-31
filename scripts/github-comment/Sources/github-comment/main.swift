/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import Utility

// MARK: Argument parsing

// The first argument is always the executable, drop it
let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())

let parser = ArgumentParser(usage: "<options>",
                            overview: "A tool for managing comments on GitHub pull requests.")

let repoArgument = parser.add(option: "--repo", kind: String.self, usage:
  "[required]. The GitHub repository to synchronize with")
let githubTokenArgument = parser.add(option: "--github_token", kind: String.self, usage:
  "[required]. The token that should be used to issue GitHub API requests.")
let prNumberArgument = parser.add(option: "--pull_request_number", kind: Int.self, usage:
  "[required]. The pull request to which comments should be posted.")
let identifierArgument = parser.add(option: "--identifier", kind: String.self, usage:
  "[required]. An identifier that will be used to identify the comment.")

// Single comment feedback
let bodyArgument = parser.add(option: "--comment_body", kind: PathArgument.self, usage:
  "[optional]. A path to a file containing the body of the comment.")
let deleteArgument = parser.add(option: "--delete", kind: Bool.self, usage:
  "[optional]. Will delete the comment.")

// Line-based feedback
let diffArgument = parser.add(option: "--diff", kind: PathArgument.self, usage:
  "[optional]. A diff that will be used to post line comments.")
let commitArgument = parser.add(option: "--commit", kind: String.self, usage:
  "[optional]. A commit that will be used to post line comments.")

let parsedArguments: ArgumentParser.Result
do {
  parsedArguments = try parser.parse(arguments)
} catch let error as ArgumentParserError {
  print(error.description)
  exit(1)
}
catch let error {
  print(error.localizedDescription)
  exit(1)
}

guard let repo = parsedArguments.get(repoArgument) else {
  print("--repo is required")
  exit(1)
}
guard let githubToken = parsedArguments.get(githubTokenArgument) else {
  print("--github_token is required")
  exit(1)
}
guard let prNumber = parsedArguments.get(prNumberArgument) else {
  print("--pull_request_number is required")
  exit(1)
}
guard let identifier = parsedArguments.get(identifierArgument) else {
  print("--identifier is required")
  exit(1)
}
let bodyFilename = parsedArguments.get(bodyArgument)
let shouldDelete = parsedArguments.get(deleteArgument) ?? false
let diffFilename = parsedArguments.get(diffArgument)
let commit = parsedArguments.get(commitArgument)

let commentIdentifier = "<!-- identifier: \(identifier) -->"

// MARK: Load the comment body

let github = GitHub(token: githubToken)

var user: GitHub.User? = github.get(from: "user")

guard let user = user, let userId = user.id else {
  print("Failed to get authenticated user.")
  exit(1)
}

func getCommentBody() throws -> String? {
  if let bodyFilename = bodyFilename {
    return try String(contentsOf: URL(fileURLWithPath: bodyFilename.path.asString))
  }
  return nil
}

func getDiff() throws -> String? {
  if let diffFilename = diffFilename {
    return try String(contentsOf: URL(fileURLWithPath: diffFilename.path.asString))
  }
  return nil
}

if let diffFilename = diffFilename {
  guard let body = try getCommentBody() else {
    print("A comment body is required when posting comments.")
    exit(1)
  }

  guard let commit = commit else {
    print("A commit is required when posting comments.")
    exit(1)
  }

  guard let diff = try getDiff() else {
    print("No diff could be loaded from \(diffFilename).")
    exit(1)
  }

  guard let pullRequestDiff = github.get(from: "repos/\(repo)/pulls/\(prNumber)",
      additionalHeaders: ["Accept": "application/vnd.github.v3.diff"]) else {
    print("Unable to fetch diff for pull request.")
    exit(1)
  }

  // First build a set of comments that have already been posted.
  var existingComments = Set<String>()
  print("Building set of existing comments...")
  github.getAll(startingFrom: "repos/\(repo)/pulls/\(prNumber)/comments") { jsonResult in
    guard let json = jsonResult as? GitHub.CommentList.JsonFormat else {
      return false // Halt execution
    }
    let list = GitHub.CommentList(json: json)
    guard let comments = list.comments else {
      return false
    }
    for comment in comments {
      guard let body = comment.body else {
        continue
      }
      existingComments.insert(body)
    }
    return true
  }

  print("Parsing pull request diff...")
  let pullRequestHunks = hunksFromDiff(pullRequestDiff).after
  print("Parsing desired diff...")
  let diffHunks = hunksFromDiff(diff).before

  print("Intersecting hunks...")
  for (file, suggestedHunks) in diffHunks {
    guard let fileHunks = pullRequestHunks[file] else {
      continue // This file doesn't exist in the PR. Ignore it.
    }

    for suggestedHunk in suggestedHunks {
      guard let position = githubPosition(for: suggestedHunk, in: fileHunks) else {
        continue // Unable to find this hunk in the pull request diff.
      }
      let desiredBody = """
\(body)

```
\(suggestedHunk.contents.joined(separator: "\n"))
```

\(commentIdentifier)
<!-- File: \(file) -->
"""
      if existingComments.contains(desiredBody) {
        print("Already posted comment, skipping...")
        continue // Don't repost this comment.
      }
      print("Posting comment...")
      github.post(to: "repos/\(repo)/pulls/\(prNumber)/comments", json: [
        "body": desiredBody,
        "commit_id": commit,
        "path": file,
        "position": position
      ])
    }
  }

} else {
  var existingComment: GitHub.Comment? = nil
  github.getAll(startingFrom: "repos/\(repo)/issues/\(prNumber)/comments") { jsonResult in
    guard let json = jsonResult as? GitHub.CommentList.JsonFormat else {
      return false // Halt execution
    }
    let list = GitHub.CommentList(json: json)
    guard let comments = list.comments else {
      return false
    }
    for comment in comments {
      guard let body = comment.body else {
        continue
      }
      if comment.user?.id == user.id && body.contains(commentIdentifier) {
        existingComment = comment
        return false // Stop enumerating the comments
      }
    }
    return true
  }

  if shouldDelete {
    if let existingCommentId = existingComment?.id {
      print("Deleting existing comment...")
      github.delete(at: "repos/\(repo)/issues/comments/\(existingCommentId)")
    }

  } else if let body = try getCommentBody() {
    if let existingCommentId = existingComment?.id {
      let desiredBody = body + "\n" + commentIdentifier

      if existingComment?.body == desiredBody {
        print("Nothing to do, comment matches desired body.")

      } else {
        print("Updating existing comment...")
        github.patch(to: "repos/\(repo)/issues/comments/\(existingCommentId)", json: [
          "body": desiredBody
        ])
      }

    } else {
      print("Creating new comment...")
      github.post(to: "repos/\(repo)/issues/\(prNumber)/comments", json: [
        "body": body + "\n" + commentIdentifier
      ])
    }
  }
}
