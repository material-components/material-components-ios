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

import MaterialComponents.MaterialButtons_Theming

class ButtonsDynamicTypeViewController: UIViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Buttons (DynamicType)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  func containerToday() {
    // Shared app logic
    let containerScheme = MDCContainerScheme(defaults: .defaults201811)

    // Repeated frequently throughout the app
    let button = MDCButton()
    button.applyContainedTheme(withScheme: containerScheme)

    button.applyTextTheme(withScheme: containerScheme)
  }

  func containerWithNewSubsystem() {
    // To opt in to the new subsystem, a new scheme must be created and configured.
    // All users of this scheme will automatically update with the new mappings.

    // Shared app logic
    let containerScheme = MDCContainerScheme(defaults: .defaults201811)
    containerScheme.motionScheme = MDCMotionScheme(/* defaults */) // New code

    // Repeated frequently throughout the app
    let button = MDCButton()
    button.applyContainedTheme(withScheme: containerScheme) // Now uses motion

    button.applyTextTheme(withScheme: containerScheme) // Now uses motion
  }

  func containerTodayThirdParty() {
    // Shared app logic
    let containerScheme = ThirdPartyContainerScheme(defaults: .defaults201811)

    // Repeated frequently throughout the app
    let button = MDCButton()
    button.thirdparty_applyContainedTheme(withScheme: containerScheme)

    button.thirdparty_applyFancyTheme(withScheme: containerScheme)
  }

  func explicitToday() {
    // Shared app logic
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)

    // Repeated frequently throughout the app
    let button = MDCButton()
    button
      .applyContainedTheme(withColorScheme: colorScheme)
      .applyContainedTheme(withTypographyScheme: typographyScheme)
      // Where do straggler APIs get set in order to get this component to Baseline?

    button
      .applyTextTheme(withColorScheme: colorScheme)
      .applyTextTheme(withTypographyScheme: typographyScheme)
  }

  func explicitWithNewSubsystem() {
    // Shared app logic
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)
    let motionScheme = MDCMotionScheme(/* defaults */)

    // Repeated frequently throughout the app
    let button = MDCButton()
    button
      .applyContainedTheme(withColorScheme: colorScheme)
      .applyContainedTheme(withTypographyScheme: typographyScheme)
      .applyContainedTheme(withMotionScheme: motionScheme) // New code

    button
      .applyTextTheme(withColorScheme: colorScheme)
      .applyTextTheme(withTypographyScheme: typographyScheme)
      .applyTextTheme(withMotionScheme: motionScheme) // New code
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha:1.0)
    let titleColor = UIColor.white
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)

    let flatButtonStatic = MDCRaisedButton()
    flatButtonStatic.setTitleColor(titleColor, for: .normal)
    flatButtonStatic.setBackgroundColor(backgroundColor, for: .normal)
    flatButtonStatic.setTitle("Static", for: UIControlState())
    flatButtonStatic.sizeToFit()
    flatButtonStatic.translatesAutoresizingMaskIntoConstraints = false
    flatButtonStatic.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(flatButtonStatic)

    let flatButtonDynamic = MDCRaisedButton()
    flatButtonDynamic.setTitleColor(titleColor, for: .normal)
    flatButtonDynamic.setBackgroundColor(backgroundColor, for: .normal)
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
