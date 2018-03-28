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

@available(iOS 9.0, *)
class ShapedCardViewController: UIViewController {
  var card = MDCCard()

  override func viewDidLoad() {
    view.backgroundColor = .white
    super.viewDidLoad()

    card.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    let shapeGenerator = MDCRectangleShapeGenerator()
    let curvedCornerTreatment = MDCCurvedCornerTreatment()
    curvedCornerTreatment.size = CGSize(width: 10, height: 40)
    shapeGenerator.setCorners(curvedCornerTreatment)
    card.shapeGenerator = shapeGenerator
    view.addSubview(card)
  }

  override func viewDidLayoutSubviews() {
    card.center = view.center
    card.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

    let contentView = UIView()
    contentView.layoutMargins = .zero
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.isUserInteractionEnabled = false
    card.addSubview(contentView)
    contentView.leadingAnchor.constraint(equalTo: card.layoutMarginsGuide.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: card.layoutMarginsGuide.trailingAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: card.layoutMarginsGuide.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: card.layoutMarginsGuide.bottomAnchor).isActive = true
    let shapeLayer = (card.layer as! MDCShapedShadowLayer).shapeLayer
    contentView.layer.mask = shapeLayer

//    let rect = CGRect(x: 20, y: 20, width: 20, height: 20)
//
//    // Cuts rectangle inside view, leaving 20pt borders around
//    contentView.mask(withRect: rect, inverse: true)

//    // Cuts 20pt borders around the view, keeping part inside rect intact
//    targetView.mask(withRect: rect)
    let label = UILabel()
    label.text = "abcde fghi jklm nopq rstuv wxyz abcd efgh ijkl mnop qrst uvw xyz abcde fghi jkl" +
        "nopq rstuv wxyz abcd efgh ijkl mnop qrst uvw xyz abcde fghi jklm nopq rstuv wxyz abcdefg" +
        "efgh ijkl mnop qrst uvw xyz abcde fghi jklm nopq rstuv wxyz abcd efgh ijkl abcd efghijkl"
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(label)

    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let bundle = Bundle(for: ShapedCardViewController.self)
    imageView.image = UIImage(named: "sample-image", in: bundle, compatibleWith: nil)
    contentView.addSubview(imageView)

    let margins = contentView.layoutMarginsGuide
    label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    label.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

    imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    imageView.bottomAnchor.constraint(equalTo: label.topAnchor).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: card.bounds.height/2).isActive = true
    label.heightAnchor.constraint(equalToConstant: card.bounds.height/2).isActive = true

  }

  override public var traitCollection: UITraitCollection {
    if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isPortrait {
      return UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .compact),
                                           UITraitCollection(verticalSizeClass: .regular)])
    }
    return super.traitCollection
  }

}

@available(iOS 9.0, *)
extension ShapedCardViewController {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Cards", "Shaped Card"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }

  @objc class func catalogIsDebug() -> Bool {
    return true
  }
}

extension UIView {
  func mask(withRect rect: CGRect, inverse: Bool = false) {
    let path = UIBezierPath(rect: rect)
    let maskLayer = CAShapeLayer()

    if inverse {
      path.append(UIBezierPath(rect: self.bounds))
      maskLayer.fillRule = kCAFillRuleEvenOdd
    }

    maskLayer.path = path.cgPath

    self.layer.mask = maskLayer
  }

  func mask(withPath path: UIBezierPath, inverse: Bool = false) {
    let path = path
    let maskLayer = CAShapeLayer()

    if inverse {
      path.append(UIBezierPath(rect: self.bounds))
      maskLayer.fillRule = kCAFillRuleEvenOdd
    }

    maskLayer.path = path.cgPath

    self.layer.mask = maskLayer
  }
}
