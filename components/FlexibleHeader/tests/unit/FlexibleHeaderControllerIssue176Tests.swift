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

// Tests confirming that the flexible header view's frame correctly reflects the target scroll
// view's position immediately after being registered.
//
// Based on issue https://github.com/google/material-components-ios/issues/176
class FlexibleHeaderControllerIssue176Tests: XCTestCase {

  var fhvc: MDCFlexibleHeaderViewController!

  override func setUp() {
    fhvc = MDCFlexibleHeaderViewController()
    fhvc.headerView.maximumHeight = fhvc.headerView.minimumHeight + 100
  }

  func registerToParentViewController(parent: UIViewController) {
    parent.addChildViewController(fhvc)
    parent.view.addSubview(fhvc.view)
  }

  func testWithNoTrackingScrollView() {
    let parentVc = UIViewController()
    self.registerToParentViewController(parentVc)

    // NOTE: No tracking scroll view

    fhvc.didMoveToParentViewController(parentVc)

    XCTAssertEqual(fhvc.view.bounds.size.height, fhvc.headerView.minimumHeight)
  }

  func testWithTrackingScrollView() {
    let parentVc = UITableViewController()
    self.registerToParentViewController(parentVc)

    fhvc.headerView.trackingScrollView = parentVc.tableView

    fhvc.didMoveToParentViewController(parentVc)

    XCTAssertEqual(fhvc.view.bounds.size.height, fhvc.headerView.maximumHeight)
  }
}
