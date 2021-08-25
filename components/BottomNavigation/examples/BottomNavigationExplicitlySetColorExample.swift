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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialContainerScheme

class BottomNavigationExplicitlySetColorExample: UIViewController {

  @objc let containerScheme = MDCContainerScheme()
  let bottomNavBar = MDCBottomNavigationBar()
  let redButton = MDCButton()
  let blueButton = MDCButton()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func layoutButtons() {
    redButton.frame.origin = CGPoint(
      x: view.center.x - (redButton.frame.width / 2),
      y: view.center.y - (redButton.frame.height + 16))
    blueButton.frame.origin = CGPoint(
      x: view.center.x - (blueButton.frame.width / 2),
      y: view.center.y + 16)
  }

  func layoutBottomNavBar() {
    let size = bottomNavBar.sizeThatFits(view.bounds.size)
    var bottomNavBarFrame = CGRect(
      x: 0,
      y: view.bounds.height - size.height,
      width: size.width,
      height: size.height)
    if #available(iOS 11.0, *) {
      bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
      bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
    }
    bottomNavBar.frame = bottomNavBarFrame
    bottomNavBar.enableRippleBehavior = true
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    layoutButtons()
    layoutBottomNavBar()
  }

  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    layoutBottomNavBar()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = MDCPalette.grey.tint300
    view.addSubview(bottomNavBar)

    bottomNavBar.alignment = .centered

    // Add items to the bottom navigation bar.
    let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), tag: 0)
    let tabBarItem2 =
      UITabBarItem(title: "Messages", image: UIImage(named: "ic_email"), tag: 1)
    let tabBarItem3 =
      UITabBarItem(title: "Favorites", image: UIImage(named: "ic_favorite"), tag: 2)
    bottomNavBar.items = [tabBarItem1, tabBarItem2, tabBarItem3]

    // Select a bottom navigation bar item.
    bottomNavBar.selectedItem = tabBarItem2

    // Layout buttons
    redButton.setTitle("Red theme", for: .normal)
    redButton.sizeToFit()
    redButton.backgroundColor = MDCPalette.red.tint300
    redButton.addTarget(self, action: #selector(redTheme), for: .touchUpInside)
    view.addSubview(redButton)

    blueButton.setTitle("Blue theme", for: .normal)
    blueButton.sizeToFit()
    blueButton.backgroundColor = MDCPalette.blue.tint300
    blueButton.addTarget(self, action: #selector(blueTheme), for: .touchUpInside)
    view.addSubview(blueButton)

    bottomNavBar.applyPrimaryTheme(withScheme: containerScheme)
    bottomNavBar.backgroundColor = MDCPalette.grey.tint700
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  @objc func redTheme(_ button: UIButton) {
    bottomNavBar.selectedItemTintColor = MDCPalette.red.tint300
    bottomNavBar.unselectedItemTintColor = MDCPalette.green.tint300
  }

  @objc func blueTheme(_ button: UIButton) {
    bottomNavBar.selectedItemTintColor = MDCPalette.blue.tint300
    bottomNavBar.unselectedItemTintColor = MDCPalette.yellow.tint300
  }
}

// MARK: Catalog by convention
extension BottomNavigationExplicitlySetColorExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Set Color (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
