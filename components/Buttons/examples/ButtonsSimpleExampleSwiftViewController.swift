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

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.white

    let raisedButton = MDCRaisedButton()
    raisedButton.customTitleColor = UIColor.white
    raisedButton.setElevation(4, for: UIControlState())
    raisedButton.setTitle("Tap Me Too", for: UIControlState())
    raisedButton.sizeToFit()
    raisedButton.translatesAutoresizingMaskIntoConstraints = false
    raisedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    self.view.addSubview(raisedButton)

    let flatButton = MDCFlatButton()
    flatButton.customTitleColor = UIColor.gray
    flatButton.setTitle("Touch me", for: UIControlState())
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    self.view.addSubview(flatButton)

    let floatingButton = MDCFloatingButton()
    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(tap), for: .touchUpInside)

    let plusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(plusShapeLayer)

    self.view.addSubview(floatingButton)

    let views = [
      "raised": raisedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]

    self.view.addConstraint(NSLayoutConstraint(
      item: flatButton,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .centerX,
      multiplier: 1.0,
      constant: 0.0))

    self.view.addConstraint(NSLayoutConstraint(
      item: flatButton,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 0.0))

    self.view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:[raised]-40-[flat]-40-[floating]",
        options: .alignAllCenterX,
        metrics: nil,
        views: views))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func tap(_ sender: AnyObject) {
    print("\(type(of: sender)) was tapped.")
  }

  class func catalogBreadcrumbs() -> [String] {
    return ["Buttons", "Buttons (Swift)"]
  }

}
