// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

import Foundation
import UIKit

import MaterialComponents.MaterialButtons_ButtonThemer

class ButtonsSwiftAndStoryboardController: UIViewController {

  let containedButton = MDCButton()
  let flatButton = MDCFlatButton()
  let floatingButton = MDCFloatingButton()

  @IBOutlet weak var storyboardContained: MDCButton!
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

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(containerView)

    layoutContainer()

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

    buttonSetup()

    let floatingPlusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(floatingPlusShapeLayer)
    innerContainerView.addSubview(floatingButton)

    let storyboardPlusShapeLayer =
      ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    storyboardFloating.layer.addSublayer(storyboardPlusShapeLayer)

    addButtonConstraints()
  }

  private func layoutContainer() {
    let viewLayoutGuide: Any = {
      #if swift(>=3.2)
        if #available(iOS 11.0, *) {
          return view.safeAreaLayoutGuide
        }
      #endif
      return view
    }()
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: containerView,
                         attribute: .leading,
                         relatedBy: .equal,
                         toItem: viewLayoutGuide,
                         attribute: .leading,
                         multiplier: 1.0,
                         constant: 0),
      NSLayoutConstraint(item: containerView,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: viewLayoutGuide,
                         attribute: .top,
                         multiplier: 1.0,
                         constant: 0),
      NSLayoutConstraint(item: containerView,
                         attribute: .bottom,
                         relatedBy: .equal,
                         toItem: viewLayoutGuide,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: 0),
      NSLayoutConstraint(item: containerView,
                         attribute: .width,
                         relatedBy: .equal,
                         toItem: viewLayoutGuide,
                         attribute: .width,
                         multiplier: 0.5,
                         constant: 0)
      ])
  }

  private func buttonSetup() {
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)

    let buttonScheme = MDCButtonScheme()
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: containedButton)
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: storyboardContained)

    containedButton.setTitle("Programmatic", for: .normal)
    containedButton.sizeToFit()
    containedButton.translatesAutoresizingMaskIntoConstraints = false
    containedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    innerContainerView.addSubview(containedButton)

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
  }

  private func addButtonConstraints() {
    let views = [
      "raised": containedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]

    view.addConstraint(NSLayoutConstraint(
      item: containedButton,
      attribute: .leading,
      relatedBy: .equal,
      toItem: innerContainerView,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0))

    view.addConstraint(NSLayoutConstraint(
      item: containedButton,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: innerContainerView,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0))

    view.addConstraint(NSLayoutConstraint(
      item: containedButton,
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

  @IBAction func tap(_ sender: Any) {
    print("\(type(of: sender)) was tapped.")
  }

}

extension ButtonsSwiftAndStoryboardController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Buttons (Swift and Storyboard)"],
      "primaryDemo": false,
      "presentable": false,
      "storyboardName": "ButtonsStoryboardAndProgrammatic",
    ]
  }
}
