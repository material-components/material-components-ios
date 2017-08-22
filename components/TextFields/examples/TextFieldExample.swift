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

import MaterialComponents.MaterialTextFields

final class TextFieldLegacySwiftExample: UIViewController {

  let scrollView = UIScrollView()

  let name: MDCTextField = {
    let name = MDCTextField()
    name.placeholder = "Name"
    name.translatesAutoresizingMaskIntoConstraints = false
    name.autocapitalizationType = .words
    return name
  }()

  let address: MDCTextField = {
    let address = MDCTextField()
    address.placeholder = "Address"
    address.translatesAutoresizingMaskIntoConstraints = false
    address.autocapitalizationType = .words
    return address
  }()

  let city: MDCTextField = {
    let city = MDCTextField()
    city.placeholder = "City"
    city.translatesAutoresizingMaskIntoConstraints = false
    city.autocapitalizationType = .words
    return city
  }()
  let cityController: MDCTextInputControllerLegacyDefault

  let state: MDCTextField = {
    let state = MDCTextField()
    state.placeholder = "State"
    state.translatesAutoresizingMaskIntoConstraints = false
    state.autocapitalizationType = .allCharacters
    return state
  }()
  let stateController: MDCTextInputControllerLegacyDefault

  let zip: MDCTextField = {
    let zip = MDCTextField()
    zip.placeholder = "Zip code"
    zip.translatesAutoresizingMaskIntoConstraints = false
    return zip
  }()
  let zipController: MDCTextInputControllerLegacyDefault

  let phone: MDCTextField = {
    let phone = MDCTextField()
    phone.placeholder = "Phone number"
    phone.translatesAutoresizingMaskIntoConstraints = false
    return phone
  }()

  let message: MDCMultilineTextField = {
    let message = MDCMultilineTextField()
    message.placeholder = "Message"
    message.translatesAutoresizingMaskIntoConstraints = false
    return message
  }()

  var allTextFieldControllers = [MDCTextInputControllerLegacyDefault]()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    cityController = MDCTextInputControllerLegacyDefault(textInput: city)
    stateController = MDCTextInputControllerLegacyDefault(textInput: state)
    zipController = MDCTextInputControllerLegacyDefault(textInput: zip)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(white:0.97, alpha: 1.0)

    title = "Legacy Text Fields"

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
    let nameController = MDCTextInputControllerLegacyDefault(textInput: name)
    name.delegate = self
    allTextFieldControllers.append(nameController)

    scrollView.addSubview(address)
    let addressController = MDCTextInputControllerLegacyDefault(textInput: address)
    address.delegate = self
    allTextFieldControllers.append(addressController)

    scrollView.addSubview(city)
    city.delegate = self
    allTextFieldControllers.append(cityController)

    // In iOS 9+, you could accomplish this with a UILayoutGuide.
    // TODO: (larche) add iOS version specific implementations
    let stateZip = UIView()
    stateZip.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(stateZip)

    stateZip.addSubview(state)
    state.delegate = self
    allTextFieldControllers.append(stateController)

    stateZip.addSubview(zip)
    zip.delegate = self
    allTextFieldControllers.append(zipController)

    scrollView.addSubview(phone)
    let phoneController = MDCTextInputControllerLegacyDefault(textInput: phone)
    phone.delegate = self
    allTextFieldControllers.append(phoneController)

    scrollView.addSubview(message)
    let messageController = MDCTextInputControllerLegacyDefault(textInput: message)
    message.textView?.delegate = self
    allTextFieldControllers.append(messageController)

    var tag = 0
    for controller in allTextFieldControllers {
      guard let textField = controller.textInput as? MDCTextField else { continue }
      textField.tag = tag
      tag += 1
    }

    let views = [ "name": name,
                  "address": address,
                  "city": city,
                  "stateZip": stateZip,
                  "phone": phone,
                  "message": message ]
    var constraints = NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-20-[name]-[address]-[city]-[stateZip]-[phone]-[message]-|",
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
                                                  options: [.alignAllTop],
                                                  metrics: nil,
                                                  views: stateZipViews)
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[state]|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: stateZipViews)
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[zip]|",
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

  @objc func tapDidTouch(sender: Any) {
    self.view.endEditing(true)
  }

  @objc func buttonDidTouch(sender: Any) {
    let isFloatingEnabled = allTextFieldControllers.first?.isFloatingEnabled ?? false
    let alert = UIAlertController(title: "Floating Labels",
                                  message: nil,
                                  preferredStyle: .actionSheet)

    let defaultAction = UIAlertAction(title: "Default (Yes)" + (isFloatingEnabled ? " ✓" : ""),
                                      style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.isFloatingEnabled = true
      })
    }
    alert.addAction(defaultAction)
    let floatingAction = UIAlertAction(title: "No" + (isFloatingEnabled ? "" : " ✓"),
                                       style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.isFloatingEnabled = false
      })
    }
    alert.addAction(floatingAction)
    present(alert, animated: true, completion: nil)
  }
}

extension TextFieldLegacySwiftExample: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard let rawText = textField.text else {
      return true
    }

    let fullString = NSString(string: rawText).replacingCharacters(in: range, with: string)

    if textField == state {
      if let range = fullString.rangeOfCharacter(from: CharacterSet.letters.inverted),
        fullString[range].characters.count > 0 {
        stateController.setErrorText("Error: State can only contain letters",
                                   errorAccessibilityValue: nil)
      } else {
        stateController.setErrorText(nil, errorAccessibilityValue: nil)
      }
    } else if textField == zip {
      if let range = fullString.rangeOfCharacter(from: CharacterSet.letters),
        fullString[range].characters.count > 0 {
        zipController.setErrorText("Error: Zip can only contain numbers",
                                   errorAccessibilityValue: nil)
      } else if fullString.characters.count > 5 {
        zipController.setErrorText("Error: Zip can only contain five digits",
                                   errorAccessibilityValue: nil)
      } else {
        zipController.setErrorText(nil, errorAccessibilityValue: nil)
      }
    } else if textField == city {
      if let range = fullString.rangeOfCharacter(from: CharacterSet.decimalDigits),
        fullString[range].characters.count > 0 {
        cityController.setErrorText("Error: City can only contain letters",
                                    errorAccessibilityValue: nil)
      } else {
        cityController.setErrorText(nil, errorAccessibilityValue: nil)
      }
    }
    return true
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let index = textField.tag
    if index + 1 < allTextFieldControllers.count,
      let nextField = allTextFieldControllers[index + 1].textInput as? MDCTextField {
      nextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }

    return false
  }
}

extension TextFieldLegacySwiftExample: UITextViewDelegate {
  func textViewDidEndEditing(_ textView: UITextView) {
    print(textView.text)
  }
}

// MARK: - Keyboard Handling

extension TextFieldLegacySwiftExample {
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
}

// MARK: - Status Bar Style

extension TextFieldLegacySwiftExample {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension TextFieldLegacySwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Text Field", "[Legacy] Typical Use"]
  }

  class func catalogDescription() -> String {
    // swiftlint:disable:next line_length
    return "The Material Design Text Fields take the familiar element to a new level by adding useful animations, character counts, helper text and error states."
  }
  class func catalogIsPrimaryDemo() -> Bool {
    return true
  }
}
