// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

import MaterialComponents.MaterialTextFields_ColorThemer
import MaterialComponents.MaterialTextFields_TypographyThemer

final class TextFieldSemanticColorThemer: UIViewController {

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

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
    MDCOutlinedTextFieldColorThemer.applySemanticColorScheme(colorScheme, to: standardController)
    MDCTextFieldTypographyThemer.applyTypographyScheme(typographyScheme, to: standardController)

    MDCFilledTextFieldColorThemer.applySemanticColorScheme(colorScheme, to: alternativeController)
    MDCTextFieldTypographyThemer.applyTypographyScheme(typographyScheme, to: alternativeController)
  }

  func setupTextFields() {
    scrollView.addSubview(textfieldStandard)
    textfieldStandard.text = "Grace Hopper"
    standardController.placeholderText = "Standard"

    scrollView.addSubview(textfieldAlternative)
    textfieldAlternative.text = ""
    alternativeController.placeholderText = "Alternative"

    //NOTE: In iOS 9+, you could accomplish this with a UILayoutGuide.
    let views = [ "standard": textfieldStandard,
                  "alternative": textfieldAlternative,
                  ]
    var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[standard]-[alternative]",
                                                     options: [.alignAllLeading, .alignAllTrailing],
                                                     metrics: nil,
                                                     views: views)

    constraints += [NSLayoutConstraint(item: textfieldStandard,
                                       attribute: .leading,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .leadingMargin,
                                       multiplier: 1,
                                       constant: 0)]
    constraints += [NSLayoutConstraint(item: textfieldStandard,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .trailingMargin,
                                       multiplier: 1,
                                       constant: 0)]

    #if swift(>=3.2)
    if #available(iOS 11.0, *) {
      constraints += [NSLayoutConstraint(item: textfieldStandard,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: scrollView.contentLayoutGuide,
                                         attribute: .top,
                                         multiplier: 1,
                                         constant: 20),
                      NSLayoutConstraint(item: textfieldAlternative,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: scrollView.contentLayoutGuide,
                                         attribute: .bottomMargin,
                                         multiplier: 1,
                                         constant: -20)]
    } else {
      constraints += [NSLayoutConstraint(item: textfieldStandard,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: scrollView,
                                         attribute: .top,
                                         multiplier: 1,
                                         constant: 20),
                      NSLayoutConstraint(item: textfieldAlternative,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: scrollView,
                                         attribute: .bottomMargin,
                                         multiplier: 1,
                                         constant: -20)]
    }
    #else
    constraints += [NSLayoutConstraint(item: textfieldStandard,
                                       attribute: .top,
                                       relatedBy: .equal,
                                       toItem: scrollView,
                                       attribute: .top,
                                       multiplier: 1,
                                       constant: 20),
                    NSLayoutConstraint(item: textfieldAlternative,
                                       attribute: .bottom,
                                       relatedBy: .equal,
                                       toItem: scrollView,
                                       attribute: .bottomMargin,
                                       multiplier: 1,
                                       constant: -20)]
    #endif

    NSLayoutConstraint.activate(constraints)
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
    let marginOffset: CGFloat = 16
    let margins = UIEdgeInsets(top: 0, left: marginOffset, bottom: 0, right: marginOffset)

    scrollView.layoutMargins = margins
  }


  func addGestureRecognizer() {
    let tapRecognizer = UITapGestureRecognizer(target: self,
                                               action: #selector(tapDidTouch(sender: )))
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
      name: .UIKeyboardWillChangeFrame,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillShow(notif:)),
      name: .UIKeyboardWillShow,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillHide(notif:)),
      name: .UIKeyboardWillHide,
      object: nil)
  }

  @objc func keyboardWillShow(notif: Notification) {
    guard let frame = notif.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
      return
    }
    scrollView.contentInset = UIEdgeInsets(top: 0.0,
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

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Text Field", "Theming Text Fields"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
