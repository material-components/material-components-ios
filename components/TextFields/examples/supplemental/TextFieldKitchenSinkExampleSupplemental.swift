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
// swiftlint:disable line_length
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTextFields

extension TextFieldKitchenSinkSwiftExample {

  func setupExampleViews() {
    view.backgroundColor = UIColor(white: 0.97, alpha: 1.0)

    title = "Material Text Fields"

    let textFieldControllersFullWidth = setupFullWidthTextFields()

    allTextFieldControllers = [
      setupFilledTextFields(), setupInlineUnderlineTextFields(),
      textFieldControllersFullWidth,
      setupFloatingUnderlineTextFields(),
      setupSpecialTextFields(),
    ].flatMap { $0 as! [MDCTextInputController] }

    let multilineTextFieldControllersFullWidth = setupFullWidthMultilineTextFields()

    allMultilineTextFieldControllers = [
      setupAreaTextFields(), setupUnderlineMultilineTextFields(),
      multilineTextFieldControllersFullWidth,
      setupFloatingMultilineTextFields(),
      setupSpecialMultilineTextFields(),
    ].flatMap { $0 }

    controllersFullWidth = textFieldControllersFullWidth + multilineTextFieldControllersFullWidth

    allInputControllers = allTextFieldControllers + allMultilineTextFieldControllers

    setupScrollView()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(TextFieldKitchenSinkSwiftExample.contentSizeCategoryDidChange(notif:)),
      name: UIContentSizeCategory.didChangeNotification,
      object: nil)
  }

  func setupButton() -> MDCButton {
    let button = MDCButton()
    button.setTitleColor(.white, for: .normal)
    button.mdc_adjustsFontForContentSizeCategory = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }

  func setupControls() -> [UIView] {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(container)

    container.addSubview(errorLabel)

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(
      self,
      action: #selector(TextFieldKitchenSinkSwiftExample.errorSwitchDidChange(errorSwitch:)),
      for: .touchUpInside)
    container.addSubview(errorSwitch)
    errorSwitch.accessibilityLabel = "Show errors"

    container.addSubview(helperLabel)

    let helperSwitch = UISwitch()
    helperSwitch.translatesAutoresizingMaskIntoConstraints = false
    helperSwitch.addTarget(
      self,
      action: #selector(TextFieldKitchenSinkSwiftExample.helperSwitchDidChange(helperSwitch:)),
      for: .touchUpInside)
    container.addSubview(helperSwitch)
    helperSwitch.accessibilityLabel = "Helper text"

    let views = [
      "errorLabel": errorLabel, "errorSwitch": errorSwitch,
      "helperLabel": helperLabel, "helperSwitch": helperSwitch,
    ]
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat:
          "H:|-[errorLabel]-[errorSwitch]|", options: [.alignAllCenterY], metrics: nil, views: views
      ))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat:
          "H:|-[helperLabel]-[helperSwitch]|", options: [.alignAllCenterY], metrics: nil,
        views: views))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat:
          "V:|-[errorSwitch]-[helperSwitch]|", options: [], metrics: nil, views: views))

    textInsetsModeButton.addTarget(
      self,
      action: #selector(textInsetsModeButtonDidTouch(button:)),
      for: .touchUpInside)
    textInsetsModeButton.setTitle("Text Insets Mode: If Content", for: .normal)
    scrollView.addSubview(textInsetsModeButton)

    characterModeButton.addTarget(
      self,
      action: #selector(textFieldModeButtonDidTouch(button:)),
      for: .touchUpInside)
    characterModeButton.setTitle("Character Count Mode: Always", for: .normal)
    scrollView.addSubview(characterModeButton)

    clearModeButton.addTarget(
      self,
      action: #selector(textFieldModeButtonDidTouch(button:)),
      for: .touchUpInside)
    clearModeButton.setTitle("Clear Button Mode: While Editing", for: .normal)
    scrollView.addSubview(clearModeButton)

    underlineButton.addTarget(
      self,
      action: #selector(textFieldModeButtonDidTouch(button:)),
      for: .touchUpInside)

    underlineButton.setTitle("Underline Mode: While Editing", for: .normal)
    scrollView.addSubview(underlineButton)

    return [container, textInsetsModeButton, characterModeButton, underlineButton, clearModeButton]
  }

  func setupSectionLabels() {
    scrollView.addSubview(controlLabel)
    scrollView.addSubview(singleLabel)
    scrollView.addSubview(multiLabel)

    NSLayoutConstraint(
      item: singleLabel,
      attribute: .leading,
      relatedBy: .equal,
      toItem: view,
      attribute: .leadingMargin,
      multiplier: 1,
      constant: 0
    ).isActive = true

    NSLayoutConstraint(
      item: singleLabel,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: view,
      attribute: .trailingMargin,
      multiplier: 1,
      constant: 0
    ).isActive = true
  }

  func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[topGuide]-[scrollView]|",
        options: [],
        metrics: nil,
        views: ["scrollView": scrollView, "topGuide": topLayoutGuide]))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[scrollView]|",
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
      accumulator + "-[" + self.unique(from: object, with: prefix) + "]"
    }

    let allControls = setupControls()
    let controlsString = allControls.reduce("", concatenatingClosure)

    var controls = [String: UIView]()
    allControls.forEach { control in
      controls[unique(from: control, with: prefix)] =
        control
    }

    let allTextFields = allTextFieldControllers.compactMap { $0.textInput }
    let textFieldsString = allTextFields.reduce("", concatenatingClosure)

    var textFields = [String: UIView]()
    allTextFields.forEach { textInput in
      textFields[unique(from: textInput, with: prefix)] = textInput
    }

    let allTextViews = allMultilineTextFieldControllers.compactMap { $0.textInput }
    let textViewsString = allTextViews.reduce("", concatenatingClosure)

    var textViews = [String: UIView]()
    allTextViews.forEach { input in
      textViews[unique(from: input, with: prefix)] = input
    }

    let visualString =
      "V:[singleLabel]" + textFieldsString + "[unstyledTextField]-20-[multiLabel]" + textViewsString
      + "[unstyledTextView]-10-[controlLabel]" + controlsString

    let labels: [String: UIView] = [
      "controlLabel": controlLabel,
      "singleLabel": singleLabel,
      "multiLabel": multiLabel,
      "unstyledTextField": unstyledTextField,
      "unstyledTextView": unstyledMultilineTextField,
    ]

    var views = [String: UIView]()

    let dictionaries = [labels, textFields, controls, textViews]

    dictionaries.forEach { dictionary in
      dictionary.forEach { (key, value) in
        views[key] = value

        // We have a scrollview and we're adding some elements that are subclassed from scrollviews.
        // So constraints need to be in relation to something that doesn't have a content size.
        // We'll use the view controller's view.
        let leading = NSLayoutConstraint(
          item: value,
          attribute: .leading,
          relatedBy: .equal,
          toItem: view,
          attribute: .leadingMargin,
          multiplier: 1.0,
          constant: 0.0)
        leading.priority = UILayoutPriority.defaultHigh
        leading.isActive = true

        let trailing = NSLayoutConstraint(
          item: value,
          attribute: .trailing,
          relatedBy: .equal,
          toItem: view,
          attribute: .trailing,
          multiplier: 1.0,
          constant: 0.0)
        trailing.priority = UILayoutPriority.defaultHigh
        trailing.isActive = true
      }
    }

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: visualString,
        options: [.alignAllCenterX],
        metrics: nil,
        views: views))

    controllersFullWidth.compactMap { $0.textInput }.forEach { textInput in
      NSLayoutConstraint(
        item: textInput,
        attribute: .leading,
        relatedBy: .equal,
        toItem: view,
        attribute: .leading,
        multiplier: 1.0,
        constant: 0
      ).isActive = true
      NSLayoutConstraint(
        item: textInput,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: view,
        attribute: .trailing,
        multiplier: 1.0,
        constant: 0
      ).isActive = true

      // This constraint is necessary for the scrollview to have a content width.
      NSLayoutConstraint(
        item: textInput,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: scrollView,
        attribute: .trailing,
        multiplier: 1.0,
        constant: 0
      ).isActive = true
    }

    // These used to be done in the visual format string but iOS 11 changed that.
    NSLayoutConstraint(
      item: singleLabel,
      attribute: .topMargin,
      relatedBy: .equal,
      toItem: scrollView.contentLayoutGuide,
      attribute: .top,
      multiplier: 1.0,
      constant: 20
    ).isActive = true
    NSLayoutConstraint(
      item: allControls.last as Any,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: scrollView.contentLayoutGuide,
      attribute: .bottomMargin,
      multiplier: 1.0,
      constant: -20
    ).isActive = true

    registerKeyboardNotifications()
    addGestureRecognizer()
  }

  func addGestureRecognizer() {
    let tapRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(tapDidTouch(sender:)))
    self.scrollView.addGestureRecognizer(tapRecognizer)
  }

  func registerKeyboardNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      self,
      selector: #selector(TextFieldKitchenSinkSwiftExample.keyboardWillShow(notif:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(TextFieldKitchenSinkSwiftExample.keyboardWillShow(notif:)),
      name: UIResponder.keyboardWillChangeFrameNotification,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(TextFieldKitchenSinkSwiftExample.keyboardWillHide(notif:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }

  @objc func keyboardWillShow(notif: Notification) {
    guard let frame = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
      return
    }
    scrollView.contentInset = UIEdgeInsets(
      top: 0.0,
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
  // 3 of the 'mode' buttons all are similar. The following code is shared by them
  @objc func textFieldModeButtonDidTouch(button: MDCButton) {
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

    let closure: (UITextField.ViewMode, String) -> Void = { mode, title in
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

    let alert = UIAlertController(
      title: partialTitle,
      message: nil,
      preferredStyle: .alert)
    presentAlert(alert: alert, partialTitle: partialTitle, closure: closure)
  }

  func presentAlert(
    alert: UIAlertController,
    partialTitle: String,
    closure: @escaping (_ mode: UITextField.ViewMode, _ title: String) -> Void
  ) {

    for rawMode in 0...3 {
      let mode = UITextField.ViewMode(rawValue: rawMode)!
      alert.addAction(
        UIAlertAction(
          title: modeName(mode: mode),
          style: .default,
          handler: { _ in
            closure(mode, partialTitle)
          }))
    }

    present(alert, animated: true, completion: nil)
  }

  func modeName(mode: UITextField.ViewMode) -> String {
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
  // The 'text insets' button does not have the same options as the other mode buttons
  @objc func textInsetsModeButtonDidTouch(button: MDCButton) {

    let closure: (MDCTextInputTextInsetsMode, String) -> Void = { mode, title in
      self.allInputControllers.forEach { controller in
        guard let input = controller.textInput else {
          return
        }
        input.textInsetsMode = mode

        button.setTitle(title + ": " + self.textInsetsModeName(mode: mode), for: .normal)
      }
    }

    let title = "Text Insets Mode"
    let alert = UIAlertController(
      title: title,
      message: nil,
      preferredStyle: .alert)

    for rawMode: UInt in 0...2 {
      let mode = MDCTextInputTextInsetsMode(rawValue: rawMode)!
      alert.addAction(
        UIAlertAction(
          title: textInsetsModeName(mode: mode),
          style: .default,
          handler: { _ in
            closure(mode, title)
          }))
    }

    present(alert, animated: true, completion: nil)
  }

  func textInsetsModeName(mode: MDCTextInputTextInsetsMode) -> String {
    switch mode {
    case .always:
      return "Always"
    case .ifContent:
      return "If Content"
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

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Text Field", "Kitchen Sink"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
