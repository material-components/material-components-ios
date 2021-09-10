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
import MaterialComponents.MaterialUIMetrics

class FlexibleHeaderInjectionTopLayoutGuideTests: XCTestCase {

  var fhvc: MDCFlexibleHeaderViewController!

  override func setUp() {
    super.setUp()

    fhvc = MDCFlexibleHeaderViewController()
    fhvc.headerView.minMaxHeightIncludesSafeArea = false
    fhvc.headerView.minimumHeight = 50
    fhvc.headerView.maximumHeight = 100
  }

  override func tearDown() {
    fhvc = nil

    super.tearDown()
  }

  // MARK: No top layout guide view controller

  func testTopLayoutGuideIsUnaffactedWithNoTopLayoutGuideViewController() {
    // Given
    let contentViewController = UIViewController()
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.isTopLayoutGuideAdjustmentEnabled = true
    fhvc.topLayoutGuideViewController = nil
    fhvc.didMove(toParent: contentViewController)

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, 0)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
    }
  }

  // MARK: No scroll view

  func testNoScrollViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UIViewController()
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        fhvc.headerView.frame.maxY - MDCDeviceTopSafeAreaInset())
    }
  }

  func testNoScrollViewInferSafeAreaTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    if #available(iOS 11.0, *) {
      let contentViewController = UIViewController()
      contentViewController.addChild(fhvc)
      contentViewController.view.addSubview(fhvc.view)
      fhvc.permitInferringTopSafeAreaFromTopLayoutGuideViewController = true
      fhvc.inferTopSafeAreaInsetFromViewController = true
      fhvc.topLayoutGuideViewController = contentViewController
      fhvc.didMove(toParent: contentViewController)

      // Then
      XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, fhvc.headerView.frame.maxY)
    }
  }

  // MARK: Untracked table view

  func testUntrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UITableViewController()
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        fhvc.headerView.frame.maxY - MDCDeviceTopSafeAreaInset())
      XCTAssertEqual(contentViewController.tableView.adjustedContentInset.top, 0)
    }
  }

  func testTrackingAnUntrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UITableViewController()
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        fhvc.headerView.frame.maxY - MDCDeviceTopSafeAreaInset())
      XCTAssertEqual(contentViewController.tableView.adjustedContentInset.top, 0)
    }

    // And then when
    fhvc.headerView.trackingScrollView = contentViewController.tableView

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
      XCTAssertEqual(
        contentViewController.tableView.adjustedContentInset.top,
        fhvc.headerView.maximumHeight + MDCDeviceTopSafeAreaInset())
    }
  }

  // MARK: Tracked table view

  func testTrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let contentViewController = UITableViewController()
    fhvc.headerView.trackingScrollView = contentViewController.tableView
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)
    fhvc.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
      XCTAssertEqual(
        contentViewController.tableView.adjustedContentInset.top,
        fhvc.headerView.maximumHeight + MDCDeviceTopSafeAreaInset())
    }
  }

  func testTrackedTableViewTopLayoutGuideEqualsBottomEdgeOfHeaderViewAfterScrolling() {
    // Given
    let contentViewController = UITableViewController()
    contentViewController.tableView.contentSize =
      CGSize(
        width: contentViewController.tableView.bounds.width,
        height: contentViewController.tableView.bounds.height * 2)
    fhvc.headerView.trackingScrollView = contentViewController.tableView
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)
    fhvc.headerView.trackingScrollDidScroll()
    contentViewController.tableView.contentOffset =
      CGPoint(x: 0, y: -contentViewController.tableView.contentInset.top)
    fhvc.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(
      contentViewController.topLayoutGuide.length,
      fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
      XCTAssertEqual(
        contentViewController.tableView.adjustedContentInset.top,
        fhvc.headerView.maximumHeight + MDCDeviceTopSafeAreaInset())
    }
  }

  // MARK: Untracked collection view

  func testUntrackedCollectionViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let flow = UICollectionViewFlowLayout()
    let contentViewController = UICollectionViewController(collectionViewLayout: flow)
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(
        contentViewController.additionalSafeAreaInsets.top,
        fhvc.headerView.frame.maxY - MDCDeviceTopSafeAreaInset())
      XCTAssertEqual(contentViewController.collectionView!.adjustedContentInset.top, 0)
    }
  }

  // MARK: Tracked collection view view

  func testTrackedCollectionViewTopLayoutGuideEqualsBottomEdgeOfHeaderView() {
    // Given
    let flow = UICollectionViewFlowLayout()
    let contentViewController = UICollectionViewController(collectionViewLayout: flow)
    fhvc.headerView.trackingScrollView = contentViewController.collectionView
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)
    fhvc.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
      XCTAssertEqual(
        contentViewController.collectionView!.adjustedContentInset.top,
        fhvc.headerView.maximumHeight + MDCDeviceTopSafeAreaInset())
    }
  }

  func testTrackedCollectionViewTopLayoutGuideEqualsBottomEdgeOfHeaderViewAfterScrolling() {
    // Given
    let flow = UICollectionViewFlowLayout()
    let contentViewController = UICollectionViewController(collectionViewLayout: flow)
    contentViewController.collectionView!.contentSize =
      CGSize(
        width: contentViewController.collectionView!.bounds.width,
        height: contentViewController.collectionView!.bounds.height * 2)
    fhvc.headerView.trackingScrollView = contentViewController.collectionView!
    contentViewController.addChild(fhvc)
    contentViewController.view.addSubview(fhvc.view)
    fhvc.topLayoutGuideViewController = contentViewController
    fhvc.didMove(toParent: contentViewController)
    fhvc.headerView.trackingScrollDidScroll()
    contentViewController.collectionView!.contentOffset =
      CGPoint(x: 0, y: -contentViewController.collectionView!.contentInset.top)
    fhvc.headerView.trackingScrollDidScroll()

    // Then
    XCTAssertEqual(contentViewController.topLayoutGuide.length, fhvc.headerView.frame.maxY)
    if #available(iOS 11.0, *) {
      XCTAssertEqual(contentViewController.additionalSafeAreaInsets.top, 0)
      XCTAssertEqual(
        contentViewController.collectionView!.adjustedContentInset.top,
        fhvc.headerView.maximumHeight + MDCDeviceTopSafeAreaInset())
    }
  }

}
