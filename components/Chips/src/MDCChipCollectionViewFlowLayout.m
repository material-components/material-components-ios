// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
#import <CoreGraphics/CoreGraphics.h>

#import "MDCChipCollectionViewFlowLayout.h"

@implementation MDCChipCollectionViewFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
  NSMutableArray *customLayoutAttributes =
      [NSMutableArray arrayWithCapacity:layoutAttributes.count];

  // Left-align cells
  UICollectionViewLayoutAttributes *prevAttrs;
  for (UICollectionViewLayoutAttributes *attrs in layoutAttributes) {
    UICollectionViewLayoutAttributes *newAttrs = [attrs copy];
    if (newAttrs.representedElementCategory == UICollectionElementCategoryCell) {
      // If the attributes are for a cell that isn't on the same line as the previous cell, set the
      // x origin of the frame to 0. Otherwise, align the frame to the right end of the previous
      // frame (accounting for minimumInteritemSpacing).
      CGRect frame = newAttrs.frame;
      BOOL isNewLine = CGRectGetMinY(newAttrs.frame) != CGRectGetMinY(prevAttrs.frame);
      if (!prevAttrs || isNewLine) {
        frame.origin.x = self.sectionInset.left;
      } else {
        frame.origin.x = CGRectGetMaxX(prevAttrs.frame) + self.minimumInteritemSpacing;
      }
      newAttrs.frame = frame;
      prevAttrs = newAttrs;
    }
    [customLayoutAttributes addObject:newAttrs];
  }

  return [customLayoutAttributes copy];
}

- (BOOL)flipsHorizontallyInOppositeLayoutDirection {
  return YES;
}

@end
