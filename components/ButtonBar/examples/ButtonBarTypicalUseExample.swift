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

import Foundation
import MaterialComponents.MaterialButtonBar
import MaterialComponents.MaterialContainerScheme

class ButtonBarTypicalUseSwiftExample: UIViewController {
  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
  @objc var typographyScheme = MDCTypographyScheme(defaults: .material201804)

  var scheme: MDCContainerScheming {
    let scheme = MDCContainerScheme()
    scheme.colorScheme = colorScheme
    scheme.typographyScheme = typographyScheme
    return scheme
  }

  lazy var buttonBar = MDCButtonBar()
  override func viewDidLoad() {
    super.viewDidLoad()

    buttonBar.backgroundColor = colorScheme.primaryColor
    buttonBar.tintColor = colorScheme.onPrimaryColor
    buttonBar.setButtonsTitleFont(typographyScheme.button, for: .normal)

    // MDCButtonBar ignores the style of UIBarButtonItem.
    let ignored: UIBarButtonItem.Style = .done

    let actionItem = UIBarButtonItem(
      title: "Action",
      style: ignored,
      target: self,
      action: #selector(didTapActionButton)
    )

    let secondActionItem = UIBarButtonItem(
      title: "Second action",
      style: ignored,
      target: self,
      action: #selector(didTapActionButton)
    )

    buttonBar.items = [actionItem, secondActionItem]

    // MDCButtonBar's sizeThatFits gives a "best-fit" size of the provided items.
    let size = buttonBar.sizeThatFits(self.view.bounds.size)
    let x = (self.view.bounds.size.width - size.width) / 2
    let y = self.view.bounds.size.height / 2 - size.height
    buttonBar.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
    buttonBar.autoresizingMask =
      [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    self.view.addSubview(buttonBar)

    // Ensure that the controller's view isn't transparent.
    view.backgroundColor = .white
  }

  @objc func didTapActionButton(_ item: UIBarButtonItem) {
    let rect = buttonBar.rect(for: item, in: view)
    print("\(rect)")
    print("Did tap action item: \(item)")
  }

  // MARK: Typical application code (not Material-specific)
  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Button Bar"
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: Catalog by convention
extension ButtonBarTypicalUseSwiftExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Button Bar", "Button Bar (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
