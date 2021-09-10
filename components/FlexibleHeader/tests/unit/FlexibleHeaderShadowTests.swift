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

import UIKit
import XCTest
import MaterialComponents.MaterialFlexibleHeader
import MaterialComponents.MaterialShadowLayer

class MDCFlexibleHeaderShadowTests: XCTestCase {
  var flexibleHeader: MDCFlexibleHeaderView!

  override func setUp() {
    super.setUp()

    flexibleHeader = MDCFlexibleHeaderView()
  }

  override func tearDown() {
    flexibleHeader = nil

    super.tearDown()
  }

  func testDefaultFlexibleHeaderShadow() {
    // Then
    XCTAssertNil(flexibleHeader.shadowLayer)
  }

  func testMaterialShadowLayer() {
    // Given
    let shadowLayer = MDCShadowLayer()

    // When
    flexibleHeader.shadowLayer = shadowLayer

    // Then
    XCTAssertEqual(flexibleHeader.shadowLayer, shadowLayer)
  }

  func testCALayerShadowLayer() {
    // Given
    let fakeShadowLayer = CALayer()

    // When
    flexibleHeader.shadowLayer = fakeShadowLayer

    // Then
    XCTAssertEqual(flexibleHeader.shadowLayer, fakeShadowLayer)
  }

  func testMaterialShadowLayerWithCustomShadowColor() {
    // Given
    let shadowLayer = MDCShadowLayer()
    flexibleHeader.shadowLayer = shadowLayer
    let fakeColor = UIColor.blue

    // When
    flexibleHeader.shadowColor = fakeColor

    // Then
    if let shadowLayer = flexibleHeader.shadowLayer {
      XCTAssertEqual(shadowLayer.shadowColor, fakeColor.cgColor)
    } else {
      XCTAssertNotNil(flexibleHeader.shadowLayer)
    }
  }

  func testCALayerWithCustomShadowColor() {
    // Given
    let shadowLayer = CALayer()
    flexibleHeader.shadowLayer = shadowLayer
    let fakeColor = UIColor.blue

    // When
    flexibleHeader.shadowColor = fakeColor

    // Then
    if let shadowLayer = flexibleHeader.shadowLayer {
      XCTAssertEqual(shadowLayer.shadowColor, fakeColor.cgColor)
    } else {
      XCTAssertNotNil(flexibleHeader.shadowLayer)
    }
  }
}
