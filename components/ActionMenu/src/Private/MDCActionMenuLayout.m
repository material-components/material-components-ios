/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCActionMenuLayout.h"

@implementation MDCActionMenuLayout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes *attribute =
      [super layoutAttributesForItemAtIndexPath:indexPath];
  UICollectionViewLayoutAttributes *copiedAttribute = [attribute copy];
  [self updateLayoutAttribute:copiedAttribute];
  return copiedAttribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
  NSMutableArray *copiedUpdatedAttributes = [NSMutableArray arrayWithCapacity:attributes.count];
  for (UICollectionViewLayoutAttributes *attribute in attributes) {
    UICollectionViewLayoutAttributes *copiedAttribute = [attribute copy];
    [self updateLayoutAttribute:copiedAttribute];
    [copiedUpdatedAttributes addObject:copiedAttribute];
  }
  return copiedUpdatedAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  CGRect oldBounds = self.collectionView.bounds;
  if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
    [self invalidateLayout];
    return YES;
  }
  return NO;
}

#pragma mark - Private

- (void)updateLayoutAttribute:(UICollectionViewLayoutAttributes *)attribute {
  CGSize contentSize = self.collectionViewContentSize;
  CGRect frame = attribute.frame;
  frame.origin.x = contentSize.width - frame.origin.x - frame.size.width;
  frame.origin.y = contentSize.height - frame.origin.y - frame.size.height;
  attribute.frame = frame;
}

@end
