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
import CoreGraphics

import MaterialComponents.MaterialAppBar_ColorThemer
import MaterialComponents.MaterialAppBar_TypographyThemer
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTabs
import MaterialComponents.MaterialTabs_Theming

class TabBarIndicatorTemplateExample: UIViewController {

  // MARK: Properties
  var alignment: MDCTabBarAlignment {
    get {
      return tabBar.alignment
    }
    set(newAlignment) {
      tabBar.setAlignment(newAlignment, animated: true)
    }
  }

  var itemAppearance: MDCTabBarItemAppearance {
    get {
      return tabBar.itemAppearance
    }
    set {
      tabBar.itemAppearance = newValue

      // itemAppearance affects the height of the tab bar.
      appBarViewController.headerStackView.setNeedsLayout()
    }
  }

  lazy var alignmentButton: MDCButton = self.makeAlignmentButton()
  lazy var appearanceButton: MDCButton = self.makeAppearanceButton()
  lazy var appBarViewController: MDCAppBarViewController = self.makeAppBar()
  @objc var containerScheme = MDCContainerScheme()

  lazy var tabBar: MDCTabBar = {
    let tabBar = MDCTabBar()
    tabBar.alignment = .justified

    tabBar.applyPrimaryTheme(withScheme: containerScheme)

    let bundle = Bundle(for: TabBarIndicatorTemplateExample.self)
    let info = UIImage.init(named: "TabBarDemo_ic_info", in: bundle, compatibleWith:nil)
    let star = UIImage.init(named: "TabBarDemo_ic_star", in: bundle, compatibleWith:nil)
    tabBar.items = [
      UITabBarItem(title: "Fly", image: info, tag:0),
      UITabBarItem(title: "Sleep", image: star, tag:0),
      UITabBarItem(title: "Eat", image: info, tag:0),
    ]

    // Set lighter ink so the indicator animation is more visible.
    tabBar.inkColor = UIColor.white.withAlphaComponent(0.15)

    tabBar.itemAppearance = .titles

    // Configure custom title fonts
    tabBar.selectedItemTitleFont = UIFont.boldSystemFont(ofSize: 12)
    tabBar.unselectedItemTitleFont = UIFont.systemFont(ofSize: 12)

    // Configure custom indicator template
    tabBar.selectionIndicatorTemplate = IndicatorTemplate()
    return tabBar
  }()

  // MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    setupExampleViews()

    alignmentButton.addTarget(
      self,
      action:#selector(changeAlignmentDidTouch(sender:)),
      for: .touchUpInside)
    appearanceButton.addTarget(
      self,
      action: #selector(changeAppearance),
      for: .touchUpInside)

    MDCAppBarColorThemer.applyColorScheme(containerScheme.colorScheme, to: self.appBarViewController)
    MDCAppBarTypographyThemer.applyTypographyScheme(containerScheme.typographyScheme,
                                                    to: self.appBarViewController)
  }

  @objc func changeAlignmentDidTouch(sender: UIButton) {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    sheet.popoverPresentationController?.sourceView = self.alignmentButton
    sheet.popoverPresentationController?.sourceRect = self.alignmentButton.bounds
    sheet.addAction(UIAlertAction(title: "Leading", style: .default, handler: { _ in
      self.alignment = .leading
    }))
    sheet.addAction(UIAlertAction(title: "Center", style: .default, handler: { _ in
      self.alignment = .center
    }))
    sheet.addAction(UIAlertAction(title: "Justified", style: .default, handler: { _ in
      self.alignment = .justified
    }))
    sheet.addAction(UIAlertAction(title: "Selected Center", style: .default, handler: { _ in
      self.alignment = .centerSelected
    }))
    present(sheet, animated: true, completion:nil)
  }

  @objc func changeAppearance(fromSender sender: UIButton) {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    sheet.popoverPresentationController?.sourceView = self.appearanceButton
    sheet.popoverPresentationController?.sourceRect = self.appearanceButton.bounds
    sheet.addAction(UIAlertAction(title: "Titles", style: .default, handler: { _ in
      self.itemAppearance = .titles
    }))
    sheet.addAction(UIAlertAction(title: "Images", style: .default, handler: { _ in
      self.itemAppearance = .images
    }))
    sheet.addAction(UIAlertAction(title: "Titled Images", style: .default, handler: { _ in
      self.itemAppearance = .titledImages
    }))
    present(sheet, animated: true, completion:nil)
  }

  // MARK: Private

  class IndicatorTemplate: NSObject, MDCTabBarIndicatorTemplate {
    func indicatorAttributes(
      for context: MDCTabBarIndicatorContext
    ) -> MDCTabBarIndicatorAttributes {
      let attributes = MDCTabBarIndicatorAttributes()
      // Outset frame, round corners, and stroke.
      let indicatorFrame = context.contentFrame.insetBy(dx: -8, dy: -4)
      let path = UIBezierPath(roundedRect: indicatorFrame, cornerRadius: 4)
      attributes.path = path.stroked(withWidth: 2)
      return attributes
    }
  }
}

extension UIBezierPath {
  /// Returns a copy of the path, stroked with the given line width.
  func stroked(withWidth width: CGFloat) -> UIBezierPath {
    let strokedPath = cgPath.copy(
      strokingWithWidth: width,
      lineCap: .butt,
      lineJoin: .miter,
      miterLimit: 0)
    return UIBezierPath(cgPath: strokedPath)
  }
}
