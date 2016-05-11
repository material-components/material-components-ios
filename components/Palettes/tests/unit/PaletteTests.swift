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

class PaletteTests: XCTestCase {
  // Creates a UIColor from a 24-bit RGB color encoded as an integer.
  func colorFromRGB(rgbValue: UInt32) -> UIColor {
    return UIColor(
      red:CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
      green:CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
      blue:CGFloat((rgbValue & 0x0000FF) >> 0) / 255,
      alpha:1);
  }

  func testBasics() {
    let color = MDCPalette.redPalette().tint50
    XCTAssertEqual(color, colorFromRGB(0xFFEBEE))
  }

  func testCaching() {
    let first = MDCPalette.redPalette()
    let second = MDCPalette.redPalette()
    XCTAssertTrue(first === second)
  }

  func testAccentlessPalette() {
    let brownPalette = MDCPalette.brownPalette()
    XCTAssertNil(brownPalette.accent100)
  }

}
