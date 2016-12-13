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

// Testing status bar-related functionality.
class FlexibleHeaderStatusBarTests: XCTestCase {

  func testDarkBackgroundColor() {
    let controller = MDCFlexibleHeaderViewController()
    let view = controller.headerView
    view.backgroundColor = UIColor.blackColor()
    XCTAssertEqual(controller.preferredStatusBarStyle(), UIStatusBarStyle.LightContent)
  }

  func testLightBackgroundColor() {
    let controller = MDCFlexibleHeaderViewController()
    let view = controller.headerView
    view.backgroundColor = UIColor.whiteColor()
    XCTAssertEqual(controller.preferredStatusBarStyle(), UIStatusBarStyle.Default)
  }

  func testNonOpaqueBackgroundColor() {
    let controller = MDCFlexibleHeaderViewController()
    let view = controller.headerView
    view.backgroundColor = UIColor.init(white: 0, alpha: 0)
    XCTAssertEqual(controller.preferredStatusBarStyle(), UIStatusBarStyle.Default)
  }
}
