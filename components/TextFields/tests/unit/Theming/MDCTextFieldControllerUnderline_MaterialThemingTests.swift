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

import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialTextFields_Theming
import XCTest

class MDCTextFieldControllerUnderline_MaterialThemingTests: XCTestCase {
  func testWithDefaultContainerSchemeStylesAppropriatly() {
    // Given
    let textFieldFilled = MDCTextField()
    let textFieldControllerUnderline = MDCTextInputControllerUnderline(textInput: textFieldFilled)
    let scheme: MDCContainerScheme = MDCContainerScheme()

    // When
    textFieldControllerFilled.applyTheme(withScheme: scheme)

    // Then
    // Color
    XCTAssertEqual(textFieldControllerUnderline, scheme.colorScheme.primaryColor)
    

    // Typography
  }

  func testWithCustomContainerSchemeStylesAppropriatly() {
    // Given
    let textFieldFilled = MDCTextField()
    let textFieldControllerFilled = MDCTextInputControllerUnderline(textInput: textFieldFilled)
    let scheme: MDCContainerScheme = MDCContainerScheme()

    // When
    textFieldControllerFilled.applyTheme(withScheme: scheme)

    // Then
    // Color

    // Typography
  }
}
