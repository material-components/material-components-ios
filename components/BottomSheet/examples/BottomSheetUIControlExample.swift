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

import Foundation
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MaterialButtons_ButtonThemer 
import MaterialComponents.MaterialButtons

class BottomSheetUIControlExample: UIViewController {

  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
  @objc var typographyScheme = MDCTypographyScheme()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Table View Menu"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = colorScheme.backgroundColor

    let button = MDCButton()
    button.setTitle("Show bottom sheet", for: .normal)
    button.addTarget(
      self,
      action: #selector(BottomSheetTableViewExample.didTapFloatingButton),
      for: .touchUpInside)

    let buttonScheme = MDCButtonScheme()
    buttonScheme.colorScheme = colorScheme
    buttonScheme.typographyScheme = typographyScheme
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: button)

    button.sizeToFit()
    button.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    button.autoresizingMask = [
      .flexibleLeftMargin,
      .flexibleTopMargin,
      .flexibleRightMargin,
      .flexibleBottomMargin,
    ]

    view.addSubview(button)
  }

  @objc func didTapFloatingButton(_ sender: MDCFloatingButton) {
    let menu = BottomSheetUIControl()
    let bottomSheet = MDCBottomSheetController(contentViewController: menu)
    present(bottomSheet, animated: true)
  }

}

class BottomSheetUIControl: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .white

    let slideControl = UISlider()
    slideControl.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(slideControl)

    NSLayoutConstraint.activate([
      slideControl.widthAnchor.constraint(equalToConstant: 300),
      slideControl.heightAnchor.constraint(equalToConstant: 20),
      slideControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      slideControl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
    ])
  }
}

// MARK: Catalog by convention
extension BottomSheetUIControlExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Sheet", "Bottom sheet with UIControl"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
