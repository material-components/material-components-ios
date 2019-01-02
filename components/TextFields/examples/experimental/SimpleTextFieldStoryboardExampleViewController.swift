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

final class SimpleTextFieldStoryboardExampleViewController: UIViewController {

  @IBOutlet var filledTextField: UITextField!
  @IBOutlet weak var outlinedTextField: UITextField!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerKeyboardNotifications()

  }

}

extension SimpleTextFieldStoryboardExampleViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return false
  }
}

extension SimpleTextFieldStoryboardExampleViewController: UITextViewDelegate {
  func textViewDidEndEditing(_ textView: UITextView) {
    print(textView.text)
  }
}

// MARK: - Keyboard Handling

extension SimpleTextFieldStoryboardExampleViewController {
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
    notificationCenter.addObserver(
      self,
      selector: #selector(keyboardWillShow(notif:)),
      name: .UIKeyboardWillChangeFrame,
      object: nil)
  }
  
  @objc func keyboardWillShow(notif: Notification) {
    guard let _ = notif.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
      return
    }
  }
  
  @objc func keyboardWillHide(notif: Notification) {
  }
}

// MARK: - Status Bar Style

extension SimpleTextFieldStoryboardExampleViewController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

// MARK: - CatalogByConvention

extension SimpleTextFieldStoryboardExampleViewController {
  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Text Field", "Simple Text Field (Storyboard)"],
      "description": "Text fields let users enter and edit text.",
      "primaryDemo": false,
      "presentable": false,
      "storyboardName": "SimpleTextFieldStoryboardExampleViewController"
    ]
  }
}

