/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
import MaterialComponents.MaterialButtons_ButtonThemer
import MaterialComponents.MaterialCards_CardThemer

class CardExampleViewController: UIViewController {
  @IBOutlet weak var imageView: CardImageView!
  @IBOutlet weak var card: MDCCard!
  @IBOutlet weak var button: MDCButton!

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    // The main image from the xib is taken from: https://unsplash.com/photos/wMzx2nBdeng
    // License details: https://unsplash.com/license
    let bundle = Bundle(for: CardExampleViewController.self)
    bundle.loadNibNamed("CardExampleViewController", owner: self, options: nil)
    view.frame = self.view.bounds

    let buttonScheme = MDCButtonScheme();
    buttonScheme.colorScheme = colorScheme
    buttonScheme.typographyScheme = typographyScheme
    MDCTextButtonThemer.applyScheme(buttonScheme, to: button)

    let cardScheme = MDCCardScheme();
    cardScheme.colorScheme = colorScheme
    MDCCardThemer.applyScheme(cardScheme, to: card)
    card.isInteractable = false

    imageView.isAccessibilityElement = true
    imageView.accessibilityLabel = "Missing Dish"
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

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Cards", "Card (Swift)"],
      "description": "Cards contain content and actions about a single subject.",
      "primaryDemo": true,
      "presentable": true,
    ]
  }
}

class CardImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    self.curveImageToCorners()
  }

  func curveImageToCorners() {
    // The main image from the xib is taken from: https://unsplash.com/photos/wMzx2nBdeng
    // License details: https://unsplash.com/license
    var roundingCorners = UIRectCorner.topLeft
    if (UIDevice.current.orientation == .portrait ||
      UIDevice.current.orientation == .portraitUpsideDown) {
      roundingCorners.formUnion(.topRight)
    } else {
      roundingCorners.formUnion(.bottomLeft)
    }

    let bezierPath = UIBezierPath(roundedRect: self.bounds,
                                  byRoundingCorners: roundingCorners,
                                  cornerRadii: CGSize(width: 4,
                                                      height: 4))
    let shapeLayer = CAShapeLayer()
    shapeLayer.frame = self.bounds
    shapeLayer.path = bezierPath.cgPath
    self.layer.mask = shapeLayer
  }

}
