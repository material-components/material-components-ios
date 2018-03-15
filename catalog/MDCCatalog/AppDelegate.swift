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

import MaterialComponents.MDCActivityIndicatorColorThemer
import MaterialComponents.MDCButtonBarColorThemer
import MaterialComponents.MDCButtonColorThemer
import MaterialComponents.MDCAlertColorThemer
import MaterialComponents.MaterialDialogs
import MaterialComponents.MDCBottomNavigationBarColorThemer
import MaterialComponents.MDCFeatureHighlightColorThemer
import MaterialComponents.MDCFlexibleHeaderColorThemer
import MaterialComponents.MDCHeaderStackViewColorThemer
import MaterialComponents.MDCNavigationBarColorThemer
import MaterialComponents.MDCPageControlColorThemer
import MaterialComponents.MDCProgressViewColorThemer
import MaterialComponents.MDCSliderColorThemer
import MaterialComponents.MDCTabBarColorThemer
import MaterialComponents.MaterialTextFields
import MaterialComponents.MDCTextFieldColorThemer
import MaterialComponents.MaterialNavigationBar
import MaterialComponents.MaterialThemes
import MaterialComponents.MDCCardExperimentalColorThemer
import MaterialComponents.MDCChipViewExperimentalColorThemer
import MaterialComponents.MDCSnackbarMessageViewExperimentalColorThemer


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var colorScheme: MDCExperimentalColorScheme = {
    let colorScheme = MDCExperimentalColorScheme()
    colorScheme.primaryColor = MDCPalette.blue.tint500
    colorScheme.backgroundColor = MDCPalette.grey.tint900
    colorScheme.borderColor = MDCPalette.blue.tint700
    colorScheme.shadowColor = MDCPalette.grey.tint600
    colorScheme.inkColor = MDCPalette.blue.tint200.withAlphaComponent(0.16)
    colorScheme.textColor = MDCPalette.grey.tint50
    colorScheme.disabledBackgroundColor = MDCPalette.grey.tint800
    colorScheme.selectionColor = MDCPalette.blue.tint300
    colorScheme.errorColor = MDCPalette.red.tint300
    colorScheme.badgeColor = MDCPalette.blue.tint600
    return colorScheme;
  }()

  func applyColorScheme(_ colorScheme: MDCExperimentalColorScheme) {
    // Apply color scheme to material design components using component themers.
    MDCActivityIndicatorColorThemer.applyExperimental(colorScheme, to: MDCActivityIndicator.appearance())
    MDCBottomAppBarExperimentalColorThemer.apply(colorScheme, toBar: MDCBottomAppBarView.appearance())
    MDCBottomNavigationBarColorThemer.apply(colorScheme, to: MDCBottomNavigationBar.appearance())
    if #available(iOS 9.0, *) {
      MDCBottomNavigationBarColorThemer.apply(colorScheme, to: UITabBarItem.appearance(whenContainedInInstancesOf: [MDCBottomNavigationBar.self]))
    }
    MDCButtonColorThemer.apply(colorScheme, to: MDCButton.appearance())
    MDCButtonColorThemer.apply(colorScheme, to: MDCFlatButton.appearance())
//    MDCButtonColorThemer.apply(colorScheme, to: MDCRaisedButton.appearance())
//    MDCButtonColorThemer.apply(colorScheme, to: MDCFloatingButton.appearance())
    MDCButtonBarColorThemer.apply(colorScheme, to: MDCButtonBar.appearance())
    MDCFeatureHighlightColorThemer.apply(colorScheme, to: MDCFeatureHighlightView.appearance())
    MDCFlexibleHeaderColorThemer.apply(colorScheme, toFlexibleHeader:MDCFlexibleHeaderView.appearance())
    MDCTabBarColorThemer.apply(colorScheme, to: MDCTabBar.appearance())
    MDCNavigationBarColorThemer.apply(colorScheme, to: MDCNavigationBar.appearance())
    MDCCardExperimentalColorThemer.applyExperimentalTheme(colorScheme, to: MDCCard.appearance())
    MDCCardExperimentalColorThemer.applyExperimentalTheme(colorScheme, to: MDCCardCollectionCell.appearance())
    MDCChipViewExperimentalColorThemer.applyExperimentalColorTheme(colorScheme, to: MDCChipView.appearance())
    MDCPageControlColorThemer.apply(colorScheme, to: MDCPageControl.appearance())
    MDCProgressViewColorThemer.apply(colorScheme, to: MDCProgressView.appearance())
    MDCSliderColorThemer.apply(colorScheme, to: MDCSlider.appearance())
    MDCSnackbarMessageViewExperimentalColorThemer.applyTheme(colorScheme, to: MDCSnackbarMessageView.appearance())
    MDCAlertColorThemer.apply(colorScheme, toInstancesOf: MDCAlertController.self)
    MDCTextFieldColorThemer.apply(colorScheme, toAllTextInputControllersOfClass: MDCTextInputControllerUnderline.self)
    MDCTextFieldColorThemer.apply(colorScheme, toAllTextInputControllersOfClass: MDCTextInputControllerLegacyDefault.self)
    MDCTextFieldColorThemer.apply(colorScheme, toAllTextInputControllersOfClass: MDCTextInputControllerFilled.self)
    MDCTextFieldColorThemer.apply(colorScheme, toAllTextInputControllersOfClass: MDCTextInputControllerOutlined.self)
    MDCTextFieldColorThemer.apply(colorScheme, toAllTextInputControllersOfClass: MDCTextInputControllerOutlinedTextArea.self)
    MDCTextFieldColorThemer.apply(colorScheme, to: MDCTextField.appearance())
    //    MDCHeaderStackViewColorThemer.apply(colorScheme, to: MDCHeaderStackView.appearance())
    //

    //
    // Apply color scheme to UIKit components.
//    UIView.appearance().backgroundColor = colorScheme.backgroundColor
//    MDCInkView.appearance().backgroundColor = UIColor.clear
    UISlider.appearance().tintColor = colorScheme.primaryColor
    UISwitch.appearance().onTintColor = colorScheme.primaryColor
  }

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = MDCCatalogWindow(frame: UIScreen.main.bounds)
    UIApplication.shared.statusBarStyle = .lightContent

    applyColorScheme(colorScheme)
    let data = NSKeyedArchiver.archivedData(withRootObject: colorScheme)
    UserDefaults.standard.set(data, forKey: "MDCCatalogColorScheme")

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
