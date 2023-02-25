// Copyright 2023-present the Material Components for iOS authors. All Rights Reserved.
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

@objc(MDCParallaxFlowLayout)
public class ParallaxFlowLayout: UICollectionViewFlowLayout {
  /// A variable that determines the size that the parallax flow layout will use.
  public var cellSize = CGSize.zero {
    didSet {
      itemSize = cellSize
    }
  }

  override public init() {
    super.init()
    minimumInteritemSpacing = 0
    minimumLineSpacing = 0
    itemSize = UIScreen.main.bounds.size
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public class var layoutAttributesClass: AnyClass {
    return ParallaxLayoutAttributes.self
  }

  override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }

  override public func layoutAttributesForElements(
    in rect: CGRect
  ) -> [UICollectionViewLayoutAttributes]? {
    guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else {
      return nil
    }

    for layoutAttributesItem in layoutAttributes {
      if layoutAttributesItem.representedElementCategory == .cell,
        let parallaxAttributes = layoutAttributesItem as? ParallaxLayoutAttributes
      {
        if let collectionView = self.collectionView {
          let pageIndex = collectionView.contentOffset.y / collectionView.frame.size.height
          parallaxAttributes.update(with: pageIndex, for: collectionView.bounds)
        }
      }
    }

    return layoutAttributes
  }

  override public func layoutAttributesForItem(
    at indexPath: IndexPath
  ) -> UICollectionViewLayoutAttributes? {
    let layoutAttributes = super.layoutAttributesForItem(at: indexPath)
    guard let parallaxAttributes = layoutAttributes as? ParallaxLayoutAttributes else {
      return layoutAttributes
    }
    if let collectionView = self.collectionView {
      let pageIndex = collectionView.contentOffset.y / collectionView.frame.size.height
      parallaxAttributes.update(with: pageIndex, for: collectionView.bounds)
    }
    return parallaxAttributes
  }
}
