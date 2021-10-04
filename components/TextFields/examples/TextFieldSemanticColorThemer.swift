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

// swiftlint:disable function_body_length

import MaterialComponents.MaterialTextFields_Theming 

final class TextFieldSemanticColorThemer: UIViewController {

  @objc var containerScheme = MDCContainerScheme()

  let textfieldStandard: MDCTextField = {
    let textfield = MDCTextField()
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()

  let textfieldAlternative: MDCTextField = {
    let textfield = MDCTextField()
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()

  let standardController: MDCTextInputControllerOutlined
  let alternativeController: MDCTextInputControllerFilled

  let scrollView = UIScrollView()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    standardController = MDCTextInputControllerOutlined(textInput: textfieldStandard)
    alternativeController = MDCTextInputControllerFilled(textInput: textfieldAlternative)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    title = "Text Field Theming"

    setupScrollView()
    setupTextFields()

    registerKeyboardNotifications()
    addGestureRecognizer()

    // Apply the themes to the controllers
    standardController.applyTheme(withScheme: containerScheme)

    alternativeController.applyTheme(withScheme: containerScheme)
  }

  func setupTextFields() {
    scrollView.addSubview(textfieldStandard)
    textfieldStandard.text = "Grace Hopper"
    standardController.placeholderText = "Standard"

    scrollView.addSubview(textfieldAlternative)
    textfieldAlternative.text = ""
    alternativeController.placeholderText = "Alternative"

    //NOTE: In iOS 9+, you could accomplish this with a UILayoutGuide.
    let views = [
      "standard": textfieldStandard,
      "alternative": textfieldAlternative,
    ]
    var constraints = NSLayoutConstraint.constraints(
      withVisualFormat: "V:[standard]-[alternative]",
      options: [.alignAllLeading, .alignAllTrailing],
      metrics: nil,
      views: views)

    constraints += [
      NSLayoutConstraint(
        item: textfieldStandard,
        attribute: .leading,
        relatedBy: .equal,
        toItem: view,
        attribute: .leadingMargin,
        multiplier: 1,
        constant: 0)
    ]
    constraints += [
      NSLayoutConstraint(
        item: textfieldStandard,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: view,
        attribute: .trailingMargin,
        multiplier: 1,
        constant: 0)
    ]

    constraints += [
      NSLayoutConstraint(
        item: textfieldStandard,
        attribute: .top,
        relatedBy: .equal,
        toItem: scrollView.contentLayoutGuide,
        attribute: .top,
        multiplier: 1,
        constant: 20),
      NSLayoutConstraint(
        item: textfieldAlternative,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: scrollView.contentLayoutGuide,
        attribute: .bottomMargin,
        multiplier: 1,
        constant: -20),
    ]

    NSLayoutConstraint.activate(constraints)
  }

  func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[scrollView]|",
        options: [],
        metrics: nil,
        views: ["scrollView": scrollView]))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[scrollView]|",
        options: [],
        metrics: nil,
        views: ["scrollView": scrollView]))
    let marginOffset: CGFloat = 16
    let margins = UIEdgeInsets(top: 0, left: marginOffset, bottom: 0, right: marginOffset)

    scrollView.layoutMargins = margins
  }

  func addGestureRecognizer() {
    let tapRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(tapDidTouch(sender:)))
    self.scrollView.addGestureRecognizer(tapRecognizer)
  }

  // MARK: - Actions

  @objc func tapDidTouch(sender: Any) {
    self.view.endEditing(true)
  }

}

// MARK: - Keyboard Handling

extension TextFieldSemanticColorThemer {
  func registerKeyboardNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillShow(notif:)),
      name: UIResponder.keyboardWillChangeFrameNotification,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillShow(notif:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillHide(notif:)),
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
    scrollView.contentInset = UIEdgeInsets.zero
  }
}

// MARK: - Status Bar Style

extension TextFieldSemanticColorThemer {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Text Field", "Theming Text Fields"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
