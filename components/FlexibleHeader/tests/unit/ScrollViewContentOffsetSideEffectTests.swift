/*
Copyright 2016-present Google Inc. All Rights Reserved.

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

import XCTest
import MaterialComponents

// Tests verifying contentOffset side effect behavior when changing contentInset.
class ScrollViewContentOffsetSideEffectTests: XCTestCase {

  let bounds = CGRect(x: 0, y: 0, width: 320, height: 20)
  let inset = CGFloat(6)

  let initialOffset = CGPoint(x: 0, y: 0)

  // Calculates the estimated contentOffset given the proposed new contentInsets and current value
  // of contentOffset + contentSize.
  class func estimatedContentOffsetForScrollView(scrollView: UIScrollView, withNewInsets newInsets: UIEdgeInsets) -> CGPoint {
    let minimumPossibleYOffset = -newInsets.top
    let maximumPossibleYOffset = (scrollView.contentSize.height + newInsets.bottom) - scrollView.bounds.height
    let estimatedYOffset = max(minimumPossibleYOffset, min(maximumPossibleYOffset, scrollView.contentOffset.y))

    let minimumPossibleXOffset = -newInsets.left
    let maximumPossibleXOffset = (scrollView.contentSize.width + newInsets.right) - scrollView.bounds.width
    let estimatedXOffset = max(minimumPossibleXOffset, min(maximumPossibleXOffset, scrollView.contentOffset.x))

    return CGPoint(x: estimatedXOffset, y: estimatedYOffset)
  }

  func testEstimationAddingTopInsets() {
    let insets = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)

    enumerateHeightRangeWithInsets(before: UIEdgeInsets(), after: insets) { scrollView, estimatedContentOffset in
      XCTAssertEqual(scrollView.contentOffset, estimatedContentOffset)
    }
  }

  func testEstimationRemovingTopInsets() {
    let insets = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)

    enumerateHeightRangeWithInsets(before: insets, after: UIEdgeInsets()) { scrollView, estimatedContentOffset in
      XCTAssertEqual(scrollView.contentOffset, estimatedContentOffset)
    }
  }

  func testEstimationAddingBottomInsets() {
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)

    enumerateHeightRangeWithInsets(before: UIEdgeInsets(), after: insets) { scrollView, estimatedContentOffset in
      XCTAssertEqual(scrollView.contentOffset, estimatedContentOffset)
    }
  }

  func testEstimationRemovingBottomInsets() {
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)

    enumerateHeightRangeWithInsets(before: insets, after: UIEdgeInsets()) { scrollView, estimatedContentOffset in
      XCTAssertEqual(scrollView.contentOffset, estimatedContentOffset)
    }
  }

  func testEstimationAddingBothInsets() {
    let insets = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)

    enumerateHeightRangeWithInsets(before: UIEdgeInsets(), after: insets) { scrollView, estimatedContentOffset in
      XCTAssertEqual(scrollView.contentOffset, estimatedContentOffset)
    }
  }

  func testEstimationRemovingBothInsets() {
    let insets = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)

    enumerateHeightRangeWithInsets(before: insets, after: UIEdgeInsets()) { scrollView, estimatedContentOffset in
      XCTAssertEqual(scrollView.contentOffset, estimatedContentOffset)
    }
  }

  func enumerateHeightRangeWithInsets(before before: UIEdgeInsets, after: UIEdgeInsets, work: (UIScrollView, CGPoint) -> Void) {
    for contentHeight in -1...Int(bounds.height * 3) {
      let scrollView = UITableView(frame: bounds)

      scrollView.contentInset = before

      scrollView.contentOffset = initialOffset
      scrollView.contentSize = CGSize(width: 0, height: CGFloat(contentHeight))

      let estimatedContentOffset = self.dynamicType.estimatedContentOffsetForScrollView(scrollView,
        withNewInsets: after
      )

      scrollView.contentInset = after

      work(scrollView, estimatedContentOffset)
    }
  }
}
