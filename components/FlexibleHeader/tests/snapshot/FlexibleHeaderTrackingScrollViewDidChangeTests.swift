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

class FlexibleHeaderTrackingScrollViewDidChangeTests: XCTestCase {

  func testFromExpandedToCollapsedStateAnimatesShadowPath() throws {
    // Given
    let window = UIWindow()
    let fhvc = MDCFlexibleHeaderViewController()
    let shadowLayer = MDCShadowLayer()
    fhvc.headerView.setShadowLayer(shadowLayer) { layer, elevation in
      guard let shadowLayer = layer as? MDCShadowLayer else {
        return
      }
      shadowLayer.elevation = .init(4 * elevation)
    }
    fhvc.headerView.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
    fhvc.headerView.minMaxHeightIncludesSafeArea = false
    fhvc.headerView.sharedWithManyScrollViews = true
    fhvc.headerView.maximumHeight = 200
    fhvc.headerView.allowShadowLayerFrameAnimationsWhenChangingTrackingScrollView = true
    let scrollView1 = UIScrollView()
    let scrollView2 = UIScrollView()
    let largeScrollableArea = CGSize(width: fhvc.headerView.frame.width, height: 1000)
    scrollView1.contentSize = largeScrollableArea
    scrollView2.contentSize = largeScrollableArea
    // Fully expanded.
    scrollView1.contentOffset = CGPoint(x: 0, y: -200)
    // Fully collapsed.
    scrollView2.contentOffset = CGPoint(x: 0, y: 300)
    // Initially fully expanded.
    fhvc.headerView.trackingScrollView = scrollView1
    window.rootViewController = fhvc
    window.makeKeyAndVisible()
    CATransaction.flush()

    // When
    // And then collapsed.
    fhvc.headerView.trackingScrollView = scrollView2

    // Then
    XCTAssertNotNil(fhvc.headerView.layer.animation(forKey: "bounds.size"))
    XCTAssertNotNil(fhvc.headerView.layer.animation(forKey: "bounds.origin"))
    XCTAssertNotNil(fhvc.headerView.layer.animation(forKey: "position"))

    guard
      let animationDuration =
        fhvc.headerView.layer.animation(forKey: "bounds.size")?.duration
    else {
      XCTFail("Missing bounds.size animation")
      return
    }

    guard let sublayers = shadowLayer.sublayers else {
      XCTFail("Missing sublayers.")
      return
    }
    XCTAssertGreaterThan(sublayers.count, 0)

    for sublayer in sublayers {
      guard let animation = sublayer.animation(forKey: "shadowPath") else {
        XCTFail("Missing shadowPath animation. \(sublayer)")
        return
      }
      XCTAssertNotNil(animation)
      XCTAssertEqual(animation.duration, animationDuration, accuracy: 0.001)
    }
  }
}
