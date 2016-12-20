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

class ButtonsStoryboardAndProgrammaticController: UIViewController {

  class func catalogBreadcrumbs() -> [String] {
    return ["Buttons", "Buttons (Swift and Storyboard)"]
  }

  class func catalogStoryboardName() -> String {
    return "ButtonsStoryboardAndProgrammatic"
  }

  let raisedButton = MDCRaisedButton()
  let flatButton = MDCFlatButton()
  let floatingButton = MDCFloatingButton()

  @IBOutlet weak var storyboardRaised: MDCRaisedButton!
  @IBOutlet weak var storyboardFlat: MDCFlatButton!
  @IBOutlet weak var storyboardFloating: MDCFloatingButton!

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    raisedButton.setTitle("Programmatic", for: UIControlState())
    raisedButton.sizeToFit()
    raisedButton.translatesAutoresizingMaskIntoConstraints = false
    raisedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    self.view.addSubview(raisedButton)

    flatButton.customTitleColor = UIColor.gray
    flatButton.setTitle("Programmatic", for: UIControlState())
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    self.view.addSubview(flatButton)

    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(tap), for: .touchUpInside)

    let floatingPlusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(floatingPlusShapeLayer)
    self.view.addSubview(floatingButton)

    let storyboardPlusShapeLayer =
      ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    storyboardFloating.layer.addSublayer(storyboardPlusShapeLayer)

    let views = [
      "raised": raisedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]

    self.view.addConstraint(NSLayoutConstraint(
      item: raisedButton,
      attribute: .leading,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .leading,
      multiplier: 1.0,
      constant: 8.0))

    self.view.addConstraint(NSLayoutConstraint(
      item: raisedButton,
      attribute: .top,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .top,
      multiplier: 1.0,
      constant: 22.0))

    self.view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:[raised]-22-[flat]-22-[floating]",
        options: .alignAllCenterX,
        metrics: nil,
        views: views))
  }

  @IBAction func tap(_ sender: AnyObject) {
    print("\(type(of: sender)) was tapped.")
  }

}
