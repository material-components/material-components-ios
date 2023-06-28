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

/// An enum that determines the direction that the parallax flow layout will be using.
@objc(MDCParallaxFlowLayoutDirection)
public enum ParallaxFlowLayoutDirection: Int {
  case vertical
}

@objc(MDCParallaxFlowLayout)
public class ParallaxFlowLayout: UICollectionViewFlowLayout {
  private var flowLayoutDirection = ParallaxFlowLayoutDirection.vertical

  /// A variable that determines the size that the parallax flow layout will use.
  public var cellSize = CGSize.zero {
    didSet {
      itemSize = cellSize
    }
  }

  /// A no parameter initializer that defaults to using the vertical flow direction.
  override public init() {
    super.init()
    minimumInteritemSpacing = 0
    minimumLineSpacing = 0
    flowLayoutDirection = .vertical
    guard let collectionViewSize = collectionView?.bounds.size else {
      itemSize = UIScreen.main.bounds.size
      return
    }
    itemSize = collectionViewSize
  }

  public init(direction: ParallaxFlowLayoutDirection) {
    super.init()
    minimumInteritemSpacing = 0
    minimumLineSpacing = 0
    flowLayoutDirection = direction
    guard let collectionViewSize = collectionView?.bounds.size else {
      itemSize = UIScreen.main.bounds.size
      return
    }
    itemSize = collectionViewSize
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public class var layoutAttributesClass: AnyClass {
    // TODO(loading): Add flowLayoutDirection check when there are more than 1 directions.
    return ParallaxLayoutVerticalAttributes.self
  }

  override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    itemSize = newBounds.size
    return true
  }

  override public func layoutAttributesForElements(
    in rect: CGRect
  ) -> [UICollectionViewLayoutAttributes]? {
    guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else {
      return nil
    }

    var finalLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    for layoutAttributesItem in layoutAttributes {
      let copiedLayoutAttributes = layoutAttributesItem.copy()
      if layoutAttributesItem.representedElementCategory == .cell,
        let parallaxAttributes = copiedLayoutAttributes as? ParallaxLayoutVerticalAttributes
      {
        if let collectionView = self.collectionView {
          let pageIndex = collectionView.contentOffset.y / collectionView.frame.size.height
          parallaxAttributes.update(with: pageIndex, for: collectionView.bounds)
          finalLayoutAttributes.append(parallaxAttributes)
        }
      }
    }

    return finalLayoutAttributes
  }

  override public func layoutAttributesForItem(
    at indexPath: IndexPath
  ) -> UICollectionViewLayoutAttributes? {
    guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath) else {
      return nil
    }
    let copiedLayoutAttributes = layoutAttributes.copy()
    guard let parallaxAttributes = copiedLayoutAttributes as? ParallaxLayoutVerticalAttributes
    else {
      return layoutAttributes
    }
    if let collectionView = self.collectionView {
      let pageIndex = collectionView.contentOffset.y / collectionView.frame.size.height
      parallaxAttributes.update(with: pageIndex, for: collectionView.bounds)
    }
    return parallaxAttributes
  }
}
