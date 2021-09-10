// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialDialogs_Theming 
import MaterialComponents.MaterialContainerScheme

class CustomShadowViewController: UIViewController {

  let bodyLabel = UILabel()

  override func viewDidLoad() {

    super.viewDidLoad()
    view.backgroundColor = UIColor.white

    // Setting the corner radius of the view's layer will propagate to the shadow
    // layer when the view is presented by MDCDailogPresentationController.
    // Note that setting the corner radius in viewDidLoad is not recommended, since it
    // will be overridden if callers apply a themer to the MDCDailogPresentationController instance.
    self.view.layer.cornerRadius = 32.0

    bodyLabel.text =
      "This presented view has a corner radius so we've set the corner radius on the presentation controller."
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyLabel.numberOfLines = 0
    bodyLabel.sizeToFit()
    self.view.addSubview(bodyLabel)

    self.view.isAccessibilityElement = true
    self.view.accessibilityTraits = .button
    self.view.accessibilityLabel = bodyLabel.text
    self.view.accessibilityHint = "Dismiss this dialog"
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
    view.addGestureRecognizer(tap)

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-[body]-|", options: [], metrics: nil, views: ["body": bodyLabel]))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-[body]-|", options: [], metrics: nil, views: ["body": bodyLabel]))
  }

  @objc func dismissSelf() {
    dismiss(animated: true)
  }

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: 200.0, height: 140.0)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

}

class DialogsCustomShadowExampleViewController: UIViewController {

  let textButton = MDCButton()
  let transitionController = MDCDialogTransitionController()
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    textButton.setTitle("PRESENT ALERT", for: UIControl.State())
    textButton.setTitleColor(UIColor(white: 0.1, alpha: 1), for: UIControl.State())
    textButton.sizeToFit()
    textButton.translatesAutoresizingMaskIntoConstraints = false
    textButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    textButton.applyTextTheme(withScheme: containerScheme)
    self.view.addSubview(textButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(
        item: textButton,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: self.view,
        attribute: .centerX,
        multiplier: 1.0,
        constant: 0.0),
      NSLayoutConstraint(
        item: textButton,
        attribute: .centerY,
        relatedBy: .equal,
        toItem: self.view,
        attribute: .centerY,
        multiplier: 1.0,
        constant: 0.0),
    ])
  }

  @objc func tap(_ sender: Any) {
    let presentedController = CustomShadowViewController(nibName: nil, bundle: nil)

    // Using a MDCDialogTransitionController as the transition delegate also sets
    // MDCDailogPresentationController as the presentation controller.
    // Make sure to store a strong reference to the transitionController.
    presentedController.modalPresentationStyle = .custom
    presentedController.transitioningDelegate = self.transitionController

    // Note this example demonstrate direct manipulation of cornerRadius on the
    //  view's layer so we're intentionally not calling the presentation controller's themer.
    self.present(presentedController, animated: true, completion: nil)
  }

  // MARK: Catalog by convention

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "View with Corner Radius"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}

// MARK: Snapshot Testing by Convention
extension DialogsCustomShadowExampleViewController {

  func resetTests() {
    if presentedViewController != nil {
      dismiss(animated: false)
    }
  }

  @objc func testPresented() {
    resetTests()
    tap(UIButton())
  }
}
