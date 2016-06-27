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

class RTLTests: XCTestCase {

  func testMDCRectFlippedForRTLLeftToRight() {
    let frame = MDCRectFlippedForRTL(CGRect(x: 10, y: 20, width: 50, height: 30), 100, .LeftToRight)
    XCTAssertEqual(frame, CGRect(x: 10, y: 20, width: 50, height: 30))
  }

  func testMDCRectFlippedForRTLRightToLeft() {
    let frame = MDCRectFlippedForRTL(CGRect(x: 10, y: 20, width: 50, height: 30), 100, .RightToLeft)
    XCTAssertEqual(frame, CGRect(x: 40, y: 20, width: 50, height: 30))
  }

  func testMDCInsetsMakeWithLayoutDirectionLeftToRight() {
    let insets = MDCInsetsMakeWithLayoutDirection(10, 20, 30, 40, .LeftToRight)
    XCTAssertEqual(insets.left, 20)
  }

  func testMDCInsetsMakeWithLayoutDirectionRightToLeft() {
    let insets = MDCInsetsMakeWithLayoutDirection(10, 20, 30, 40, .LeftToRight)
    XCTAssertEqual(insets.right, 40)
  }
}
