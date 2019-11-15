// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

class CardExampleViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var card: MDCCard!
  @IBOutlet weak var button: MDCButton!

  @objc var containerScheme: MDCContainerScheming

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    containerScheme = MDCContainerScheme()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // The main image from the xib is taken from: https://unsplash.com/photos/wMzx2nBdeng
    // License details: https://unsplash.com/license
    let bundle = Bundle(for: CardExampleViewController.self)
    bundle.loadNibNamed("CardExampleViewController", owner: self, options: nil)
    view.frame = self.view.bounds

    button.applyTextTheme(withScheme: containerScheme)
    card.applyTheme(withScheme: containerScheme)
    card.isInteractable = false

    imageView.isAccessibilityElement = true
    imageView.accessibilityLabel = "Missing Dish"
    imageView.layer.cornerRadius = card.layer.cornerRadius
    if #available(iOS 11.0, *) {
      imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
  }

  override public var traitCollection: UITraitCollection {
    if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isPortrait {
      return UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .compact),
                                           UITraitCollection(verticalSizeClass: .regular)])
    }
    return super.traitCollection
  }
}

extension CardExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Cards", "Card (Swift)"],
      "description": "Cards contain content and actions about a single subject.",
      "primaryDemo": true,
      "presentable": true,
    ]
  }
}
