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
import MaterialComponentsAlpha.MaterialNavigationDrawer
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme

class BottomDrawerWithHeaderExample: UIViewController {
  var colorScheme = MDCSemanticColorScheme()
  let button = MDCButton()

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor
    headerViewController.colorScheme = colorScheme
    contentViewController.colorScheme = colorScheme

    button.setTitle("Show Navigation Drawer", for: .normal)
    button.sizeToFit()
    let buttonScheme = MDCButtonScheme()
    buttonScheme.colorScheme = colorScheme
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: button)
    button.addTarget(self, action: #selector(presentNavigationDrawer), for: .touchUpInside)
    view.addSubview(button)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    button.center = view.center
  }

  @objc func presentNavigationDrawer() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.contentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    present(bottomDrawerViewController, animated: true, completion: nil)
  }
}

extension BottomDrawerWithHeaderExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
