// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialButtons_ButtonThemer 
import MaterialComponents.MaterialButtons

extension TabBarIndicatorTemplateExample {

  private func themeButton(_ button: MDCButton) {
    let buttonScheme = MDCButtonScheme()
    buttonScheme.colorScheme = containerScheme.colorScheme
    buttonScheme.typographyScheme = containerScheme.typographyScheme
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: button)
  }

  func makeAlignmentButton() -> MDCButton {
    let button = MDCButton()
    themeButton(button)
    button.setTitle("Change Alignment", for: .normal)
    return button
  }

  func makeAppearanceButton() -> MDCButton {
    let button = MDCButton()
    themeButton(button)
    button.setTitle("Change Appearance", for: .normal)
    return button
  }

  func makeAppBar() -> MDCAppBarViewController {
    let appBarViewController = MDCAppBarViewController()

    self.addChild(appBarViewController)

    // Give the tab bar enough height to accomodate all possible item appearances.
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
    appBarViewController.headerView.minimumHeight = 128

    appBarViewController.headerStackView.bottomBar = self.tabBar
    appBarViewController.headerStackView.setNeedsLayout()
    return appBarViewController
  }

  func setupExampleViews() {
    view.backgroundColor = UIColor.white
    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)

    // Set up buttons
    alignmentButton.translatesAutoresizingMaskIntoConstraints = false
    appearanceButton.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(alignmentButton)
    self.view.addSubview(appearanceButton)

    // Buttons are laid out relative to the safe area, if available.
    let alignmentGuide: Any
    if #available(iOS 11.0, *) {
      alignmentGuide = view.safeAreaLayoutGuide
    } else {
      alignmentGuide = view
    }

    NSLayoutConstraint.activate([
      // Center alignment button
      NSLayoutConstraint(
        item: alignmentButton,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: self.view,
        attribute: .centerX,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: alignmentButton,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: alignmentGuide,
        attribute: .bottom,
        multiplier: 1,
        constant: -40),

      // Place appearance button above
      NSLayoutConstraint(
        item: appearanceButton,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: self.view,
        attribute: .centerX,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: appearanceButton,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: alignmentButton,
        attribute: .top,
        multiplier: 1,
        constant: -8),
    ])

    self.title = "Custom Selection Indicator"
  }
}

extension TabBarIndicatorTemplateExample {
  override var childForStatusBarStyle: UIViewController? {
    return appBarViewController
  }
}

// MARK: - Catalog by convention
extension TabBarIndicatorTemplateExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Tab Bar", "Custom Selection Indicator"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
