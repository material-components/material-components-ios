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
import MaterialComponents.MaterialTextFields

class CharacterCounter: NSObject, MDCTextInputCharacterCounter, NSSecureCoding {
  var fixedCount: UInt = 0

  override init() {}

  // MARK: - NSSecureCoding

  static var supportsSecureCoding: Bool = true

  required init?(coder aDecoder: NSCoder) {
    self.fixedCount = UInt(aDecoder.decodeInt64(forKey: "fixedCount"))
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(Int64(fixedCount), forKey: "fixedCount")
  }

  // MARK: - MDCTextInputCharacterCounter

  func characterCount(forTextInput textInput: UIView?) -> UInt {
    return fixedCount
  }
}

class MDCTextInputControllerBaseEncodingTests: XCTestCase {

  func testTextInputControllerBaseEncoding() {
    // Given
    let controller = MDCTextInputControllerBase()
    controller.activeColor = UIColor.cyan
    controller.borderFillColor = UIColor.magenta
    controller.characterCountMax = 42
    controller.characterCountViewMode = .unlessEditing
    controller.roundedCorners = .bottomLeft
    controller.errorColor = UIColor.purple
    controller.floatingPlaceholderNormalColor = UIColor.brown
    controller.floatingPlaceholderScale = 0.57
    controller.inlinePlaceholderColor = UIColor.green
    controller.inlinePlaceholderFont = UIFont.systemFont(ofSize: 33)
    controller.leadingUnderlineLabelFont = UIFont.systemFont(ofSize: 51)
    controller.leadingUnderlineLabelTextColor = UIColor.white
    controller.normalColor = UIColor.orange
    controller.trailingUnderlineLabelFont = UIFont.systemFont(ofSize: 17)
    controller.trailingUnderlineLabelTextColor = UIColor.yellow

    // When
    let data = NSKeyedArchiver.archivedData(withRootObject: controller)
    let unarchivedController =
        NSKeyedUnarchiver.unarchiveObject(with: data) as? MDCTextInputControllerBase

    // Then
    XCTAssertNotNil(unarchivedController)
    XCTAssertEqual(controller.activeColor, unarchivedController?.activeColor)
    XCTAssertEqual(controller.borderFillColor, unarchivedController?.borderFillColor)
    XCTAssertEqual(controller.characterCountMax, unarchivedController?.characterCountMax)
    XCTAssertEqual(controller.characterCountViewMode, unarchivedController?.characterCountViewMode)
    XCTAssertEqual(controller.roundedCorners, unarchivedController?.roundedCorners)
    XCTAssertEqual(controller.errorColor, unarchivedController?.errorColor)
    XCTAssertEqual(controller.floatingPlaceholderNormalColor,
                   unarchivedController?.floatingPlaceholderNormalColor)
    XCTAssertEqual(controller.floatingPlaceholderScale,
                   unarchivedController?.floatingPlaceholderScale)
    XCTAssertEqual(controller.inlinePlaceholderColor, unarchivedController?.inlinePlaceholderColor)
    XCTAssertEqual(controller.inlinePlaceholderFont, unarchivedController?.inlinePlaceholderFont)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   unarchivedController?.leadingUnderlineLabelFont)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   unarchivedController?.leadingUnderlineLabelTextColor)
    XCTAssertEqual(controller.normalColor, unarchivedController?.normalColor)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   unarchivedController?.trailingUnderlineLabelFont)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   unarchivedController?.trailingUnderlineLabelTextColor)
  }

  func testTextInputControllerBaseCharacterCounterEncoding() {
    // Given
    let characterCounter = CharacterCounter()
    characterCounter.fixedCount = 6
    let controller = MDCTextInputControllerBase()
    controller.characterCounter = characterCounter

    // When
    let data = NSKeyedArchiver.archivedData(withRootObject: controller)
    let unarchivedController =
        NSKeyedUnarchiver.unarchiveObject(with: data) as? MDCTextInputControllerBase
    let unarchivedCounter = unarchivedController?.characterCounter as? CharacterCounter

    // Then
    XCTAssertNotNil(unarchivedCounter)
    XCTAssertEqual(characterCounter.fixedCount, unarchivedCounter?.fixedCount)
  }

  // TODO: add textInput encoding test
}
