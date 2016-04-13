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

import UIKit
import MaterialComponents.MaterialNavigationBar

public class NavigationBarTypicalUseSwiftExample: NavigationBarTypicalUseExample {

  override public func viewDidLoad() {

    super.viewDidLoad()
    view.backgroundColor = .whiteColor()

    title = "Navigation Bar (Swift)"

    navBar = MDCNavigationBar()
    navBar!.observeNavigationItem(navigationItem)
    navBar!.tintColor = .whiteColor()

    // Light blue 500
    navBar!.backgroundColor = UIColor.init(red: 0.012, green: 0.663, blue: 0.957, alpha: 1)

    view.addSubview(navBar!)

    navBar!.translatesAutoresizingMaskIntoConstraints = false

    let viewBindings = ["navBar" : navBar!]

    var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[navBar]|",
      options: [], metrics: nil, views: viewBindings)
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[navBar]",
      options: [], metrics: nil, views: viewBindings)

    view.addConstraints(constraints)
    self.setupExampleViews()
  }

  override public func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override public func prefersStatusBarHidden() -> Bool {
    return true
  }
}
