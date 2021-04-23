// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

import Foundation
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialContainerScheme

class BottomSheetKeyboardBehaviorExample: UIViewController {

  @objc var containerScheme = MDCContainerScheme()
  var pushBottomSheetUpWhenKeyboardShows = true

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let presentButton = MDCButton()
    presentButton.setTitle("Show bottom sheet", for: .normal)
    presentButton.applyContainedTheme(withScheme: containerScheme)
    presentButton.addTarget(
      self,
      action: #selector(didTapPresentButton),
      for: .touchUpInside)

    presentButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(presentButton)

    let toggleBehaviorButton = MDCButton()
    toggleBehaviorButton.setTitle("Toggle keyboard behavior", for: .normal)
    toggleBehaviorButton.applyContainedTheme(withScheme: containerScheme)
    toggleBehaviorButton.addTarget(
      self,
      action: #selector(didTapToggleBehaviorButton),
      for: .touchUpInside)

    toggleBehaviorButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(toggleBehaviorButton)

    NSLayoutConstraint.activate([
      presentButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      presentButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      toggleBehaviorButton.centerXAnchor.constraint(equalTo: presentButton.centerXAnchor),
      toggleBehaviorButton.bottomAnchor.constraint(equalTo: presentButton.topAnchor, constant: -20),
    ])
  }

  @objc func didTapPresentButton(_ sender: MDCFloatingButton) {
    let textFieldContent = BottomSheetWithUITextField()
    let bottomSheet = MDCBottomSheetController(contentViewController: textFieldContent)
    bottomSheet.ignoreKeyboardHeight = !pushBottomSheetUpWhenKeyboardShows
    present(bottomSheet, animated: true)
  }

  @objc func didTapToggleBehaviorButton(_ sender: MDCFloatingButton) {
    pushBottomSheetUpWhenKeyboardShows = !pushBottomSheetUpWhenKeyboardShows
  }

}

class BottomSheetWithUITextField: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.placeholder = "Type here"
    textField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(textField)

    NSLayoutConstraint.activate([
      textField.widthAnchor.constraint(equalToConstant: 200),
      textField.heightAnchor.constraint(equalToConstant: 40),
      textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
    ])
  }
}

// MARK: Catalog by convention
extension BottomSheetKeyboardBehaviorExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Sheet", "Keyboard behavior"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
