// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

private class MockMDCFlexibleHeaderViewAnimationDelegate: NSObject, MDCFlexibleHeaderViewAnimationDelegate {
  var didCompleteExpectation: XCTestExpectation
  init(didCompleteExpectation: XCTestExpectation) {
    self.didCompleteExpectation = didCompleteExpectation

    super.init()
  }

  func flexibleHeaderViewChangeTrackingScrollViewAnimationDidComplete(_ flexibleHeaderView: MDCFlexibleHeaderView) {
    didCompleteExpectation.fulfill()
  }
}

class FlexibleHeaderViewAnimationDelegateTests: XCTestCase {

  func testCompletionCallbackIsNotInvokedWhenSettingTheInitialTrackingScrollView() {
    // Given
    let window = UIWindow()
    let fhv = MDCFlexibleHeaderView()
    fhv.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
    fhv.minMaxHeightIncludesSafeArea = false
    fhv.sharedWithManyScrollViews = true
    fhv.maximumHeight = 200
    let scrollView = UIScrollView()
    let largeScrollableArea = CGSize(width: fhv.frame.width, height: 1000)
    scrollView.contentSize = largeScrollableArea
    // Fully expanded.
    scrollView.contentOffset = CGPoint(x: 0, y: -200)
    window.addSubview(fhv)
    window.makeKeyAndVisible()
    window.layer.speed = 100000
    CATransaction.flush()

    let mockDelegate = MockMDCFlexibleHeaderViewAnimationDelegate(didCompleteExpectation:
        expectation(description: "didComplete"))
    fhv.animationDelegate = mockDelegate

    // When
    fhv.trackingScrollView = scrollView

    // Then
    let waiter = XCTWaiter()
    let result = waiter.wait(for: [mockDelegate.didCompleteExpectation], timeout: 0.01)
    XCTAssertEqual(result, .timedOut)
  }

  func testCompletionCallbackIsInvokedWhenTheTrackingScrollViewIsChanged() {
    // Given
    let window = UIWindow()
    let fhv = MDCFlexibleHeaderView()
    fhv.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
    fhv.minMaxHeightIncludesSafeArea = false
    fhv.sharedWithManyScrollViews = true
    fhv.maximumHeight = 200
    let scrollView1 = UIScrollView()
    let scrollView2 = UIScrollView()
    let largeScrollableArea = CGSize(width: fhv.frame.width, height: 1000)
    scrollView1.contentSize = largeScrollableArea
    scrollView2.contentSize = largeScrollableArea
    // Fully expanded.
    scrollView1.contentOffset = CGPoint(x: 0, y: -200)
    // Fully collapsed.
    scrollView2.contentOffset = CGPoint(x: 0, y: 300)
    window.addSubview(fhv)
    window.makeKeyAndVisible()
    window.layer.speed = 100000
    CATransaction.flush()

    let mockDelegate = MockMDCFlexibleHeaderViewAnimationDelegate(didCompleteExpectation:
        expectation(description: "didComplete"))
    fhv.animationDelegate = mockDelegate

    // When
    fhv.trackingScrollView = scrollView1
    fhv.trackingScrollView = scrollView2

    // Then
    wait(for: [mockDelegate.didCompleteExpectation], timeout: 0.1)
  }
}
