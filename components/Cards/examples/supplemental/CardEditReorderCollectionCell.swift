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
import MaterialComponents.MaterialCards

class CardEditReorderCollectionCell: MDCCardCollectionCell {

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.numberOfLines = 1
    label.textAlignment = .center
    label.lineBreakMode = .byTruncatingTail
    label.font = self.typographyScheme.caption
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  func configure(title: String, imageName: String) {

    let bundle = Bundle(for: CardEditReorderCollectionCell.self)

    self.imageView.image  = UIImage(named: imageName, in: bundle, compatibleWith: nil)
    self.titleLabel.text = title

    self.insertSubview(imageView, at: 0)
    self.insertSubview(titleLabel, at: 0)

    titleLabel.setContentCompressionResistancePriority(800, for: .vertical)

    if #available(iOS 11, *) {
      post_iOS11Constraints()
    } else {
      pre_iOS11Constraints()
    }
  }

  @available(iOS 11, *)
  private func post_iOS11Constraints() {
    #if swift(>=3.2)
      let guide = self.safeAreaLayoutGuide
      let margin: CGFloat = 4.0

      NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: guide.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin),

        titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: margin),
        titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -margin),
        titleLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -margin)
      ]);
    #else
      pre_iOS11Constraints()
    #endif
  }

  private func pre_iOS11Constraints() {
    let views: [String: UIView] = ["image": self.imageView, "label": self.titleLabel]
    let metrics = ["margin": 4.0]
    self.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-[image]-|",
        options: [], metrics: metrics, views: views) +
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-[image]-(margin)-[label]-(margin)-|",
        options: [], metrics: metrics, views: views) +
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-(margin)-[label]-(margin)-|",
        options: [], metrics: metrics, views: views)
    );
  }
}
