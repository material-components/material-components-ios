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

// Tests confirming that setting the flexible header view's min or max height will bound the
// corresponding value.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/324
class FlexibleHeaderView324Tests: XCTestCase {

  var headerView: MDCFlexibleHeaderView!

  override func setUp() {
    super.setUp()
    
    headerView = MDCFlexibleHeaderView()
  }

  override func tearDown() {
    headerView = nil

    super.tearDown()
  }

  // Side effect cases

  func testSettingMinAboveMax() {
    headerView.minimumHeight = headerView.maximumHeight + 10

    XCTAssertEqual(headerView.maximumHeight, headerView.minimumHeight)
  }

  func testSettingMaxBelowMin() {
    headerView.maximumHeight = headerView.minimumHeight - 10

    XCTAssertEqual(headerView.maximumHeight, headerView.minimumHeight)
  }

  // No side effect cases

  func testSettingMinBelowMax() {
    headerView.minimumHeight = headerView.maximumHeight - 10

    XCTAssertGreaterThan(headerView.maximumHeight, headerView.minimumHeight)
  }

  func testSettingMaxAboveMin() {
    headerView.maximumHeight = headerView.minimumHeight + 10

    XCTAssertGreaterThan(headerView.maximumHeight, headerView.minimumHeight)
  }
}
