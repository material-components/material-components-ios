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

import UIKit

import MaterialComponents.MaterialTextField

class TextFieldSwiftExample: UIViewController {

  let textField = MDCTextField()
  let textFieldController: MDCTextInputController

  let textFieldInline = MDCTextField()
  let textFieldInlineController: MDCTextInputController

  let textFieldWide = MDCTextField()
  let textFieldWideController: MDCTextInputController

  let textView = MDCTextView()
  let textViewController: MDCTextInputController

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    textFieldController = MDCTextInputController(input: textField)
    textFieldInlineController = MDCTextInputController(input: textFieldInline)
    textFieldWideController = MDCTextInputController(input: textFieldWide)
    textViewController = MDCTextInputController(input: textView)

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    setupTextFields()
    setupTextViews()

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(self, action: #selector(TextFieldSwiftExample.errorSwitchDidChange(errorSwitch:)), for: .touchUpInside)
    view.addSubview(errorSwitch)

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-100-[textField]-[textFieldInline]-[textFieldWide]-[textView]-50-[switch]",
                                                               options: [.alignAllTrailing,
                                                                         .alignAllLeading],
                                                               metrics: nil,
                                                               views: ["switch": errorSwitch,
                                                                       "textField": textField,
                                                                       "textFieldInline": textFieldInline, "textFieldWide": textFieldWide,
                                                                       "textView": textView]))

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[textField]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["textField": textField]))
  }

  func setupTextFields() {
    view.addSubview(textField)
    view.addSubview(textFieldInline)
    view.addSubview(textFieldWide)

    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "This is a text field w/ floating placeholder"
    textField.delegate = self

    textField.leadingLabel.text = "Helper text"

    textField.clearButtonMode = .always

    textFieldController.presentation = .floatingPlaceholder
    textFieldController.characterCountMax = 50

    textFieldInline.translatesAutoresizingMaskIntoConstraints = false
    textFieldInline.placeholder = "This is a text field w/ inline placeholder"
    textFieldInline.delegate = self

    textFieldInline.leadingLabel.text = "More helper text"

    textFieldInline.clearButtonMode = .unlessEditing

    textFieldInlineController.presentation = .default
    textFieldInlineController.characterCountMax = 40

    textFieldWide.translatesAutoresizingMaskIntoConstraints = false
    textFieldWide.placeholder = "This is a full width text field"
    textFieldWide.delegate = self

    textFieldWide.leadingLabel.text = "This text should be hidden."

    textFieldWide.clearButtonMode = .whileEditing

    textFieldWideController.presentation = .fullWidth
    textFieldWideController.characterCountMax = 30
  }

  func setupTextViews() {
    view.addSubview(textView)

    // Hide TextView for now
    textView.alpha = 0
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.placeholderLabel.text = "This is a text view"
    textView.delegate = self

    textView.leadingLabel.text = "Leading test"
    textView.trailingLabel.text = "Trailing test"

    textViewController.presentation = .default
  }

  func errorSwitchDidChange(errorSwitch: UISwitch) {
    textFieldController.set(errorText: errorSwitch.isOn ? "Oh no! ERROR!!!" : nil, errorAccessibilityValue: nil)
  }
}

extension TextFieldSwiftExample: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

extension TextFieldSwiftExample: UITextViewDelegate {
}

extension TextFieldSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Text Field", "(Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
