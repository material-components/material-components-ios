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

// Tests confirming that MDCAppBarContainerViewController observes the content view controller's
// navigation item.
//
// Based on issue https://github.com/google/material-components-ios/issues/272
class AppBarContainerIssue272Tests: XCTestCase {

  var content: UIViewController!
  var container: MDCAppBarContainerViewController!

  override func setUp() {
    content = UIViewController()
    container = MDCAppBarContainerViewController(contentViewController: content)
  }

  func testNotObservedBeforeViewDidLoad() {
    content.navigationItem.title = "Some title"

    XCTAssertNil(container.appBar.navigationBar.title)
    XCTAssertNotEqual(content.navigationItem.title, container.appBar.navigationBar.title)
  }

  func testObservedAfterViewDidLoad() {
    let _ = container.view // Force the container to load its view
    content.navigationItem.title = "Some title"

    XCTAssertEqual(content.navigationItem.title, container.appBar.navigationBar.title)
  }
}
