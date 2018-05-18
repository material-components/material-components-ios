/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import UIKit

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialBottomAppBar
import MaterialComponents.MaterialButtons_ColorThemer

class BottomAppBarTypicalUseSwiftExample: UIViewController {
  let appBar = MDCAppBar()
  let bottomBarView = MDCBottomAppBarView()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Bottom App Bar (Swift)"
    self.addChildViewController(appBar.headerViewController)
    print("wdup")

    let color = UIColor(white: 0.2, alpha:1)
    appBar.headerViewController.headerView.backgroundColor = color
    appBar.navigationBar.tintColor = .white
    appBar.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    commonInitBottomAppBarTypicalUseSwiftExample()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInitBottomAppBarTypicalUseSwiftExample()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    appBar.addSubviewsToParent()
  }

  func commonInitBottomAppBarTypicalUseSwiftExample() {
    bottomBarView.autoresizingMask = [ .flexibleWidth, .flexibleTopMargin ]
    view.addSubview(bottomBarView)

    // Add touch handler to the floating button.
    bottomBarView.floatingButton.addTarget(self,
                                           action: #selector(didTapFloatingButton(_:)),
                                           for: .touchUpInside)

    // Set the image on the floating button.
    let addImage = UIImage(named:"Add")
    bottomBarView.floatingButton.setImage(addImage, for: .normal)

    // Set the position of the floating button.
    bottomBarView.floatingButtonPosition = .center

    // Theme the floating button.
    let colorScheme = MDCBasicColorScheme(primaryColor: .white)
    MDCButtonColorThemer.apply(colorScheme, to: bottomBarView.floatingButton)

    // Configure the navigation buttons to be shown on the bottom app bar.
    let barButtonLeadingItem = UIBarButtonItem()
    let menuImage = UIImage(named:"Menu")
    barButtonLeadingItem.image = menuImage

    let barButtonTrailingItem = UIBarButtonItem()
    let searchImage = UIImage(named:"Search")
    barButtonTrailingItem.image = searchImage

    bottomBarView.leadingBarButtonItems = [ barButtonLeadingItem ]
    bottomBarView.trailingBarButtonItems = [ barButtonTrailingItem ]
  }

  @objc func didTapFloatingButton(_ sender : MDCFloatingButton) {

    // Example of how to animate position of the floating button.
    if (bottomBarView.floatingButtonPosition == .center) {
      bottomBarView.setFloatingButtonPosition(.trailing, animated: true)
    } else {
      bottomBarView.setFloatingButtonPosition(.center, animated: true)
    }
  }

  func layoutBottomAppBar() {
    let size = bottomBarView.sizeThatFits(view.bounds.size)
    let bottomBarViewFrame = CGRect(x: 0,
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

  #if swift(>=3.2)
  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    layoutBottomAppBar()
  }
  #endif

}

// MARK: Catalog by convention
extension BottomAppBarTypicalUseSwiftExample {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Bottom App Bar", "Bottom App Bar (Swift)"]
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
