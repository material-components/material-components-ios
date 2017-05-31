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

final class TextFieldManualLayoutExample: UIViewController {

  private enum LayoutConstants {
    static let largeMargin: CGFloat = 16.0
    static let smallMargin: CGFloat = 8.0

    static let floatingHeight: CGFloat = 82.0
    static let defaultHeight: CGFloat = 62.0

    static let stateWidth: CGFloat = 80.0
  }

  let scrollView = UIScrollView()

  let name: MDCTextField = {
    let name = MDCTextField()
    name.placeholder = "Name"
    return name
  }()

  let address: MDCTextField = {
    let address = MDCTextField()
    address.placeholder = "Address"
    return address
  }()

  let city: MDCTextField = {
    let city = MDCTextField()
    city.placeholder = "City"
    return city
  }()
  let cityController: MDCTextInputController

  let state: MDCTextField = {
    let state = MDCTextField()
    state.placeholder = "State"
    return state
  }()

  let zip: MDCTextField = {
    let zip = MDCTextField()
    zip.placeholder = "Zip code"
    return zip
  }()
  let zipController: MDCTextInputController

  let phone: MDCTextField = {
    let phone = MDCTextField()
    phone.placeholder = "Phone number"
    return phone
  }()

  let stateZip = UIView()

  var allTextFieldControllers = [MDCTextInputController]()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    cityController = MDCTextInputController(textInput: city)
    zipController = MDCTextInputController(textInput: zip)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(white:0.97, alpha: 1.0)

    title = "Manual Text Fields"

    setupScrollView()
    setupTextFields()

    updateLayout()

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
    let nameController = MDCTextInputController(textInput: name)
    nameController.presentationStyle = .floatingPlaceholder
    name.delegate = self
    allTextFieldControllers.append(nameController)

    scrollView.addSubview(address)
    let addressController = MDCTextInputController(textInput: address)
    addressController.presentationStyle = .floatingPlaceholder
    address.delegate = self
    allTextFieldControllers.append(addressController)

    scrollView.addSubview(city)
    cityController.presentationStyle = .floatingPlaceholder
    city.delegate = self
    allTextFieldControllers.append(cityController)

    scrollView.addSubview(stateZip)

    stateZip.addSubview(state)
    let stateController = MDCTextInputController(textInput: state)
    stateController.presentationStyle = .floatingPlaceholder
    state.delegate = self
    allTextFieldControllers.append(stateController)

    stateZip.addSubview(zip)
    zipController.presentationStyle = .floatingPlaceholder
    zip.delegate = self
    allTextFieldControllers.append(zipController)

    scrollView.addSubview(phone)
    let phoneController = MDCTextInputController(textInput: phone)
    phoneController.presentationStyle = .floatingPlaceholder
    phone.delegate = self
    allTextFieldControllers.append(phoneController)

    var tag = 0
    for controller in allTextFieldControllers {
      guard let textField = controller.textInput as? MDCTextField else { continue }
      textField.tag = tag
      tag += 1
    }

  }

  func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.frame = view.bounds

    scrollView.contentSize = CGSize(width: scrollView.bounds.width - 2 * LayoutConstants.largeMargin,
                                    height: 372.0)
  }

  func addGestureRecognizer() {
    let tapRecognizer = UITapGestureRecognizer(target: self,
                                               action: #selector(tapDidTouch(sender: )))
    self.scrollView.addGestureRecognizer(tapRecognizer)
  }

  func updateLayout() {
    let commonWidth = view.bounds.width - 2 * LayoutConstants.largeMargin
    var height = LayoutConstants.floatingHeight
    if let controller = allTextFieldControllers.first {
      height = controller.presentationStyle == .floatingPlaceholder ? LayoutConstants.floatingHeight : LayoutConstants.defaultHeight
    }

    name.frame = CGRect(x: LayoutConstants.largeMargin,
                        y: LayoutConstants.smallMargin,
                        width: commonWidth,
                        height: height)

    address.frame = CGRect(x: LayoutConstants.largeMargin,
                           y: name.frame.minY + height + LayoutConstants.smallMargin,
                           width: commonWidth,
                           height: height)

    city.frame = CGRect(x: LayoutConstants.largeMargin,
                        y: address.frame.minY + height + LayoutConstants.smallMargin,
                        width: commonWidth,
                        height: height)

    stateZip.frame = CGRect(x: LayoutConstants.largeMargin,
                            y: city.frame.minY + height + LayoutConstants.smallMargin,
                            width: commonWidth,
                            height: height)

    state.frame = CGRect(x: 0,
                         y: 0,
                         width: LayoutConstants.stateWidth,
                         height: height)

    zip.frame = CGRect(x: LayoutConstants.stateWidth + LayoutConstants.smallMargin,
                       y: 0,
                       width: stateZip.bounds.width - LayoutConstants.stateWidth - LayoutConstants.smallMargin,
                       height: height)

    phone.frame = CGRect(x: LayoutConstants.largeMargin,
                         y: stateZip.frame.minY + height + LayoutConstants.smallMargin,
                         width: commonWidth,
                         height: height)
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
        controller.presentationStyle = .default
      })
      self.updateLayout()
    }
    alert.addAction(defaultAction)
    let floatingAction = UIAlertAction(title: "Floating", style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.presentationStyle = .floatingPlaceholder
      })
      self.updateLayout()
    }
    alert.addAction(floatingAction)
    present(alert, animated: true, completion: nil)
  }
}

extension TextFieldManualLayoutExample: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard let rawText = textField.text else {
      return true
    }

    let fullString = NSString(string: rawText).replacingCharacters(in: range, with: string)

    if textField == zip {
      if let range = fullString.rangeOfCharacter(from: CharacterSet.letters),
        fullString[range].characters.count > 0 {
        zipController.setErrorText("Error: Zip can only contain numbers", errorAccessibilityValue: nil)
      } else if fullString.characters.count > 5 {
        zipController.setErrorText("Error: Zip can only contain five digits", errorAccessibilityValue: nil)
      } else {
        zipController.setErrorText(nil, errorAccessibilityValue: nil)
      }
    } else if textField == city {
      if let range = fullString.rangeOfCharacter(from: CharacterSet.decimalDigits),
        fullString[range].characters.count > 0 {
        cityController.setErrorText("Error: City can only contain letters", errorAccessibilityValue: nil)
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

// MARK: - Keyboard Handling

extension TextFieldManualLayoutExample {
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

extension TextFieldManualLayoutExample {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension TextFieldManualLayoutExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Text Field", "Manual Layout"]
  }
}
