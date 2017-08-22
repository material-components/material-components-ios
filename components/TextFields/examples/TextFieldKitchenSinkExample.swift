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

  let multiLabel: UILabel = {
    let multiLabel = UILabel()
    multiLabel.translatesAutoresizingMaskIntoConstraints = false
    multiLabel.text = "Multiline Text Fields"
    multiLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    multiLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    multiLabel.numberOfLines = 0
    return multiLabel
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
  var allMultilineTextFieldControllers = [MDCTextInputController]()
  var controllersWithCharacterCount = [MDCTextInputController]()
  var controllersFullWidth = [MDCTextInputControllerLegacyFullWidth]()

  let unstyledTextField = MDCTextField()
  let unstyledMultilineTextField = MDCMultilineTextField()

  lazy var characterModeButton: MDCButton = self.setupButton()
  lazy var clearModeButton: MDCButton = self.setupButton()
  lazy var underlineButton: MDCButton = self.setupButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupExampleViews()
  }

  func setupDefaultTextFields() -> [MDCTextInputControllerLegacyDefault] {
    let textFieldDefault = MDCTextField()
    scrollView.addSubview(textFieldDefault)
    textFieldDefault.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefault.delegate = self
    textFieldDefault.clearButtonMode = .whileEditing
    textFieldDefault.backgroundColor = .white

    let textFieldControllerDefault = MDCTextInputControllerLegacyDefault(textInput: textFieldDefault)

    textFieldControllerDefault.isFloatingEnabled = false

    let textFieldDefaultPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldDefaultPlaceholder)
    textFieldDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultPlaceholder.placeholder = "This is a text field w/ inline placeholder"
    textFieldDefaultPlaceholder.delegate = self

    textFieldDefaultPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerDefaultPlaceholder =
      MDCTextInputControllerLegacyDefault(textInput: textFieldDefaultPlaceholder)

    textFieldControllerDefaultPlaceholder.isFloatingEnabled = false

    let textFieldDefaultCharMax = MDCTextField()
    scrollView.addSubview(textFieldDefaultCharMax)
    textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultCharMax.placeholder = "This is a text field w/ character count"
    textFieldDefaultCharMax.delegate = self
    textFieldDefaultCharMax.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCharMax =
      MDCTextInputControllerLegacyDefault(textInput: textFieldDefaultCharMax)
    textFieldControllerDefaultCharMax.characterCountMax = 50
    textFieldControllerDefaultCharMax.isFloatingEnabled = false

    controllersWithCharacterCount.append(textFieldControllerDefaultCharMax)

    return [textFieldControllerDefault, textFieldControllerDefaultPlaceholder,
            textFieldControllerDefaultCharMax]
  }

  func setupFullWidthTextFields() -> [MDCTextInputControllerLegacyFullWidth] {
    let textFieldFullWidth = MDCTextField()
    scrollView.addSubview(textFieldFullWidth)
    textFieldFullWidth.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidth.delegate = self
    textFieldFullWidth.clearButtonMode = .whileEditing
    textFieldFullWidth.backgroundColor = .white

    let textFieldControllerFullWidth =
      MDCTextInputControllerLegacyFullWidth(textInput: textFieldFullWidth)

    let textFieldFullWidthPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldFullWidthPlaceholder)
    textFieldFullWidthPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthPlaceholder.placeholder = "This is a full width text field"
    textFieldFullWidthPlaceholder.delegate = self
    textFieldFullWidthPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthPlaceholder =
      MDCTextInputControllerLegacyFullWidth(textInput: textFieldFullWidthPlaceholder)

    let textFieldFullWidthCharMax = MDCTextField()
    scrollView.addSubview(textFieldFullWidthCharMax)
    textFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthCharMax.placeholder =
      "This is a full width text field with character count and a very long placeholder"
    textFieldFullWidthCharMax.delegate = self
    textFieldFullWidthCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthCharMax =
      MDCTextInputControllerLegacyFullWidth(textInput: textFieldFullWidthCharMax)
    textFieldControllerFullWidthCharMax.characterCountMax = 50

    controllersWithCharacterCount.append(textFieldControllerFullWidthCharMax)

    return [textFieldControllerFullWidth, textFieldControllerFullWidthPlaceholder,
            textFieldControllerFullWidthCharMax]
  }

  func setupFloatingTextFields() -> [MDCTextInputControllerLegacyDefault] {
    let textFieldFloating = MDCTextField()
    scrollView.addSubview(textFieldFloating)
    textFieldFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldFloating.placeholder = "This is a text field w/ floating placeholder"
    textFieldFloating.delegate = self
    textFieldFloating.clearButtonMode = .whileEditing

    let textFieldControllerFloating = MDCTextInputControllerLegacyDefault(textInput: textFieldFloating)

    let textFieldFloatingCharMax = MDCTextField()
    scrollView.addSubview(textFieldFloatingCharMax)
    textFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldFloatingCharMax.placeholder = "This is floating with character count"
    textFieldFloatingCharMax.delegate = self
    textFieldFloatingCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFloatingCharMax =
      MDCTextInputControllerLegacyDefault(textInput: textFieldFloatingCharMax)
    textFieldControllerFloatingCharMax.characterCountMax = 50

    controllersWithCharacterCount.append(textFieldControllerFloatingCharMax)

    return [textFieldControllerFloating, textFieldControllerFloatingCharMax]
  }

  func setupSpecialTextFields() -> [MDCTextInputControllerLegacyDefault] {
    let textFieldDisabled = MDCTextField()
    scrollView.addSubview(textFieldDisabled)
    textFieldDisabled.translatesAutoresizingMaskIntoConstraints = false

    textFieldDisabled.placeholder = "This is a disabled text field"
    textFieldDisabled.delegate = self
    textFieldDisabled.isEnabled = false

    let textFieldControllerDefaultDisabled =
      MDCTextInputControllerLegacyDefault(textInput: textFieldDisabled)
    textFieldControllerDefaultDisabled.isFloatingEnabled = false

    let textFieldCustomFont = MDCTextField()
    scrollView.addSubview(textFieldCustomFont)
    textFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false

    textFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFont.placeholder = "This is a custom font"
    textFieldCustomFont.delegate = self
    textFieldCustomFont.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCustomFont =
      MDCTextInputControllerLegacyDefault(textInput: textFieldCustomFont)
    textFieldCustomFont.placeholderLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldControllerDefaultCustomFont.isFloatingEnabled = false

    let textFieldCustomFontFloating = MDCTextField()
    scrollView.addSubview(textFieldCustomFontFloating)
    textFieldCustomFontFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldCustomFontFloating.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.placeholder = "This is a custom font with the works"
    textFieldCustomFontFloating.delegate = self
    textFieldCustomFontFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCustomFontFloating =
      MDCTextInputControllerLegacyDefault(textInput: textFieldCustomFontFloating)
    textFieldControllerDefaultCustomFontFloating.characterCountMax = 40
    textFieldControllerDefaultCustomFontFloating.helperText = "Custom Font"
    textFieldControllerDefaultCustomFontFloating.activeColor = .green
    textFieldControllerDefaultCustomFontFloating.normalColor = .purple
    textFieldControllerDefaultCustomFontFloating.leadingUnderlineLabelTextColor = .cyan
    textFieldControllerDefaultCustomFontFloating.trailingUnderlineLabelTextColor = .magenta
    textFieldCustomFontFloating.leadingUnderlineLabel.font =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.placeholderLabel.font =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.trailingUnderlineLabel.font =
      UIFont.preferredFont(forTextStyle: .subheadline)
    textFieldCustomFontFloating.clearButtonColor = MDCPalette.red.accent400

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

    let textFieldControllerDefaultLeftView =
      MDCTextInputControllerLegacyDefault(textInput: textFieldLeftView)
    textFieldControllerDefaultLeftView.isFloatingEnabled = false

    let textFieldLeftViewFloating = MDCTextField()
    textFieldLeftViewFloating.leftViewMode = .always
    textFieldLeftViewFloating.leftView = UIImageView(image:leftViewImage)

    scrollView.addSubview(textFieldLeftViewFloating)
    textFieldLeftViewFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldLeftViewFloating.placeholder = "This has a left view and floats"
    textFieldLeftViewFloating.delegate = self
    textFieldLeftViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeftViewFloating =
      MDCTextInputControllerLegacyDefault(textInput: textFieldLeftViewFloating)

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

    let textFieldControllerDefaultRightView =
      MDCTextInputControllerLegacyDefault(textInput: textFieldRightView)
    textFieldControllerDefaultRightView.isFloatingEnabled = false

    let textFieldRightViewFloating = MDCTextField()
    textFieldRightViewFloating.rightViewMode = .always
    textFieldRightViewFloating.rightView = UIImageView(image:rightViewImage)

    scrollView.addSubview(textFieldRightViewFloating)
    textFieldRightViewFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldRightViewFloating.placeholder = "This has a right view and floats"
    textFieldRightViewFloating.delegate = self
    textFieldRightViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultRightViewFloating =
      MDCTextInputControllerLegacyDefault(textInput: textFieldRightViewFloating)

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
      MDCTextInputControllerLegacyDefault(textInput: textFieldLeftRightView)
    textFieldControllerDefaultLeftRightView.isFloatingEnabled = false

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
      MDCTextInputControllerLegacyDefault(textInput: textFieldLeftRightViewFloating)

    scrollView.addSubview(unstyledTextField)
    unstyledTextField.translatesAutoresizingMaskIntoConstraints = false

    unstyledTextField.placeholder = "This is an unstyled text field (no controller)"
    unstyledTextField.leadingUnderlineLabel.text = "Leading label"
    unstyledTextField.trailingUnderlineLabel.text = "Trailing label"
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

  // MARK: - Multiline
  func setupDefaultMultilineTextFields() -> [MDCTextInputControllerLegacyDefault] {
    let multilineTextFieldDefault = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldDefault)
    multilineTextFieldDefault.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldDefault.textView?.delegate = self

    let multilineTextFieldControllerDefault =
        MDCTextInputControllerLegacyDefault(textInput: multilineTextFieldDefault)
    multilineTextFieldControllerDefault.isFloatingEnabled = false

    let multilineTextFieldDefaultPlaceholder = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldDefaultPlaceholder)
    multilineTextFieldDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldDefaultPlaceholder.placeholder =
        "This is a multiline text field with placeholder"
    multilineTextFieldDefaultPlaceholder.textView?.delegate = self

    let multilineTextFieldControllerDefaultPlaceholder =
      MDCTextInputControllerLegacyDefault(textInput: multilineTextFieldDefaultPlaceholder)
    multilineTextFieldControllerDefaultPlaceholder.isFloatingEnabled = false

    let multilineTextFieldDefaultCharMax = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldDefaultCharMax)
    multilineTextFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldDefaultCharMax.placeholder = "This is a multiline text field with placeholder"
    multilineTextFieldDefaultCharMax.textView?.delegate = self

    let multilineTextFieldControllerDefaultCharMax =
          MDCTextInputControllerLegacyDefault(textInput: multilineTextFieldDefaultCharMax)
    multilineTextFieldControllerDefaultCharMax.characterCountMax = 140
    multilineTextFieldControllerDefaultCharMax.isFloatingEnabled = false

    controllersWithCharacterCount.append(multilineTextFieldControllerDefaultCharMax)

    return [multilineTextFieldControllerDefault, multilineTextFieldControllerDefaultPlaceholder,
            multilineTextFieldControllerDefaultCharMax]
  }

  func setupFullWidthMultilineTextFields() -> [MDCTextInputControllerLegacyFullWidth] {
    let multilineTextFieldFullWidth = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldFullWidth)
    multilineTextFieldFullWidth.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldFullWidth.placeholder = "This is a full width multiline text field"
    multilineTextFieldFullWidth.textView?.delegate = self

    let multilineTextFieldControllerFullWidth =
          MDCTextInputControllerLegacyFullWidth(textInput: multilineTextFieldFullWidth)

    let multilineTextFieldFullWidthCharMax = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldFullWidthCharMax)
    multilineTextFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldFullWidthCharMax.placeholder =
        "This is a full width multiline text field with character count"
    multilineTextFieldFullWidthCharMax.textView?.delegate = self

    let multilineTextFieldControllerFullWidthCharMax =
          MDCTextInputControllerLegacyFullWidth(textInput: multilineTextFieldFullWidthCharMax)

    controllersWithCharacterCount.append(multilineTextFieldControllerFullWidthCharMax)
    multilineTextFieldControllerFullWidthCharMax.characterCountMax = 140

    return [multilineTextFieldControllerFullWidth, multilineTextFieldControllerFullWidthCharMax]
  }

  func setupFloatingMultilineTextFields() -> [MDCTextInputControllerLegacyDefault] {
    let multilineTextFieldFloating = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldFloating)
    multilineTextFieldFloating.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldFloating.textView?.delegate = self
    multilineTextFieldFloating.placeholder =
        "This is a multiline text field with a floating placeholder"

    let multilineTextFieldControllerFloating =
          MDCTextInputControllerLegacyDefault(textInput: multilineTextFieldFloating)

    let multilineTextFieldFloatingCharMax = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldFloatingCharMax)
    multilineTextFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldFloatingCharMax.textView?.delegate = self
    multilineTextFieldFloatingCharMax.placeholder =
        "This is a multiline text field with a floating placeholder and character count"

    let multilineTextFieldControllerFloatingCharMax =
          MDCTextInputControllerLegacyDefault(textInput: multilineTextFieldFloatingCharMax)

    controllersWithCharacterCount.append(multilineTextFieldControllerFloatingCharMax)

    return [multilineTextFieldControllerFloating, multilineTextFieldControllerFloatingCharMax]
  }

  func setupSpecialMultilineTextFields() -> [MDCTextInputController] {
    let bundle = Bundle(for: TextFieldKitchenSinkSwiftExample.self)
    let rightViewImagePath = bundle.path(forResource: "ic_done", ofType: "png")!
    let rightViewImage = UIImage(contentsOfFile: rightViewImagePath)!

    let multilineTextFieldTrailingView = MDCMultilineTextField()
    multilineTextFieldTrailingView.trailingViewMode = .always
    multilineTextFieldTrailingView.trailingView = UIImageView(image:rightViewImage)

    scrollView.addSubview(multilineTextFieldTrailingView)
    multilineTextFieldTrailingView.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldTrailingView.placeholder = "This has a trailing view"
    multilineTextFieldTrailingView.textView?.delegate = self
    multilineTextFieldTrailingView.clearButtonMode = .whileEditing

    let multilineTextFieldControllerDefaultTrailingView =
        MDCTextInputControllerLegacyDefault(textInput: multilineTextFieldTrailingView)
    multilineTextFieldControllerDefaultTrailingView.isFloatingEnabled = false

    let multilineTextFieldCustomFont = MDCMultilineTextField()
    scrollView.addSubview(multilineTextFieldCustomFont)
    multilineTextFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false

    multilineTextFieldCustomFont.placeholder = "This has a custom font"

    let multilineTextFieldControllerDefaultCustomFont =
        MDCTextInputControllerLegacyDefault(textInput: multilineTextFieldCustomFont)

    scrollView.addSubview(unstyledMultilineTextField)
    unstyledMultilineTextField.translatesAutoresizingMaskIntoConstraints = false

    unstyledMultilineTextField.placeholder =
        "This multiline text field has no controller (unstyled)"
    unstyledMultilineTextField.leadingUnderlineLabel.text = "Leading label"
    unstyledMultilineTextField.trailingUnderlineLabel.text = "Trailing label"
    unstyledMultilineTextField.textView?.delegate = self

    return [multilineTextFieldControllerDefaultTrailingView,
            multilineTextFieldControllerDefaultCustomFont]
  }

  @objc func tapDidTouch(sender: Any) {
    self.view.endEditing(true)
  }

  @objc func errorSwitchDidChange(errorSwitch: UISwitch) {
    allInputControllers.forEach { controller in
      if errorSwitch.isOn {
        controller.setErrorText("Uh oh! Try something else.", errorAccessibilityValue: nil)
      } else {
        controller.setErrorText(nil, errorAccessibilityValue: nil)
      }
    }
  }

  @objc func helperSwitchDidChange(helperSwitch: UISwitch) {
    allInputControllers.forEach { controller in
      controller.helperText = helperSwitch.isOn ? "This is helper text." : nil
    }
  }

}

extension TextFieldKitchenSinkSwiftExample: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

extension TextFieldKitchenSinkSwiftExample: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    print(textView.text)
  }
}

extension TextFieldKitchenSinkSwiftExample {
  @objc func contentSizeCategoryDidChange(notif: Notification) {
    controlLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    singleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    errorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    helperLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
  }
}
