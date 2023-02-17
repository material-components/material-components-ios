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

class ParallaxLayoutAttributes: UICollectionViewLayoutAttributes {
  private let heightWhenShrunk = 16.0
  private let spaceWhenShrunk = 10.0

  public var relativeIndexOffset: Double = 0.0

  override func isEqual(_ object: Any?) -> Bool {
    if let attributes = object as? ParallaxLayoutAttributes,
      attributes.relativeIndexOffset == relativeIndexOffset
    {
      return super.isEqual(object)
    }
    return false
  }

  /// Returns an optional double that represents the relative offset of the current scrolling
  /// position to the page index.
  ///
  ///
  /// - Parameter pageIndex: A number that represents the current scrolling position in relation to
  ///   the items in the collection view.
  /// - Returns: an optional double that is between -1 and 1 that represents the offset to the
  ///   current visible page during scolling. Returns nil for pages out of the visible range.
  public func calculateRelativeIndexOffset(with pageIndex: Double) -> Double? {
    let itemIndex = Double(self.indexPath.item)
    let offset = pageIndex - itemIndex
    // The range [-1, 1] is picked because those relative offset represent
    // scrolling to the previous and next page. We are only interested in
    // the cells with those 2 relative offsets.
    return -1 <= offset && offset <= 1 ? offset : nil
  }

  public func update(with pageIndex: CGFloat, for bounds: CGRect) {
    // Keep the cell at the center
    let boundsCenter = CGPoint(x: bounds.midX, y: bounds.midY)
    center = boundsCenter

    if let relativeIndexOffset = calculateRelativeIndexOffset(with: pageIndex) {
      self.relativeIndexOffset = relativeIndexOffset
      isHidden = false

      let heightAtRest = frame.height
      let yAtRest = frame.origin.y
      var heightRangeInterpolator: RangeInterpolator
      var yRangeInterpolator: RangeInterpolator

      if relativeIndexOffset == 0 {
        return
      }

      if relativeIndexOffset > 0 {
        // Going to disappear at top
        let yWhenShrunk = yAtRest - spaceWhenShrunk - heightWhenShrunk

        heightRangeInterpolator = RangeInterpolator(
          from: [0.0, 1.0], to: [heightAtRest, heightWhenShrunk])
        yRangeInterpolator = RangeInterpolator(from: [0.0, 1.0], to: [yAtRest, yWhenShrunk])
      } else {
        // Going to appear from bottom
        let yWhenShrunk = yAtRest + heightAtRest

        heightRangeInterpolator = RangeInterpolator(
          from: [-1.0, 0.0], to: [heightWhenShrunk, heightAtRest])
        yRangeInterpolator = RangeInterpolator(from: [-1, 0], to: [yWhenShrunk, yAtRest])
      }

      let heightOptional = heightRangeInterpolator.map(value: relativeIndexOffset)
      let yOptional = yRangeInterpolator.map(value: relativeIndexOffset)
      if let height = heightOptional {
        frame.size.height = height
      }
      if let y = yOptional {
        frame.origin.y = y
      }
    } else {
      isHidden = true
    }
  }
}
