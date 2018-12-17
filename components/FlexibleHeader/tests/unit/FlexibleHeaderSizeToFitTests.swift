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

// Testing the contract for sizeToFit
class FlexibleHeaderSizeToFitTests: XCTestCase {

  func testSizeToFitBelowMinimumHeight() {
    let view = MDCFlexibleHeaderView()

    let initialFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
    view.frame = initialFrame

    view.sizeToFit()

    XCTAssertEqual(view.frame.origin.x, initialFrame.origin.x)
    XCTAssertEqual(view.frame.origin.y, initialFrame.origin.y)
    XCTAssertEqual(view.frame.size.width, initialFrame.size.width)
    XCTAssertEqual(view.frame.size.height, view.minimumHeight)
  }

  func testSizeToFitAboveMinimumHeight() {
    let view = MDCFlexibleHeaderView()

    let initialFrame = CGRect(x: 0, y: 0, width: 100, height: 500)
    view.frame = initialFrame

    view.sizeToFit()

    XCTAssertEqual(view.frame.origin.x, initialFrame.origin.x)
    XCTAssertEqual(view.frame.origin.y, initialFrame.origin.y)
    XCTAssertEqual(view.frame.size.width, initialFrame.size.width)
    XCTAssertEqual(view.frame.size.height, view.minimumHeight)
  }

  func testSizeThatFitsSideEffects() {
    let view = MDCFlexibleHeaderView()

    let initialFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
    view.frame = initialFrame

    let possibleSize = CGSize(width: 300, height: 500)
    let bestFitSize = view.sizeThatFits(possibleSize)

    // Verify no side effects
    XCTAssertEqual(view.frame.origin.x, initialFrame.origin.x)
    XCTAssertEqual(view.frame.origin.y, initialFrame.origin.y)
    XCTAssertEqual(view.frame.size.width, initialFrame.size.width)
    XCTAssertEqual(view.frame.size.height, initialFrame.size.height)

    XCTAssertEqual(bestFitSize.width, possibleSize.width)
    XCTAssertEqual(bestFitSize.height, view.minimumHeight)
  }
}
