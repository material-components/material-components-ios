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

// Tests confirming contract with a tracking scroll view that isn't scrolling
class FlexibleHeaderTrackingScrollViewTests: XCTestCase, UIScrollViewDelegate {

  // Implicitly unwrapped to indicate the contract of creating these values in setUp and make our
  // accessors cleaner in tests.
  var view: MDCFlexibleHeaderView!
  var beforeFrame: CGRect!
  var scrollView: UIScrollView!
  var contentOffset = CGPoint(x: 0, y: 0)
  var contentOffsetPtr: UnsafeMutablePointer<CGPoint>?

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

    scrollView.delegate = self

    view.trackingScrollView = scrollView
    contentOffsetPtr = UnsafeMutablePointer<CGPoint>(&contentOffset)
  }

  override func tearDown() {
    contentOffsetPtr = nil
    view.trackingScrollView = nil
    scrollView.delegate = nil
    scrollView = nil
    view = nil

    super.tearDown()
  }

  // MARK: UIScrollViewDelegate events

  func testDidScroll() {
    view.trackingScrollDidScroll()

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testDidEndDraggingWillDecelerate() {
    view.trackingScrollDidEndDraggingWillDecelerate(true)

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testDidEndDraggingWillNotDecelerate() {
    view.trackingScrollDidEndDraggingWillDecelerate(false)

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testDidEndDecelerating() {
    view.trackingScrollDidEndDecelerating()

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testWillEndDraggingWithZeroVelocity() {
    view.trackingScrollWillEndDragging(
      withVelocity: CGPoint.zero,
      targetContentOffset: contentOffsetPtr!)

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testWillEndDraggingWithPositiveVelocity() {
    view.trackingScrollWillEndDragging(
      withVelocity: CGPoint(x: 0, y: 10),
      targetContentOffset: contentOffsetPtr!)

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testWillEndDraggingWithNegativeVelocity() {
    view.trackingScrollWillEndDragging(
      withVelocity: CGPoint(x: 0, y: 10),
      targetContentOffset: contentOffsetPtr!)

    XCTAssertEqual(beforeFrame, view.frame)
  }

  // MARK: Changing the tracking scroll view

  func testWillChangeToNilScrollView() {
    view.trackingScrollWillChange(toScroll: nil)

    XCTAssertEqual(beforeFrame, view.frame)
  }

  // MARK: Shifting header on screen

  func testShiftHeaderOnScreen() {
    view.shiftHeaderOnScreen(animated: false)

    XCTAssertEqual(beforeFrame, view.frame)
  }

  // MARK: Interface orientation changes

  func testInterfaceOrientationWillChange() {
    view.interfaceOrientationWillChange()

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testInterfaceOrientationIsChanging() {
    view.interfaceOrientationWillChange()  // Required by interfaceOrientationIsChanging
    view.interfaceOrientationIsChanging()

    XCTAssertEqual(beforeFrame, view.frame)
  }

  func testInterfaceOrientationDidChange() {
    view.interfaceOrientationWillChange()  // Required by interfaceOrientationDidChange
    view.interfaceOrientationDidChange()

    XCTAssertEqual(beforeFrame, view.frame)
  }

  // MARK: Content insets

  func testChangeContentInsets() {
    view.changeContentInsets {}  // no-op

    XCTAssertEqual(beforeFrame, view.frame)
  }

  // MARK: UIScrollViewDelegate

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if view.trackingScrollView == scrollView {
      view.trackingScrollDidScroll()
    }
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if view.trackingScrollView == scrollView {
      view.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if view.trackingScrollView == scrollView {
      view.trackingScrollDidEndDecelerating()
    }
  }

  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    if view.trackingScrollView == scrollView {
      view.trackingScrollWillEndDragging(
        withVelocity: velocity,
        targetContentOffset: targetContentOffset)
    }
  }
}
