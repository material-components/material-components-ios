/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
import Foundation
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer

class ShadowElevationsPointsLabelSwift: UILabel {
  
  var elevation: ShadowElevation {
    get {
      let layer = self.layer as! MDCShadowLayer
      return layer.elevation
    }
    set {
      let layer = self.layer as! MDCShadowLayer
      layer.elevation = newValue
    }
  }

  override class var layerClass: AnyClass {
    get {
      return MDCShadowLayer.self
    }
  }
}

class ShadowElevationsTypicalUseExample: UIViewController {

  let appBarViewController = MDCAppBarViewController()
  let paper = ShadowElevationsPointsLabelSwift()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Shadow Elevations (Swift)"
    self.addChildViewController(appBarViewController)

    let color = UIColor(white: 0.2, alpha:1)
    appBarViewController.headerView.backgroundColor = color
    appBarViewController.navigationBar.tintColor = .white
    appBarViewController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

    let paperDim = CGFloat(200)
    paper.frame =
      CGRect(x: (view.frame.width - paperDim) / 2, y: paperDim, width: paperDim, height: paperDim)
    view.addSubview(paper)

    paper.elevation = .fabResting
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParentViewController: self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.backgroundColor = .white

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

}

// MARK: Catalog by convention
extension ShadowElevationsTypicalUseExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow", "Shadow Elevations (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
