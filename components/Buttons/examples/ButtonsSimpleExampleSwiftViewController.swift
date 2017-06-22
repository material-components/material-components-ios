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
import MaterialComponents

class ButtonsSimpleExampleSwiftViewController: UIViewController {

  let floatingButtonPlusDimension = CGFloat(24)

  class func catalogBreadcrumbs() -> [String] {
    return ["Buttons", "Buttons (Swift)"]
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha: 1.0);
    //let titleColor = UIColor.white
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)

    let raisedButton = MDCRaisedButton()
    raisedButton.setBackgroundColor(backgroundColor, for: .normal)
    raisedButton.setElevation(4, for: UIControlState())
    raisedButton.setTitle("Tap Me Too", for: UIControlState())
    raisedButton.sizeToFit()
    raisedButton.translatesAutoresizingMaskIntoConstraints = false
    raisedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(raisedButton)

    let flatButton = MDCFlatButton()
    flatButton.customTitleColor = .gray
    flatButton.setTitle("Touch me", for: UIControlState())
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    view.addSubview(flatButton)

    let floatingButton = MDCFloatingButton()
    floatingButton.backgroundColor = backgroundColor;
    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(tap), for: .touchUpInside)

    let plusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(plusShapeLayer)

    view.addSubview(floatingButton)

    let views = [
      "raised": raisedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]

    centerView(view: flatButton, onView: self.view)

    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:[raised]-40-[flat]-40-[floating]",
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

  func tap(_ sender: Any) {
    print("\(type(of: sender)) was tapped.")
  }

}
