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
// swiftlint:disable line_length
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import UIKit

extension TextFieldKitchenSinkSwiftExample {

  func setupExampleViews() {
    view.backgroundColor = UIColor(white:0.97, alpha: 1.0)

    title = "Material Text Fields"

    let textFieldControllersFullWidth = setupFullWidthTextFields()

    allTextFieldControllers = [setupDefaultTextFields(),
                               textFieldControllersFullWidth,
                               setupFloatingTextFields(),
                               setupSpecialTextFields()].flatMap { $0 as! [MDCTextInputController] }

    let multilineTextFieldControllersFullWidth = setupFullWidthMultilineTextFields()

    allMultilineTextFieldControllers = [setupDefaultMultilineTextFields(),
                              multilineTextFieldControllersFullWidth,
                              setupFloatingMultilineTextFields(),
                              setupSpecialMultilineTextFields()].flatMap { $0 as! [MDCTextInputController] }

    controllersFullWidth = textFieldControllersFullWidth + multilineTextFieldControllersFullWidth

    allInputControllers = allTextFieldControllers + allMultilineTextFieldControllers

    setupScrollView()

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(TextFieldKitchenSinkSwiftExample.contentSizeCategoryDidChange(notif:)),
                                           name:.UIContentSizeCategoryDidChange,
                                           object: nil)
  }

  func setupButton() -> MDCButton {
    let button = MDCButton()
    button.setTitleColor(.white, for: .normal)
    return button
  }

  func setupControls() -> [UIView] {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(container)

    container.addSubview(errorLabel)

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(self,
                          action: #selector(TextFieldKitchenSinkSwiftExample.errorSwitchDidChange(errorSwitch:)),
                          for: .touchUpInside)
    container.addSubview(errorSwitch)
    errorSwitch.accessibilityLabel = "Show errors"

    container.addSubview(helperLabel)

    let helperSwitch = UISwitch()
    helperSwitch.translatesAutoresizingMaskIntoConstraints = false
    helperSwitch.addTarget(self,
                           action: #selector(TextFieldKitchenSinkSwiftExample.helperSwitchDidChange(helperSwitch:)),
                           for: .touchUpInside)
    container.addSubview(helperSwitch)
    helperSwitch.accessibilityLabel = "Helper text"

    let views = ["errorLabel": errorLabel, "errorSwitch": errorSwitch,
                 "helperLabel": helperLabel, "helperSwitch": helperSwitch]
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[errorLabel]-[errorSwitch]|", options: [.alignAllCenterY], metrics: nil, views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[helperLabel]-[helperSwitch]|", options: [.alignAllCenterY], metrics: nil, views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-[errorSwitch]-[helperSwitch]|", options: [], metrics: nil, views: views))

    characterModeButton.translatesAutoresizingMaskIntoConstraints = false
    characterModeButton.addTarget(self,
                                  action: #selector(buttonDidTouch(button:)),
                                  for: .touchUpInside)
    characterModeButton.setTitle("Character Count Mode: Always", for: .normal)
    characterModeButton.setTitleColor(.white, for: .normal)
    characterModeButton.mdc_adjustsFontForContentSizeCategory = true
    scrollView.addSubview(characterModeButton)

    clearModeButton.translatesAutoresizingMaskIntoConstraints = false
    clearModeButton.addTarget(self,
                              action: #selector(buttonDidTouch(button:)),
                              for: .touchUpInside)
    clearModeButton.setTitle("Clear Button Mode: While Editing", for: .normal)
    clearModeButton.setTitleColor(.white, for: .normal)
    clearModeButton.mdc_adjustsFontForContentSizeCategory = true
    scrollView.addSubview(clearModeButton)

    underlineButton.translatesAutoresizingMaskIntoConstraints = false
    underlineButton.addTarget(self,
                              action: #selector(buttonDidTouch(button:)),
                              for: .touchUpInside)

    underlineButton.setTitle("Underline Mode: While Editing", for: .normal)
    underlineButton.setTitleColor(.white, for: .normal)
    underlineButton.mdc_adjustsFontForContentSizeCategory = true
    scrollView.addSubview(underlineButton)

    return [container, characterModeButton, underlineButton, clearModeButton]
  }

  func setupSectionLabels() {
    scrollView.addSubview(controlLabel)
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

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[scrollView]|",
      options: [],
      metrics: nil,
      views: ["scrollView": scrollView]))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["scrollView": scrollView]))
    let marginOffset: CGFloat = 16
    let margins = UIEdgeInsets(top: 0, left: marginOffset, bottom: 0, right: marginOffset)

    scrollView.layoutMargins = margins

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

    let allTextFields = allTextFieldControllers.flatMap { $0.textInput }
    let textFieldsString = allTextFields.reduce("", concatenatingClosure)

    var textFields = [String: UIView]()
    allTextFields.forEach { textInput in
      textFields[unique(from: textInput, with: prefix)] = textInput
    }

    let allTextViews = allMultilineTextFieldControllers.flatMap { $0.textInput }
    let textViewsString = allTextViews.reduce("", concatenatingClosure)

    var textViews = [String: UIView]()
    allTextViews.forEach { input in
      textViews[unique(from: input, with: prefix)] = input
    }

    let visualString = "V:|-20-[singleLabel]-" +
      textFieldsString + "[unstyledTextField]-20-[multiLabel]-" + textViewsString +
      "[unstyledTextView]-10-[controlLabel]-" + controlsString + "20-|"

    let labels: [String: UIView] = ["controlLabel": controlLabel,
                                    "singleLabel": singleLabel,
                                    "multiLabel": multiLabel,
                                    "unstyledTextField": unstyledTextField,
                                    "unstyledTextView": unstyledMultilineTextField]

    var views = [String: UIView]()

    let dictionaries = [labels, textFields, controls, textViews]

    dictionaries.forEach { dictionary in
      dictionary.forEach { (key, value) in
        views[key] = value

        // We have a scrollview and we're adding some elements that are subclassed from scrollviews.
        // So constraints need to be in relation to something that doesn't have a content size.
        // We'll use the view controller's view.
        let leading = NSLayoutConstraint(item: value,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .leadingMargin,
                                         multiplier: 1.0,
                                         constant: 0.0)
        leading.priority = 750.0
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: value,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: 0.0)
        trailing.priority = 750.0
        trailing.isActive = true
      }
    }

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: visualString,
                                                               options: [.alignAllCenterX],
                                                               metrics: nil,
                                                               views: views))

    controllersFullWidth.flatMap { $0.textInput }.forEach { textInput in
      NSLayoutConstraint(item: textInput,
                         attribute: .leading,
                         relatedBy: .equal,
                         toItem: view,
                         attribute: .leading,
                         multiplier: 1.0,
                         constant: 0).isActive = true
      NSLayoutConstraint(item: textInput,
                         attribute: .trailing,
                         relatedBy: .equal,
                         toItem: view,
                         attribute: .trailing,
                         multiplier: 1.0,
                         constant: 0).isActive = true

      // This constraint is necessary for the scrollview to have a content width.
      NSLayoutConstraint(item: textInput,
                         attribute: .trailing,
                         relatedBy: .equal,
                         toItem: scrollView,
                         attribute: .trailing,
                         multiplier: 1.0,
                         constant: 0).isActive = true
    }
    registerKeyboardNotifications()
    addGestureRecognizer()
  }

  func addGestureRecognizer() {
    let tapRecognizer = UITapGestureRecognizer(target: self,
                                               action: #selector(tapDidTouch(sender: )))
    self.scrollView.addGestureRecognizer(tapRecognizer)
  }

  func registerKeyboardNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      self,
      selector: #selector(TextFieldKitchenSinkSwiftExample.keyboardWillShow(notif:)),
      name: .UIKeyboardWillShow,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(TextFieldKitchenSinkSwiftExample.keyboardWillHide(notif:)),
      name: .UIKeyboardWillHide,
      object: nil)
  }

  @objc func keyboardWillShow(notif: Notification) {
    guard let frame = notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect else {
      return
    }
    scrollView.contentInset = UIEdgeInsets(top: 0.0,
                                           left: 0.0,
                                           bottom: frame.height,
                                           right: 0.0)
  }

  @objc func keyboardWillHide(notif: Notification) {
    scrollView.contentInset = UIEdgeInsets()
  }

  func unique(from input: AnyObject, with prefix: String) -> String {
    return prefix + String(describing: Unmanaged.passUnretained(input).toOpaque())
  }

}

extension TextFieldKitchenSinkSwiftExample {
  // The 3 'mode' buttons all are similar. The following code is shared by them
  @objc func buttonDidTouch(button: MDCButton) {
    var controllersToChange = allInputControllers
    var partialTitle = ""

    if button == characterModeButton {
      partialTitle = "Character Count Mode"
      controllersToChange = controllersWithCharacterCount
    } else if button == clearModeButton {
      partialTitle = "Clear Button Mode"
      controllersToChange = allTextFieldControllers
    } else {
      partialTitle = "Underline View Mode"
    }

    let closure: (UITextFieldViewMode, String) -> Void = { mode, title in
      controllersToChange.forEach { controller in
        if button == self.characterModeButton {
          controller.characterCountViewMode = mode
        } else if button == self.clearModeButton {
          if let input = controller.textInput as? MDCTextField {
            input.clearButtonMode = mode
          }
        } else {
          controller.underlineViewMode = mode
        }

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

extension TextFieldKitchenSinkSwiftExample {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension TextFieldKitchenSinkSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Text Field", "Kitchen Sink"]
  }
}
