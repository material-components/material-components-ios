// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialBottomAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

class BottomAppBarTypicalUseSwiftExample: UIViewController {

  let appBarViewController = MDCAppBarViewController()
  let bottomBarView = MDCBottomAppBarView()
  @objc var containerScheme = MDCContainerScheme()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Bottom App Bar (Swift)"
    self.addChild(appBarViewController)

    let color = UIColor(white: 0.2, alpha: 1)
    appBarViewController.headerView.backgroundColor = color
    appBarViewController.navigationBar.tintColor = .white
    appBarViewController.navigationBar.titleTextAttributes =
      [NSAttributedString.Key.foregroundColor: UIColor.white]
    commonInitBottomAppBarTypicalUseSwiftExample()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInitBottomAppBarTypicalUseSwiftExample()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)
  }

  func commonInitBottomAppBarTypicalUseSwiftExample() {
    bottomBarView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    view.addSubview(bottomBarView)

    // Add touch handler to the floating button.
    bottomBarView.floatingButton.addTarget(
      self,
      action: #selector(didTapFloatingButton(_:)),
      for: .touchUpInside)

    // Set the image on the floating button.
    let addImage = UIImage(named: "ic_add")?.withRenderingMode(.alwaysTemplate)
    bottomBarView.floatingButton.setImage(addImage, for: .normal)
    bottomBarView.floatingButton.setTitle("Add new item", for: .normal)
    bottomBarView.floatingButton.mode = .expanded

    // Set the position of the floating button.
    bottomBarView.floatingButtonPosition = .center

    // Theme the floating button.
    bottomBarView.floatingButton.applySecondaryTheme(withScheme: containerScheme)

    // Configure the navigation buttons to be shown on the bottom app bar.
    let barButtonLeadingItem = UIBarButtonItem()
    let menuImage = UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate)
    barButtonLeadingItem.image = menuImage

    let barButtonTrailingItem = UIBarButtonItem()
    let searchImage = UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate)
    barButtonTrailingItem.image = searchImage

    bottomBarView.leadingBarButtonItems = [barButtonLeadingItem]
    bottomBarView.trailingBarButtonItems = [barButtonTrailingItem]
  }

  @objc func didTapFloatingButton(_ sender: MDCFloatingButton) {

    // Example of how to animate position of the floating button.
    if bottomBarView.floatingButtonPosition == .center {
      bottomBarView.setFloatingButtonPosition(.trailing, animated: true)
      bottomBarView.floatingButton.setTitle("", for: .normal)
      bottomBarView.floatingButton.mode = .normal
    } else {
      bottomBarView.setFloatingButtonPosition(.center, animated: true)
      bottomBarView.floatingButton.setTitle("Add new item", for: .normal)
      bottomBarView.floatingButton.mode = .expanded
    }
  }

  func layoutBottomAppBar() {
    let size = bottomBarView.sizeThatFits(view.bounds.size)
    let bottomBarViewFrame = CGRect(
      x: 0,
      y: view.bounds.size.height - size.height,
      width: size.width,
      height: size.height)
    bottomBarView.frame = bottomBarViewFrame
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.backgroundColor = .white

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    layoutBottomAppBar()
  }

  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    layoutBottomAppBar()
  }
}

// MARK: Catalog by convention
extension BottomAppBarTypicalUseSwiftExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom App Bar", "Bottom App Bar (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
