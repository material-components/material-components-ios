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

import Foundation
import UIKit

import MaterialComponents.MaterialButtons_ButtonThemer

class ButtonsSimpleExampleSwiftViewController: UIViewController {

  let floatingButtonPlusDimension = CGFloat(24)
  let kMinimumAccessibleButtonSize = CGSize(width: 64, height: 48)
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    //let titleColor = UIColor.white
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    let buttonScheme = MDCButtonScheme()
    
    let containedButton = MDCButton()
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: containedButton)
    containedButton.setTitle("Tap Me Too", for: UIControlState())
    containedButton.sizeToFit()
    let containedButtonVerticalInset =
      min(0, -(kMinimumAccessibleButtonSize.height - containedButton.bounds.height) / 2);
    let containedButtonHorizontalInset =
      min(0, -(kMinimumAccessibleButtonSize.width - containedButton.bounds.width) / 2);
    containedButton.hitAreaInsets =
      UIEdgeInsetsMake(containedButtonVerticalInset, containedButtonHorizontalInset,
                       containedButtonVerticalInset, containedButtonHorizontalInset);
    containedButton.translatesAutoresizingMaskIntoConstraints = false
    containedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(containedButton)

    let textButton = MDCButton()
    MDCTextButtonThemer.applyScheme(buttonScheme, to: textButton)
    textButton.setTitle("Touch me", for: UIControlState())
    textButton.sizeToFit()
    let textButtonVerticalInset =
      min(0, -(kMinimumAccessibleButtonSize.height - textButton.bounds.height) / 2);
    let textButtonHorizontalInset =
      min(0, -(kMinimumAccessibleButtonSize.width - textButton.bounds.width) / 2);
    textButton.hitAreaInsets =
      UIEdgeInsetsMake(textButtonVerticalInset, textButtonHorizontalInset,
                       textButtonVerticalInset, textButtonHorizontalInset);
    textButton.translatesAutoresizingMaskIntoConstraints = false
    textButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(textButton)

    let floatingButton = MDCFloatingButton()
    floatingButton.backgroundColor = backgroundColor
    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(tap), for: .touchUpInside)

    let plusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(plusShapeLayer)
    floatingButton.accessibilityLabel = "Create"

    view.addSubview(floatingButton)

    let views = [
      "contained": containedButton,
      "text": textButton,
      "floating": floatingButton
    ]

    centerView(view: textButton, onView: self.view)

    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:[contained]-40-[text]-40-[floating]",
        options: .alignAllCenterX,
        metrics: nil,
        views: views))
  }

  // MARK: Private

  private func centerView(view: UIView, onView: UIView) {
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
      constant: -20.0))
  }

  @objc func tap(_ sender: Any) {
    print("\(type(of: sender)) was tapped.")
  }

}

extension ButtonsSimpleExampleSwiftViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Buttons (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
