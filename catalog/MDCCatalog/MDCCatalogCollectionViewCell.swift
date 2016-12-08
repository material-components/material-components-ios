/*
Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

import MaterialComponents.MaterialTypography

class MDCCatalogCollectionViewCell: UICollectionViewCell {

  var label = UILabel()
  let pad = CGFloat(14)
  let tile = MDCCatalogTileView(frame: CGRectZero)

  override init(frame: CGRect) {
    super.init(frame: frame)
    label.textColor = UIColor(white: 0.2, alpha: 1)
    label.font = MDCTypography.captionFont()
    self.addSubview(label)
    self.clipsToBounds = true

    tile.frame = self.bounds
    tile.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    self.addSubview(tile)
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    label.sizeToFit()
    label.frame = CGRect(
      x: pad,
      y: frame.height - label.frame.height - pad,
      width: frame.width - pad * 2,
      height: label.frame.height
    )
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = ""
  }

  func populateView(componentName: String) {
    label.text = componentName
    tile.componentName = componentName
  }

}
