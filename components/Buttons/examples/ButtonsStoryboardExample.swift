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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialContainerScheme

class ButtonsStoryboardExample: UIViewController {

  let containedButton = MDCButton()
  let flatButton = MDCButton()
  let floatingButton = MDCFloatingButton()

  var containerScheme = MDCContainerScheme()

  @IBOutlet weak var storyboardContained: MDCButton!
  @IBOutlet weak var storyboardFlat: MDCButton!
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
      NSLayoutConstraint(
        item: innerContainerView,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: containerView,
        attribute: .centerX,
        multiplier: 1.0,
        constant: 0),
      NSLayoutConstraint(
        item: innerContainerView,
        attribute: .centerY,
        relatedBy: .equal,
        toItem: containerView,
        attribute: .centerY,
        multiplier: 1.0,
        constant: 0),
    ])

    buttonSetup()

    let floatingPlusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(floatingPlusShapeLayer)
    floatingButton.applySecondaryTheme(withScheme: containerScheme)
    floatingButton.accessibilityLabel = "Programmatic floating action button"
    innerContainerView.addSubview(floatingButton)

    let storyboardPlusShapeLayer =
      ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    storyboardFloating.applySecondaryTheme(withScheme: containerScheme)
    storyboardFloating.accessibilityLabel = "Storyboard floating action button"
    storyboardFloating.layer.addSublayer(storyboardPlusShapeLayer)

    storyboardContained.applyContainedTheme(withScheme: containerScheme)
    storyboardFlat.applyTextTheme(withScheme: containerScheme)

    addButtonConstraints()
  }

  private func layoutContainer() {
    let viewLayoutGuide: Any = {
      return view.safeAreaLayoutGuide
      return view
    }()
    NSLayoutConstraint.activate([
      NSLayoutConstraint(
        item: containerView,
        attribute: .leading,
        relatedBy: .equal,
        toItem: viewLayoutGuide,
        attribute: .leading,
        multiplier: 1.0,
        constant: 0),
      NSLayoutConstraint(
        item: containerView,
        attribute: .top,
        relatedBy: .equal,
        toItem: viewLayoutGuide,
        attribute: .top,
        multiplier: 1.0,
        constant: 0),
      NSLayoutConstraint(
        item: containerView,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: viewLayoutGuide,
        attribute: .bottom,
        multiplier: 1.0,
        constant: 0),
      NSLayoutConstraint(
        item: containerView,
        attribute: .width,
        relatedBy: .equal,
        toItem: viewLayoutGuide,
        attribute: .width,
        multiplier: 0.5,
        constant: 0),
    ])
  }

  private func buttonSetup() {
    let backgroundColor = UIColor(white: 0.1, alpha: 1.0)

    containedButton.applyContainedTheme(withScheme: containerScheme)
    containedButton.setTitle("Programmatic", for: .normal)
    containedButton.sizeToFit()
    containedButton.translatesAutoresizingMaskIntoConstraints = false
    containedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    innerContainerView.addSubview(containedButton)

    flatButton.applyTextTheme(withScheme: containerScheme)
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
      "floating": floatingButton,
    ]

    view.addConstraint(
      NSLayoutConstraint(
        item: containedButton,
        attribute: .leading,
        relatedBy: .equal,
        toItem: innerContainerView,
        attribute: .leading,
        multiplier: 1.0,
        constant: 0))

    view.addConstraint(
      NSLayoutConstraint(
        item: containedButton,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: innerContainerView,
        attribute: .trailing,
        multiplier: 1.0,
        constant: 0))

    view.addConstraint(
      NSLayoutConstraint(
        item: containedButton,
        attribute: .top,
        relatedBy: .equal,
        toItem: innerContainerView,
        attribute: .top,
        multiplier: 1.0,
        constant: 0))

    view.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[raised]-22-[flat]-22-[floating]|",
        options: .alignAllCenterX,
        metrics: nil,
        views: views))
  }

  @IBAction func tap(_ sender: Any) {
    print("\(type(of: sender)) was tapped.")
  }

}

extension ButtonsStoryboardExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Buttons (Storyboard)"],
      "primaryDemo": false,
      "presentable": false,
      // Disabling tests of this example because it currently crashes with
      // "'[<UIViewController 0x7f97f6d4cda0> setValue:forUndefinedKey:]: this class is not key
      // value coding-compliant for the key storyboardContained.'"
      "skip_snapshots": true,
      "storyboardName": "ButtonsStoryboardAndProgrammatic",
    ]
  }
}
