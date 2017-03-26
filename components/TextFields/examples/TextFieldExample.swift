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

import MaterialComponents.MaterialTextField
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTypography

final class TextFieldSwiftExample: UIViewController {

  let scrollView = UIScrollView()

  let singleLabel: UILabel = {
    let singleLabel = UILabel()
    singleLabel.translatesAutoresizingMaskIntoConstraints = false
    singleLabel.text = "Single Line Text Fields"
    singleLabel.font = MDCTypography.headlineFont()
    singleLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    return singleLabel
  }()
  var allTextFieldControllers = [MDCTextInputController]()

  let multiLabel: UILabel = {
    let multiLabel = UILabel()
    multiLabel.translatesAutoresizingMaskIntoConstraints = false
    multiLabel.text = "Multi Line Text Views"
    multiLabel.font = MDCTypography.display1Font()
    multiLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    return multiLabel
  }()

  var allTextViewControllers = [MDCTextInputController]()

  var allInputControllers = [MDCTextInputController]()

  let characterModeButton = MDCButton()
  let underlineButton = MDCButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    allTextFieldControllers = [setupDefaultTextFields(),
                     setupFullWidthTextFields(),
                     setupFloatingTextFields(),
                     setupSpecialTextFields()].flatMap { $0 }

    allTextViewControllers = [setupDefaultTextViews(),
                    setupFullWidthTextViews(),
                    setupFloatingTextViews(),
                    setupSpecialTextViews()].flatMap { $0 }

    allInputControllers = allTextFieldControllers + allTextViewControllers
    setupScrollView()
  }

  func setupDefaultTextFields() -> [MDCTextInputController] {
    let textFieldDefault = MDCTextField()
    scrollView.addSubview(textFieldDefault)
    textFieldDefault.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefault.delegate = self
    textFieldDefault.clearButtonMode = .always

    let textFieldControllerDefault = MDCTextInputController(input: textFieldDefault)

    textFieldControllerDefault.presentation = .default

    let textFieldDefaultPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldDefaultPlaceholder)
    textFieldDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultPlaceholder.placeholder = "This is a text field w/ inline placeholder"
    textFieldDefaultPlaceholder.delegate = self

    textFieldDefaultPlaceholder.clearButtonMode = .always

    let textFieldControllerDefaultPlaceholder =
      MDCTextInputController(input: textFieldDefaultPlaceholder)

    textFieldControllerDefaultPlaceholder.presentation = .default

    let textFieldDefaultCharMax = MDCTextField()
    scrollView.addSubview(textFieldDefaultCharMax)
    textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultCharMax.placeholder = "This is a text field w/ character count"
    textFieldDefaultCharMax.delegate = self
    textFieldDefaultCharMax.clearButtonMode = .always

    let textFieldControllerDefaultCharMax = MDCTextInputController(input: textFieldDefaultCharMax)
    textFieldControllerDefaultCharMax.characterCountMax = 50

    return [textFieldControllerDefault, textFieldControllerDefaultPlaceholder,
            textFieldControllerDefaultCharMax]
  }
  func setupFullWidthTextFields() -> [MDCTextInputController] {
    let textFieldFullWidth = MDCTextField()
    scrollView.addSubview(textFieldFullWidth)
    textFieldFullWidth.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidth.delegate = self

    let textFieldControllerFullWidth = MDCTextInputController(input: textFieldFullWidth)
    textFieldControllerFullWidth.presentation = .fullWidth

    let textFieldFullWidthPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldFullWidthPlaceholder)
    textFieldFullWidthPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthPlaceholder.placeholder = "This is a full width text field"
    textFieldFullWidthPlaceholder.delegate = self

    let textFieldControllerFullWidthPlaceholder =
      MDCTextInputController(input: textFieldFullWidthPlaceholder)
    textFieldControllerFullWidthPlaceholder.presentation = .fullWidth

    let textFieldFullWidthCharMax = MDCTextField()
    scrollView.addSubview(textFieldFullWidthCharMax)
    textFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthCharMax.placeholder = "This is a full width text field"
    textFieldFullWidthCharMax.delegate = self

    let textFieldControllerFullWidthCharMax =
      MDCTextInputController(input: textFieldFullWidthCharMax)
    textFieldControllerFullWidthCharMax.presentation = .fullWidth
    textFieldControllerFullWidthCharMax.characterCountMax = 50

    return [textFieldControllerFullWidth, textFieldControllerFullWidthPlaceholder,
            textFieldControllerFullWidthCharMax]
  }

  func setupFloatingTextFields() -> [MDCTextInputController] {
    let textFieldFloating = MDCTextField()
    scrollView.addSubview(textFieldFloating)
    textFieldFloating.translatesAutoresizingMaskIntoConstraints = false
    textFieldFloating.placeholder = "This is a text field w/ floating placeholder"
    textFieldFloating.delegate = self

    textFieldFloating.clearButtonMode = .always

    let textFieldControllerFloating = MDCTextInputController(input: textFieldFloating)

    textFieldControllerFloating.presentation = .floatingPlaceholder

    let textFieldFloatingCharMax = MDCTextField()
    scrollView.addSubview(textFieldFloatingCharMax)
    textFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerFloatingCharMax = MDCTextInputController(input: textFieldFloatingCharMax)
    textFieldControllerFloatingCharMax.presentation = .floatingPlaceholder
    textFieldControllerFloatingCharMax.characterCountMax = 50

    return [textFieldControllerFloating, textFieldControllerFloatingCharMax]
  }

  func setupSpecialTextFields() -> [MDCTextInputController] {
    let textFieldDisabled = MDCTextField()
    scrollView.addSubview(textFieldDisabled)
    textFieldDisabled.translatesAutoresizingMaskIntoConstraints = false
    textFieldDisabled.placeholder = "This is a disabled text field"
    textFieldDisabled.isEnabled = false

    let textFieldControllerDefaultDisabled = MDCTextInputController(input: textFieldDisabled)

    let textFieldCustomFont = MDCTextField()
    scrollView.addSubview(textFieldCustomFont)
    textFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false
    textFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)

    let textFieldControllerDefaultCustomFont = MDCTextInputController(input: textFieldCustomFont)

    let textFieldLeftView = MDCTextField()
    scrollView.addSubview(textFieldLeftView)
    textFieldLeftView.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerDefaultLeftView = MDCTextInputController(input: textFieldLeftView)

    return [textFieldControllerDefaultDisabled, textFieldControllerDefaultCustomFont,
            textFieldControllerDefaultLeftView]
  }

  func setupDefaultTextViews() -> [MDCTextInputController] {
    let textViewDefault = MDCTextView()
    scrollView.addSubview(textViewDefault)
    textViewDefault.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerDefault = MDCTextInputController(input: textViewDefault)

    let textViewDefaultPlaceholder = MDCTextView()
    scrollView.addSubview(textViewDefaultPlaceholder)
    textViewDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false
    textViewDefaultPlaceholder.placeholder = "This is a multi line text view with placeholder"

    let textViewControllerDefaultPlaceholder =
      MDCTextInputController(input: textViewDefaultPlaceholder)

    let textViewDefaultCharMax = MDCTextView()
    scrollView.addSubview(textViewDefaultCharMax)
    textViewDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false
    textViewDefaultCharMax.placeholder = "This is a multi line text view with placeholder"

    let textViewControllerDefaultCharMax = MDCTextInputController(input: textViewDefaultCharMax)
    textViewControllerDefaultCharMax.characterCountMax = 140

    return [textViewControllerDefault, textViewControllerDefaultPlaceholder,
            textViewControllerDefaultCharMax]
  }

  func setupFullWidthTextViews() -> [MDCTextInputController] {
    let textViewFullWidth = MDCTextView()
    scrollView.addSubview(textViewFullWidth)
    textViewFullWidth.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFullWidth = MDCTextInputController(input: textViewFullWidth)

    let textViewFullWidthCharMax = MDCTextView()
    scrollView.addSubview(textViewFullWidthCharMax)
    textViewFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFullWidthCharMax = MDCTextInputController(input: textViewFullWidthCharMax)

    return [textViewControllerFullWidth, textViewControllerFullWidthCharMax]
  }

  func setupFloatingTextViews() -> [MDCTextInputController] {
    let textViewFloating = MDCTextView()
    scrollView.addSubview(textViewFloating)
    textViewFloating.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFloating = MDCTextInputController(input: textViewFloating)

    let textViewFloatingCharMax = MDCTextView()
    scrollView.addSubview(textViewFloatingCharMax)
    textViewFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFloatingCharMax = MDCTextInputController(input: textViewFloatingCharMax)

    return [textViewControllerFloating, textViewControllerFloatingCharMax]
  }

  func setupSpecialTextViews() -> [MDCTextInputController] {
    let textViewCustomFont = MDCTextView()
    scrollView.addSubview(textViewCustomFont)
    textViewCustomFont.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerDefaultCustomFont = MDCTextInputController(input: textViewCustomFont)

    return [textViewControllerDefaultCustomFont]
  }

  func setupSectionLabels() {
    scrollView.addSubview(singleLabel)
    scrollView.addSubview(multiLabel)

    NSLayoutConstraint(item: singleLabel,
                       attribute: .leading,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .leadingMargin,
                       multiplier: 1,
                       constant: 0).isActive = true

    NSLayoutConstraint(item: singleLabel,
                       attribute: .trailing,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .trailingMargin,
                       multiplier: 1,
                       constant: 0).isActive = true

  }

  func setupScrollView() {
    view.addSubview(scrollView)

    scrollView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["scrollView": scrollView]))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["scrollView": scrollView]))
    let header = UILabel()
    header.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(header)
    header.text = "Material Text Fields"
    header.font = MDCTypography.display1Font()
    header.textColor = UIColor(white: 0, alpha: MDCTypography.display1FontOpacity())
    setupSectionLabels()

    let prefix = "view"
    let concatenatingClosure = {
      (accumulator, object: AnyObject) in
      accumulator + "[" + self.unique(from: object, with: prefix) +
        "]" + "-"
    }

    let allControls = setupControls()
    let controlsString = allControls.reduce("", concatenatingClosure)

    var controls = [String: UIView]()
    allControls.forEach { control in
      controls[unique(from: control, with: prefix)] =
      control
    }

    let allTextFields = allTextFieldControllers.flatMap { $0.input }
    let textFieldsString = allTextFields.reduce("", concatenatingClosure)

    var textFields = [String: UIView]()
    allTextFields.forEach { input in
      textFields[unique(from: input, with: prefix)] = input
    }

    let allTextViews = allTextViewControllers.flatMap { $0.input }
    let textViewsString = allTextViews.reduce("", concatenatingClosure)

    var textViews = [String: UIView]()
    allTextViews.forEach { input in
      textViews[unique(from: input, with: prefix)] = input
    }

    let visualString = "V:|-20-[header]-20-" + controlsString + "[singleLabel]-" + textFieldsString
      + "[multiLabel]-" + textViewsString + "20-|"

    let labels: [String: UIView] = ["header": header, "singleLabel": singleLabel,
                                    "multiLabel": multiLabel]

    var views = [String: UIView]()

    let dictionaries = [labels, textFields, controls, textViews]

    dictionaries.forEach { dictionary in
      dictionary.forEach { (key, value) in
        views[key] = value
      }
    }

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: visualString,
                                                               options: [.alignAllLeft,
                                                                         .alignAllRight],
                                                               metrics: nil,
                                                               views: views))
  }

  func setupControls() -> [UIView] {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(container)

    let errorLabel = UILabel()
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.text = "In Error:"
    errorLabel.font = MDCTypography.subheadFont()
    errorLabel.textColor = UIColor(white: 0, alpha: MDCTypography.subheadFontOpacity())
    container.addSubview(errorLabel)

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(self,
                    action: #selector(TextFieldSwiftExample.errorSwitchDidChange(errorSwitch:)),
                    for: .touchUpInside)
    container.addSubview(errorSwitch)

    let helperLabel = UILabel()
    helperLabel.translatesAutoresizingMaskIntoConstraints = false
    helperLabel.text = "Show Helper Text:"
    helperLabel.font = MDCTypography.subheadFont()
    helperLabel.textColor = UIColor(white: 0, alpha: MDCTypography.subheadFontOpacity())
    container.addSubview(helperLabel)

    let helperSwitch = UISwitch()
    helperSwitch.translatesAutoresizingMaskIntoConstraints = false
    helperSwitch.addTarget(self,
                      action: #selector(TextFieldSwiftExample.helperSwitchDidChange(helperSwitch:)),
                      for: .touchUpInside)
    container.addSubview(helperSwitch)

    let views = ["errorLabel": errorLabel, "errorSwitch": errorSwitch,
                 "helperLabel": helperLabel, "helperSwitch": helperSwitch]
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[errorLabel]-[errorSwitch]|", options: [.alignAllCenterY], metrics: nil, views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[helperLabel]-[helperSwitch]|", options: [.alignAllCenterY], metrics: nil, views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-[errorSwitch]-[helperSwitch]|", options: [], metrics: nil, views: views))

    let underlineButton = MDCButton()
    underlineButton.translatesAutoresizingMaskIntoConstraints = false
    underlineButton.addTarget(self,
                              action: #selector(TextFieldSwiftExample.buttonDidTouch(button:)),
                              for: .touchUpInside)

    underlineButton.setTitle("Underline Mode: While Editing", for: .normal)
    underlineButton.setTitleColor(.white, for: .normal)
    scrollView.addSubview(underlineButton)

    let characterButton = MDCButton()
    characterButton.translatesAutoresizingMaskIntoConstraints = false
    characterButton.addTarget(self,
                              action: #selector(TextFieldSwiftExample.buttonDidTouch(button:)),
                              for: .touchUpInside)
    characterButton.setTitle("Character Count Mode: While Editing", for: .normal)
    characterButton.setTitleColor(.white, for: .normal)
    scrollView.addSubview(characterButton)

    return [container, underlineButton, characterButton]
  }

  func unique(from input: AnyObject, with prefix: String) -> String {
    return prefix + String(describing: Unmanaged.passUnretained(input).toOpaque())
  }

  func errorSwitchDidChange(errorSwitch: UISwitch) {
    allInputControllers.forEach { controller in
      if errorSwitch.isOn {
        controller.set(errorText: "Uh oh! Error. Try something else.", errorAccessibilityValue: nil)
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

  func buttonDidTouch(button: MDCButton) {
    var partialTitle = ""
    if button == underlineButton {
      partialTitle = "Underline View Mode"
    } else {
      partialTitle = "Character Count Mode"
    }

    let closure: (UITextFieldViewMode, String) -> Void = { mode, title in
      self.allInputControllers.forEach { controller in
        controller.underlineMode = mode

        button.setTitle(title + ": " + self.modeName(mode: mode), for: .normal)
      }
    }

    let alert = UIAlertController(title: partialTitle,
                                  message: nil,
                                  preferredStyle: .alert)
    presentAlert(alert: alert, partialTitle: partialTitle, closure: closure)
  }

  func presentAlert (alert: UIAlertController,
                     partialTitle: String,
    closure: @escaping (_ mode: UITextFieldViewMode, _ title: String) -> Void) -> Void {

    for rawMode in 0...3 {
      let mode = UITextFieldViewMode(rawValue: rawMode)!
      alert.addAction(UIAlertAction(title: modeName(mode: mode),
                                    style: .default,
                                    handler: { _ in
        closure(mode, partialTitle)
      }))
    }

    present(alert, animated: true, completion: nil)
  }

  func modeName(mode: UITextFieldViewMode) -> String {
    switch mode {
    case .always:
      return "Always"
    case .whileEditing:
      return "While Editing"
    case .unlessEditing:
      return "Unless Editing"
    case .never:
      return "Never"
    }
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
