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

class ButtonsSwiftAndStoryboardController: UIViewController {

  class func catalogBreadcrumbs() -> [String] {
    return ["Buttons", "Buttons (Swift and Storyboard)"]
  }

  class func catalogStoryboardName() -> String {
    return "ButtonsStoryboardAndProgrammatic"
  }

  let raisedButton = MDCRaisedButton()
  let flatButton = MDCFlatButton()
  let floatingButton = MDCFloatingButton()

  // UIAppearance colors will overwrite values set in storyboards. In order to see the values set in
  // ButtonsStoryboardAndProgrammatic.storyboard comment out the MDCButtonColorThemer.apply(...)
  // call in AppDelegate.swift.
  @IBOutlet weak var storyboardRaised: MDCRaisedButton!
  @IBOutlet weak var storyboardFlat: MDCFlatButton!
  @IBOutlet weak var storyboardFloating: MDCFloatingButton!

  private lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  private lazy var innerContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // swiftlint:disable function_body_length
  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(containerView)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: containerView,
                         attribute: .leading,
                         relatedBy: .equal,
                         toItem: view,
                         attribute: .leading,
                         multiplier: 1.0,
                         constant: 0),
      NSLayoutConstraint(item: containerView,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: view,
                         attribute: .top,
                         multiplier: 1.0,
                         constant: 0),
      NSLayoutConstraint(item: containerView,
                         attribute: .bottom,
                         relatedBy: .equal,
                         toItem: view,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: 0),
      NSLayoutConstraint(item: containerView,
                         attribute: .width,
                         relatedBy: .equal,
                         toItem: view,
                         attribute: .width,
                         multiplier: 0.5,
                         constant: 0)
    ])

    containerView.addSubview(innerContainerView)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: innerContainerView,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: containerView,
                         attribute: .centerX,
                         multiplier: 1.0,
                         constant: 0),
      NSLayoutConstraint(item: innerContainerView,
                         attribute: .centerY,
                         relatedBy: .equal,
                         toItem: containerView,
                         attribute: .centerY,
                         multiplier: 1.0,
                         constant: 0)
    ])

    let titleColor = UIColor.white
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)

    raisedButton.setTitle("Programmatic", for: .normal)
    raisedButton.setTitleColor(titleColor, for: .normal)
    raisedButton.backgroundColor = backgroundColor
    raisedButton.sizeToFit()
    raisedButton.translatesAutoresizingMaskIntoConstraints = false
    raisedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    innerContainerView.addSubview(raisedButton)

    flatButton.setTitleColor(.gray, for: .normal)
    flatButton.setTitle("Programmatic", for: .normal)
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    innerContainerView.addSubview(flatButton)

    floatingButton.sizeToFit()
    floatingButton.backgroundColor = backgroundColor
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(tap), for: .touchUpInside)

    let floatingPlusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(floatingPlusShapeLayer)
    innerContainerView.addSubview(floatingButton)

    let storyboardPlusShapeLayer =
      ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    storyboardFloating.layer.addSublayer(storyboardPlusShapeLayer)

    let views = [
      "raised": raisedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]

    view.addConstraint(NSLayoutConstraint(
      item: raisedButton,
      attribute: .leading,
      relatedBy: .equal,
      toItem: innerContainerView,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0))

    view.addConstraint(NSLayoutConstraint(
      item: raisedButton,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: innerContainerView,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0))

    view.addConstraint(NSLayoutConstraint(
      item: raisedButton,
      attribute: .top,
      relatedBy: .equal,
      toItem: innerContainerView,
      attribute: .top,
      multiplier: 1.0,
      constant: 0))

    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:|[raised]-22-[flat]-22-[floating]|",
        options: .alignAllCenterX,
        metrics: nil,
        views: views))
  }
  // swiftlint:enable function_body_length

  @IBAction func tap(_ sender: Any) {
    print("\(type(of: sender)) was tapped.")
  }

}
