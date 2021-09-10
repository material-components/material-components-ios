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
import MaterialComponents.MaterialShadowLayer

class FlexibleHeaderAnimateTests: XCTestCase {

  func testAnimatingMaximumHeightAnimatesHeight() throws {
    // Given
    let fhvc = MDCFlexibleHeaderViewController()
    fhvc.headerView.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
    fhvc.headerView.minMaxHeightIncludesSafeArea = false
    fhvc.headerView.maximumHeight = 200
    let scrollView = UIScrollView()
    let largeScrollableArea = CGSize(width: fhvc.headerView.frame.width, height: 1000)
    scrollView.contentSize = largeScrollableArea
    scrollView.contentOffset = CGPoint(x: 0, y: -200)
    fhvc.headerView.trackingScrollView = scrollView

    let window = UIWindow()
    window.rootViewController = fhvc
    window.makeKeyAndVisible()
    CATransaction.flush()

    // When
    fhvc.headerView.animate(animations: {
      scrollView.contentOffset = CGPoint(x: 0, y: -100)
      fhvc.headerView.maximumHeight = 100
    })

    // Then
    XCTAssertNotNil(fhvc.headerView.layer.animation(forKey: "bounds.size"))
    XCTAssertNotNil(fhvc.headerView.layer.animation(forKey: "bounds.origin"))
    XCTAssertNotNil(fhvc.headerView.layer.animation(forKey: "position"))

    guard
      let sizeAnimation =
        fhvc.headerView.layer.animation(forKey: "bounds.size") as? CABasicAnimation
    else {
      XCTFail("bounds.size animation is not a CABasicAnimation")
      return
    }

    XCTAssertTrue(sizeAnimation.isAdditive)
    XCTAssertEqual(sizeAnimation.fromValue as! CGSize, CGSize(width: 0, height: 100))
    XCTAssertEqual(sizeAnimation.toValue as! CGSize, CGSize(width: 0, height: 0))
  }
}
