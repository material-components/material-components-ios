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

class ChipTextFieldExampleViewController: UIViewController {

  let chipTextField = MDCChipTextField()
  let chipInputController: MDCTextInputControllerOutlined
  let textField = MDCTextField()
  let inputController: MDCTextInputControllerOutlined
  let resignButton = MDCButton()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    chipInputController = MDCTextInputControllerOutlined(textInput: chipTextField)
    chipInputController.placeholderText = "With Chips"
    inputController = MDCTextInputControllerOutlined(textInput: textField)
    inputController.placeholderText = "Regular MDCTextField"
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white

    setupExample()
  }

  func setupExample() {
    chipTextField.translatesAutoresizingMaskIntoConstraints = false
    chipTextField.backgroundColor = .white
    chipTextField.delegate = self

    // when on, enter responds to auto-correction which is confusing when we're trying to create "chips"
    chipTextField.autocorrectionType = UITextAutocorrectionType.no
    view.addSubview(chipTextField)

    // position the textfield somewhere in the screen
    if #available(iOSApplicationExtension 11.0, *) {
      let guide = view.safeAreaLayoutGuide
      chipTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20.0).isActive = true
      chipTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20.0).isActive = true
      chipTextField.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40.0).isActive = true
    } else if #available(iOSApplicationExtension 9.0, *) {
      chipTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
      chipTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
      chipTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
    } else {
      // Fallback on earlier versions
      print("This example is supported on iOS version 9 or later.")
    }

    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .white
    view.addSubview(textField)

    // position the textfield somewhere in the screen
    if #available(iOSApplicationExtension 11.0, *) {
      let guide = view.safeAreaLayoutGuide
      textField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20.0).isActive = true
      textField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20.0).isActive = true
      textField.topAnchor.constraint(equalTo: chipTextField.bottomAnchor, constant: 20.0).isActive = true
    } else if #available(iOSApplicationExtension 9.0, *) {
      textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
      textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
      textField.topAnchor.constraint(equalTo: chipTextField.bottomAnchor, constant: 20.0).isActive = true
    } else {
      // Fallback on earlier versions
      print("This example is supported on iOS version 9 or later.")
    }

    resignButton.setTitle("Resign", for: .normal)
    resignButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(resignButton)

    resignButton.applyContainedTheme(withScheme: MDCContainerScheme())
    resignButton.addTarget(self, action: #selector(resignTapped), for: .touchUpInside)

    if #available(iOSApplicationExtension 9.0, *) {
      resignButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
      resignButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20.0).isActive = true
    }
  }

  @objc func resignTapped(_ sender: Any) {
    chipTextField.resignFirstResponder()
    textField.resignFirstResponder()
  }
}

extension ChipTextFieldExampleViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let chipTextField = textField as? MDCChipTextField,
      let chipText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
      chipText.count > 0 {
      chipTextField.appendChip(text: chipText)
      chipTextField.text = ""
    }
    return true
  }
}

extension ChipTextFieldExampleViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Chip Text Field", "A Chip Text Field"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
