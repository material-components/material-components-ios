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

class FlexibleHeaderWrappingTopLayoutGuideTests: XCTestCase {

  var container: MDCFlexibleHeaderContainerViewController!

  override func setUp() {
    super.setUp()

    container = MDCFlexibleHeaderContainerViewController()
    container.isTopLayoutGuideAdjustmentEnabled = true
    container.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    container.headerViewController.headerView.minimumHeight = 50
    container.headerViewController.headerView.maximumHeight = 100
  }

  override func tearDown() {
    container = nil

    super.tearDown()
  }

  // MARK: No scroll view

  func testNoScrollViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UIViewController()
    container.contentViewController = contentViewController
    let _ = container.view  // Force the view to load.

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(
      contentViewController.additionalSafeAreaInsets.top,
      container.headerViewController.headerView.frame.maxY)
  }

  func testEarlyViewLoadStillAffectsTopLayoutGuide() {
    // Given
    let contentViewController = UIViewController()
    let _ = container.view  // Force the view to load.
    container.contentViewController = contentViewController

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(
      contentViewController.additionalSafeAreaInsets.top,
      container.headerViewController.headerView.frame.maxY)
  }

  // MARK: Untracked table view

  func testUntrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UITableViewController()
    container.contentViewController = contentViewController
    let _ = container.view  // Force the view to load.

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(
      contentViewController.additionalSafeAreaInsets.top,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(contentViewController.tableView.adjustedContentInset.top, 0)
  }

  // MARK: Tracked table view

  func testTrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UITableViewController()
    container.headerViewController.headerView.trackingScrollView = contentViewController.tableView
    container.contentViewController = contentViewController
    let _ = container.view  // Force the view to load.
    container.headerViewController.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
    XCTAssertEqual(
      contentViewController.tableView.adjustedContentInset.top,
      container.headerViewController.headerView.maximumHeight)
  }

  // MARK: Untracked collection view

  func testUntrackedCollectionViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let flow = UICollectionViewFlowLayout()
    let contentViewController = UICollectionViewController(collectionViewLayout: flow)
    container.contentViewController = contentViewController
    let _ = container.view  // Force the view to load.

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(
      contentViewController.additionalSafeAreaInsets.top,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(contentViewController.collectionView!.adjustedContentInset.top, 0)
  }

  // MARK: Tracked collection view view

  func testTrackedCollectionViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let flow = UICollectionViewFlowLayout()
    let contentViewController = UICollectionViewController(collectionViewLayout: flow)
    container.headerViewController.headerView.trackingScrollView =
      contentViewController.collectionView
    container.contentViewController = contentViewController
    let _ = container.view  // Force the view to load.
    container.headerViewController.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.headerViewController.headerView.frame.maxY)
    XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
    XCTAssertEqual(
      contentViewController.collectionView!.adjustedContentInset.top,
      container.headerViewController.headerView.maximumHeight)
  }

}
