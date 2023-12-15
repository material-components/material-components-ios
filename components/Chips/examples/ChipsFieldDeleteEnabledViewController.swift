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

import UIKit
import MaterialComponents.MaterialChips
import MaterialComponents.MaterialChips_Theming 
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialContainerScheme

class ChipsFieldDeleteEnabledViewController: UIViewController, MDCChipFieldDelegate {
  var containerScheming: MDCContainerScheming
  var chipField = MDCChipField()

  init() {
    containerScheming = MDCContainerScheme()
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheming.colorScheme.backgroundColor
    chipField.frame = .zero
    chipField.delegate = self
    let placeholderAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.placeholderText
    ]
    chipField.placeholderAttributes = placeholderAttributes
    chipField.placeholder = "This is a chip field."
    chipField.backgroundColor = containerScheming.colorScheme.surfaceColor
    view.addSubview(chipField)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    var frame = view.bounds
    frame = frame.inset(by: view.safeAreaInsets)
    frame.size = chipField.sizeThatFits(frame.size)
    chipField.frame = frame
  }

  func chipFieldHeightDidChange(_ chipField: MDCChipField) {
    view.layoutIfNeeded()
  }

  func chipField(_ chipField: MDCChipField, didAddChip chip: MDCChipView) {
    chip.applyTheme(withScheme: containerScheming)
    chip.sizeToFit()
    let chipVerticalInset = min(0, chip.bounds.height - 48 / 2)
    chip.hitAreaInsets = UIEdgeInsets(
      top: chipVerticalInset, left: 0, bottom: chipVerticalInset, right: 0)
  }
}
// MARK - Catalog by Convention
extension ChipsFieldDeleteEnabledViewController {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Chips", "Chips Input Delete Enabled (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
