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
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialUIMetrics

class AppBarWrappingTopLayoutGuideTests: XCTestCase {

  // MARK: No scroll view

  func testNoScrollViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UIViewController()
    let container = MDCAppBarContainerViewController(contentViewController: contentViewController)
    container.appBar.inferTopSafeAreaInsetFromViewController = true
    container.isTopLayoutGuideAdjustmentEnabled = true
    container.appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    container.appBar.headerViewController.headerView.minimumHeight = 50
    container.appBar.headerViewController.headerView.maximumHeight = 100
    let _ = container.view  // Force the view to load.

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.appBar.headerViewController.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        container.appBar.headerViewController.headerView.frame.maxY
          - MDCDeviceTopSafeAreaInset())
    }
  }

  func testEarlyViewLoadStillAffectsTopLayoutGuide() {
    // Given
    let contentViewController = UIViewController()
    let container = MDCAppBarContainerViewController(contentViewController: contentViewController)
    container.appBar.inferTopSafeAreaInsetFromViewController = true
    container.isTopLayoutGuideAdjustmentEnabled = true
    container.appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    container.appBar.headerViewController.headerView.minimumHeight = 50
    container.appBar.headerViewController.headerView.maximumHeight = 100
    let _ = container.view  // Force the view to load.

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.appBar.headerViewController.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        container.appBar.headerViewController.headerView.frame.maxY
          - MDCDeviceTopSafeAreaInset())
    }
  }

  // MARK: Untracked table view

  func testUntrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UITableViewController()
    let container = MDCAppBarContainerViewController(contentViewController: contentViewController)
    container.appBar.inferTopSafeAreaInsetFromViewController = true
    container.isTopLayoutGuideAdjustmentEnabled = true
    container.appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    container.appBar.headerViewController.headerView.minimumHeight = 50
    container.appBar.headerViewController.headerView.maximumHeight = 100
    let _ = container.view  // Force the view to load.

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.appBar.headerViewController.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        container.appBar.headerViewController.headerView.frame.maxY
          - MDCDeviceTopSafeAreaInset())
      XCTAssertEqual(contentViewController.tableView.adjustedContentInset.top, 0)
    }
  }

  // MARK: Tracked table view

  func testTrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UITableViewController()

    let container = MDCAppBarContainerViewController(contentViewController: contentViewController)
    container.appBar.inferTopSafeAreaInsetFromViewController = true
    container.isTopLayoutGuideAdjustmentEnabled = true
    container.appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    container.appBar.headerViewController.headerView.minimumHeight = 50
    container.appBar.headerViewController.headerView.maximumHeight = 100
    let _ = container.view  // Force the view to load.

    container.appBar.headerViewController.headerView.trackingScrollView =
      contentViewController.tableView
    container.appBar.headerViewController.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.appBar.headerViewController.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
      XCTAssertEqual(
        contentViewController.tableView.adjustedContentInset.top,
        container.appBar.headerViewController.headerView.maximumHeight)
    }
  }

  // MARK: Untracked collection view

  func testUntrackedCollectionViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let flow = UICollectionViewFlowLayout()
    let contentViewController = UICollectionViewController(collectionViewLayout: flow)

    let container = MDCAppBarContainerViewController(contentViewController: contentViewController)
    container.appBar.inferTopSafeAreaInsetFromViewController = true
    container.isTopLayoutGuideAdjustmentEnabled = true
    container.appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    container.appBar.headerViewController.headerView.minimumHeight = 50
    container.appBar.headerViewController.headerView.maximumHeight = 100
    let _ = container.view  // Force the view to load.

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.appBar.headerViewController.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        container.appBar.headerViewController.headerView.frame.maxY
          - MDCDeviceTopSafeAreaInset())
      XCTAssertEqual(contentViewController.collectionView!.adjustedContentInset.top, 0)
    }
  }

  // MARK: Tracked collection view view

  func testTrackedCollectionViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let flow = UICollectionViewFlowLayout()
    let contentViewController = UICollectionViewController(collectionViewLayout: flow)

    let container = MDCAppBarContainerViewController(contentViewController: contentViewController)
    container.appBar.inferTopSafeAreaInsetFromViewController = true
    container.isTopLayoutGuideAdjustmentEnabled = true
    container.appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    container.appBar.headerViewController.headerView.minimumHeight = 50
    container.appBar.headerViewController.headerView.maximumHeight = 100
    let _ = container.view  // Force the view to load.

    container.appBar.headerViewController.headerView.trackingScrollView =
      contentViewController.collectionView
    container.appBar.headerViewController.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(contentViewController.view.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    XCTAssertEqual(contentViewController.view.frame, container.view.bounds)
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      container.appBar.headerViewController.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
      XCTAssertEqual(
        contentViewController.collectionView!.adjustedContentInset.top,
        container.appBar.headerViewController.headerView.maximumHeight)
    }
  }

}
