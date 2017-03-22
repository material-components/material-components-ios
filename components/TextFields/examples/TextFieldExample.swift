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

  let scrollView = UIScrollView()

  let textFieldControllerDefault: MDCTextInputController
  let textFieldControllerDefaultCharMax: MDCTextInputController

  let textFieldControllerFullWidth: MDCTextInputController
  let textFieldControllerFullWidthCharMax: MDCTextInputController

  let textFieldControllerFloating: MDCTextInputController
  let textFieldControllerFloatingCharMax: MDCTextInputController

  let textFieldControllerDefaultDisabled: MDCTextInputController
  let textFieldControllerDefaultCustomFont: MDCTextInputController
  let textFieldControllerDefaultLeftView: MDCTextInputController

  let allTextFields: [MDCTextInputController]

  let textViewControllerDefault: MDCTextInputController
  let textViewControllerDefaultCharMax: MDCTextInputController

  let textViewControllerFullWidth: MDCTextInputController
  let textViewControllerFullWidthCharMax: MDCTextInputController

  let textViewControllerFloating: MDCTextInputController
  let textViewControllerFloatingCharMax: MDCTextInputController

  let textViewControllerDefaultCustomFont: MDCTextInputController

  let allTextViews: [MDCTextInputController]

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

    let textFieldDefault = MDCTextField()
    textFieldControllerDefault = MDCTextInputController(input: textFieldDefault)
    let textFieldDefaultCharMax = MDCTextField()
    textFieldControllerDefaultCharMax = MDCTextInputController(input: textFieldDefaultCharMax)

    let textFieldFullWidth = MDCTextField()
    textFieldControllerFullWidth = MDCTextInputController(input: textFieldFullWidth)
    let textFieldFullWidthCharMax = MDCTextField()
    textFieldControllerFullWidthCharMax = MDCTextInputController(input: textFieldFullWidthCharMax)

    let textFieldFloating = MDCTextField()
    textFieldControllerFloating = MDCTextInputController(input: textFieldFloating)
    let textFieldFloatingCharMax = MDCTextField()
    textFieldControllerFloatingCharMax = MDCTextInputController(input: textFieldFloatingCharMax)

    let textFieldDisabled = MDCTextField()
    textFieldControllerDefaultDisabled = MDCTextInputController(input: textFieldDisabled)
    let textFieldCustomFont = MDCTextField()
    textFieldControllerDefaultCustomFont = MDCTextInputController(input: textFieldCustomFont)
    let textFieldLeftView = MDCTextField()
    textFieldControllerDefaultLeftView = MDCTextInputController(input: textFieldLeftView)

    allTextFields = [textFieldControllerDefault, textFieldControllerDefaultCharMax,
                     textFieldControllerFullWidth, textFieldControllerFullWidthCharMax,
                     textFieldControllerFloating, textFieldControllerFloatingCharMax,
                     textFieldControllerDefaultDisabled, textFieldControllerDefaultCustomFont,
                     textFieldControllerDefaultLeftView]

    let textViewDefault = MDCTextView()
    textViewControllerDefault = MDCTextInputController(input: textViewDefault)
    let textViewDefaultCharMax = MDCTextView()
    textViewControllerDefaultCharMax = MDCTextInputController(input: textViewDefaultCharMax)

    let textViewFullWidth = MDCTextView()
    textViewControllerFullWidth = MDCTextInputController(input: textViewFullWidth)
    let textViewFullWidthCharMax = MDCTextView()
    textViewControllerFullWidthCharMax = MDCTextInputController(input: textViewFullWidthCharMax)

    let textViewFloating = MDCTextView()
    textViewControllerFloating = MDCTextInputController(input: textViewFloating)
    let textViewFloatingCharMax = MDCTextView()
    textViewControllerFloatingCharMax = MDCTextInputController(input: textViewFloatingCharMax)

    let textViewCustomFont = MDCTextView()
    textViewControllerDefaultCustomFont = MDCTextInputController(input: textViewCustomFont)

    allTextViews = [textViewControllerDefault, textViewControllerDefaultCharMax,
                    textViewControllerFullWidth, textViewControllerFullWidthCharMax,
                    textViewControllerFloating, textViewControllerFloatingCharMax,
                    textViewControllerDefaultCustomFont]

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    allTextFields.forEach { if let textField = $0.input as? MDCTextField {
      scrollView.addSubview(textField)}
    }

    allTextViews.forEach { if let textView = $0.input as? MDCTextView {
      scrollView.addSubview(textView)}
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

    setupTextFields()
    setupTextViews()
    setupScrollView()

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(self,
                          action: #selector(TextFieldSwiftExample.errorSwitchDidChange(errorSwitch:)),
                          for: .touchUpInside)
    view.addSubview(errorSwitch)

    //    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
    //      "V:|-100-[textField]-[textFieldInline]-[textFieldWide]-50-[switch]",
    //                                                               options: [.alignAllTrailing,
    //                                                                         .alignAllLeading],
    //                                                               metrics: nil,
    //                                                               views: ["switch": errorSwitch,
    //                                                                    "textField": textFieldController.input,
    //                                                          "textFieldInline": textFieldInlineController.input,
    //                                                                "textFieldWide": textFieldWideController.input]))
    //
    //    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
    //      "H:|-[textField]-|",
    //                                                               options: [],
    //                                                               metrics: nil,
    //                                                               views: ["textField": textFieldController.input]))
  }

  func setupTextFields() {
    //    view.addSubview(textFieldController.input)
    //    view.addSubview(textFieldInlineController.input)
    //    view.addSubview(textFieldWideController.input)
    //
    //    textField.translatesAutoresizingMaskIntoConstraints = false
    //    textField.placeholder = "This is a text field w/ floating placeholder"
    //    textField.delegate = self
    //
    //    textField.leadingLabel.text = "Helper text"
    //
    //    textField.clearButtonMode = .always
    //
    //    textFieldController.presentation = .floatingPlaceholder
    //    textFieldController.characterCountMax = 50
    //
    //    textFieldInline.translatesAutoresizingMaskIntoConstraints = false
    //    textFieldInline.placeholder = "This is a text field w/ inline placeholder"
    //    textFieldInline.delegate = self
    //
    //    textFieldInline.leadingLabel.text = "More helper text"
    //
    //    textFieldInline.clearButtonMode = .unlessEditing
    //
    //    textFieldInlineController.presentation = .default
    //    textFieldInlineController.characterCountMax = 40
    //
    //    textFieldWide.translatesAutoresizingMaskIntoConstraints = false
    //    textFieldWide.placeholder = "This is a full width text field"
    //    textFieldWide.delegate = self
    //
    //    textFieldWide.leadingLabel.text = "This text should be hidden."
    //
    //    textFieldWide.clearButtonMode = .whileEditing
    //
    //    textFieldWideController.presentation = .fullWidth
    //    textFieldWideController.characterCountMax = 30
  }

  func setupTextViews() {
    //    view.addSubview(textView)
    //
    //    // Hide TextView for now
    //    textView.alpha = 0
    //    textView.translatesAutoresizingMaskIntoConstraints = false
    //    textView.placeholderLabel.text = "This is a text view"
    //    textView.delegate = self
    //
    //    textView.leadingLabel.text = "Leading test"
    //    textView.trailingLabel.text = "Trailing test"
    //
    //    textViewController.presentation = .default
  }

  func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }

  func errorSwitchDidChange(errorSwitch: UISwitch) {
    //    textFieldController.set(errorText: errorSwitch.isOn ? "Oh no! ERROR!!!" : nil,
    //                            errorAccessibilityValue: nil)
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
