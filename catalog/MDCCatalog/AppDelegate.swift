/*
Copyright 2015-present Google Inc. All Rights Reserved.

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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [NSObject: AnyObject]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

    let classList = classesRespondingToSelector("catalogHierarchy")

    // Build the catalog tree.

    let tree = Node(title: "Root")
    for c in classList {
      let hierarchy = CatalogHierarchyFromClass(c)

      // Walk and build the tree
      var node = tree
      for (index, name) in hierarchy.enumerate() {
        let isLeafNode = index == hierarchy.count - 1
        if let child = node.map[name] where !isLeafNode {
          node = child // Walk the node
          continue
        }
        // Create the node
        let child = Node(title: name)
        node.map[name] = child
        node.children.append(child)
        node = child // Walk the node
      }
      node.viewController = c
    }

    let rootNodeViewController = MDCCatalogComponentsController(node: tree)
    let navigationController = UINavigationController(rootViewController: rootNodeViewController)

    // In the event that an example view controller hides the navigation bar we generally want to
    // ensure that the edge-swipe pop gesture can still take effect. This may be overly-assumptive
    // but we'll explore other alternatives when we have a concrete example of this approach causing
    // problems.
    navigationController.interactivePopGestureRecognizer?.delegate = nil

    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
    return true
  }
}
