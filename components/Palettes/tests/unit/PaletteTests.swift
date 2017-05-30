/*
Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
  func colorFromRGB(_ rgbValue: UInt32) -> UIColor {
    return UIColor(
      red:CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
      green:CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
      blue:CGFloat((rgbValue & 0x0000FF) >> 0) / 255,
      alpha:1)
  }

  func testBasics() {
    let color = MDCPalette.red.tint50
    XCTAssertEqual(color, colorFromRGB(0xFFEBEE))
  }

  func testCaching() {
    let first = MDCPalette.red
    let second = MDCPalette.red
    XCTAssertTrue(first === second)
  }

  func testAccentlessPalette() {
    let brownPalette = MDCPalette.brown
    XCTAssertNil(brownPalette.accent100)
  }

  func testGeneratedPalette() {
    let palette = MDCPalette(generatedFrom: UIColor(red: 1, green: 0, blue: 0, alpha: 1))
    XCTAssertNotNil(palette.tint50)
    XCTAssertNotNil(palette.tint100)
    XCTAssertNotNil(palette.tint200)
    XCTAssertNotNil(palette.tint300)
    XCTAssertNotNil(palette.tint400)
    XCTAssertNotNil(palette.tint500)
    XCTAssertNotNil(palette.tint600)
    XCTAssertNotNil(palette.tint700)
    XCTAssertNotNil(palette.tint800)
    XCTAssertNotNil(palette.tint900)
    XCTAssertNotNil(palette.accent100)
    XCTAssertNotNil(palette.accent200)
    XCTAssertNotNil(palette.accent400)
    XCTAssertNotNil(palette.accent700)
  }

  func testCustomPalette() {
    let tints: [MDCPaletteTint: UIColor] = [
      .tint50Name: UIColor(white: 0, alpha: 1),
      .tint100Name: UIColor(white: 0.1, alpha: 1),
      .tint200Name: UIColor(white: 0.2, alpha: 1),
      .tint300Name: UIColor(white: 0.3, alpha: 1),
      .tint400Name: UIColor(white: 0.4, alpha: 1),
      .tint500Name: UIColor(white: 0.5, alpha: 1),
      .tint600Name: UIColor(white: 0.6, alpha: 1),
      .tint700Name: UIColor(white: 0.7, alpha: 1),
      .tint800Name: UIColor(white: 0.8, alpha: 1),
      .tint900Name: UIColor(white: 0.9, alpha: 1)
    ]
    let accents: [MDCPaletteAccent: UIColor] = [
      .accent100Name: UIColor(white: 1, alpha: 0),
      .accent200Name: UIColor(white: 1, alpha: 0.25),
      .accent400Name: UIColor(white: 1, alpha: 0.75),
      .accent700Name: UIColor(white: 1, alpha: 1)
    ]
    let palette = MDCPalette(tints: tints, accents: accents)
    XCTAssertEqual(palette.tint50, tints[.tint50Name])
    XCTAssertEqual(palette.tint100, tints[.tint100Name])
    XCTAssertEqual(palette.tint200, tints[.tint200Name])
    XCTAssertEqual(palette.tint300, tints[.tint300Name])
    XCTAssertEqual(palette.tint400, tints[.tint400Name])
    XCTAssertEqual(palette.tint500, tints[.tint500Name])
    XCTAssertEqual(palette.tint600, tints[.tint600Name])
    XCTAssertEqual(palette.tint700, tints[.tint700Name])
    XCTAssertEqual(palette.tint800, tints[.tint800Name])
    XCTAssertEqual(palette.tint900, tints[.tint900Name])
    XCTAssertEqual(palette.accent100, accents[.accent100Name])
    XCTAssertEqual(palette.accent200, accents[.accent200Name])
    XCTAssertEqual(palette.accent400, accents[.accent400Name])
    XCTAssertEqual(palette.accent700, accents[.accent700Name])
  }
}
