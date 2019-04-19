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
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialCards_Theming

class CardEditReorderCollectionCell: MDCCardCollectionCell {

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    if let shapedShadowLayer = self.layer as? MDCShapedShadowLayer {
      imageView.layer.mask = shapedShadowLayer.shapeLayer
    }
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.numberOfLines = 1
    label.textAlignment = .center
    label.lineBreakMode = .byTruncatingTail
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  func configure(title: String, imageName: String) {

    let bundle = Bundle(for: CardEditReorderCollectionCell.self)

    self.imageView.image  = UIImage(named: imageName, in: bundle, compatibleWith: nil)
    self.titleLabel.text = title

    self.contentView.addSubview(imageView)
    self.contentView.addSubview(titleLabel)
    titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 800),
                                                       for: .vertical)

    addConstraints()
  }

  func apply(containerScheme: MDCContainerScheming, typographyScheme: MDCTypographyScheming) {
    self.applyTheme(withScheme: containerScheme)
    self.titleLabel.font = typographyScheme.caption
  }

  private func addConstraints() {
    let views: [String: UIView] = ["image": self.imageView, "label": self.titleLabel]
    let metrics = ["margin": 4.0]
    self.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[image]|",
        options: [], metrics: metrics, views: views) +
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[image]-(margin)-[label]-(margin)-|",
        options: [], metrics: metrics, views: views) +
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-(margin)-[label]|",
        options: [], metrics: metrics, views: views)
    );
  }
}
