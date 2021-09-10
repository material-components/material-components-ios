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

// swiftlint:disable function_body_length

import MaterialComponents.MaterialTextFields

final class TextFieldManualLayoutLegacySwiftExample: UIViewController {

  private enum LayoutConstants {
    static let largeMargin: CGFloat = 16
    static let smallMargin: CGFloat = 8

    static let floatingHeight: CGFloat = 84
    static let defaultHeight: CGFloat = 62

    static let stateWidth: CGFloat = 80
  }

  let scrollView = UIScrollView()

  let name: MDCTextField = {
    let name = MDCTextField()
    name.autocapitalizationType = .words
    return name
  }()

  let address: MDCTextField = {
    let address = MDCTextField()
    address.autocapitalizationType = .words
    return address
  }()

  let city: MDCTextField = {
    let city = MDCTextField()
    city.autocapitalizationType = .words
    return city
  }()
  let cityController: MDCTextInputControllerLegacyDefault

  let state: MDCTextField = {
    let state = MDCTextField()
    state.autocapitalizationType = .allCharacters
    return state
  }()

  let zip: MDCTextField = {
    let zip = MDCTextField()
    return zip
  }()
  let zipController: MDCTextInputControllerLegacyDefault

  let phone: MDCTextField = {
    let phone = MDCTextField()
    return phone
  }()

  let stateZip = UIView()

  var allTextFieldControllers = [MDCTextInputControllerLegacyDefault]()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    cityController = MDCTextInputControllerLegacyDefault(textInput: city)
    zipController = MDCTextInputControllerLegacyDefault(textInput: zip)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(white: 0.97, alpha: 1.0)

    title = "Legacy Manual Text Fields"

    setupScrollView()
    setupTextFields()

    updateLayout()

    registerKeyboardNotifications()
    addGestureRecognizer()

    let styleButton = UIBarButtonItem(
      title: "Style",
      style: .plain,
      target: self,
      action: #selector(buttonDidTouch(sender:)))
    self.navigationItem.rightBarButtonItem = styleButton
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    scrollView.frame = view.bounds
  }

  func setupTextFields() {
    scrollView.addSubview(name)
    let nameController = MDCTextInputControllerLegacyDefault(textInput: name)
    name.delegate = self
    nameController.placeholderText = "Name"
    allTextFieldControllers.append(nameController)

    scrollView.addSubview(address)
    let addressController = MDCTextInputControllerLegacyDefault(textInput: address)
    address.delegate = self
    addressController.placeholderText = "Address"
    allTextFieldControllers.append(addressController)

    scrollView.addSubview(city)
    city.delegate = self
    cityController.placeholderText = "City"
    allTextFieldControllers.append(cityController)

    scrollView.addSubview(stateZip)

    stateZip.addSubview(state)
    let stateController = MDCTextInputControllerLegacyDefault(textInput: state)
    state.delegate = self
    stateController.placeholderText = "State"
    allTextFieldControllers.append(stateController)

    stateZip.addSubview(zip)
    zip.delegate = self
    zipController.placeholderText = "Zip Code"
    zipController.helperText = "XXXXX"
    allTextFieldControllers.append(zipController)

    scrollView.addSubview(phone)
    let phoneController = MDCTextInputControllerLegacyDefault(textInput: phone)
    phone.delegate = self
    phoneController.placeholderText = "Phone Number"
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

    scrollView.contentSize =
      CGSize(
        width: scrollView.bounds.width - 2 * LayoutConstants.largeMargin,
        height: 500.0)
  }

  func addGestureRecognizer() {
    let tapRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(tapDidTouch(sender:)))
    self.scrollView.addGestureRecognizer(tapRecognizer)
  }

  func updateLayout() {
    let commonWidth = view.bounds.width - 2 * LayoutConstants.largeMargin
    var height = LayoutConstants.floatingHeight
    if let controller = allTextFieldControllers.first {
      height =
        controller.isFloatingEnabled
        ? LayoutConstants.floatingHeight : LayoutConstants.defaultHeight
    }

    name.frame = CGRect(
      x: LayoutConstants.largeMargin,
      y: LayoutConstants.smallMargin,
      width: commonWidth,
      height: height)

    address.frame = CGRect(
      x: LayoutConstants.largeMargin,
      y: name.frame.minY + height + LayoutConstants.smallMargin,
      width: commonWidth,
      height: height)

    city.frame = CGRect(
      x: LayoutConstants.largeMargin,
      y: address.frame.minY + height + LayoutConstants.smallMargin,
      width: commonWidth,
      height: height)

    stateZip.frame = CGRect(
      x: LayoutConstants.largeMargin,
      y: city.frame.minY + height + LayoutConstants.smallMargin,
      width: commonWidth,
      height: height)

    state.frame = CGRect(
      x: 0,
      y: 0,
      width: LayoutConstants.stateWidth,
      height: height)

    zip.frame = CGRect(
      x: LayoutConstants.stateWidth + LayoutConstants.smallMargin,
      y: 0,
      width: stateZip.bounds.width - LayoutConstants.stateWidth - LayoutConstants.smallMargin,
      height: height)

    phone.frame = CGRect(
      x: LayoutConstants.largeMargin,
      y: stateZip.frame.minY + height + LayoutConstants.smallMargin,
      width: commonWidth,
      height: height)
  }

  // MARK: - Actions

  @objc func tapDidTouch(sender: Any) {
    self.view.endEditing(true)
  }

  @objc func buttonDidTouch(sender: Any) {
    let alert = UIAlertController(
      title: "Floating Enabled",
      message: nil,
      preferredStyle: .actionSheet)
    let defaultAction = UIAlertAction(title: "Default (Yes)", style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.isFloatingEnabled = true
      })
      self.updateLayout()
    }
    alert.addAction(defaultAction)
    let floatingAction = UIAlertAction(title: "No", style: .default) { _ in
      self.allTextFieldControllers.forEach({ (controller) in
        controller.isFloatingEnabled = false
      })
      self.updateLayout()
    }
    alert.addAction(floatingAction)
    present(alert, animated: true, completion: nil)
  }
}

extension TextFieldManualLayoutLegacySwiftExample: UITextFieldDelegate {
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    guard let rawText = textField.text else {
      return true
    }

    let fullString = NSString(string: rawText).replacingCharacters(in: range, with: string)

    if textField == zip {
      if let range = fullString.rangeOfCharacter(from: CharacterSet.letters),
        String(fullString[range]).characterCount > 0
      {
        zipController.setErrorText(
          "Error: Zip can only contain numbers",
          errorAccessibilityValue: nil)
      } else if fullString.characterCount > 5 {
        zipController.setErrorText(
          "Error: Zip can only contain five digits",
          errorAccessibilityValue: nil)
      } else {
        zipController.setErrorText(nil, errorAccessibilityValue: nil)
      }
    } else if textField == city {
      if let range = fullString.rangeOfCharacter(from: CharacterSet.decimalDigits),
        String(fullString[range]).characterCount > 0
      {
        cityController.setErrorText(
          "Error: City can only contain letters",
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
      let nextField = allTextFieldControllers[index + 1].textInput
    {
      nextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }

    return false
  }
}

// MARK: - Keyboard Handling

extension TextFieldManualLayoutLegacySwiftExample {
  func registerKeyboardNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillShow(notif:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillShow(notif:)),
      name: UIResponder.keyboardWillChangeFrameNotification,
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
    scrollView.contentInset = UIEdgeInsets()
  }
}

// MARK: - Status Bar Style

extension TextFieldManualLayoutLegacySwiftExample {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

// MARK: - CatalogByConvention
extension TextFieldManualLayoutLegacySwiftExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Text Field", "[Legacy] Manual Layout (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
