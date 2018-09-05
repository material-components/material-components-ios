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

struct Hunk {
  let beforeRange: Range<Int>
  let afterRange: Range<Int>
  let contents: [String]
}

/**
 Returns a pair of dictionaries of filenames to lists of hunks from a given diff format.

 First dictionary are the "before" files.
 Second dictionary are the "after" files.

 // Before and after may match if no files were moved added or deleted.
 */
func hunksFromDiff(_ diffString: String) -> (before: [String: [Hunk]], after: [String: [Hunk]]) {
  var beforeHunks: [String: [Hunk]] = [:]
  var afterHunks: [String: [Hunk]] = [:]

  var currentBeforeFile: String? = nil
  var currentAfterFile: String? = nil
  var currentBeforeRange: Range<Int>? = nil
  var currentAfterRange: Range<Int>? = nil
  var contents: [String] = []
  let commitHunkIfPossible = {
    guard let beforeFile = currentBeforeFile,
        let afterFile = currentAfterFile,
        let beforeRange = currentBeforeRange,
        let afterRange = currentAfterRange else {
      return
    }

    let hunk = Hunk(beforeRange: beforeRange, afterRange: afterRange, contents: contents)
    beforeHunks[beforeFile, default: []].append(hunk)
    afterHunks[afterFile, default: []].append(hunk)

    currentBeforeRange = nil
    currentAfterRange = nil
    contents.removeAll()
  }

  diffString.enumerateLines { line, _ in
    // Extract file
    // Example:
    // --- a/components/AppBar/src/MDCAppBarContainerViewController.m
    if let fileParts = line.split(around: "diff --git a/").1 {
      commitHunkIfPossible()

      currentBeforeFile = fileParts.split(around: " ").0
      currentAfterFile = fileParts.split(around: " b/").1
      return
    }

    if currentBeforeFile == nil || currentAfterFile == nil {
      return // Nothing to do until we find a file.
    }

    // Extract hunk line ranges
    // Examples:
    // @@ -19 +18,0 @@
    // @@ -20,0 +20 @@
    // @@ -31,3 +31 @@
    if let lineNumberInfo = line.split(around: "@@ -").1 {
      commitHunkIfPossible()

      let parts = lineNumberInfo.split(separator: " ")
      currentBeforeRange = rangeFromHunkString(String(parts[0]))
      currentAfterRange = rangeFromHunkString(String(parts[1]))
      return
    }

    // Extract contents
    if currentBeforeRange != nil && currentAfterRange != nil {
      contents.append(line)
    }
  }

  // Commit the trailing hunk
  commitHunkIfPossible()

  return (before: beforeHunks, after: afterHunks)
}

private func rangeFromHunkString(_ hunkString: String) -> Range<Int>? {
  let parts = hunkString.split(separator: ",")
  if parts.count == 1,
    let lineNumber = Int(parts[0]) {
    return Range(uncheckedBounds: (lineNumber, lineNumber + 1))

  } else if parts.count == 2,
    let lineNumber = Int(parts[0]),
    let numberOfLines = Int(parts[1]) {
    return Range(uncheckedBounds: (lineNumber, lineNumber + max(1, numberOfLines)))
  }
  return nil
}
