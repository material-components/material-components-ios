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
import MaterialComponents.MaterialTextFields
import MaterialComponentsBeta.MaterialChips_Theming
import MaterialComponentsBeta.MaterialContainerScheme

class ChipsFieldDeleteEnabledViewController : UIViewController, MDCChipFieldDelegate {
  var colorScheme = MDCSemanticColorScheme()
  var shapeScheme = MDCShapeScheme()
  var typographyScheme = MDCTypographyScheme()
  var chipField = MDCChipField()

  var scheme: MDCContainerScheming {
    let scheme = MDCContainerScheme()
    scheme.colorScheme = colorScheme
    scheme.shapeScheme = shapeScheme
    scheme.typographyScheme = typographyScheme
    return scheme
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = colorScheme.backgroundColor
    chipField.frame = .zero
    chipField.delegate = self
    chipField.textField.placeholderLabel.text = "This is a chip field."
    chipField.backgroundColor = colorScheme.surfaceColor
    chipField.showChipsDeleteButton = true
    view.addSubview(chipField)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    var frame = view.bounds
    if #available(iOS 11.0, *) {
      frame = UIEdgeInsetsInsetRect(frame, view.safeAreaInsets)
    }
    frame.size = chipField.sizeThatFits(frame.size)
    chipField.frame = frame
  }

  func chipFieldHeightDidChange(_ chipField: MDCChipField) {
    view.layoutIfNeeded()
  }

  func chipField(_ chipField: MDCChipField, didAddChip chip: MDCChipView) {
    chip.applyTheme(withScheme: scheme)
    chip.sizeToFit()
    let chipVerticalInset = min(0, chip.bounds.height - 48 / 2)
    chip.hitAreaInsets = UIEdgeInsetsMake(chipVerticalInset, 0, chipVerticalInset, 0)
  }
}
// MARK - Catalog by Convention
extension ChipsFieldDeleteEnabledViewController {
  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs" : ["Chips", "Chips Input Delete Enabled (Swift)"],
      "primaryDemo" : false,
      "presentable" : false,
    ]
  }
}
