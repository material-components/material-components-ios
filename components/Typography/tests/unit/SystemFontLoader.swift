/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

class SystemFontLoader: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testFontWeights() {
    // Given
    let size: CGFloat = 10.0
    let fontLoader = MDCSystemFontLoader()

    // Then
    if #available(iOS 8.2, *) {
      XCTAssertEqual(fontLoader.lightFont(ofSize: size),
                     UIFont.systemFont(ofSize: size, weight: UIFontWeightLight))
      XCTAssertEqual(fontLoader.regularFont(ofSize: size),
                     UIFont.systemFont(ofSize: size, weight: UIFontWeightRegular))
      XCTAssertEqual(fontLoader.mediumFont(ofSize: size),
                     UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium))
      XCTAssertEqual(fontLoader.boldFont(ofSize: size),
                     UIFont.systemFont(ofSize: size, weight: UIFontWeightBold))
    } else {
      // Fallback on earlier versions
      XCTAssertEqual(fontLoader.lightFont(ofSize: size), UIFont.systemFont(ofSize: size))
      XCTAssertEqual(fontLoader.regularFont(ofSize: size), UIFont.systemFont(ofSize: size))
      XCTAssertEqual(fontLoader.mediumFont(ofSize: size), UIFont.systemFont(ofSize: size))
      XCTAssertEqual(fontLoader.boldFont(ofSize: size), UIFont.boldSystemFont(ofSize: size))
    }
    XCTAssertEqual(fontLoader.italicFont(ofSize: size), UIFont.italicSystemFont(ofSize: size))
  }
}
