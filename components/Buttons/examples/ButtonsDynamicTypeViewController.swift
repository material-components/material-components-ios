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
import MaterialComponentsBeta.MaterialButtons_Theming
import MaterialComponentsBeta.MaterialContainerScheme

class ButtonsDynamicTypeViewController: UIViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Buttons (DynamicType)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  var containerScheme = MDCContainerScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha:1.0)
    let titleColor = UIColor.white
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)

    let flatButtonStatic = MDCButton()
    flatButtonStatic.applyContainedTheme(withScheme: containerScheme)
    flatButtonStatic.setTitleColor(titleColor, for: .normal)
    flatButtonStatic.setBackgroundColor(backgroundColor, for: .normal)
    flatButtonStatic.setTitle("Static", for: UIControlState())
    flatButtonStatic.sizeToFit()
    flatButtonStatic.translatesAutoresizingMaskIntoConstraints = false
    flatButtonStatic.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(flatButtonStatic)

    containerScheme.typographyScheme = MDCTypographyScheme.init(defaults: .material201902)
    let flatButtonDynamicM2 = MDCButton()
    flatButtonDynamicM2.applyContainedTheme(withScheme: containerScheme)
    flatButtonDynamicM2.setTitleColor(titleColor, for: .normal)
    flatButtonDynamicM2.setBackgroundColor(backgroundColor, for: .normal)
    flatButtonDynamicM2.setTitle("Dynamic", for: UIControlState())
    flatButtonDynamicM2.sizeToFit()
    flatButtonDynamicM2.translatesAutoresizingMaskIntoConstraints = false
    flatButtonDynamicM2.addTarget(self, action: #selector(tap), for: .touchUpInside)
    flatButtonDynamicM2.mdc_adjustsFontForContentSizeCategory = true
    view.addSubview(flatButtonDynamicM2)

    containerScheme.typographyScheme = MDCTypographyScheme.init(defaults: .material201804)
    let flatButtonDynamicM1 = MDCButton()
    flatButtonDynamicM1.applyContainedTheme(withScheme: containerScheme)
    flatButtonDynamicM1.setTitleColor(titleColor, for: .normal)
    flatButtonDynamicM1.setBackgroundColor(backgroundColor, for: .normal)
    flatButtonDynamicM1.setTitle("Dynamic (legacy)", for: UIControlState())
    flatButtonDynamicM1.sizeToFit()
    flatButtonDynamicM1.translatesAutoresizingMaskIntoConstraints = false
    flatButtonDynamicM1.addTarget(self, action: #selector(tap), for: .touchUpInside)
    flatButtonDynamicM1.mdc_adjustsFontForContentSizeCategory = true
    flatButtonDynamicM1.mdc_legacyFontScaling = true
    view.addSubview(flatButtonDynamicM1)

    let views = [
      "flatStatic": flatButtonStatic,
      "flatDynamicM2": flatButtonDynamicM2,
      "flatDynamicM1": flatButtonDynamicM1,
    ]

    centerView(view: flatButtonDynamicM2, onView: self.view)

    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat:
          "V:[flatStatic]-40-[flatDynamicM2]-40-[flatDynamicM1]", options: .alignAllCenterX,
              metrics: nil, views: views))
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
