//
//  AppDelegate.swift
//  BuildingBeautifulApps
//
//  Created by Joel Youngblood on 5/31/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainStoryboardName = "ProductGrid"
        guard let home = UIStoryboard(name: mainStoryboardName, bundle: nil).instantiateInitialViewController() as? ProductGridViewController else { return false }
        home.isHome = true
        home.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4)
        home.tabBarItem.title = "Home"
        home.tabBarItem.image = UIImage(named: "Diamond")
        home.products = productsFor(category: .home)!
        
        guard let clothing = UIStoryboard(name: mainStoryboardName, bundle: nil).instantiateInitialViewController() as? ProductGridViewController else { return false }
        clothing.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4)
        clothing.tabBarItem.title = "Clothing"
        clothing.tabBarItem.image = UIImage(named: "HeartFull")
        clothing.products = productsFor(category: .clothing)!
        
        guard let popsicles = UIStoryboard(name: mainStoryboardName, bundle: nil).instantiateInitialViewController() as? ProductGridViewController else { return false }
        popsicles.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4)
        popsicles.tabBarItem.title = "Popsicles"
        popsicles.tabBarItem.image = UIImage(named: "Cart")
        popsicles.products = productsFor(category: .popsicles)!
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [clothing, home, popsicles]
        tabBarController.tabBar.tintColor = UIColor(red: 96/255.0, green: 125/255.0, blue: 139/255.0, alpha: 1)
        tabBarController.selectedIndex = 1
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        return true
    }

}

