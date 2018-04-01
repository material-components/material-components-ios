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
class CardView: MDCCard {

  let contentView = UIView()
  let label = UILabel()
  let imageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonCardViewInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonCardViewInit()
  }

  func commonCardViewInit() {
    self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    contentView.layoutMargins = .zero
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.isUserInteractionEnabled = false
    self.addSubview(contentView)

    label.text = "abcde fghi jklm nopq rstuv wxyz abcd efgh ijkl mnop qrst uvw xyz abcde fghi jkl" +
      "nopq rstuv wxyz abcd efgh ijkl mnop qrst uvw xyz abcde fghi jklm nopq rstuv wxyz abcdefg" +
    "efgh ijkl mnop qrst uvw xyz abcde fghi jklm nopq rstuv wxyz abcd efgh ijkl abcd efghijkl"
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(label)

    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let bundle = Bundle(for: ShapedCardViewController.self)
    imageView.image = UIImage(named: "sample-image", in: bundle, compatibleWith: nil)
    self.contentView.addSubview(imageView)
  }

  override func layoutSubviews() {
    contentView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
    let shapeLayer = (self.layer as! MDCShapedShadowLayer).shapeLayer
    contentView.layer.mask = shapeLayer

    let margins = self.contentView.layoutMarginsGuide
    label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    label.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

    imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

    imageView.bottomAnchor.constraint(equalTo: label.topAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 1).isActive = true
  }
}

@available(iOS 9.0, *)
class ShapedCardViewController: UIViewController {
  var card = CardView()

  override func viewDidLoad() {
    view.backgroundColor = .white
    super.viewDidLoad()

    let shapeGenerator = MDCRectangleShapeGenerator()
    let curvedCornerTreatment = MDCCurvedCornerTreatment()
    curvedCornerTreatment.size = CGSize(width: 10, height: 40)
    shapeGenerator.setCorners(curvedCornerTreatment)
    card.shapeGenerator = shapeGenerator
    view.addSubview(card)
  }

  override func viewWillLayoutSubviews() {
    let cardSize = min(self.view.bounds.height, self.view.bounds.width) - 80
    card.frame = CGRect(x: 0, y: 0, width: cardSize, height: cardSize)
    card.center = view.center
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
