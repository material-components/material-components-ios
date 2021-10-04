// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialSnackbar

class SnackbarKeyboardExample: UIViewController {

  @objc var containerScheme = MDCContainerScheme()

  let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.returnKeyType = .done
    textField.delegate = self
    return textField
  }()

  lazy var showSnackbarButton: MDCButton = {
    let button = MDCButton()
    button.setTitle("Show snackbar", for: .normal)
    button.addTarget(self, action: #selector(showSnackbarButtonTapped), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    showSnackbarButton.applyTextTheme(withScheme: containerScheme)

    contentStackView.addArrangedSubview(textField)
    contentStackView.addArrangedSubview(showSnackbarButton)
    view.addSubview(contentStackView)

    contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    contentStackView.topAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
  }

  @objc func showSnackbarButtonTapped() {
    MDCSnackbarManager.default.show(MDCSnackbarMessage(text: "Hello!"))
  }
}

extension SnackbarKeyboardExample: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

extension SnackbarKeyboardExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Snackbar", "Snackbar Keyboard"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
