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

    self.view.backgroundColor = UIColor.whiteColor()

    let raisedButton = MDCRaisedButton()
    raisedButton.customTitleColor = UIColor.whiteColor()
    raisedButton.setElevation(4, forState: .Normal)
    raisedButton.setTitle("Tap Me Too", forState: .Normal)
    raisedButton.sizeToFit()
    raisedButton.translatesAutoresizingMaskIntoConstraints = false
    raisedButton.addTarget(self, action: #selector(tap), forControlEvents: .TouchUpInside)
    self.view.addSubview(raisedButton)

    let flatButton = MDCFlatButton()
    flatButton.customTitleColor = UIColor.grayColor()
    flatButton.setTitle("Touch me", forState: .Normal)
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), forControlEvents: .TouchUpInside)
    self.view.addSubview(flatButton)

    let floatingButton = MDCFloatingButton()
    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(tap), forControlEvents: .TouchUpInside)

    let plusShape = CAShapeLayer();
    plusShape.path = ButtonsTypicalUseSupplemental.plusShapePath().CGPath;
    plusShape.fillColor = UIColor.whiteColor().CGColor;
    plusShape.position =
      CGPointMake((floatingButton.frame.size.width - floatingButtonPlusDimension) / 2,
                  (floatingButton.frame.size.height - floatingButtonPlusDimension) / 2);
    floatingButton.layer.addSublayer(plusShape);

    self.view.addSubview(floatingButton)

    let views = [
      "raised": raisedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]

    self.view.addConstraint(NSLayoutConstraint(
      item: flatButton,
      attribute: .CenterX,
      relatedBy: .Equal,
      toItem: self.view,
      attribute: .CenterX,
      multiplier: 1.0,
      constant: 0.0))

    self.view.addConstraint(NSLayoutConstraint(
      item: flatButton,
      attribute: .CenterY,
      relatedBy: .Equal,
      toItem: self.view,
      attribute: .CenterY,
      multiplier: 1.0,
      constant: 0.0))

    self.view.addConstraints(
      NSLayoutConstraint.constraintsWithVisualFormat("V:[raised]-40-[flat]-40-[floating]",
        options: .AlignAllCenterX,
        metrics: nil,
        views: views))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func tap(sender: AnyObject) {
    print("\(sender.dynamicType) was tapped.")
  }

  class func catalogBreadcrumbs() -> [String] {
    return ["Buttons", "Buttons (Swift)"]
  }

}
