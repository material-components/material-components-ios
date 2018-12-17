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
import MaterialComponents.MaterialAppBar

// Tests confirming that MDCAppBarContainerViewController doesn't loads its own view during
// initialization.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/287
class AppBarContainerIssue287Tests: XCTestCase {

  var content: UIViewController!
  var container: MDCAppBarContainerViewController!

  override func setUp() {
    super.setUp()

    content = UIViewController()
    container = MDCAppBarContainerViewController(contentViewController: content)
  }

  override func tearDown() {
    container = nil
    content = nil

    super.tearDown()
  }

  func testViewHasNotLoadedAfterInitialization() {
    XCTAssertFalse(container.isViewLoaded)
  }
}
