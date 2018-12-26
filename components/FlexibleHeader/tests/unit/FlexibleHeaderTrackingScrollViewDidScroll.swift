// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import XCTest
import MaterialComponents.MaterialFlexibleHeader

// Tests confirming contract with a tracking scroll view that has scrolled
class FlexibleHeaderTrackingScrollViewDidScroll: XCTestCase {

  // Implicitly unwrapped to indicate the contract of creating these values in setUp and make our
  // accessors cleaner in tests.
  var view: MDCFlexibleHeaderView!
  var beforeFrame: CGRect!
  var scrollView: UIScrollView!

  override func setUp() {
    super.setUp()

    view = MDCFlexibleHeaderView()

    let originalFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
    view.frame = originalFrame
    view.sizeToFit()

    beforeFrame = view.frame

    scrollView = UIScrollView()
    scrollView.contentSize = CGSize(width: originalFrame.size.width, height: 1000)
    scrollView.frame = CGRect(x: 0, y: 0, width: originalFrame.size.width, height: 250)

    view.trackingScrollView = scrollView
  }

  override func tearDown() {
    view.trackingScrollView = nil
    scrollView = nil
    view = nil

    super.tearDown()
  }

  // MARK: Initial changes are ignored.

  func testFirstChangeDoesNothingNegative() {
    scrollView.setContentOffset(CGPoint(x: 0, y: -view.maximumHeight), animated: false)

    view.trackingScrollDidScroll()

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testFirstChangeDoesNothingPositive() {
    scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: false)

    view.trackingScrollDidScroll()

    XCTAssertEqual(beforeFrame, view.frame)
  }

  // MARK: Expansion on scroll to top.

  func testFullyExpandedOnScrollToTop() {
    view.trackingScrollDidScroll()

    view.maximumHeight = 200
    scrollView.setContentOffset(CGPoint(x: 0, y: -view.maximumHeight), animated: false)
    view.trackingScrollDidScroll()

    XCTAssertEqual(view.frame.size.height, view.maximumHeight)
  }
}
