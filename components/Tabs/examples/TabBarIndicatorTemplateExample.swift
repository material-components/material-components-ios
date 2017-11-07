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
import CoreGraphics

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialTabs

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

  lazy var alignmentButton: MDCRaisedButton = self.setupAlignmentButton()

  lazy var appBar: MDCAppBar = self.setupAppBar()

  lazy var tabBar: MDCTabBar = {
    let tabBar = MDCTabBar()
    tabBar.alignment = .justified

    tabBar.items = [
      UITabBarItem(title: "Fly", image: nil, tag:0),
      UITabBarItem(title: "Sleep", image: nil, tag:0),
      UITabBarItem(title: "Eat", image: nil, tag:0),
    ]

    let blue = MDCPalette.blue.tint500
    tabBar.tintColor = blue
    tabBar.inkColor = blue.withAlphaComponent(0.15)

    tabBar.barTintColor = UIColor.white
    tabBar.itemAppearance = .titles
    tabBar.selectedItemTintColor = UIColor.black.withAlphaComponent(0.87)
    tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.38)

    // Configure custom indicator template
    tabBar.selectionIndicatorTemplate = IndicatorTemplate()

    return tabBar
  }()

  // MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    setupExampleViews()

    alignmentButton.addTarget(self,
                              action:#selector(changeAlignmentDidTouch(sender:)),
                              for: .touchUpInside)
  }

  @objc func changeAlignmentDidTouch(sender: UIButton) {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
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
