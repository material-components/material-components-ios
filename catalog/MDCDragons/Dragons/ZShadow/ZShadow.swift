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

class ZShadow: UIViewController {
  
  var greenBannerLeadingConstraintCollapsed: NSLayoutConstraint!
  var blueBannerLeadingConstraintCollapsed: NSLayoutConstraint!
  
  @IBOutlet weak var greenTappable: MaterialShadowedView!
  @IBOutlet weak var greenBanner: MaterialShadowedView!
  
  @IBOutlet weak var blueTappable: VanillaShadowedView!
  @IBOutlet weak var blueBanner: VanillaShadowedView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    greenBannerLeadingConstraintCollapsed = greenBanner.trailingAnchor.constraint(equalTo: greenTappable.trailingAnchor)
    greenBannerLeadingConstraintCollapsed.isActive = false
    
    blueBannerLeadingConstraintCollapsed = blueBanner.trailingAnchor.constraint(equalTo: blueTappable.trailingAnchor)
    blueBannerLeadingConstraintCollapsed.isActive = false
    
  }
  
  @IBAction func squaresTapped(_ sender: Any) {
    greenBannerLeadingConstraintCollapsed.isActive = !greenBannerLeadingConstraintCollapsed.isActive
    blueBannerLeadingConstraintCollapsed.isActive = !blueBannerLeadingConstraintCollapsed.isActive
    
    UIView.animate(withDuration: 5, animations: {
      self.view.layoutIfNeeded()
    })
  }
}

extension ZShadow {
  
  // MARK: Catalog by convention
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["ZShadow"]
  }
  
  @objc class func catalogIsPrimaryDemo() -> Bool {
    return true
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }
}

