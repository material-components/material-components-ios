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

// Tests confirming that the flexible header view's frame correctly reflects the target scroll
// view's position immediately after being registered.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/176
class FlexibleHeaderControllerIssue176Tests: XCTestCase {

  var fhvc: MDCFlexibleHeaderViewController!

  override func setUp() {
    super.setUp()

    fhvc = MDCFlexibleHeaderViewController()
    fhvc.headerView.maximumHeight = fhvc.headerView.minimumHeight + 100
  }

  override func tearDown() {
    fhvc = nil

    super.tearDown()
  }

  func registerToParentViewController(_ parent: UIViewController) {
    parent.addChild(fhvc)
    parent.view.addSubview(fhvc.view)
  }

  func testWithNoTrackingScrollView() {
    let parentVc = UIViewController()
    self.registerToParentViewController(parentVc)

    // NOTE: No tracking scroll view
    fhvc.didMove(toParent: parentVc)

    XCTAssertEqual(fhvc.view.bounds.size.height, fhvc.headerView.minimumHeight)
  }

  func testWithTrackingScrollView() {
    let parentVc = UITableViewController()

    // iOS 8.3 and 8.4 do not provide a default frame for the view controller. The contentOffset for
    // a UIScrollView will only be modified if its bounds is sufficiently large, so we recreate the
    // expected behavior here.
    parentVc.view.frame = UIScreen.main.bounds

    self.registerToParentViewController(parentVc)

    fhvc.headerView.trackingScrollView = parentVc.tableView

    fhvc.didMove(toParent: parentVc)

    XCTAssertEqual(fhvc.headerView.trackingScrollView!.contentOffset.y,
                   -fhvc.headerView.maximumHeight)
    XCTAssertEqual(fhvc.view.bounds.size.height, fhvc.headerView.maximumHeight)
  }
}
