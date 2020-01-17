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

import MaterialComponents.MaterialTextControls
import MaterialComponents.MaterialTextControls_Theming

import UIKit

/// This example showcases how to use an MDCTextControl with a storyboard.
final class MDCTextControlTextFieldsStoryboardExample: UIViewController {

  //MARK: Properties

  @IBOutlet weak var filledTextField: MDCFilledTextField!
  @IBOutlet weak var outlinedTextField: MDCOutlinedTextField!

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  //MARK: Object Lifecycle

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  //MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTextFields()
  }

  //MARK: Setup

  func setUpTextFields() {
    filledTextField.label.text = "label text"
    filledTextField.placeholder = "placeholder text"
    filledTextField.applyTheme(withScheme: containerScheme)

    outlinedTextField.label.text = "label text"
    outlinedTextField.placeholder = "placeholder text"
    outlinedTextField.applyTheme(withScheme: containerScheme)
  }
}

/// This extension implements a CatalogByConvention method
extension MDCTextControlTextFieldsStoryboardExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Text Controls", "MDCTextControl TextFields (Storyboard)"],
      "primaryDemo": false,
      "presentable": false,
      "storyboardName": "MDCTextControlTextFieldsStoryboardExample"
    ]
  }
}
