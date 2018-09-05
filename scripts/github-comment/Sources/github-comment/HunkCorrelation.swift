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

/**
 Returns a GitHub pull request comment "position" for a given hunk in a given list of hunks.

 Context:
 One might hope you could post comments to GitHub pull requests given a file and line range.
 Alas, GitHub instead requires that you post comments to the pull request diff's hunks.
 For example, if a pull request made changes to lines 20-50 on file A, and you want to post a
 comment to line 25 of that file, you need to post a comment to "6" (line 20 is line "1" of the
 hunk).

 From the docs: https://developer.github.com/v3/pulls/comments/#create-a-comment
 > The position value equals the number of lines down from the first "@@" hunk header in the
 > file you want to add a comment. The line just below the "@@" line is position 1, the next
 > line is position 2, and so on. The position in the diff continues to increase through lines
 > of whitespace and additional hunks until the beginning of a new file.
 */
func githubPosition(for hunk: Hunk, in hunks: [Hunk]) -> Int? {
  // Our hunk ranges line up like so:
  // hunks.beforeRange = original code
  // hunks.afterRange  = pull request changes
  // hunk.beforeRange  = pull request changes
  // hunk.afterRange   = after suggested changes
  guard let index = hunks.index(where: { $0.afterRange.overlaps(hunk.beforeRange) }) else {
    return nil
  }

  // Position is counted by number of lines in the hunk content, so we start by counting the number
  // of lines in all of the preceeding hunks.
  let numberOfPrecedingHunkLines = hunks[0..<index].map { $0.contents.count }.reduce(0, +)
  // Each hunk's header (including the current one) has as an implicit line
  let numberOfHunksHeaders = index + 1

  // The position should be the last line of code we intend to change in the index'd hunk.
  // First, count how many lines our hunk intends to change:
  let linesChanged = hunk.contents.index(where: { !$0.starts(with: "-") }) ?? hunk.contents.count
  let lastLineChanged = hunk.beforeRange.lowerBound + linesChanged

  // We now know the line number. Now we need to calculate the position.
  var numberOfLinesToCount = lastLineChanged - hunks[index].afterRange.lowerBound
  for (hunkPosition, line) in hunks[index].contents.enumerated() {
    if line.hasPrefix("-") { // Ignore removed lines
      continue
    }
    numberOfLinesToCount = numberOfLinesToCount - 1
    if numberOfLinesToCount == 0 {
      return numberOfPrecedingHunkLines + numberOfHunksHeaders + hunkPosition
    }
  }
  return nil
}
