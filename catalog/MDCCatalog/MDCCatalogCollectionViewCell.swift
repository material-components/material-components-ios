// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

import MaterialComponents.MaterialTypography

class MDCCatalogCollectionViewCell: UICollectionViewCell {

  fileprivate struct Constants {
    static let imageWidthHeight: CGFloat = 80
    static let padding: CGFloat = 16
  }

  private lazy var label: UILabel = {
    let label = UILabel()
    label.textColor = AppTheme.defaultTheme.colorScheme.primaryColor
    label.font = MDCTypography.buttonFont()

    return label
  }()
  private lazy var tile = MDCCatalogTileView(frame: CGRect.zero)

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(label)
    contentView.clipsToBounds = true
    contentView.addSubview(tile)
    self.isAccessibilityElement = true
    self.accessibilityTraits |= UIAccessibilityTraitButton
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
      x: Constants.padding,
      y: frame.height - label.frame.height - Constants.padding,
      width: frame.width - Constants.padding * 2,
      height: label.frame.height
    )
    tile.bounds = CGRect(x: 0,
                         y: 0,
                         width: Constants.imageWidthHeight,
                         height: Constants.imageWidthHeight)
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

  override public var accessibilityLabel: String? {
    get {
      return self.label.accessibilityLabel
    }
    set {
      self.label.accessibilityLabel = newValue
    }
  }
}
