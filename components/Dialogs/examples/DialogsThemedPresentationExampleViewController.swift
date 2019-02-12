// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialDialogs
import MaterialComponentsBeta.MaterialButtons_Theming
import MaterialComponentsBeta.MaterialContainerScheme
import MaterialComponentsBeta.MaterialDialogs_Theming

class CustomDialogViewController: UIViewController {
  var dialogTitle: String?
  var dialogMessage: String?

  init(title: String, message: String) {
    super.init(nibName: nil, bundle: nil)
    dialogTitle = title
    dialogMessage = message
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white

    let titleLabel = UILabel()
    titleLabel.text = dialogTitle
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.numberOfLines = 0
    self.view.addSubview(titleLabel)

    let bodyLabel = UILabel()
    bodyLabel.text = dialogMessage
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyLabel.numberOfLines = 0
    self.view.addSubview(bodyLabel)

    let confirmButton = UIButton()
    confirmButton.setTitle("OK", for: .normal)
    confirmButton.setTitleColor(UIColor.black, for: .normal)
    confirmButton.translatesAutoresizingMaskIntoConstraints = false
    confirmButton.addTarget(self, action: #selector(dismissDialog), for: .touchUpInside)
    self.view.addSubview(confirmButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: titleLabel,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerX,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: titleLabel,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .top,
                         multiplier: 1.0,
                         constant: 15.0),
      NSLayoutConstraint(item: bodyLabel,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: titleLabel,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: 10.0),
      NSLayoutConstraint(item: bodyLabel,
                         attribute: .left,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .left,
                         multiplier: 1.0,
                         constant: 5.0),
      NSLayoutConstraint(item: bodyLabel,
                         attribute: .right,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .right,
                         multiplier: 1.0,
                         constant: -5.0),
      NSLayoutConstraint(item: confirmButton,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: bodyLabel,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: 10.0),
      NSLayoutConstraint(item: confirmButton,
                         attribute: .bottom,
                         relatedBy: .lessThanOrEqual,
                         toItem: self.view,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: confirmButton,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerX,
                         multiplier: 1.0,
                         constant: 0.0),
      ])
  }

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width:200.0, height:150.0);
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  @objc func dismissDialog() {
    self.dismiss(animated:true)
  }
}

class DialogsThemedPresentationExampleViewController: UIViewController {

  private let materialButton = MDCButton()
  private let transitionController = MDCDialogTransitionController()
  var containerScheme = MDCContainerScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme?.backgroundColor ??
      MDCSemanticColorScheme(defaults: .material201804).backgroundColor

    materialButton.translatesAutoresizingMaskIntoConstraints = false
    materialButton.setTitle("Custom Alert With Themed Presentation", for: .normal)
    materialButton.sizeToFit()
    materialButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    materialButton.applyTextTheme(withScheme: containerScheme)
    self.view.addSubview(materialButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item:materialButton,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerX,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: materialButton,
                         attribute: .centerY,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerY,
                         multiplier: 1.0,
                         constant: 0.0)
      ])
  }

  @objc func tap(_ sender: Any) {
    let title = "Reset Settings"
    let message = "Your device will reset to its default factory settings."
    let customDialogController = CustomDialogViewController(title: title, message: message)
    customDialogController.modalPresentationStyle = .custom;
    customDialogController.transitioningDelegate = self.transitionController;

    if let presentationController = customDialogController.mdc_dialogPresentationController {
      presentationController.applyTheme(withScheme: containerScheme)
      customDialogController.view.layer.cornerRadius = presentationController.dialogCornerRadius;
    }
    present(customDialogController, animated: true, completion: nil)
  }
}

extension DialogsThemedPresentationExampleViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Dialog Presentation Controller Theming"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}

