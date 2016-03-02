import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let flexHeadVC = ShrineFlexibleHeaderContainerViewController()
    self.window?.rootViewController = flexHeadVC;
    self.window?.makeKeyAndVisible();

    return true
  }

}
