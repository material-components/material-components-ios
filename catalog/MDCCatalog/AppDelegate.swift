/*
Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

import UIKit

import CatalogByConvention
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MaterialIcons_ic_more_horiz

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = MDCCatalogWindow(frame: UIScreen.main.bounds)
    UIApplication.shared.statusBarStyle = .lightContent

    // The navigation tree will only take examples that implement
    // and return YES to catalogIsPresentable.
    let tree = CBCCreatePresentableNavigationTree()

    let rootNodeViewController = MDCCatalogComponentsController(node: tree)
    let navigationController = UINavigationController(rootViewController: rootNodeViewController)

    // In the event that an example view controller hides the navigation bar we generally want to
    // ensure that the edge-swipe pop gesture can still take effect. This may be overly-assumptive
    // but we'll explore other alternatives when we have a concrete example of this approach causing
    // problems.
    navigationController.interactivePopGestureRecognizer?.delegate = navigationController

    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}

extension UINavigationController {
  func presentMenu() {
    let menuViewController = MDCMenuViewController(style: .plain)
    let bottomSheet = MDCBottomSheetController(contentViewController: menuViewController)
    self.present(bottomSheet, animated: true, completion: nil)
  }

  func setMenuBarButton(for viewController: UIViewController) {
    let dotsImage = MDCIcons.imageFor_ic_more_horiz()?.withRenderingMode(.alwaysTemplate)
    viewController.navigationItem.rightBarButtonItem =
      UIBarButtonItem(image: dotsImage,
                      style: .plain,
                      target: self,
                      action: #selector(presentMenu))
  }

  class func embedExampleWithinAppBarContainer(using viewController: UIViewController,
                                               currentBounds: CGRect,
                                               named title: String) -> UIViewController {
    let appBarFont: UIFont
    if #available(iOS 9.0, *) {
      appBarFont = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: UIFontWeightRegular)
    } else {
      let attribute: [String: UIFontDescriptorSymbolicTraits] =
        [UIFontSymbolicTrait: UIFontDescriptorSymbolicTraits.traitMonoSpace]
      let descriptor: UIFontDescriptor = UIFontDescriptor(fontAttributes: attribute)
      appBarFont = UIFont(descriptor: descriptor, size: 16)
    }
    let container = MDCAppBarContainerViewController(contentViewController: viewController)
    container.appBar.navigationBar.titleAlignment = .center
    container.appBar.navigationBar.tintColor = UIColor.white
    container.appBar.navigationBar.titleTextAttributes =
      [ NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: appBarFont ]
    MDCAppBarColorThemer.applySemanticColorScheme(AppTheme.globalTheme.colorScheme,
                                                  to: container.appBar)
    // TODO(featherless): Remove once
    // https://github.com/material-components/material-components-ios/issues/367 is resolved.
    viewController.title = title
    let headerView = container.appBar.headerViewController.headerView
    if let collectionVC = viewController as? MDCCollectionViewController {
      headerView.trackingScrollView = collectionVC.collectionView
    } else if let scrollView = viewController.view as? UIScrollView {
      headerView.trackingScrollView = scrollView
    } else {
      // TODO(chuga): This is bad. We should be adjusting for Safe Area changes.
      var contentFrame = container.contentViewController.view.frame
      let headerSize = headerView.sizeThatFits(container.contentViewController.view.frame.size)
      contentFrame.origin.y = headerSize.height
      contentFrame.size.height = currentBounds.height - headerSize.height
      container.contentViewController.view.frame = contentFrame
    }
    return container
  }

}
