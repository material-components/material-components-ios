// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

class ZShadow: UIView {
  @IBOutlet weak var greenTappable: MaterialShadowedView!
  @IBOutlet weak var greenBanner: MaterialShadowedView!
  
  @IBOutlet weak var blueTappable: VanillaShadowedView!
  @IBOutlet weak var blueBanner: VanillaShadowedView!
  
  @IBOutlet var containerView: UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    let bundle = Bundle(for: ZShadow.self)
    bundle.loadNibNamed("ZShadow", owner: self, options: nil)
    addSubview(containerView)
    self.backgroundColor = .white
    containerView.backgroundColor = .white
    containerView.frame = self.bounds
    containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}

class ZShadowViewController: UIViewController {
  
  var greenBannerLeadingConstraintCollapsed: NSLayoutConstraint!
  var blueBannerLeadingConstraintCollapsed: NSLayoutConstraint!
  var contentView: ZShadow!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contentView = ZShadow(frame: self.view.bounds)
    self.view.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                       options: [],
                                                       metrics: nil,
                                                       views: ["view": contentView]));
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                       options: [],
                                                       metrics: nil,
                                                       views: ["view": contentView]));
    greenBannerLeadingConstraintCollapsed = contentView.greenBanner.trailingAnchor.constraint(equalTo: contentView.greenTappable.trailingAnchor)
    greenBannerLeadingConstraintCollapsed.isActive = false
    
    blueBannerLeadingConstraintCollapsed = contentView.blueBanner.trailingAnchor.constraint(equalTo: contentView.blueTappable.trailingAnchor)
    blueBannerLeadingConstraintCollapsed.isActive = false
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(squaresTapped))
    contentView.greenTappable.addGestureRecognizer(tap)
    contentView.greenTappable.isAccessibilityElement = true
    contentView.greenTappable.accessibilityTraits = .button
    contentView.greenTappable.accessibilityLabel = "Toggle Material Shadow"
    let tap2 = UITapGestureRecognizer(target: self, action: #selector(squaresTapped))
    contentView.blueTappable.addGestureRecognizer(tap2)
    contentView.blueTappable.isAccessibilityElement = true
    contentView.blueTappable.accessibilityTraits = .button
    contentView.blueTappable.accessibilityLabel = "Toggle UIKit Shadow"
  }
  
  @objc func squaresTapped() {
    greenBannerLeadingConstraintCollapsed.isActive = !greenBannerLeadingConstraintCollapsed.isActive
    blueBannerLeadingConstraintCollapsed.isActive = !blueBannerLeadingConstraintCollapsed.isActive
    
    UIView.animate(withDuration: 5, animations: {
      self.view.layoutIfNeeded()
    })
  }
}

extension ZShadowViewController {
  
  // MARK: Catalog by convention

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["ZShadow"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}

