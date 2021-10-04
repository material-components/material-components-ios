// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_Theming 
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialCards_Theming 
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialContainerScheme

/// An example for testing the performance of `MDCShadowLayer`. This example is not intended to
/// demonstrate how to setup any specific components but rather to push `MDCShadowLayer` to the
/// limits for metric testing.
class MDCShadowPerformanceExample:
  UIViewController,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout
{

  /// Injected `MDCAppBarViewController` so we can render the shadow on it.
  lazy var appBar = makeAppBar()

  /// The _plus_ FAB.
  let createButton = MDCFloatingButton()

  /// Used to render a _top_ shadow on a component that is pinned to the bottom.
  let bottomNavBar = MDCBottomNavigationBar()

  /// Used for styling the sub components based on the app container scheme.
  // `@objc` is required for `setupTransition` to work within `MDCDragonsController`.
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  /// The main scroll view content.
  let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout())

  /// Number of cells in the `collectionView`.
  let cellCount = 200

  /// Cell reuse identifier.
  let cellIdentifier = "Cell"

  /// Padding between cells.
  let defaultPadding: CGFloat = 8

  /// The title of the example
  fileprivate static let exampleTitle = "Shadow & Performance"

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    appBar.headerView.observesTrackingScrollViewScrollEvents = true
    appBar.applyPrimaryTheme(withScheme: containerScheme)
    appBar.didMove(toParent: self)
    appBar.navigationBar.title = MDCShadowPerformanceExample.exampleTitle

    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = containerScheme.colorScheme.backgroundColor
    collectionView.alwaysBounceVertical = true
    collectionView.register(MDCCardCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    view.addSubview(appBar.view)
    appBar.headerView.trackingScrollView = collectionView

    createButton.sizeToFit()
    let plusImage = UIImage(named: "ic_add")
    createButton.setImage(plusImage, for: .normal)
    createButton.accessibilityLabel = "Create"
    createButton.applySecondaryTheme(withScheme: containerScheme)
    view.addSubview(createButton)

    view.addSubview(bottomNavBar)
    bottomNavBar.titleVisibility = .always
    bottomNavBar.alignment = .centered
    bottomNavBar.enableRippleBehavior = true
    let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), tag: 0)
    let tabBarItem2 =
      UITabBarItem(title: "Messages", image: UIImage(named: "ic_email"), tag: 1)
    bottomNavBar.items = [tabBarItem1, tabBarItem2]
    bottomNavBar.selectedItem = tabBarItem2
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    let width = view.bounds.width
    let height = view.bounds.height
    var safeArea: UIEdgeInsets = .zero
    safeArea = view.safeAreaInsets
    collectionView.contentInsetAdjustmentBehavior = .always

    collectionView.frame = CGRect(
      origin: .zero, size: CGSize(width: width, height: height - (safeArea.bottom + safeArea.top)))

    let size = bottomNavBar.sizeThatFits(view.bounds.size)
    var bottomNavBarFrame = CGRect(
      x: 0,
      y: height - size.height,
      width: size.width,
      height: size.height)
    bottomNavBarFrame.size.height += safeArea.bottom
    bottomNavBarFrame.origin.y -= safeArea.bottom
    bottomNavBar.frame = bottomNavBarFrame

    let createButtonDimension: CGFloat = 56
    let createButtonPadding: CGFloat = 16
    createButton.frame = CGRect(
      x: width - (createButtonDimension + safeArea.left + createButtonPadding),
      y: bottomNavBarFrame.origin.y - (createButtonDimension + createButtonPadding),
      width: createButtonDimension,
      height: createButtonDimension
    )
  }

  private func makeAppBar() -> MDCAppBarViewController {
    let appBarViewController = MDCAppBarViewController()
    addChild(appBarViewController)
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
    appBarViewController.inferTopSafeAreaInsetFromViewController = true
    appBarViewController.headerView.canOverExtend = false
    return appBarViewController
  }

  // MARK: Collection View methods

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellIdentifier, for: indexPath)
    guard let cardCell = cell as? MDCCardCollectionCell else { return cell }

    cardCell.enableRippleBehavior = true
    cardCell.isAccessibilityElement = true
    cardCell.accessibilityLabel = title
    cardCell.setShadowElevation(.cardResting, for: .normal)
    cardCell.applyTheme(withScheme: containerScheme)

    return cardCell
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return cellCount
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let cardSize = (collectionView.bounds.size.width / 3) - 12
    return CGSize(width: cardSize, height: cardSize)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(
      top: defaultPadding,
      left: defaultPadding,
      bottom: defaultPadding,
      right: defaultPadding
    )
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return defaultPadding
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return defaultPadding
  }
}

// MARK: Catalog by convention
extension MDCShadowPerformanceExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow", MDCShadowPerformanceExample.exampleTitle],
      "primaryDemo": false,
      "presentable": true,
      "description": """
        This example is not intended to demonstrate how to setup any specific components but rather to
        push `MDCShadowLayer` to the limits for metric testing.
        """,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
