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

class CardExampleViewController: UIViewController {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var card: MDCCard!

  override func viewDidLoad() {
    super.viewDidLoad()

    // The main image from the xib is taken from: https://unsplash.com/photos/wMzx2nBdeng
    // License details: https://unsplash.com/license
    let bundle = Bundle(for: CardExampleViewController.self)
    bundle.loadNibNamed("CardExampleViewController", owner: self, options: nil)
    contentView.frame = self.view.bounds
    self.view.addSubview(contentView)

    let bezierPath = UIBezierPath(roundedRect: imageView.bounds,
                                  byRoundingCorners: [.topLeft, .topRight],
                                  cornerRadii: CGSize(width: card.cornerRadius,
                                                      height: card.cornerRadius))
    let shapeLayer = CAShapeLayer()
    shapeLayer.frame = imageView.bounds
    shapeLayer.path = bezierPath.cgPath
    imageView.layer.mask = shapeLayer

    let colorScheme = MDCSemanticColorScheme()
    MDCCardsColorThemer.applySemanticColorScheme(colorScheme, to: card)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
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
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Cards", "Card (Swift)"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }

  @objc class func catalogIsDebug() -> Bool {
    return false
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return true
  }

  @objc class func catalogDescription() -> String {
    return "Material Cards."
  }
}
