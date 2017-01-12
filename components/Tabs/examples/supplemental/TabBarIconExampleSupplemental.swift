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

import MaterialComponents.MaterialButtons

extension TabBarIconSwiftExample {


  // MARK: Methods

  func setupExampleViews() {
    setupAppBar()

    setupScrollView()
    setupScrollingContent()

    setupAlignmentButton()
  }


  func setupAlignmentButton() {

  }

  func setupAppBar() {

  }

  func setupScrollView() {

  }

  func setupScrollingContent() {

  }

  func addStar(centered: Bool) {
    
  }
}

extension TabBarIconSwiftExample {
  override var childViewControllerForStatusBarStyle: UIViewController? {
    return appBar.headerViewController
  }
}

// MARK: Catalog by convention
extension TabBarIconSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Tab Bar", "Icons and Text (Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
