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
    singleLabel.text = "Single-line Text Fields"
    singleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    singleLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    singleLabel.numberOfLines = 0
    return singleLabel
  }()

  let multiLabel: UILabel = {
    let multiLabel = UILabel()
    multiLabel.translatesAutoresizingMaskIntoConstraints = false
    multiLabel.text = "Multi-line Text Fields"
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
  var controllersFullWidth = [MDCTextInputControllerFullWidth]()

  let unstyledTextField = MDCTextField()
  let unstyledMultilineTextField = MDCMultilineTextField()

  lazy var textInsetsModeButton: MDCButton = self.setupButton()
  lazy var characterModeButton: MDCButton = self.setupButton()
  lazy var clearModeButton: MDCButton = self.setupButton()
  lazy var underlineButton: MDCButton = self.setupButton()

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupExampleViews()
  }

  func setupFilledTextFields() -> [MDCTextInputControllerFilled] {
    let textFieldFilled = MDCTextField()
    textFieldFilled.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFilled)

    textFieldFilled.delegate = self

    let textFieldControllerFilled = MDCTextInputControllerFilled(textInput: textFieldFilled)
    textFieldControllerFilled.isFloatingEnabled = false
    textFieldControllerFilled.placeholderText = "This is a filled text field"

    let textFieldFilledFloating = MDCTextField()
    textFieldFilledFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFilledFloating)

    textFieldFilledFloating.delegate = self

    let textFieldControllerFilledFloating = MDCTextInputControllerFilled(textInput: textFieldFilledFloating)
    textFieldControllerFilledFloating.placeholderText = "This is filled and floating"
    return [textFieldControllerFilled, textFieldControllerFilledFloating]
  }

  func setupDefaultTextFields() -> [MDCTextInputControllerDefault] {
    let textFieldDefault = MDCTextField()
    textFieldDefault.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldDefault)

    textFieldDefault.delegate = self
    textFieldDefault.clearButtonMode = .whileEditing

    let textFieldControllerDefault = MDCTextInputControllerDefault(textInput: textFieldDefault)

    textFieldControllerDefault.isFloatingEnabled = false

    let textFieldDefaultPlaceholder = MDCTextField()
    textFieldDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldDefaultPlaceholder)

    textFieldDefaultPlaceholder.delegate = self

    textFieldDefaultPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerDefaultPlaceholder =
      MDCTextInputControllerDefault(textInput: textFieldDefaultPlaceholder)

    textFieldControllerDefaultPlaceholder.isFloatingEnabled = false
    textFieldControllerDefaultPlaceholder.placeholderText = "This is a text field w/ inline placeholder"

    let textFieldDefaultCharMax = MDCTextField()
    textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldDefaultCharMax)

    textFieldDefaultCharMax.delegate = self
    textFieldDefaultCharMax.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCharMax =
      MDCTextInputControllerDefault(textInput: textFieldDefaultCharMax)
    textFieldControllerDefaultCharMax.characterCountMax = 50
    textFieldControllerDefaultCharMax.isFloatingEnabled = false
    textFieldControllerDefaultCharMax.placeholderText = "This is a text field w/ character count"

    controllersWithCharacterCount.append(textFieldControllerDefaultCharMax)

    return [textFieldControllerDefault, textFieldControllerDefaultPlaceholder,
            textFieldControllerDefaultCharMax]
  }

  func setupFullWidthTextFields() -> [MDCTextInputControllerFullWidth] {
    let textFieldFullWidthPlaceholder = MDCTextField()
    textFieldFullWidthPlaceholder.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFullWidthPlaceholder)

    textFieldFullWidthPlaceholder.delegate = self
    textFieldFullWidthPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthPlaceholder =
      MDCTextInputControllerFullWidth(textInput: textFieldFullWidthPlaceholder)
    textFieldControllerFullWidthPlaceholder.placeholderText = "This is a full width text field"

    let textFieldFullWidthCharMax = MDCTextField()
    textFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFullWidthCharMax)

    textFieldFullWidthCharMax.delegate = self
    textFieldFullWidthCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthCharMax =
      MDCTextInputControllerFullWidth(textInput: textFieldFullWidthCharMax)
    textFieldControllerFullWidthCharMax.characterCountMax = 50
    textFieldControllerFullWidthCharMax.placeholderText =
      "This is a full width text field with character count and a very long placeholder"

    controllersWithCharacterCount.append(textFieldControllerFullWidthCharMax)

    return [textFieldControllerFullWidthPlaceholder,
            textFieldControllerFullWidthCharMax]
  }

  func setupFloatingTextFields() -> [MDCTextInputControllerDefault] {
    let textFieldFloating = MDCTextField()
    textFieldFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFloating)

    textFieldFloating.delegate = self
    textFieldFloating.clearButtonMode = .whileEditing

    let textFieldControllerFloating = MDCTextInputControllerDefault(textInput: textFieldFloating)
    textFieldControllerFloating.placeholderText = "This is a text field w/ floating placeholder"

    let textFieldFloatingCharMax = MDCTextField()
    textFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFloatingCharMax)

    textFieldFloatingCharMax.delegate = self
    textFieldFloatingCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFloatingCharMax =
      MDCTextInputControllerDefault(textInput: textFieldFloatingCharMax)
    textFieldControllerFloatingCharMax.characterCountMax = 50
    textFieldControllerFloatingCharMax.placeholderText = "This is floating with character count"

    controllersWithCharacterCount.append(textFieldControllerFloatingCharMax)

    return [textFieldControllerFloating, textFieldControllerFloatingCharMax]
  }

  func setupSpecialTextFields() -> [MDCTextInputControllerDefault] {
    let textFieldDisabled = MDCTextField()
    textFieldDisabled.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldDisabled)

    textFieldDisabled.delegate = self
    textFieldDisabled.isEnabled = false

    let textFieldControllerDefaultDisabled =
      MDCTextInputControllerDefault(textInput: textFieldDisabled)
    textFieldControllerDefaultDisabled.isFloatingEnabled = false
    textFieldControllerDefaultDisabled.placeholderText = "This is a disabled text field"

    let textFieldCustomFont = MDCTextField()
    textFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldCustomFont)

    textFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFont.delegate = self
    textFieldCustomFont.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCustomFont =
      MDCTextInputControllerDefault(textInput: textFieldCustomFont)
    textFieldControllerDefaultCustomFont.inlinePlaceholderFont = UIFont.preferredFont(forTextStyle: .headline)
    textFieldControllerDefaultCustomFont.isFloatingEnabled = false
    textFieldControllerDefaultCustomFont.placeholderText = "This is a custom font"

    let textFieldCustomFontFloating = MDCTextField()
    textFieldCustomFontFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldCustomFontFloating)

    textFieldCustomFontFloating.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.delegate = self
    textFieldCustomFontFloating.clearButtonMode = .whileEditing
    textFieldCustomFontFloating.cursorColor = .orange

    let textFieldControllerDefaultCustomFontFloating =
      MDCTextInputControllerDefault(textInput: textFieldCustomFontFloating)
    textFieldControllerDefaultCustomFontFloating.characterCountMax = 40
    textFieldControllerDefaultCustomFontFloating.placeholderText = "This is a custom font with the works"
    textFieldControllerDefaultCustomFontFloating.helperText = "Custom Font"
    textFieldControllerDefaultCustomFontFloating.activeColor = .green
    textFieldControllerDefaultCustomFontFloating.normalColor = .purple
    textFieldControllerDefaultCustomFontFloating.leadingUnderlineLabelTextColor = .cyan
    textFieldControllerDefaultCustomFontFloating.trailingUnderlineLabelTextColor = .magenta
    textFieldControllerDefaultCustomFontFloating.leadingUnderlineLabelFont =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldControllerDefaultCustomFontFloating.inlinePlaceholderFont =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldControllerDefaultCustomFontFloating.trailingUnderlineLabelFont =
      UIFont.preferredFont(forTextStyle: .subheadline)
    textFieldCustomFontFloating.clearButton.tintColor = MDCPalette.red.accent400

    let bundle = Bundle(for: TextFieldKitchenSinkSwiftExample.self)
    let leadingViewImage = UIImage(named: "ic_search", in: bundle, compatibleWith: nil)!

    let textFieldLeadingView = MDCTextField()
    textFieldLeadingView.leadingViewMode = .always
    textFieldLeadingView.leadingView = UIImageView(image:leadingViewImage)

    textFieldLeadingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingView)

    textFieldLeadingView.delegate = self
    textFieldLeadingView.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeadingView =
      MDCTextInputControllerDefault(textInput: textFieldLeadingView)
    textFieldControllerDefaultLeadingView.isFloatingEnabled = false
    textFieldControllerDefaultLeadingView.placeholderText = "This has a leading view"

    let textFieldLeadingViewFloating = MDCTextField()
    textFieldLeadingViewFloating.leadingViewMode = .always
    textFieldLeadingViewFloating.leadingView = UIImageView(image:leadingViewImage)

    textFieldLeadingViewFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingViewFloating)

    textFieldLeadingViewFloating.delegate = self
    textFieldLeadingViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeadingViewFloating =
      MDCTextInputControllerDefault(textInput: textFieldLeadingViewFloating)
    textFieldControllerDefaultLeadingViewFloating.placeholderText = "This has a leading view and floats"

    let trailingViewImage = UIImage(named: "ic_done", in: bundle, compatibleWith: nil)!

    let textFieldTrailingView = MDCTextField()
    textFieldTrailingView.trailingViewMode = .always
    textFieldTrailingView.trailingView = UIImageView(image:trailingViewImage)

    textFieldTrailingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldTrailingView)

    textFieldTrailingView.delegate = self
    textFieldTrailingView.clearButtonMode = .whileEditing

    let textFieldControllerDefaultTrailingView =
      MDCTextInputControllerDefault(textInput: textFieldTrailingView)
    textFieldControllerDefaultTrailingView.isFloatingEnabled = false
    textFieldControllerDefaultTrailingView.placeholderText = "This has a trailing view"

    let textFieldTrailingViewFloating = MDCTextField()
    textFieldTrailingViewFloating.trailingViewMode = .always
    textFieldTrailingViewFloating.trailingView = UIImageView(image:trailingViewImage)

    textFieldTrailingViewFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldTrailingViewFloating)

    textFieldTrailingViewFloating.delegate = self
    textFieldTrailingViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultTrailingViewFloating =
      MDCTextInputControllerDefault(textInput: textFieldTrailingViewFloating)
    textFieldControllerDefaultTrailingViewFloating.placeholderText = "This has a trailing view and floats"

    let textFieldLeadingTrailingView = MDCTextField()
    textFieldLeadingTrailingView.leadingViewMode = .whileEditing
    textFieldLeadingTrailingView.leadingView = UIImageView(image: leadingViewImage)
    textFieldLeadingTrailingView.trailingViewMode = .unlessEditing
    textFieldLeadingTrailingView.trailingView = UIImageView(image:trailingViewImage)

    textFieldLeadingTrailingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingTrailingView)

    textFieldLeadingTrailingView.delegate = self
    textFieldLeadingTrailingView.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeadingTrailingView =
      MDCTextInputControllerDefault(textInput: textFieldLeadingTrailingView)
    textFieldControllerDefaultLeadingTrailingView.isFloatingEnabled = false
    textFieldControllerDefaultLeadingTrailingView.placeholderText =
      "This has leading & trailing views and a very long placeholder that should be truncated"

    let textFieldLeadingTrailingViewFloating = MDCTextField()
    textFieldLeadingTrailingViewFloating.leadingViewMode = .always
    textFieldLeadingTrailingViewFloating.leadingView = UIImageView(image: leadingViewImage)
    textFieldLeadingTrailingViewFloating.trailingViewMode = .whileEditing
    textFieldLeadingTrailingViewFloating.trailingView = UIImageView(image:trailingViewImage)

    textFieldLeadingTrailingViewFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingTrailingViewFloating)

    textFieldLeadingTrailingViewFloating.delegate = self
    textFieldLeadingTrailingViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeadingTrailingViewFloating =
      MDCTextInputControllerDefault(textInput: textFieldLeadingTrailingViewFloating)
    textFieldControllerDefaultLeadingTrailingViewFloating.placeholderText =
      "This has leading & trailing views and floats and a very long placeholder that should be truncated"

    unstyledTextField.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(unstyledTextField)

    unstyledTextField.placeholder = "This is an unstyled text field (no controller)"
    unstyledTextField.leadingUnderlineLabel.text = "Leading label"
    unstyledTextField.trailingUnderlineLabel.text = "Trailing label"
    unstyledTextField.delegate = self
    unstyledTextField.clearButtonMode = .whileEditing
    unstyledTextField.leadingView = UIImageView(image: leadingViewImage)
    unstyledTextField.leadingViewMode = .always
    unstyledTextField.trailingView = UIImageView(image: trailingViewImage)
    unstyledTextField.trailingViewMode = .always

    return [textFieldControllerDefaultDisabled,
            textFieldControllerDefaultCustomFont, textFieldControllerDefaultCustomFontFloating,
            textFieldControllerDefaultLeadingView, textFieldControllerDefaultLeadingViewFloating,
            textFieldControllerDefaultTrailingView, textFieldControllerDefaultTrailingViewFloating,
            textFieldControllerDefaultLeadingTrailingView,
            textFieldControllerDefaultLeadingTrailingViewFloating]
  }

  // MARK: - Multi-line

  func setupAreaTextFields() -> [MDCTextInputControllerOutlinedTextArea] {
    let textFieldArea = MDCMultilineTextField()
    textFieldArea.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldArea)

    textFieldArea.textView?.delegate = self

    let textFieldControllerArea = MDCTextInputControllerOutlinedTextArea(textInput: textFieldArea)
    textFieldControllerArea.placeholderText = "This is a text area"

    return [textFieldControllerArea]
  }

  func setupDefaultMultilineTextFields() -> [MDCTextInputControllerDefault] {
    let multilineTextFieldDefault = MDCMultilineTextField()
    multilineTextFieldDefault.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldDefault)

    multilineTextFieldDefault.textView?.delegate = self

    let multilineTextFieldControllerDefault =
        MDCTextInputControllerDefault(textInput: multilineTextFieldDefault)
    multilineTextFieldControllerDefault.isFloatingEnabled = false

    let multilineTextFieldDefaultPlaceholder = MDCMultilineTextField()
    multilineTextFieldDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldDefaultPlaceholder)

    multilineTextFieldDefaultPlaceholder.textView?.delegate = self

    let multilineTextFieldControllerDefaultPlaceholder =
      MDCTextInputControllerDefault(textInput: multilineTextFieldDefaultPlaceholder)
    multilineTextFieldControllerDefaultPlaceholder.isFloatingEnabled = false
    multilineTextFieldControllerDefaultPlaceholder.placeholderText =
      "This is a multi-line text field with placeholder"

    let multilineTextFieldDefaultCharMax = MDCMultilineTextField()
    multilineTextFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldDefaultCharMax)

    multilineTextFieldDefaultCharMax.textView?.delegate = self

    let multilineTextFieldControllerDefaultCharMax =
          MDCTextInputControllerDefault(textInput: multilineTextFieldDefaultCharMax)
    multilineTextFieldControllerDefaultCharMax.characterCountMax = 140
    multilineTextFieldControllerDefaultCharMax.isFloatingEnabled = false
    multilineTextFieldControllerDefaultCharMax.placeholderText =
      "This is a multi-line text field with placeholder"

    controllersWithCharacterCount.append(multilineTextFieldControllerDefaultCharMax)

    return [multilineTextFieldControllerDefault, multilineTextFieldControllerDefaultPlaceholder,
            multilineTextFieldControllerDefaultCharMax]
  }

  func setupFullWidthMultilineTextFields() -> [MDCTextInputControllerFullWidth] {
    let multilineTextFieldFullWidth = MDCMultilineTextField()
    multilineTextFieldFullWidth.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldFullWidth)

    multilineTextFieldFullWidth.textView?.delegate = self

    let multilineTextFieldControllerFullWidth =
          MDCTextInputControllerFullWidth(textInput: multilineTextFieldFullWidth)
    multilineTextFieldControllerFullWidth.placeholderText =
      "This is a full width multi-line text field"

    let multilineTextFieldFullWidthCharMax = MDCMultilineTextField()
    multilineTextFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldFullWidthCharMax)

    multilineTextFieldFullWidthCharMax.textView?.delegate = self

    let multilineTextFieldControllerFullWidthCharMax =
          MDCTextInputControllerFullWidth(textInput: multilineTextFieldFullWidthCharMax)
    multilineTextFieldControllerFullWidthCharMax.placeholderText =
        "This is a full width multi-line text field with character count"

    controllersWithCharacterCount.append(multilineTextFieldControllerFullWidthCharMax)
    multilineTextFieldControllerFullWidthCharMax.characterCountMax = 140

    return [multilineTextFieldControllerFullWidth, multilineTextFieldControllerFullWidthCharMax]
  }

  func setupFloatingMultilineTextFields() -> [MDCTextInputControllerDefault] {
    let multilineTextFieldFloating = MDCMultilineTextField()
    multilineTextFieldFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldFloating)

    multilineTextFieldFloating.textView?.delegate = self

    let multilineTextFieldControllerFloating =
          MDCTextInputControllerDefault(textInput: multilineTextFieldFloating)
    multilineTextFieldControllerFloating.placeholderText =
      "This is a multi-line text field with a floating placeholder"

    let multilineTextFieldFloatingCharMax = MDCMultilineTextField()
    multilineTextFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldFloatingCharMax)

    multilineTextFieldFloatingCharMax.textView?.delegate = self

    let multilineTextFieldControllerFloatingCharMax =
          MDCTextInputControllerDefault(textInput: multilineTextFieldFloatingCharMax)
    multilineTextFieldControllerFloatingCharMax.placeholderText =
        "This is a multi-line text field with a floating placeholder and character count"

    controllersWithCharacterCount.append(multilineTextFieldControllerFloatingCharMax)

    return [multilineTextFieldControllerFloating, multilineTextFieldControllerFloatingCharMax]
  }

  func setupSpecialMultilineTextFields() -> [MDCTextInputController] {
    let bundle = Bundle(for: TextFieldKitchenSinkSwiftExample.self)
    let trailingViewImage = UIImage(named: "ic_done", in: bundle, compatibleWith: nil)!

    let multilineTextFieldTrailingView = MDCMultilineTextField()
    multilineTextFieldTrailingView.trailingViewMode = .always
    multilineTextFieldTrailingView.trailingView = UIImageView(image:trailingViewImage)

    multilineTextFieldTrailingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldTrailingView)

    multilineTextFieldTrailingView.textView?.delegate = self
    multilineTextFieldTrailingView.clearButtonMode = .whileEditing

    let multilineTextFieldControllerDefaultTrailingView =
        MDCTextInputControllerDefault(textInput: multilineTextFieldTrailingView)
    multilineTextFieldControllerDefaultTrailingView.isFloatingEnabled = false
    multilineTextFieldControllerDefaultTrailingView.placeholderText = "This has a trailing view"

    let multilineTextFieldCustomFont = MDCMultilineTextField()
    multilineTextFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldCustomFont)


    let multilineTextFieldControllerDefaultCustomFont =
        MDCTextInputControllerDefault(textInput: multilineTextFieldCustomFont)
    multilineTextFieldControllerDefaultCustomFont.placeholderText = "This has a custom font"

    multilineTextFieldCustomFont.placeholderLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    multilineTextFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)

    scrollView.addSubview(unstyledMultilineTextField)
    unstyledMultilineTextField.translatesAutoresizingMaskIntoConstraints = false

    unstyledMultilineTextField.placeholder =
        "This multi-line text field has no controller (unstyled)"
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
