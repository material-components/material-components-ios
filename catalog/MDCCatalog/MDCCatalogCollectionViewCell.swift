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

  fileprivate struct Constants {
    static let imagePadding: CGFloat = 50
  }

  var label = UILabel()
  let xPadding = CGFloat(14)
  let yPadding = CGFloat(16)
  let tile = MDCCatalogTileView(frame: CGRect.zero)

  override init(frame: CGRect) {
    super.init(frame: frame)
    label.textColor = UIColor(white: 0, alpha: MDCTypography.buttonFontOpacity())
    label.font = MDCTypography.buttonFont()
    contentView.addSubview(label)
    contentView.clipsToBounds = true
    contentView.addSubview(tile)
  }

  @available(*, unavailable)
  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    label.sizeToFit()
    label.frame = CGRect(
      x: xPadding,
      y: frame.height - label.frame.height - yPadding,
      width: frame.width - xPadding * 2,
      height: label.frame.height
    )
    tile.bounds = CGRect(x: 0, y: 0, width: tileWidthHeight(), height: tileWidthHeight())
    tile.center = CGPoint(x: contentView.bounds.width / 2,
                          y: label.frame.minY / 2 )
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = ""
  }

  func populateView(_ componentName: String) {
    label.text = componentName
    tile.componentName = componentName
    accessibilityIdentifier = componentName
  }

  func tileWidthHeight() -> CGFloat {
    let widthHeight = frame.width - 2 * Constants.imagePadding
    return widthHeight
  }
}
