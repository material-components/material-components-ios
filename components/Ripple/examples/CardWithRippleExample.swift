// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialButtons_ButtonThemer
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialCards_Theming
import MaterialComponents.MaterialButtons_Theming

class CardWithRippleExample: UIViewController {
  var card = MDCCard()
  var button = MDCButton()

  @objc var containerScheme: MDCContainerScheming

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    card.enableRippleBehavior = true
    containerScheme = MDCContainerScheme()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    button.setTitle("Button", for: .normal)
    card.applyTheme(withScheme: containerScheme)
    card.backgroundColor = UIColor.blue.withAlphaComponent(0.05)
    button.applyContainedTheme(withScheme: containerScheme)
    view.addSubview(card)
    card.addSubview(button)
    card.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(30)-[card]-(30)-|",
                                                       options: [],
                                                       metrics: nil,
                                                       views: ["card": card]))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(120)-[card]-(60)-|",
                                                       options: [],
                                                       metrics: nil,
                                                       views: ["card": card]))
    card.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|",
                                                       options: [],
                                                       metrics: nil,
                                                       views: ["button": button]))
    card.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button]",
                                                       options: [],
                                                       metrics: nil,
                                                       views: ["button": button]))
    button.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal,
                                            toItem: nil, attribute: .notAnAttribute, multiplier: 1,
                                            constant: 60))

    view.accessibilityElements = [card, button]
    card.isAccessibilityElement = true
    card.accessibilityTraits = .button
    card.accessibilityLabel = "Card with button"
  }

  override public var traitCollection: UITraitCollection {
    if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isPortrait {
      return UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .compact),
                                           UITraitCollection(verticalSizeClass: .regular)])
    }
    return super.traitCollection
  }
}

extension CardWithRippleExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Ripple", "Card with Ripple"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
