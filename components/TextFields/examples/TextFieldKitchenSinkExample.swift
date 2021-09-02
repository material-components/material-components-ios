// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialTextFields

final class TextFieldKitchenSinkSwiftExample: UIViewController {

  let scrollView = UIScrollView()

  let controlLabel: UILabel = {
    let controlLabel = UILabel()
    controlLabel.translatesAutoresizingMaskIntoConstraints = false
    controlLabel.text = "Options"
    controlLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    return controlLabel
  }()

  let singleLabel: UILabel = {
    let singleLabel = UILabel()
    singleLabel.translatesAutoresizingMaskIntoConstraints = false
    singleLabel.text = "Single-line Text Fields"
    singleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    singleLabel.numberOfLines = 0
    return singleLabel
  }()

  let multiLabel: UILabel = {
    let multiLabel = UILabel()
    multiLabel.translatesAutoresizingMaskIntoConstraints = false
    multiLabel.text = "Multi-line Text Fields"
    multiLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    multiLabel.numberOfLines = 0
    return multiLabel
  }()

  let errorLabel: UILabel = {
    let errorLabel = UILabel()
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.text = "In Error:"
    errorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    errorLabel.numberOfLines = 0
    return errorLabel
  }()

  let helperLabel: UILabel = {
    let helperLabel = UILabel()
    helperLabel.translatesAutoresizingMaskIntoConstraints = false
    helperLabel.text = "Show Helper Text:"
    helperLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    helperLabel.numberOfLines = 0
    return helperLabel
  }()

  let baselineTestLabel: UILabel = {
    let baselineTestLabel = UILabel()
    baselineTestLabel.text = "popopopopopop       "
    baselineTestLabel.translatesAutoresizingMaskIntoConstraints = false
    return baselineTestLabel
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

  let attributedString = NSAttributedString(string: "This uses attributed text.")

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

    let textFieldControllerFilledFloating = MDCTextInputControllerFilled(
      textInput: textFieldFilledFloating)
    textFieldControllerFilledFloating.placeholderText = "This is filled and floating"

    let textFieldFilledFloatingAttributed = MDCTextField()
    textFieldFilledFloatingAttributed.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFilledFloatingAttributed)

    textFieldFilledFloatingAttributed.delegate = self

    let textFieldControllerFilledFloatingAttributed =
      MDCTextInputControllerFilled(textInput: textFieldFilledFloatingAttributed)
    textFieldControllerFilledFloatingAttributed.placeholderText = "This is filled and floating"
    textFieldFilledFloatingAttributed.attributedText = attributedString
    return [
      textFieldControllerFilled, textFieldControllerFilledFloating,
      textFieldControllerFilledFloatingAttributed,
    ]
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

    return [
      textFieldControllerFullWidthPlaceholder,
      textFieldControllerFullWidthCharMax,
    ]
  }

  func setupFloatingUnderlineTextFields() -> [MDCTextInputControllerUnderline] {
    let textFieldFloating = MDCTextField()
    textFieldFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFloating)

    textFieldFloating.delegate = self
    textFieldFloating.clearButtonMode = .whileEditing

    let textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFieldFloating)
    textFieldControllerFloating.placeholderText = "This is a text field w/ floating placeholder"

    let textFieldFloatingCharMax = MDCTextField()
    textFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldFloatingCharMax)

    textFieldFloatingCharMax.delegate = self
    textFieldFloatingCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFloatingCharMax =
      MDCTextInputControllerUnderline(textInput: textFieldFloatingCharMax)
    textFieldControllerFloatingCharMax.characterCountMax = 50
    textFieldControllerFloatingCharMax.placeholderText = "This is floating with character count"

    controllersWithCharacterCount.append(textFieldControllerFloatingCharMax)

    baselineTestLabel.font = textFieldFloatingCharMax.font
    self.scrollView.addSubview(baselineTestLabel)

    baselineTestLabel.trailingAnchor.constraint(
      equalTo: textFieldFloatingCharMax.trailingAnchor,
      constant: 0
    ).isActive = true

    baselineTestLabel.firstBaselineAnchor.constraint(
      equalTo: textFieldFloatingCharMax.firstBaselineAnchor
    ).isActive = true

    return [textFieldControllerFloating, textFieldControllerFloatingCharMax]
  }

  func setupInlineUnderlineTextFields() -> [MDCTextInputControllerUnderline] {
    let textFieldUnderline = MDCTextField()
    textFieldUnderline.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldUnderline)

    textFieldUnderline.delegate = self
    textFieldUnderline.clearButtonMode = .whileEditing

    let textFieldControllerUnderline = MDCTextInputControllerUnderline(
      textInput: textFieldUnderline)

    textFieldControllerUnderline.isFloatingEnabled = false

    let textFieldUnderlinePlaceholder = MDCTextField()
    textFieldUnderlinePlaceholder.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldUnderlinePlaceholder)

    textFieldUnderlinePlaceholder.delegate = self

    textFieldUnderlinePlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerUnderlinePlaceholder =
      MDCTextInputControllerUnderline(textInput: textFieldUnderlinePlaceholder)

    textFieldControllerUnderlinePlaceholder.isFloatingEnabled = false
    textFieldControllerUnderlinePlaceholder.placeholderText =
      "This is a text field w/ inline placeholder"

    let textFieldUnderlineCharMax = MDCTextField()
    textFieldUnderlineCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldUnderlineCharMax)

    textFieldUnderlineCharMax.delegate = self
    textFieldUnderlineCharMax.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineCharMax =
      MDCTextInputControllerUnderline(textInput: textFieldUnderlineCharMax)
    textFieldControllerUnderlineCharMax.characterCountMax = 50
    textFieldControllerUnderlineCharMax.isFloatingEnabled = false
    textFieldControllerUnderlineCharMax.placeholderText = "This is a text field w/ character count"

    controllersWithCharacterCount.append(textFieldControllerUnderlineCharMax)

    return [
      textFieldControllerUnderline, textFieldControllerUnderlinePlaceholder,
      textFieldControllerUnderlineCharMax,
    ]
  }

  func setupSpecialTextFields() -> [MDCTextInputControllerFloatingPlaceholder] {
    let textFieldDisabled = MDCTextField()
    textFieldDisabled.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldDisabled)

    textFieldDisabled.delegate = self
    textFieldDisabled.isEnabled = false

    let textFieldControllerUnderlineDisabled =
      MDCTextInputControllerUnderline(textInput: textFieldDisabled)
    textFieldControllerUnderlineDisabled.isFloatingEnabled = false
    textFieldControllerUnderlineDisabled.placeholderText = "This is a disabled text field"

    let textFieldCustomFont = MDCTextField()
    textFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldCustomFont)

    textFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFont.delegate = self
    textFieldCustomFont.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineCustomFont =
      MDCTextInputControllerUnderline(textInput: textFieldCustomFont)
    textFieldControllerUnderlineCustomFont.inlinePlaceholderFont = UIFont.preferredFont(
      forTextStyle: .headline)
    textFieldControllerUnderlineCustomFont.isFloatingEnabled = false
    textFieldControllerUnderlineCustomFont.placeholderText = "This is a custom font"

    let textFieldCustomFontFloating = MDCTextField()
    textFieldCustomFontFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldCustomFontFloating)

    textFieldCustomFontFloating.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFontFloating.delegate = self
    textFieldCustomFontFloating.clearButtonMode = .whileEditing
    textFieldCustomFontFloating.cursorColor = .orange

    let textFieldControllerUnderlineCustomFontFloating =
      MDCTextInputControllerUnderline(textInput: textFieldCustomFontFloating)
    textFieldControllerUnderlineCustomFontFloating.characterCountMax = 40
    textFieldControllerUnderlineCustomFontFloating.placeholderText =
      "This is a custom font with the works"
    textFieldControllerUnderlineCustomFontFloating.setHelperText(
      "Custom Font",
      helperAccessibilityLabel: "Cyan custom font in leading underline label")
    textFieldControllerUnderlineCustomFontFloating.activeColor = .green
    textFieldControllerUnderlineCustomFontFloating.normalColor = .purple
    textFieldControllerUnderlineCustomFontFloating.leadingUnderlineLabelTextColor = .cyan
    textFieldControllerUnderlineCustomFontFloating.trailingUnderlineLabelTextColor = .magenta
    textFieldControllerUnderlineCustomFontFloating.leadingUnderlineLabelFont =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldControllerUnderlineCustomFontFloating.inlinePlaceholderFont =
      UIFont.preferredFont(forTextStyle: .headline)
    textFieldControllerUnderlineCustomFontFloating.trailingUnderlineLabelFont =
      UIFont.preferredFont(forTextStyle: .subheadline)
    textFieldCustomFontFloating.clearButton.tintColor = MDCPalette.red.accent400
    textFieldControllerUnderlineCustomFontFloating.floatingPlaceholderNormalColor = .yellow
    textFieldControllerUnderlineCustomFontFloating.floatingPlaceholderActiveColor = .orange

    let bundle = Bundle(for: TextFieldKitchenSinkSwiftExample.self)
    let leadingViewImage = UIImage(named: "ic_search", in: bundle, compatibleWith: nil) ?? UIImage()

    let textFieldLeadingView = MDCTextField()
    textFieldLeadingView.leadingViewMode = .always
    textFieldLeadingView.leadingView = UIImageView(image: leadingViewImage)

    textFieldLeadingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingView)

    textFieldLeadingView.delegate = self
    textFieldLeadingView.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineLeadingView =
      MDCTextInputControllerUnderline(textInput: textFieldLeadingView)
    textFieldControllerUnderlineLeadingView.isFloatingEnabled = false
    textFieldControllerUnderlineLeadingView.placeholderText = "This has a leading view"

    let textFieldLeadingViewAttributed = MDCTextField()
    textFieldLeadingViewAttributed.leadingViewMode = .always
    textFieldLeadingViewAttributed.leadingView = UIImageView(image: leadingViewImage)

    textFieldLeadingViewAttributed.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingViewAttributed)

    textFieldLeadingViewAttributed.delegate = self
    textFieldLeadingViewAttributed.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineLeadingViewAttributed =
      MDCTextInputControllerUnderline(textInput: textFieldLeadingViewAttributed)
    textFieldControllerUnderlineLeadingViewAttributed.isFloatingEnabled = false
    textFieldControllerUnderlineLeadingViewAttributed.placeholderText = "This has a leading view"
    textFieldLeadingViewAttributed.attributedText = attributedString

    let textFieldLeadingViewFloating = MDCTextField()
    textFieldLeadingViewFloating.leadingViewMode = .always
    textFieldLeadingViewFloating.leadingView = UIImageView(image: leadingViewImage)

    textFieldLeadingViewFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingViewFloating)

    textFieldLeadingViewFloating.delegate = self
    textFieldLeadingViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineLeadingViewFloating =
      MDCTextInputControllerUnderline(textInput: textFieldLeadingViewFloating)
    textFieldControllerUnderlineLeadingViewFloating.placeholderText =
      "This has a leading view and floats"

    let textFieldLeadingViewFloatingAttributed = MDCTextField()
    textFieldLeadingViewFloatingAttributed.leadingViewMode = .always
    textFieldLeadingViewFloatingAttributed.leadingView = UIImageView(image: leadingViewImage)

    textFieldLeadingViewFloatingAttributed.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingViewFloatingAttributed)

    textFieldLeadingViewFloatingAttributed.delegate = self
    textFieldLeadingViewFloatingAttributed.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineLeadingViewFloatingAttributed =
      MDCTextInputControllerUnderline(textInput: textFieldLeadingViewFloatingAttributed)
    textFieldControllerUnderlineLeadingViewFloatingAttributed.placeholderText =
      "This has a leading view and floats"
    textFieldLeadingViewFloatingAttributed.attributedText = attributedString

    let trailingViewImage = UIImage(named: "ic_done", in: bundle, compatibleWith: nil) ?? UIImage()

    let textFieldTrailingView = MDCTextField()
    textFieldTrailingView.trailingViewMode = .always
    textFieldTrailingView.trailingView = UIImageView(image: trailingViewImage)

    textFieldTrailingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldTrailingView)

    textFieldTrailingView.delegate = self
    textFieldTrailingView.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineTrailingView =
      MDCTextInputControllerUnderline(textInput: textFieldTrailingView)
    textFieldControllerUnderlineTrailingView.isFloatingEnabled = false
    textFieldControllerUnderlineTrailingView.placeholderText = "This has a trailing view"

    let textFieldTrailingViewFloating = MDCTextField()
    textFieldTrailingViewFloating.trailingViewMode = .always
    textFieldTrailingViewFloating.trailingView = UIImageView(image: trailingViewImage)

    textFieldTrailingViewFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldTrailingViewFloating)

    textFieldTrailingViewFloating.delegate = self
    textFieldTrailingViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineTrailingViewFloating =
      MDCTextInputControllerUnderline(textInput: textFieldTrailingViewFloating)
    textFieldControllerUnderlineTrailingViewFloating.placeholderText =
      "This has a trailing view and floats"

    let textFieldLeadingTrailingView = MDCTextField()
    textFieldLeadingTrailingView.leadingViewMode = .whileEditing
    textFieldLeadingTrailingView.leadingView = UIImageView(image: leadingViewImage)
    textFieldLeadingTrailingView.trailingViewMode = .unlessEditing
    textFieldLeadingTrailingView.trailingView = UIImageView(image: trailingViewImage)

    textFieldLeadingTrailingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingTrailingView)

    textFieldLeadingTrailingView.delegate = self
    textFieldLeadingTrailingView.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineLeadingTrailingView =
      MDCTextInputControllerUnderline(textInput: textFieldLeadingTrailingView)
    textFieldControllerUnderlineLeadingTrailingView.isFloatingEnabled = false
    textFieldControllerUnderlineLeadingTrailingView.placeholderText =
      "This has leading & trailing views and a very long placeholder that should be truncated"

    let textFieldLeadingTrailingViewFloating = MDCTextField()
    textFieldLeadingTrailingViewFloating.leadingViewMode = .always
    textFieldLeadingTrailingViewFloating.leadingView = UIImageView(image: leadingViewImage)
    textFieldLeadingTrailingViewFloating.trailingViewMode = .whileEditing
    textFieldLeadingTrailingViewFloating.trailingView = UIImageView(image: trailingViewImage)

    textFieldLeadingTrailingViewFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldLeadingTrailingViewFloating)

    textFieldLeadingTrailingViewFloating.delegate = self
    textFieldLeadingTrailingViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerUnderlineLeadingTrailingViewFloating =
      MDCTextInputControllerUnderline(textInput: textFieldLeadingTrailingViewFloating)
    textFieldControllerUnderlineLeadingTrailingViewFloating.placeholderText =
      "This has leading & trailing views and floats and a very long placeholder that should be truncated"

    let textFieldBase = MDCTextField()
    textFieldBase.delegate = self
    textFieldBase.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldBase)

    let textFieldControllerBase = MDCTextInputControllerBase(textInput: textFieldBase)
    textFieldControllerBase.placeholderText = "This is the common base class for controllers"
    textFieldControllerBase.setHelperText(
      "It's expected that you'll subclass this.",
      helperAccessibilityLabel: "You should subclass this.")

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

    return [
      textFieldControllerUnderlineDisabled,
      textFieldControllerUnderlineCustomFont, textFieldControllerUnderlineCustomFontFloating,
      textFieldControllerUnderlineLeadingView,
      textFieldControllerUnderlineLeadingViewAttributed,
      textFieldControllerUnderlineLeadingViewFloating,
      textFieldControllerUnderlineLeadingViewFloatingAttributed,
      textFieldControllerUnderlineTrailingView,
      textFieldControllerUnderlineTrailingViewFloating,
      textFieldControllerUnderlineLeadingTrailingView,
      textFieldControllerUnderlineLeadingTrailingViewFloating,
      textFieldControllerBase,
    ]
  }

  // MARK: - Multi-line

  func setupAreaTextFields() -> [MDCTextInputControllerOutlinedTextArea] {
    let textFieldArea = MDCMultilineTextField()
    textFieldArea.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldArea)

    textFieldArea.textView?.delegate = self

    let textFieldControllerArea = MDCTextInputControllerOutlinedTextArea(textInput: textFieldArea)
    textFieldControllerArea.placeholderText = "This is a text area"

    let textFieldAreaAttributed = MDCMultilineTextField()
    textFieldAreaAttributed.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(textFieldAreaAttributed)

    textFieldAreaAttributed.textView?.delegate = self

    let textFieldControllerAreaAttributed =
      MDCTextInputControllerOutlinedTextArea(textInput: textFieldAreaAttributed)
    textFieldControllerAreaAttributed.placeholderText = "This is a text area"
    textFieldAreaAttributed.attributedText = attributedString

    return [textFieldControllerArea, textFieldControllerAreaAttributed]
  }

  func setupUnderlineMultilineTextFields() -> [MDCTextInputControllerUnderline] {
    let multilineTextFieldUnderline = MDCMultilineTextField()
    multilineTextFieldUnderline.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldUnderline)

    multilineTextFieldUnderline.textView?.delegate = self

    let multilineTextFieldControllerUnderline =
      MDCTextInputControllerUnderline(textInput: multilineTextFieldUnderline)
    multilineTextFieldControllerUnderline.isFloatingEnabled = false

    let multilineTextFieldUnderlinePlaceholder = MDCMultilineTextField()
    multilineTextFieldUnderlinePlaceholder.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldUnderlinePlaceholder)

    multilineTextFieldUnderlinePlaceholder.textView?.delegate = self

    let multilineTextFieldControllerUnderlinePlaceholder =
      MDCTextInputControllerUnderline(textInput: multilineTextFieldUnderlinePlaceholder)
    multilineTextFieldControllerUnderlinePlaceholder.isFloatingEnabled = false
    multilineTextFieldControllerUnderlinePlaceholder.placeholderText =
      "This is a multi-line text field with placeholder"

    let multilineTextFieldUnderlineCharMax = MDCMultilineTextField()
    multilineTextFieldUnderlineCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldUnderlineCharMax)

    multilineTextFieldUnderlineCharMax.textView?.delegate = self

    let multilineTextFieldControllerUnderlineCharMax =
      MDCTextInputControllerUnderline(textInput: multilineTextFieldUnderlineCharMax)
    multilineTextFieldControllerUnderlineCharMax.characterCountMax = 140
    multilineTextFieldControllerUnderlineCharMax.isFloatingEnabled = false
    multilineTextFieldControllerUnderlineCharMax.placeholderText =
      "This is a multi-line text field with placeholder"

    controllersWithCharacterCount.append(multilineTextFieldControllerUnderlineCharMax)

    return [
      multilineTextFieldControllerUnderline, multilineTextFieldControllerUnderlinePlaceholder,
      multilineTextFieldControllerUnderlineCharMax,
    ]
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

  func setupFloatingMultilineTextFields() -> [MDCTextInputControllerUnderline] {
    let multilineTextFieldFloating = MDCMultilineTextField()
    multilineTextFieldFloating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldFloating)

    multilineTextFieldFloating.textView?.delegate = self

    let multilineTextFieldControllerFloating =
      MDCTextInputControllerUnderline(textInput: multilineTextFieldFloating)
    multilineTextFieldControllerFloating.placeholderText =
      "This is a multi-line text field with a floating placeholder"

    let multilineTextFieldFloatingCharMax = MDCMultilineTextField()
    multilineTextFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldFloatingCharMax)

    multilineTextFieldFloatingCharMax.textView?.delegate = self

    let multilineTextFieldControllerFloatingCharMax =
      MDCTextInputControllerUnderline(textInput: multilineTextFieldFloatingCharMax)
    multilineTextFieldControllerFloatingCharMax.placeholderText =
      "This is a multi-line text field with a floating placeholder and character count"

    controllersWithCharacterCount.append(multilineTextFieldControllerFloatingCharMax)

    return [multilineTextFieldControllerFloating, multilineTextFieldControllerFloatingCharMax]
  }

  func setupSpecialMultilineTextFields() -> [MDCTextInputController] {
    let bundle = Bundle(for: TextFieldKitchenSinkSwiftExample.self)
    let trailingViewImage = UIImage(named: "ic_done", in: bundle, compatibleWith: nil) ?? UIImage()

    let multilineTextFieldTrailingView = MDCMultilineTextField()
    multilineTextFieldTrailingView.trailingViewMode = .always
    multilineTextFieldTrailingView.trailingView = UIImageView(image: trailingViewImage)

    multilineTextFieldTrailingView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldTrailingView)

    multilineTextFieldTrailingView.textView?.delegate = self
    multilineTextFieldTrailingView.clearButtonMode = .whileEditing

    let multilineTextFieldControllerUnderlineTrailingView =
      MDCTextInputControllerUnderline(textInput: multilineTextFieldTrailingView)
    multilineTextFieldControllerUnderlineTrailingView.isFloatingEnabled = false
    multilineTextFieldControllerUnderlineTrailingView.placeholderText = "This has a trailing view"

    let multilineTextFieldCustomFont = MDCMultilineTextField()
    multilineTextFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(multilineTextFieldCustomFont)

    let multilineTextFieldControllerUnderlineCustomFont =
      MDCTextInputControllerUnderline(textInput: multilineTextFieldCustomFont)
    multilineTextFieldControllerUnderlineCustomFont.placeholderText = "This has a custom font"

    multilineTextFieldCustomFont.placeholderLabel.font = UIFont.preferredFont(
      forTextStyle: .headline)
    multilineTextFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)

    scrollView.addSubview(unstyledMultilineTextField)
    unstyledMultilineTextField.translatesAutoresizingMaskIntoConstraints = false

    unstyledMultilineTextField.placeholder =
      "This multi-line text field has no controller (unstyled)"
    unstyledMultilineTextField.leadingUnderlineLabel.text = "Leading label"
    unstyledMultilineTextField.trailingUnderlineLabel.text = "Trailing label"
    unstyledMultilineTextField.textView?.delegate = self

    return [
      multilineTextFieldControllerUnderlineTrailingView,
      multilineTextFieldControllerUnderlineCustomFont,
    ]
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
      controller.setHelperText(
        helperSwitch.isOn ? "This is helper text." : nil,
        helperAccessibilityLabel: helperSwitch.isOn ? "This is accessible helper text." : nil)
    }
  }

}

extension TextFieldKitchenSinkSwiftExample: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    for controller in allTextFieldControllers {
      if textField == controller.textInput {
        controller.setErrorText(nil, errorAccessibilityValue: nil)
        return true
      }
    }
    return true
  }

  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    for controller in allTextFieldControllers {
      if textField == controller.textInput {
        let finishedString = (textField.text as NSString?)?.replacingCharacters(
          in: range, with: string)

        if finishedString?.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
          controller.setErrorText(
            "Only letters allowed.",
            errorAccessibilityValue: "Error: Only letters allowed.")
        } else {
          controller.setErrorText(nil, errorAccessibilityValue: nil)
        }
        return true
      }
    }
    return true
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
