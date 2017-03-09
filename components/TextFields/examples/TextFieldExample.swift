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
  let textView = MDCTextView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addSubview(textField)
    view.addSubview(textView)

    let textFieldBehavior = MDCTextInputBehavior(input: textField)

    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "This is a text field"
    textField.delegate = self

    textField.leadingLabel.text = "Leading test"
    textField.trailingLabel.text = "Trailing test"

    textField.clearButtonMode = .always
    textField.sizeToFit()

    textFieldBehavior.presentation = .floatingPlaceholder

    let textViewBehavior = MDCTextInputBehavior(input: textView)

    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.placeholderLabel.text = "This is a text view"
    textView.delegate = self

    textView.leadingLabel.text = "Leading test"
    textView.trailingLabel.text = "Trailing test"

    textViewBehavior.presentation = .default

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-100-[textField]-[textView]",
                                                               options: [.alignAllTrailing,
                                                                         .alignAllLeading],
                                                               metrics: nil,
                                                               views: ["textField": textField,
                                                                       "textView": textView]))

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[textField]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["textField": textField]))
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
