//
//  CardEditReorderCollectionCell.swift
//  CatalogByConvention
//
//  Created by Galia Kaufman on 7/6/18.
//
//  Card images source:
//  Material Design Guidelines (https://material.io/design/components/cards.html#card-collections)
//

import UIKit
import MaterialComponents.MaterialCards

class CardEditReorderCollectionCell: MDCCardCollectionCell {

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 6.0
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.numberOfLines = 1
    label.textAlignment = .center
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.systemFont(ofSize: 12.0)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  func configure(title: String, number: Int) {

    let bundle = Bundle(for: CardEditReorderCollectionCell.self)

    let img = UIImage(named: "check-circle-blue", in: bundle, compatibleWith: nil)
    self.setImage(img, for: .selected)

    let maxImageNumber = 7
    let imageName = "cell-image-\(number % maxImageNumber)"
    self.imageView.image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
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
      let margin: CGFloat = 8.0
      let thinMargin: CGFloat = 4.0

      NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: margin),
        imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: margin),
        imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -margin),

        imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -thinMargin),

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
    let metrics = ["margin": 8.0, "thin": 4.0]
    self.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-(margin)-[image]-(margin)-|",
        options: [], metrics: metrics, views: views) +
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-(margin)-[image]-(thin)-[label]-(margin)-|",
        options: [], metrics: metrics, views: views) +
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-(margin)-[label]-(margin)-|",
        options: [], metrics: metrics, views: views)
    );
  }
}
