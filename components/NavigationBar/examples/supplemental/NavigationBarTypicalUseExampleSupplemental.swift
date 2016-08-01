/*
Copyright 2016-present Google Inc. All Rights Reserved.

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

/* IMPORTANT:
This file contains supplemental code used to populate the examples with dummy data and/or
instructions. It is not necessary to import this file to use Material Components for iOS.
*/

import Foundation
import MaterialComponents

extension NavigationBarTypicalUseSwiftExample {

  // (CatalogByConvention)

  class func catalogBreadcrumbs() -> [String] {
    return [ "Navigation Bar", "Navigation Bar (Swift)" ]
  }

  class func catalogDescription() -> String {
    return "The Navigation Bar component is a view composed of a left and right Button Bar and"
          " either a title label or a custom title view."
  }

  class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }

  override public func setupExampleViews() {
    /// Both self.viewDidLoad() and super.viewDidLoad() will add NavigationBars to the hierarchy.
    /// We only want to keep one.

    for subview in view.subviews {
      if let navBarSubview = subview as? MDCNavigationBar where navBarSubview != self.navBar {
        navBarSubview.removeFromSuperview()
      }
    }
    super.setupExampleViews()
  }

}
