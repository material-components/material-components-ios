// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialCards_Theming 
import MaterialComponents.MaterialContainerScheme

class CustomCard: MDCCard {

  static let cardWidth: CGFloat = 300
  let imageView: UIImageView = UIImageView()
  let cardButton1: MDCButton = MDCButton()
  let cardButton2: MDCButton = MDCButton()

  override func layoutSubviews() {
    super.layoutSubviews()
    if imageView.superview == nil { addSubview(imageView) }
    if cardButton1.superview == nil { addSubview(cardButton1) }
    if cardButton2.superview == nil { addSubview(cardButton2) }
    cardButton1.sizeToFit()
    cardButton2.sizeToFit()
    imageView.frame = CGRect(
      x: 0,
      y: 0,
      width: CustomCard.cardWidth,
      height: 200)
    cardButton1.frame = CGRect(
      x: 8,
      y: imageView.frame.maxY + 8,
      width: cardButton1.frame.width,
      height: cardButton1.frame.height)
    cardButton2.frame = CGRect(
      x: 8,
      y: cardButton1.frame.maxY + 8,
      width: cardButton2.frame.width,
      height: cardButton2.frame.height)
  }

  override var intrinsicContentSize: CGSize {
    return CGSize(width: CustomCard.cardWidth, height: cardButton2.frame.maxY + 8)
  }
}

class CardWithImageViewAndButtonsExample: UIViewController {
  let card: CustomCard = CustomCard()

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
    view.backgroundColor = containerScheme.colorScheme.backgroundColor
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpCard()
  }

  func setUpCard() {
    let bundle = Bundle(for: CardWithImageViewAndButtonsExample.self)
    card.imageView.image = UIImage(named: "sample-image", in: bundle, compatibleWith: nil)
    card.cardButton1.setTitle("Action 1", for: .normal)
    card.cardButton2.setTitle("Action 2", for: .normal)
    card.cardButton1.applyTextTheme(withScheme: containerScheme)
    card.cardButton2.applyTextTheme(withScheme: containerScheme)
    card.cornerRadius = 8
    card.applyTheme(withScheme: containerScheme)
    card.setNeedsLayout()
    card.layoutIfNeeded()
    card.frame = CGRect(
      x: card.frame.minX,
      y: card.frame.minY,
      width: card.intrinsicContentSize.width,
      height: card.intrinsicContentSize.height)
    if card.superview == nil { view.addSubview(card) }
    card.center = view.center
  }
}

extension CardWithImageViewAndButtonsExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Cards", "Card README example"],
      "description": "Cards contain content and actions about a single subject.",
      "primaryDemo": true,
      "presentable": true,
    ]
  }
}
