// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_Theming 
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

class MDCTextFieldControllerUnderline_MaterialThemingTests: XCTestCase {
  func testWithDefaultContainerSchemeStylesAppropriately() {
    // Given
    let textFieldFilled = MDCTextField()
    let textFieldControllerUnderline = MDCTextInputControllerUnderline(textInput: textFieldFilled)
    let scheme = MDCContainerScheme()
    let onSurface60Opacity = scheme.colorScheme.onSurfaceColor.withAlphaComponent(0.6)
    let typographyScheme = scheme.typographyScheme
    let floatingPlaceholderController: MDCTextInputControllerFloatingPlaceholder =
      textFieldControllerUnderline

    // When
    textFieldControllerUnderline.applyTheme(withScheme: scheme)

    // Then
    // Color
    XCTAssertEqual(textFieldControllerUnderline.activeColor, scheme.colorScheme.primaryColor)
    XCTAssertEqual(textFieldControllerUnderline.errorColor, scheme.colorScheme.errorColor)
    XCTAssertEqual(
      textFieldControllerUnderline.normalColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(0.87)
    )
    XCTAssertEqual(textFieldControllerUnderline.inlinePlaceholderColor, onSurface60Opacity)
    XCTAssertEqual(textFieldControllerUnderline.trailingUnderlineLabelTextColor, onSurface60Opacity)
    XCTAssertEqual(textFieldControllerUnderline.leadingUnderlineLabelTextColor, onSurface60Opacity)
    XCTAssertEqual(floatingPlaceholderController.floatingPlaceholderNormalColor, onSurface60Opacity)
    XCTAssertEqual(
      floatingPlaceholderController.floatingPlaceholderActiveColor,
      scheme.colorScheme.primaryColor.withAlphaComponent(0.87)
    )
    // Typography
    XCTAssertEqual(textFieldControllerUnderline.inlinePlaceholderFont, typographyScheme.subtitle1)
    XCTAssertEqual(textFieldControllerUnderline.leadingUnderlineLabelFont, typographyScheme.caption)
    XCTAssertEqual(
      textFieldControllerUnderline.trailingUnderlineLabelFont,
      typographyScheme.caption
    )
    if typographyScheme.caption.pointSize <= 0 {
      XCTAssertNil(floatingPlaceholderController.floatingPlaceholderScale)
    } else {
      let ratio = Double(typographyScheme.caption.pointSize / typographyScheme.subtitle1.pointSize)
      XCTAssertEqual(floatingPlaceholderController.floatingPlaceholderScale, NSNumber(value: ratio))
    }
  }
}
