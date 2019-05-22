// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

class FlexibleHeaderScrollViewObservationTests: XCTestCase {

  var fhvc: MDCFlexibleHeaderViewController!

  override func setUp() {
    super.setUp()

    fhvc = MDCFlexibleHeaderViewController()

    // The behavior we're testing
    fhvc.headerView.observesTrackingScrollViewScrollEvents = true
  }

  override func tearDown() {
    fhvc = nil

    super.tearDown()
  }

  // MARK: Tracked table view

  func testTrackedTableViewTopContentOffsetIsObserved() {
    // Given
    let contentViewController = UITableViewController()
    contentViewController.tableView.contentSize =
      CGSize(width: contentViewController.tableView.bounds.width,
             height: contentViewController.tableView.bounds.height * 2)
    fhvc.headerView.trackingScrollView = contentViewController.tableView
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.didMove(toParent: contentViewController)
    
    // When
    let overshoot: CGFloat = 10
    contentViewController.tableView.contentOffset =
      CGPoint(x: 0, y: -contentViewController.tableView.contentInset.top - overshoot)

    // Then
    XCTAssertEqual(fhvc.headerView.frame.size.height, fhvc.headerView.maximumHeight + overshoot)

    // Required teardown when observation is enabled on pre-iOS 11 devices
    fhvc.headerView.trackingScrollView = nil
  }

  func testTrackedTableViewTopContentOffsetCausesShadowLayerOpacityChange() {
    // Given
    let contentViewController = UITableViewController()
    contentViewController.tableView.contentSize =
      CGSize(width: contentViewController.tableView.bounds.width,
             height: contentViewController.tableView.bounds.height * 2)
    fhvc.headerView.trackingScrollView = contentViewController.tableView

    contentViewController.addChild(fhvc)

    contentViewController.view.addSubview(fhvc.view)

    fhvc.didMove(toParent: contentViewController)

    // When
    let scrollAmount: CGFloat = fhvc.headerView.maximumHeight
    contentViewController.tableView.contentOffset =
      CGPoint(x: 0, y: -contentViewController.tableView.contentInset.top + scrollAmount)

    // Then
    XCTAssertGreaterThan(fhvc.headerView.layer.shadowOpacity, 0,
                         "Shadow opacity was expected to be non-zero due to scrolling amount.")

    // Required teardown when observation is enabled on pre-iOS 11 devices
    fhvc.headerView.trackingScrollView = nil
  }

}

