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

// Tests confirming that the flexible header view is always in front of other views when the
// flexible header view is a subview of its tracking scroll view.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/279
class FlexibleHeaderControllerIssue279Tests: XCTestCase {

  var fhvc: MDCFlexibleHeaderViewController!
  var tableViewController: UITableViewController!

  override func setUp() {
    super.setUp()

    fhvc = MDCFlexibleHeaderViewController()

    tableViewController = UITableViewController()
    tableViewController.addChild(fhvc)
    tableViewController.view.addSubview(fhvc.headerView)

    fhvc.headerView.trackingScrollView = tableViewController.tableView

    fhvc.didMove(toParent: tableViewController)
  }

  override func tearDown() {
    tableViewController = nil
    fhvc = nil

    super.tearDown()
  }

  func testIsFrontMostView() {
    XCTAssertEqual(tableViewController.tableView.subviews.last, fhvc.headerView)
  }
}
