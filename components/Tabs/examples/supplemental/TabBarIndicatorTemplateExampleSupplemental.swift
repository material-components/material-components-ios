/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

// swiftlint:disable function_body_length
// swiftlint:disable line_length

import UIKit

import MaterialComponents.MaterialButtons

extension TabBarIndicatorTemplateExample {

  func setupAlignmentButton() -> MDCRaisedButton {
    let alignmentButton = MDCRaisedButton()

    alignmentButton.setTitle("Change Alignment", for: .normal)
    alignmentButton.setTitleColor(.white, for: .normal)

    self.view.addSubview(alignmentButton)
    alignmentButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint(item: alignmentButton,
                       attribute: .centerX,
                       relatedBy: .equal,
                       toItem: self.view,
                       attribute: .centerX,
                       multiplier: 1,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: alignmentButton,
                       attribute: .bottom,
                       relatedBy: .equal,
                       toItem: self.view,
                       attribute: .bottom,
                       multiplier: 1,
                       constant: -40).isActive = true

    return alignmentButton
  }

  func setupAppBar() -> MDCAppBar {
    let appBar = MDCAppBar()

    self.addChildViewController(appBar.headerViewController)
    appBar.navigationBar.backgroundColor = UIColor.white

    appBar.headerViewController.headerView.backgroundColor = UIColor.white
    appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    appBar.headerViewController.headerView.minimumHeight = 56 + 72
    appBar.headerViewController.headerView.tintColor = MDCPalette.blue.tint500

    appBar.headerStackView.bottomBar = self.tabBar
    appBar.headerStackView.setNeedsLayout()
    return appBar
  }

  func setupExampleViews() {
    view.backgroundColor = UIColor.white

    appBar.addSubviewsToParent()

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
