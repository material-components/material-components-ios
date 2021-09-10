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
import MaterialComponents.MaterialButtonBar

class ButtonBarCustomViewTests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    super.setUp()

    buttonBar = MDCButtonBar()
  }

  override func tearDown() {
    buttonBar = nil

    super.tearDown()
  }

  func testSettingTintColorOnItemModifiesCustomViewTintColor() {
    // Given
    let customView = UIView()
    let item = UIBarButtonItem(customView: customView)
    buttonBar.items = [item]

    // When
    item.tintColor = .red

    // Then
    XCTAssertEqual(customView.tintColor, item.tintColor)
  }

  func testSettingImageToNilOnItemDoesNothing() {
    // Given
    let customView = UIView()
    let item = UIBarButtonItem(customView: customView)
    buttonBar.items = [item]

    // When
    item.image = nil

    // Then, doesn't crash.
  }

  func testSettingTitleOnItemDoesNothing() {
    // Given
    let customView = UIView()
    let item = UIBarButtonItem(customView: customView)
    buttonBar.items = [item]

    // When
    item.title = "Hello"

    // Then, doesn't crash.
  }
}
