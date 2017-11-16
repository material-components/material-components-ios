/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

import UIKit

import MaterialComponents.MaterialButtons

extension TabBarIndicatorTemplateExample {

  func makeAlignmentButton() -> MDCRaisedButton {
    let button = MDCRaisedButton()
    button.setTitle("Change Alignment", for: .normal)
    return button
  }

  func makeAppearanceButton() -> MDCRaisedButton {
    let button = MDCRaisedButton()
    button.setTitle("Change Appearance", for: .normal)
    return button
  }

  func makeAppBar() -> MDCAppBar {
    let appBar = MDCAppBar()

    self.addChildViewController(appBar.headerViewController)
    appBar.navigationBar.backgroundColor = UIColor.white
    appBar.headerViewController.headerView.backgroundColor = UIColor.white

    // Give the tab bar enough height to accomodate all possible item appearances.
    appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    appBar.headerViewController.headerView.minimumHeight = 128

    appBar.headerStackView.bottomBar = self.tabBar
    appBar.headerStackView.setNeedsLayout()
    return appBar
  }

  func setupExampleViews() {
    view.backgroundColor = UIColor.white
    appBar.addSubviewsToParent()

    // Set up buttons
    alignmentButton.translatesAutoresizingMaskIntoConstraints = false
    appearanceButton.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(alignmentButton)
    self.view.addSubview(appearanceButton)

    // Buttons are laid out relative to the safe area, if available.
    let alignmentGuide: Any
    #if swift(>=3.2)
      if #available(iOS 11.0, *) {
        alignmentGuide = view.safeAreaLayoutGuide
      } else {
        alignmentGuide = view
      }
    #else
      alignmentGuide = view
    #endif

    NSLayoutConstraint.activate([
      // Center alignment button
      NSLayoutConstraint(item: alignmentButton,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerX,
                         multiplier: 1,
                         constant: 0),
      NSLayoutConstraint(item: alignmentButton,
                         attribute: .bottom,
                         relatedBy: .equal,
                         toItem: alignmentGuide,
                         attribute: .bottom,
                         multiplier: 1,
                         constant: -40),

      // Place appearance button above
      NSLayoutConstraint(item: appearanceButton,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerX,
                         multiplier: 1,
                         constant: 0),
      NSLayoutConstraint(item: appearanceButton,
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
  override var childViewControllerForStatusBarStyle: UIViewController? {
    return appBar.headerViewController
  }
}

// MARK: - Catalog by convention
extension TabBarIndicatorTemplateExample {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Tab Bar", "Custom Selection Indicator"]
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
