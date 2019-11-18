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

import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialButtons_Theming

class ButtonsDynamicTypeViewController: UIViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Buttons (DynamicType)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc var containerScheme = MDCContainerScheme()
  var flatButtonDynamic = MDCButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha:1.0)
    let titleColor = UIColor.white
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)

    let flatButtonStatic = MDCButton()
    flatButtonStatic.applyContainedTheme(withScheme: containerScheme)
    flatButtonStatic.setTitleColor(titleColor, for: .normal)
    flatButtonStatic.setBackgroundColor(backgroundColor, for: .normal)
    flatButtonStatic.setTitle("Static", for: UIControl.State())
    flatButtonStatic.sizeToFit()
    flatButtonStatic.translatesAutoresizingMaskIntoConstraints = false
    flatButtonStatic.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(flatButtonStatic)

    containerScheme.typographyScheme = MDCTypographyScheme.init(defaults: .material201902)
    flatButtonDynamic.applyContainedTheme(withScheme: containerScheme)
    flatButtonDynamic.setTitleColor(titleColor, for: .normal)
    flatButtonDynamic.setBackgroundColor(backgroundColor, for: .normal)
    flatButtonDynamic.setTitle("Dynamic", for: UIControl.State())
    flatButtonDynamic.sizeToFit()
    flatButtonDynamic.translatesAutoresizingMaskIntoConstraints = false
    flatButtonDynamic.addTarget(self, action: #selector(tap), for: .touchUpInside)
    flatButtonDynamic.mdc_adjustsFontForContentSizeCategory = true
    view.addSubview(flatButtonDynamic)

    containerScheme.typographyScheme = MDCTypographyScheme.init(defaults: .material201804)
    let flatButtonDynamicLegacy = MDCButton()
    flatButtonDynamicLegacy.applyContainedTheme(withScheme: containerScheme)
    flatButtonDynamicLegacy.setTitleColor(titleColor, for: .normal)
    flatButtonDynamicLegacy.setBackgroundColor(backgroundColor, for: .normal)
    flatButtonDynamicLegacy.setTitle("Dynamic (legacy)", for: UIControl.State())
    flatButtonDynamicLegacy.sizeToFit()
    flatButtonDynamicLegacy.translatesAutoresizingMaskIntoConstraints = false
    flatButtonDynamicLegacy.addTarget(self, action: #selector(tap), for: .touchUpInside)
    flatButtonDynamicLegacy.mdc_adjustsFontForContentSizeCategory = true
    flatButtonDynamicLegacy.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = true
    view.addSubview(flatButtonDynamicLegacy)

    let views = [
      "flatStatic": flatButtonStatic,
      "flatDynamic": flatButtonDynamic,
      "flatDynamicLegacy": flatButtonDynamicLegacy,
    ]

    centerView(view: flatButtonDynamic, onView: self.view)

    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat:
          "V:[flatStatic]-40-[flatDynamic]-40-[flatDynamicLegacy]",
              options: .alignAllCenterX, metrics: nil, views: views))
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    let buttonFont = containerScheme.typographyScheme.button.mdc_scaledFont(for: view)
    flatButtonDynamic.setTitleFont(buttonFont, for: .normal)
  }

  // MARK: Private

  func centerView(view: UIView, onView: UIView) {
    onView.addConstraint(NSLayoutConstraint(
      item: view,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: onView,
      attribute: .centerX,
      multiplier: 1.0,
      constant: 0.0))

    onView.addConstraint(NSLayoutConstraint(
      item: view,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: onView,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 0.0))
  }

  @objc func tap(_ sender: Any) {
    print("\(type(of: sender)) was tapped.")
  }

}
