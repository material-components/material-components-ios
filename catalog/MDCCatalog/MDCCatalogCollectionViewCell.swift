/*
Copyright 2015-present Google Inc. All Rights Reserved.

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
import MaterialComponents

class MDCCatalogCollectionViewCell: UICollectionViewCell {

  var imageView = UIImageView()
  var label = UILabel()
  let pad = CGFloat(14)

  override init(frame: CGRect) {
    super.init(frame: frame)
    imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    imageView.contentMode = .ScaleAspectFill;
    self.addSubview(imageView)
    label.textColor = UIColor(white: 0.2, alpha: 1)
    label.font = MDCTypography.captionFont()
    self.addSubview(label)
    self.clipsToBounds = true
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func applyLayoutAttributes(layoutAttributes : UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    label.sizeToFit()
    label.frame = CGRectMake(pad, frame.height - label.frame.height - pad,
                             frame.width - pad * 2, label.frame.height)
    imageView.frame = self.bounds
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = ""
    imageView.image = nil
  }

  func populateView(componentName: String, image: UIImage) {
    label.text = componentName
    imageView.image = image
  }

}
