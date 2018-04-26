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
import MaterialComponents.MaterialButtons_ButtonThemer

class ButtonsCustomFontViewController: UIViewController {

  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Buttons", "Buttons (Custom Font)"]
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Define our design data
    let buttonScheme = MDCButtonScheme()
    if let customFont = UIFont(name:"Zapfino", size:14.0) {
      let typographyScheme = MDCTypographyScheme()
      typographyScheme.button = customFont
      buttonScheme.typographyScheme = typographyScheme
    }

    // Apply our design data using the Material themers
    view.backgroundColor = buttonScheme.colorScheme.backgroundColor

    let flatButtonStatic = MDCButton()
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: flatButtonStatic)
    flatButtonStatic.setTitle("Static", for: UIControlState())
    flatButtonStatic.sizeToFit()
    flatButtonStatic.translatesAutoresizingMaskIntoConstraints = false
    flatButtonStatic.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(flatButtonStatic)

    let flatButtonDynamic = MDCButton()
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: flatButtonDynamic)
    flatButtonDynamic.setTitle("Dynamic", for: UIControlState())
    flatButtonDynamic.sizeToFit()
    flatButtonDynamic.translatesAutoresizingMaskIntoConstraints = false
    flatButtonDynamic.addTarget(self, action: #selector(tap), for: .touchUpInside)
    flatButtonDynamic.mdc_adjustsFontForContentSizeCategory = true
    view.addSubview(flatButtonDynamic)

    let views = [
      "flatStatic": flatButtonStatic,
      "flatDynamic": flatButtonDynamic
    ]

    centerView(view: flatButtonDynamic, onView: self.view)

    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:[flatStatic]-40-[flatDynamic]",
                                     options: .alignAllCenterX,
                                     metrics: nil,
                                     views: views))
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
