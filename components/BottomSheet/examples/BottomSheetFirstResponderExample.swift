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
import MaterialComponents.MaterialContainerScheme

class BottomSheetFirstResponderExample: UIViewController {
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()
  let textField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
    return textField
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let button = MDCButton()
    button.setTitle("Show bottom sheet", for: .normal)
    button.addTarget(self,
                     action: #selector(BottomSheetFirstResponderExample.didTapButton),
                     for: .touchUpInside)

    button.applyContainedTheme(withScheme: containerScheme)

    button.sizeToFit()
    button.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    button.autoresizingMask = [
      .flexibleLeftMargin,
      .flexibleTopMargin,
      .flexibleRightMargin,
      .flexibleBottomMargin
    ]

    textField.frame = CGRect(x: 100, y: 200, width: 200, height: 50)

    view.addSubview(button)
    view.addSubview(textField)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textField.becomeFirstResponder()
  }

  @objc func didTapButton() {
    let menu = BottomSheetDummyCollectionViewController(numItems: 6)!
    let bottomSheet = MDCBottomSheetController(contentViewController: menu)
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
