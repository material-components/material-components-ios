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

// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import UIKit

import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTypography

final class TextFieldKitchenSinkSwiftExample: UIViewController {

  let scrollView = UIScrollView()

  let controlLabel: UILabel = {
    let controlLabel = UILabel()
    controlLabel.translatesAutoresizingMaskIntoConstraints = false
    controlLabel.text = "Options"
    controlLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    controlLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    return controlLabel
  }()

  let singleLabel: UILabel = {
    let singleLabel = UILabel()
    singleLabel.translatesAutoresizingMaskIntoConstraints = false
    singleLabel.text = "Single Line Text Fields"
    singleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    singleLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    singleLabel.numberOfLines = 0
    return singleLabel
  }()

  let errorLabel: UILabel = {
    let errorLabel = UILabel()
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.text = "In Error:"
    errorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    errorLabel.textColor = UIColor(white: 0, alpha: MDCTypography.subheadFontOpacity())
    errorLabel.numberOfLines = 0
    return errorLabel
  }()

  let helperLabel: UILabel = {
    let helperLabel = UILabel()
    helperLabel.translatesAutoresizingMaskIntoConstraints = false
    helperLabel.text = "Show Helper Text:"
    helperLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    helperLabel.textColor = UIColor(white: 0, alpha: MDCTypography.subheadFontOpacity())
    helperLabel.numberOfLines = 0
    return helperLabel
  }()

  var allInputControllers = [MDCTextInputController]()
  var allTextFieldControllers = [MDCTextInputController]()
  var controllersWithCharacterCount = [MDCTextInputController]()
  var controllersFullWidth = [MDCTextInputController]()

  let unstyledTextField = MDCTextField()

  let characterModeButton = MDCButton()
  let clearModeButton = MDCButton()
  let underlineButton = MDCButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupExampleViews()
  }

  func setupDefaultTextFields() -> [MDCTextInputController] {
    let textFieldDefault = MDCTextField()
    scrollView.addSubview(textFieldDefault)
    textFieldDefault.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefault.delegate = self
    textFieldDefault.clearButtonMode = .whileEditing
    textFieldDefault.backgroundColor = .white

    let textFieldControllerDefault = MDCTextInputController(input: textFieldDefault)

    textFieldControllerDefault.presentation = .default

    let textFieldDefaultPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldDefaultPlaceholder)
    textFieldDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultPlaceholder.placeholder = "This is a text field w/ inline placeholder"
    textFieldDefaultPlaceholder.delegate = self

    textFieldDefaultPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerDefaultPlaceholder =
      MDCTextInputController(input: textFieldDefaultPlaceholder)

    textFieldControllerDefaultPlaceholder.presentation = .default

    let textFieldDefaultCharMax = MDCTextField()
    scrollView.addSubview(textFieldDefaultCharMax)
    textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultCharMax.placeholder = "This is a text field w/ character count"
    textFieldDefaultCharMax.delegate = self
    textFieldDefaultCharMax.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCharMax = MDCTextInputController(input: textFieldDefaultCharMax)
    textFieldControllerDefaultCharMax.characterMax = 50

    controllersWithCharacterCount.append(textFieldControllerDefaultCharMax)

    return [textFieldControllerDefault, textFieldControllerDefaultPlaceholder,
            textFieldControllerDefaultCharMax]
  }

  func setupFullWidthTextFields() -> [MDCTextInputController] {
    let textFieldFullWidth = MDCTextField()
    scrollView.addSubview(textFieldFullWidth)
    textFieldFullWidth.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidth.delegate = self
    textFieldFullWidth.clearButtonMode = .whileEditing
    textFieldFullWidth.backgroundColor = .white

    let textFieldControllerFullWidth = MDCTextInputController(input: textFieldFullWidth)
    textFieldControllerFullWidth.presentation = .fullWidth

    let textFieldFullWidthPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldFullWidthPlaceholder)
    textFieldFullWidthPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthPlaceholder.placeholder = "This is a full width text field"
    textFieldFullWidthPlaceholder.delegate = self
    textFieldFullWidthPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthPlaceholder =
      MDCTextInputController(input: textFieldFullWidthPlaceholder)
    textFieldControllerFullWidthPlaceholder.presentation = .fullWidth

    let textFieldFullWidthCharMax = MDCTextField()
    scrollView.addSubview(textFieldFullWidthCharMax)
    textFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthCharMax.placeholder =
      "This is a full width text field with character count and a very long placeholder"
    textFieldFullWidthCharMax.delegate = self
    textFieldFullWidthCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthCharMax =
      MDCTextInputController(input: textFieldFullWidthCharMax)
    textFieldControllerFullWidthCharMax.presentation = .fullWidth
    textFieldControllerFullWidthCharMax.characterMax = 50

    controllersWithCharacterCount.append(textFieldControllerFullWidthCharMax)

    return [textFieldControllerFullWidth, textFieldControllerFullWidthPlaceholder,
            textFieldControllerFullWidthCharMax]
  }

  func setupFloatingTextFields() -> [MDCTextInputController] {
    let textFieldFloating = MDCTextField()
    scrollView.addSubview(textFieldFloating)
    textFieldFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldFloating.placeholder = "This is a text field w/ floating placeholder"
    textFieldFloating.delegate = self
    textFieldFloating.clearButtonMode = .whileEditing

    let textFieldControllerFloating = MDCTextInputController(input: textFieldFloating)

    textFieldControllerFloating.presentation = .floatingPlaceholder

    let textFieldFloatingCharMax = MDCTextField()
    scrollView.addSubview(textFieldFloatingCharMax)
    textFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldFloatingCharMax.placeholder = "This is floating with character count"
    textFieldFloatingCharMax.delegate = self
    textFieldFloatingCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFloatingCharMax = MDCTextInputController(input: textFieldFloatingCharMax)
    textFieldControllerFloatingCharMax.presentation = .floatingPlaceholder
    textFieldControllerFloatingCharMax.characterMax = 50

    controllersWithCharacterCount.append(textFieldControllerFloatingCharMax)

    return [textFieldControllerFloating, textFieldControllerFloatingCharMax]
  }

  func setupSpecialTextFields() -> [MDCTextInputController] {
    let textFieldDisabled = MDCTextField()
    scrollView.addSubview(textFieldDisabled)
    textFieldDisabled.translatesAutoresizingMaskIntoConstraints = false

    textFieldDisabled.placeholder = "This is a disabled text field"
    textFieldDisabled.delegate = self
    textFieldDisabled.isEnabled = false

    let textFieldControllerDefaultDisabled = MDCTextInputController(input: textFieldDisabled)

    let textFieldCustomFont = MDCTextField()
    scrollView.addSubview(textFieldCustomFont)
    textFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false

    textFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFont.placeholder = "This is a custom font"
    textFieldCustomFont.delegate = self
    textFieldCustomFont.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCustomFont = MDCTextInputController(input: textFieldCustomFont)
    textFieldCustomFont.placeholderLabel.font = UIFont.preferredFont(forTextStyle: .headline)

    let textFieldCustomFontFloating = MDCTextField()
    scrollView.addSubview(textFieldCustomFontFloating)
    textFieldCustomFontFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldCustomFontFloating.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.placeholder = "This is a custom font with the works"
    textFieldCustomFontFloating.delegate = self
    textFieldCustomFontFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCustomFontFloating =
      MDCTextInputController(input: textFieldCustomFontFloating)
    textFieldControllerDefaultCustomFontFloating.presentation = .floatingPlaceholder
    textFieldControllerDefaultCustomFontFloating.characterMax = 40
    textFieldControllerDefaultCustomFontFloating.helper = "Custom Font"
    textFieldCustomFontFloating.leadingLabel.font =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.placeholderLabel.font =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.trailingLabel.font =
      UIFont.preferredFont(forTextStyle: .subheadline)
    textFieldCustomFontFloating.clearButtonColor = MDCPalette.red().tint500

    let bundle = Bundle(for: TextFieldKitchenSinkSwiftExample.self)
    let leftViewImagePath = bundle.path(forResource: "ic_search", ofType: "png")!
    let leftViewImage = UIImage(contentsOfFile: leftViewImagePath)!

    let textFieldLeftView = MDCTextField()
    textFieldLeftView.leftViewMode = .always
    textFieldLeftView.leftView = UIImageView(image:leftViewImage)

    scrollView.addSubview(textFieldLeftView)
    textFieldLeftView.translatesAutoresizingMaskIntoConstraints = false

    textFieldLeftView.placeholder = "This has a left view"
    textFieldLeftView.delegate = self
    textFieldLeftView.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeftView = MDCTextInputController(input: textFieldLeftView)

    let textFieldLeftViewFloating = MDCTextField()
    textFieldLeftViewFloating.leftViewMode = .always
    textFieldLeftViewFloating.leftView = UIImageView(image:leftViewImage)

    scrollView.addSubview(textFieldLeftViewFloating)
    textFieldLeftViewFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldLeftViewFloating.placeholder = "This has a left view and floats"
    textFieldLeftViewFloating.delegate = self
    textFieldLeftViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeftViewFloating =
      MDCTextInputController(input: textFieldLeftViewFloating)
    textFieldControllerDefaultLeftViewFloating.presentation = .floatingPlaceholder

    let rightViewImagePath = bundle.path(forResource: "ic_done", ofType: "png")!
    let rightViewImage = UIImage(contentsOfFile: rightViewImagePath)!

    let textFieldRightView = MDCTextField()
    textFieldRightView.rightViewMode = .always
    textFieldRightView.rightView = UIImageView(image:rightViewImage)

    scrollView.addSubview(textFieldRightView)
    textFieldRightView.translatesAutoresizingMaskIntoConstraints = false

    textFieldRightView.placeholder = "This has a right view"
    textFieldRightView.delegate = self
    textFieldRightView.clearButtonMode = .whileEditing

    let textFieldControllerDefaultRightView = MDCTextInputController(input: textFieldRightView)

    let textFieldRightViewFloating = MDCTextField()
    textFieldRightViewFloating.rightViewMode = .always
    textFieldRightViewFloating.rightView = UIImageView(image:rightViewImage)

    scrollView.addSubview(textFieldRightViewFloating)
    textFieldRightViewFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldRightViewFloating.placeholder = "This has a right view and floats"
    textFieldRightViewFloating.delegate = self
    textFieldRightViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultRightViewFloating =
      MDCTextInputController(input: textFieldRightViewFloating)
    textFieldControllerDefaultRightViewFloating.presentation = .floatingPlaceholder

    let textFieldLeftRightView = MDCTextField()
    textFieldLeftRightView.leftViewMode = .whileEditing
    textFieldLeftRightView.leftView = UIImageView(image: leftViewImage)
    textFieldLeftRightView.rightViewMode = .unlessEditing
    textFieldLeftRightView.rightView = UIImageView(image:rightViewImage)

    scrollView.addSubview(textFieldLeftRightView)
    textFieldLeftRightView.translatesAutoresizingMaskIntoConstraints = false

    textFieldLeftRightView.placeholder =
      "This has left & right views and a very long placeholder that should be truncated"
    textFieldLeftRightView.delegate = self
    textFieldLeftRightView.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeftRightView =
      MDCTextInputController(input: textFieldLeftRightView)

    let textFieldLeftRightViewFloating = MDCTextField()
    textFieldLeftRightViewFloating.leftViewMode = .always
    textFieldLeftRightViewFloating.leftView = UIImageView(image: leftViewImage)
    textFieldLeftRightViewFloating.rightViewMode = .whileEditing
    textFieldLeftRightViewFloating.rightView = UIImageView(image:rightViewImage)

    scrollView.addSubview(textFieldLeftRightViewFloating)
    textFieldLeftRightViewFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldLeftRightViewFloating.placeholder =
      "This has left & right views and floats and a very long placeholder that should be truncated"
    textFieldLeftRightViewFloating.delegate = self
    textFieldLeftRightViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeftRightViewFloating =
      MDCTextInputController(input: textFieldLeftRightViewFloating)
    textFieldControllerDefaultLeftRightViewFloating.presentation = .floatingPlaceholder

    scrollView.addSubview(unstyledTextField)
    unstyledTextField.translatesAutoresizingMaskIntoConstraints = false

    unstyledTextField.placeholder = "This is an unstyled text field (no controller)"
    unstyledTextField.leadingLabel.text = "Leading label"
    unstyledTextField.trailingLabel.text = "Trailing label"
    unstyledTextField.delegate = self
    unstyledTextField.clearButtonMode = .whileEditing
    unstyledTextField.leftView = UIImageView(image: leftViewImage)
    unstyledTextField.leftViewMode = .always
    unstyledTextField.rightView = UIImageView(image: rightViewImage)
    unstyledTextField.rightViewMode = .always

    return [textFieldControllerDefaultDisabled,
            textFieldControllerDefaultCustomFont, textFieldControllerDefaultCustomFontFloating,
            textFieldControllerDefaultLeftView, textFieldControllerDefaultLeftViewFloating,
            textFieldControllerDefaultRightView, textFieldControllerDefaultRightViewFloating,
            textFieldControllerDefaultLeftRightView,
            textFieldControllerDefaultLeftRightViewFloating]
  }

  func tapDidTouch(sender: Any) {
    self.view.endEditing(true)
  }

  func errorSwitchDidChange(errorSwitch: UISwitch) {
    allInputControllers.forEach { controller in
      if errorSwitch.isOn {
        controller.set(errorText: "Uh oh! Try something else.", errorAccessibilityValue: nil)
      } else {
        controller.set(errorText: nil, errorAccessibilityValue: nil)
      }
    }
  }

  func helperSwitchDidChange(helperSwitch: UISwitch) {
    allInputControllers.forEach { controller in
      controller.helper = helperSwitch.isOn ? "This is helper text." : nil
    }
  }

}

extension TextFieldKitchenSinkSwiftExample: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

extension TextFieldKitchenSinkSwiftExample {
  func contentSizeCategoryDidChange(notif: Notification) {
    controlLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    singleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    errorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    helperLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
  }
}
