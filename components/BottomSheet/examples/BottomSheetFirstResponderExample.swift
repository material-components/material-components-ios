// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialContainerScheme

class BottomSheetFirstResponderExample: UIViewController {
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    return stackView
  }()

  let issueDescriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = """
      With VoiceOver on, the focused text field steals focus back from the bottom sheet
      if resignFirstResponder is not called.
      """
    label.textColor = .black
    return label
  }()

  let textField: MDCMultilineTextField = {
    let textField = MDCMultilineTextField()
    textField.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
    return textField
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let button = MDCButton()
    button.setTitle("Show bottom sheet", for: .normal)
    button.addTarget(
      self,
      action: #selector(BottomSheetFirstResponderExample.didTapButton),
      for: .touchUpInside)

    button.applyContainedTheme(withScheme: containerScheme)
    button.sizeToFit()

    contentStackView.addArrangedSubview(issueDescriptionLabel)
    contentStackView.addArrangedSubview(textField)
    contentStackView.addArrangedSubview(button)

    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(contentStackView)
    contentStackView.leadingAnchor
      .constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    contentStackView.trailingAnchor
      .constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textField.becomeFirstResponder()
  }

  @objc func didTapButton() {
    let menu = BottomSheetUIControl()
    let bottomSheet = MDCBottomSheetController(contentViewController: menu)
    textField.resignFirstResponder()
    present(bottomSheet, animated: true)
  }
}

// MARK: Catalog by Convention
extension BottomSheetFirstResponderExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Sheet", "Over Focused Text Field (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
