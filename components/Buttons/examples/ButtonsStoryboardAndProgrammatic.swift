/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

    raisedButton.setTitle("Programmatic", forState: .Normal)
    raisedButton.sizeToFit()
    raisedButton.translatesAutoresizingMaskIntoConstraints = false
    raisedButton.addTarget(self, action: #selector(tap), forControlEvents: .TouchUpInside)
    self.view.addSubview(raisedButton)

    flatButton.customTitleColor = UIColor.grayColor()
    flatButton.setTitle("Programmatic", forState: .Normal)
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), forControlEvents: .TouchUpInside)
    self.view.addSubview(flatButton)

    floatingButton.setTitle("+", forState: .Normal)
    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(tap), forControlEvents: .TouchUpInside)
    self.view.addSubview(floatingButton)

    let views = [
      "raised": raisedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]

    self.view.addConstraint(NSLayoutConstraint(
      item: raisedButton,
      attribute: .Leading,
      relatedBy: .Equal,
      toItem: self.view,
      attribute: .Leading,
      multiplier: 1.0,
      constant: 8.0))

    self.view.addConstraint(NSLayoutConstraint(
      item: raisedButton,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: self.view,
      attribute: .Top,
      multiplier: 1.0,
      constant: 22.0))

    self.view.addConstraints(
      NSLayoutConstraint.constraintsWithVisualFormat("V:[raised]-22-[flat]-22-[floating]",
        options: .AlignAllCenterX,
        metrics: nil,
        views: views))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func tap(sender: AnyObject) {
    print("\(sender.dynamicType) was tapped.")
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()


  }
}
