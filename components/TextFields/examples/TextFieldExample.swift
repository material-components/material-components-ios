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

// swiftlint:disable function_body_length

import Foundation

import MaterialComponents.MaterialTextFields

final class TextFieldSwiftExample: UIViewController {

  let scrollView = UIScrollView()

  let name: MDCTextField = {
    let name = MDCTextField()
    name.placeholder = "Name"
    name.translatesAutoresizingMaskIntoConstraints = false
    return name
  }()

  let address: MDCTextField = {
    let address = MDCTextField()
    address.placeholder = "Address"
    address.translatesAutoresizingMaskIntoConstraints = false
    return address
  }()

  let city: MDCTextField = {
    let city = MDCTextField()
    city.placeholder = "City"
    city.translatesAutoresizingMaskIntoConstraints = false
    return city
  }()

  let state: MDCTextField = {
    let state = MDCTextField()
    state.placeholder = "State"
    state.translatesAutoresizingMaskIntoConstraints = false
    return state
  }()

  let zip: MDCTextField = {
    let zip = MDCTextField()
    zip.placeholder = "Zip code"
    zip.translatesAutoresizingMaskIntoConstraints = false
    return zip
  }()

  let phone: MDCTextField = {
    let phone = MDCTextField()
    phone.placeholder = "Phone number"
    phone.translatesAutoresizingMaskIntoConstraints = false
    return phone
  }()

  var allTextFieldControllers = [MDCTextInputController]()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(white:0.97, alpha: 1.0)

    title = "Material Text Fields"

    setupScrollView()
    setupTextFields()

    registerKeyboardNotifications()
    addGestureRecognizer()

    let styleButton = UIBarButtonItem(title: "Style",
                                      style: .plain,
                                      target: self,
                                      action: #selector(buttonDidTouch(sender: )))
    self.navigationItem.rightBarButtonItem = styleButton
  }

  func setupTextFields() {
    scrollView.addSubview(name)
    let nameController = MDCTextInputController(input: name)
    nameController.presentation = .floatingPlaceholder
    name.delegate = self
    allTextFieldControllers.append(nameController)

    scrollView.addSubview(address)
    let addressController = MDCTextInputController(input: address)
    addressController.presentation = .floatingPlaceholder
    address.delegate = self
    allTextFieldControllers.append(addressController)

    scrollView.addSubview(city)
    let cityController = MDCTextInputController(input: city)
    cityController.presentation = .floatingPlaceholder
    city.delegate = self
    allTextFieldControllers.append(cityController)

    let stateZip = UIView()
    stateZip.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(stateZip)

    stateZip.addSubview(state)
    let stateController = MDCTextInputController(input: state)
    stateController.presentation = .floatingPlaceholder
    state.delegate = self
    allTextFieldControllers.append(stateController)

    stateZip.addSubview(zip)
    let zipController = MDCTextInputController(input: zip)
    zipController.presentation = .floatingPlaceholder
    zip.delegate = self
    allTextFieldControllers.append(zipController)

    scrollView.addSubview(phone)
    let phoneController = MDCTextInputController(input: phone)
    phoneController.presentation = .floatingPlaceholder
    phone.delegate = self
    allTextFieldControllers.append(phoneController)

    let views = [ "name": name,
                  "address": address,
                  "city": city,
                  "stateZip": stateZip,
                  "phone": phone ]
    var constraints = NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-[name]-[address]-[city]-[stateZip]-[phone]-|",
                                                     options: [.alignAllLeading, .alignAllTrailing],
                                                     metrics: nil,
                                                     views: views)

    constraints += [NSLayoutConstraint(item: name,
                                       attribute: .leading,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .leadingMargin,
                                       multiplier: 1,
                                       constant: 0)]
    constraints += [NSLayoutConstraint(item: name,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .trailingMargin,
                                       multiplier: 1,
                                       constant: 0)]
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[name]|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: views)

    let stateZipViews = [ "state": state, "zip": zip ]
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[state(80)]-[zip]|",
                                                  options: [.alignAllTop, .alignAllBottom],
                                                  metrics: nil,
                                                  views: stateZipViews)
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[state]|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: stateZipViews)

    NSLayoutConstraint.activate(constraints)
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
  }

  func addGestureRecognizer() {
    let tapRecognizer = UITapGestureRecognizer(target: self,
                                               action: #selector(tapDidTouch(sender: )))
    self.scrollView.addGestureRecognizer(tapRecognizer)
  }

  // MARK: - Actions

  func tapDidTouch(sender: Any) {
    self.view.endEditing(true)
  }

  func buttonDidTouch(sender: Any) {
    let alert = UIAlertController(title: "Presentation Style",
                                  message: nil,
                                  preferredStyle: .actionSheet)
    let defaultAction = UIAlertAction(title: "Default", style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.presentation = .default
      })
    }
    alert.addAction(defaultAction)
    let floatingAction = UIAlertAction(title: "Floating", style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.presentation = .floatingPlaceholder
      })
    }
    alert.addAction(floatingAction)
    let fullWidthAction = UIAlertAction(title: "Full Width", style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.presentation = .fullWidth
      })
    }
    alert.addAction(fullWidthAction)
    present(alert, animated: true, completion: nil)
  }
}

extension TextFieldSwiftExample: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {

    return true
  }
}

// MARK: - Keyboard Handling

extension TextFieldSwiftExample {
  func registerKeyboardNotifications() {
    let notificationCenter = NotificationCenter.default
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

  func keyboardWillShow(notif: Notification) {
    guard let frame = notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect else {
      return
    }
    scrollView.contentInset = UIEdgeInsets(top: 0.0,
                                           left: 0.0,
                                           bottom: frame.height,
                                           right: 0.0)
  }

  func keyboardWillHide(notif: Notification) {
    scrollView.contentInset = UIEdgeInsets()
  }
}

// MARK: - Status Bar Style

extension TextFieldSwiftExample {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension TextFieldSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Text Field", "Typical Use"]
  }

  class func catalogDescription() -> String {
    // swiftlint:disable:next line_length
    return "The Material Design Text Fields take the familiar element to a new level by adding useful animations, character counts, helper text and error states."
  }
  class func catalogIsPrimaryDemo() -> Bool {
    return true
  }
}
