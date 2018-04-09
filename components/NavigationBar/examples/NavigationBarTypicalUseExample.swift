/*
Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

open class NavigationBarTypicalUseSwiftExample: NavigationBarTypicalUseExample {

  override open func viewDidLoad() {

    super.viewDidLoad()
    view.backgroundColor = .white

    title = "Navigation Bar (Swift)"

    navBar = MDCNavigationBar()
    navBar!.observe(navigationItem)

    let mutator = MDCNavigationBarTextColorAccessibilityMutator()
    mutator.mutate(navBar!)

    let colorScheme = MDCSemanticColorScheme()
    MDCNavigationBarColorThemer.applySemanticColorScheme(colorScheme, to: navBar!)

    view.addSubview(navBar!)

    navBar!.translatesAutoresizingMaskIntoConstraints = false

    #if swift(>=3.2)
      if #available(iOS 11.0, *) {
        self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.navBar!.topAnchor).isActive = true
      } else {
        NSLayoutConstraint(item: self.topLayoutGuide,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.navBar,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
      }
    #else
      NSLayoutConstraint(item: self.topLayoutGuide,
                         attribute: .bottom,
                         relatedBy: .equal,
                         toItem: self.navBar,
                         attribute: .top,
                         multiplier: 1,
                         constant: 0).isActive = true
    #endif

    let viewBindings = ["navBar": navBar!]

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[navBar]|",
                                                                options: [],
                                                                metrics: nil,
                                                                views: viewBindings))
    self.setupExampleViews()
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override open var prefersStatusBarHidden: Bool {
    return true
  }
}
