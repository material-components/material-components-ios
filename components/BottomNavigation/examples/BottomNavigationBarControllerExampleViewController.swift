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

import UIKit

import MaterialComponentsBeta.MaterialBottomNavigationBeta
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialBottomNavigation_Theming
import MaterialComponents.MaterialContainerScheme

class BottomNavigationControllerExampleFixedChildViewController: UIViewController {

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = containerScheme.colorScheme.secondaryColor
  }

  override var prefersHomeIndicatorAutoHidden: Bool {
    return false
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }

  override var prefersStatusBarHidden: Bool {
    return false
  }
}

class BottomNavigationControllerExampleScrollableChildViewController: UICollectionViewController {

  let numberOfItems = 200

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

    if #available(iOS 11.0, *) {
      collectionView.contentInsetAdjustmentBehavior = .always
      collectionView.insetsLayoutMarginsFromSafeArea = true
    }
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberOfItems
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let hue = CGFloat(indexPath.row) / CGFloat(numberOfItems)
    cell.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
    return cell
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  override var prefersHomeIndicatorAutoHidden: Bool {
    return true
  }
}

class BottomNavigationControllerExampleViewController: MDCBottomNavigationBarController {

  var containerScheme: MDCContainerScheming = MDCContainerScheme() {
    didSet {
      apply(containerScheme: containerScheme)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationBar.alignment = .justifiedAdjacentTitles

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.estimatedItemSize = CGSize(width: 96, height: 48)
    let viewController1 = BottomNavigationControllerExampleScrollableChildViewController(collectionViewLayout: flowLayout)
    viewController1.collectionView.backgroundColor = containerScheme.colorScheme.primaryColorVariant
    viewController1.tabBarItem = UITabBarItem(title: "Item 1", image: UIImage(named: "Home"), tag: 0)

    let viewController2 = BottomNavigationControllerExampleFixedChildViewController()
    viewController2.containerScheme = containerScheme
    viewController2.tabBarItem = UITabBarItem(title: "Item 2", image: UIImage(named: "Favorite"), tag: 1)

    let viewController3 = UIViewController()
    viewController3.view.backgroundColor = containerScheme.colorScheme.surfaceColor
    viewController3.tabBarItem = UITabBarItem(title: "Item 3", image: UIImage(named: "Search"), tag: 2)

    viewControllers = [ viewController1, viewController2, viewController3 ]
  }

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Controller"],
      "presentable": false
    ]
  }
}

// MARK: Private Functions

extension BottomNavigationControllerExampleViewController {
  fileprivate func apply(containerScheme: MDCContainerScheming) {
    navigationBar.applyPrimaryTheme(withScheme: containerScheme)
  }
}
