/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
import MaterialComponents.MaterialFlexibleHeader

class FlexibleHeaderTopSafeAreaInsetTests: XCTestCase {

  var fhvc: MDCFlexibleHeaderViewController!

  override func setUp() {
    super.setUp()

    fhvc = MDCFlexibleHeaderViewController()

    fhvc.headerView.topSafeAreaInsetBehaviorEnabled = true

    fhvc.headerView.minMaxHeightIncludesSafeArea = false
    fhvc.headerView.minimumHeight = 50
    fhvc.headerView.maximumHeight = 100
  }

  override func tearDown() {
    fhvc = nil

    super.tearDown()
  }

  func testFrameIsAdjustedToMinimumHeightWithNoTrackingScrollView() {
    // Given
    let contentViewController = UIViewController()
    contentViewController.addChildViewController(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.didMove(toParentViewController: contentViewController)

    // When
    fhvc.headerView.topSafeAreaInset = 200

    // Then
    XCTAssertEqual(fhvc.headerView.frame.size.height,
                   fhvc.headerView.minimumHeight + fhvc.headerView.topSafeAreaInset)
  }

  func testFrameIsAdjustedToMaximumHeightWithTrackingScrollView() {
    // Given
    let contentViewController = UITableViewController()
    fhvc.headerView.trackingScrollView = contentViewController.tableView
    contentViewController.addChildViewController(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.didMove(toParentViewController: contentViewController)
    fhvc.headerView.trackingScrollDidScroll()

    // When
    fhvc.headerView.topSafeAreaInset = 200

    // Then
    XCTAssertEqual(fhvc.headerView.frame.size.height,
                   fhvc.headerView.maximumHeight + fhvc.headerView.topSafeAreaInset)
  }
}

