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

import Foundation
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialColorScheme

class BottomNavigationTitleVisibilityChangeExample: UIViewController, MDCBottomNavigationBarDelegate
{

  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
  let instructionLabel = UILabel()

  // Create a bottom navigation bar to add to a view.
  let bottomNavBar = MDCBottomNavigationBar()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = colorScheme.backgroundColor
    view.addSubview(bottomNavBar)

    // Always show bottom navigation bar item titles.
    bottomNavBar.titleVisibility = .always

    // Cluster and center the bottom navigation bar items.
    bottomNavBar.alignment = .centered

    // Add items to the bottom navigation bar.
    let tabBarItem1 = UITabBarItem(
      title: "Home", image: UIImage(named: "system_icons/home"), tag: 0)
    let tabBarItem2 =
      UITabBarItem(title: "Messages", image: UIImage(named: "system_icons/email"), tag: 1)
    let tabBarItem3 =
      UITabBarItem(title: "Favorites", image: UIImage(named: "system_icons/favorite"), tag: 2)
    bottomNavBar.items = [tabBarItem1, tabBarItem2, tabBarItem3]

    // Select a bottom navigation bar item.
    bottomNavBar.selectedItem = tabBarItem2

    bottomNavBar.delegate = self
    bottomNavBar.enableRippleBehavior = true
    addInstructionLabel()
  }

  func layoutBottomNavBar() {
    let size = bottomNavBar.sizeThatFits(view.bounds.size)
    var bottomNavBarFrame = CGRect(
      x: 0,
      y: view.bounds.height - size.height,
      width: size.width,
      height: size.height)
    bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
    bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
    bottomNavBar.frame = bottomNavBarFrame
  }

  func addInstructionLabel() {
    instructionLabel.numberOfLines = 0
    instructionLabel.textAlignment = .center
    instructionLabel.lineBreakMode = .byWordWrapping
    instructionLabel.text =
      "Choose the Home tab to make all titles disappear, and any other tab to make them reappear."
    view.addSubview(instructionLabel)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    var viewBounds = view.bounds
    viewBounds = viewBounds.inset(by: view.safeAreaInsets)
    let labelWidth = min(viewBounds.size.width - 32, 480)
    let labelSize = instructionLabel.sizeThatFits(
      CGSize(
        width: labelWidth,
        height: viewBounds.size.height))
    instructionLabel.bounds = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
    instructionLabel.center = CGPoint(x: viewBounds.midX, y: viewBounds.midY)

    layoutBottomNavBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  func bottomNavigationBar(
    _ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem
  ) {
    if item == bottomNavigationBar.items[0] {
      bottomNavigationBar.titleVisibility = .never
    } else {
      bottomNavigationBar.titleVisibility = .always
    }
  }
}

// MARK: Catalog by convention
extension BottomNavigationTitleVisibilityChangeExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Title Visibility (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
