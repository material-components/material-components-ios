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
import MaterialComponents.MDCSnackbarManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Instantiate a UITabBarController with 3 ProductGridViewControllers
        let mainStoryboardName = "ProductGrid"
        guard let home = UIStoryboard(name: mainStoryboardName, bundle: nil).instantiateInitialViewController() as? ProductGridViewController else { return false }
        home.isHome = true
        home.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4)
        home.tabBarItem.title = "Home"
        home.tabBarItem.image = UIImage(named: "Diamond")
        home.products = productsFor(category: .home)
        
        guard let clothing = UIStoryboard(name: mainStoryboardName, bundle: nil).instantiateInitialViewController() as? ProductGridViewController else { return false }
        clothing.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4)
        clothing.tabBarItem.title = "Clothing"
        clothing.tabBarItem.image = UIImage(named: "HeartFull")
        clothing.products = productsFor(category: .clothing)
        
        guard let popsicles = UIStoryboard(name: mainStoryboardName, bundle: nil).instantiateInitialViewController() as? ProductGridViewController else { return false }
        popsicles.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4)
        popsicles.tabBarItem.title = "Popsicles"
        popsicles.tabBarItem.image = UIImage(named: "Cart")
        popsicles.products = productsFor(category: .popsicles)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [clothing, home, popsicles]
        tabBarController.tabBar.tintColor = UIColor(red: 96/255.0, green: 125/255.0, blue: 139/255.0, alpha: 1)
        tabBarController.selectedIndex = 1
        
        // Make the UITabBarController the main interface of the app
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        MDCSnackbarManager.setBottomOffset(tabBarController.tabBar.bounds.size.height)
        
        return true
    }
    
}

