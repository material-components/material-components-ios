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

class UITextFieldWithChipsExample: UIViewController {

  fileprivate let textField = InsetTextField()
  private var leftView = UIView()
  fileprivate var leadingConstraint: NSLayoutConstraint?

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.white

    setupExample()
    additionalTextField()

    // this fixes the issue of the cursor becoming half size when the field is empty
    DispatchQueue.main.async {
      self.textField.becomeFirstResponder()
    }
  }

  private func setupExample() {

    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = UIColor.black.withAlphaComponent(0.05)
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.textColor = .darkGray
    textField.text = "With Chips (Hit Enter)"

    // when on, enter responds to auto-correction which is confusing when we're trying to create "chips"
    textField.autocorrectionType = UITextAutocorrectionType.no

    textField.delegate = self

    textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    view.addSubview(textField)

    // position the textfield somewhere in the screen
    if #available(iOSApplicationExtension 11.0, *) {
      let guide = view.safeAreaLayoutGuide
      textField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20.0).isActive = true
      textField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20.0).isActive = true
      textField.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40.0).isActive = true
    } else if #available(iOSApplicationExtension 9.0, *) {
      textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
      textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
      textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
    } else {
      // Fallback on earlier versions
      print("This example is supported on iOS version 9 or later.")
    }

    leftView.translatesAutoresizingMaskIntoConstraints = false
    leftView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)

    leftView.clipsToBounds = true
    textField.leftView = leftView
    textField.leftViewMode = .always
  }

  private func additionalTextField() {
    let additionalTextField = PlainTextField()
    additionalTextField.translatesAutoresizingMaskIntoConstraints = false
    additionalTextField.backgroundColor = UIColor.black.withAlphaComponent(0.05)
    additionalTextField.layer.borderWidth = 1.0
    additionalTextField.layer.borderColor = UIColor.black.cgColor
    additionalTextField.textColor = .darkGray
    additionalTextField.text = "Regular UITextfield"

    // when on, enter responds to auto-correction which is confusing when we're trying to create "chips"
    additionalTextField.autocorrectionType = UITextAutocorrectionType.no

    view.addSubview(additionalTextField)

    // position the textfield somewhere in the screen
    if #available(iOSApplicationExtension 9.0, *) {
      additionalTextField.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
      additionalTextField.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
      additionalTextField.topAnchor.constraint(equalTo: textField.topAnchor, constant: 60.0).isActive = true
    } else {
      // Fallback on earlier versions
      print("This example is supported on iOS version 9 or later.")
    }
  }

  fileprivate func appendLabel(text: String) {

    let pad: CGFloat = 5.0

    // create label and add to left view
    let label = newLabel(text: text)
    let lastLabel = leftView.subviews.last
    leftView.addSubview(label)

    // add constraints
    if #available(iOSApplicationExtension 9.0, *) {
      label.topAnchor.constraint(equalTo: leftView.topAnchor).isActive = true
      label.bottomAnchor.constraint(equalTo: leftView.bottomAnchor).isActive = true
      if let lastLabel = lastLabel {
        label.leadingAnchor.constraint(equalTo: lastLabel.trailingAnchor, constant: pad).isActive = true
        //label.leadingAnchor.constraint(equalTo: lastLabel.trailingAnchor, constant: pad).isActive = true
        //lastmax = lastLabel.frame.maxX
      } else {
        leadingConstraint = label.leadingAnchor.constraint(equalTo: leftView.leadingAnchor)
        leadingConstraint?.priority = UILayoutPriority.defaultLow
        leadingConstraint?.isActive = true
      }
    } else {
      // Fallback on earlier versions
      print("This example is supported on iOS version 9 or later.")
    }

    // adjust text field's inset and width
    leftView.layoutIfNeeded()
    textField.insetX = label.frame.maxX
  }

  private func newLabel(text: String) -> UILabel {
    // create label and add to left view
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = UIColor.red.withAlphaComponent(0.4)
    label.text = " " + text + " "
    label.textColor = .white
    label.layer.cornerRadius = 3.0
    label.layer.masksToBounds = true
    return label
  }
}

// MARK: Example Extensions

extension UITextFieldWithChipsExample: UITextFieldDelegate {

  // listen to "enter" key
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    if string == "\n" {
      if let trimmedText = textField.text?.trimmingCharacters(in: .whitespaces),
        trimmedText.count > 0 {
        appendLabel(text: trimmedText)
        textField.text = ""
      }
    }
    return true
  }

  func setupEditingRect(string: String) {

    let textrect = textField.textRect(forBounds: textField.bounds)
    let insetTextField = textField as InsetTextField
    if let textrange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) {
      let firstrect = textField.firstRect(for: textrange)

      // if space is too small for typing, we need to make more room - by moving the split point
      let textWidth = firstrect.width
      let fieldWidth = textrect.width
      let space = fieldWidth - textWidth
      if space < 0 {
        insetTextField.insetX += space
        if let leadingConstraint = leadingConstraint {
          //leftView.removeConstraint(leadingConstraint)
          leadingConstraint.constant += space
        }
        insetTextField.layoutIfNeeded()
      }

    }
  }

  @objc func textFieldDidChange(_ textField: UITextField) {
    setupEditingRect(string: textField.text ?? "")
  }
}

extension UITextFieldWithChipsExample {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension UITextFieldWithChipsExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Chip Text Field", "UI Text Fields With Label Chips"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}

// MARK: UITextField Subclass

private class InsetTextField: UITextField {

  // the split point: this is the x position where chips view ends and text begins.
  // Updating this property moves the split point between chips & text.
  var insetX: CGFloat = 8.0

  // default padding for the textfield, taking insetX into account for the left position
  let insetRect = UIEdgeInsets(top: 5.0, left: 8.0, bottom: 5.0, right: 8.0)

  // text bounds
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    let superbounds = super.textRect(forBounds: bounds)
    var newbounds = superbounds.inset(by: insetRect)
    newbounds.origin.x = insetX
    return newbounds
  }

  // text bounds while editing
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let superbounds = super.editingRect(forBounds: bounds)
    var newbounds = superbounds.inset(by: insetRect)
    newbounds.origin.x = insetX
    return newbounds
  }

  // left view bounds
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    let superbounds = super.leftViewRect(forBounds: bounds)
    var newbounds = superbounds
    newbounds.size.width = insetX
    return newbounds
  }
}

class PlainTextField: UITextField {

  // default padding for the textfield, taking insetX into account for the left position
  let insetRect = UIEdgeInsets(top: 5.0, left: 8.0, bottom: 5.0, right: 8.0)

  // text bounds
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    let superbounds = super.textRect(forBounds: bounds)
    let newbounds = superbounds.inset(by: insetRect)
    return newbounds
  }

  // text bounds while editing
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let superbounds = super.editingRect(forBounds: bounds)
    let newbounds = superbounds.inset(by: insetRect)
    return newbounds
  }
}
