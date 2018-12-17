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

import Foundation
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialDialogs

class CustomShadowViewController: UIViewController {

  let bodyLabel = UILabel()

  let dismissButton = MDCFlatButton()

  override func viewDidLoad() {

    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    view.layer.cornerRadius = 32.0

    bodyLabel.text =
      "This presented view has a corner radius so we've set the corner radius on the presentation controller."
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyLabel.numberOfLines = 0
    bodyLabel.sizeToFit()
    self.view.addSubview(bodyLabel)

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(withVisualFormat: "H:|-[body]-|", options: [], metrics: nil, views: [ "body": bodyLabel]))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(withVisualFormat: "V:|-[body]-|", options: [], metrics: nil, views: [ "body": bodyLabel]))
  }

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width:200.0, height:140.0);
    }
    set {
      super.preferredContentSize = newValue
    }
  }

}

class DialogsCustomShadowExampleViewController: UIViewController {

  let flatButton = MDCFlatButton()
  let transitionController = MDCDialogTransitionController()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white

    flatButton.setTitle("PRESENT ALERT", for: UIControlState())
    flatButton.setTitleColor(UIColor(white: 0.1, alpha:1), for: UIControlState())
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    self.view.addSubview(flatButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item:flatButton,
                       attribute:.centerX,
                       relatedBy:.equal,
                       toItem:self.view,
                       attribute:.centerX,
                       multiplier:1.0,
                       constant: 0.0),
      NSLayoutConstraint(item:flatButton,
                       attribute:.centerY,
                       relatedBy:.equal,
                       toItem:self.view,
                       attribute:.centerY,
                       multiplier:1.0,
                       constant: 0.0)
    ])
  }

  @objc func tap(_ sender: Any) {
    let presentedController = CustomShadowViewController(nibName: nil, bundle: nil)
    presentedController.modalPresentationStyle = .custom;
    presentedController.transitioningDelegate = self.transitionController;

    self.present(presentedController, animated: true, completion: nil)

    // We set the corner radius to adjust the shadow that is implemented via the trackingView in the
    // presentation controller.
    if let presentationController = presentedController.mdc_dialogPresentationController {
      presentationController.dialogCornerRadius = presentedController.view.layer.cornerRadius
    }
  }

  // MARK: Catalog by convention

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "View with Corner Radius"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
