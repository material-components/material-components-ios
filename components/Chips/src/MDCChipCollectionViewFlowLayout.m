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

/* Left aligns one rect to another with a given padding */
static inline CGRect CGRectLeftAlignToRect(CGRect rect, CGRect staticRect, CGFloat padding) {
  return CGRectMake(CGRectGetMaxX(staticRect) + padding,
                    CGRectGetMinY(rect),
                    CGRectGetWidth(rect),
                    CGRectGetHeight(rect));
}

static inline CGRect CGRectLeftAlign(CGRect rect) {
  return CGRectMake(0,
                    CGRectGetMinY(rect),
                    CGRectGetWidth(rect),
                    CGRectGetHeight(rect));
}

@implementation MDCChipCollectionViewFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
  NSMutableArray *customLayoutAttributes =
      [NSMutableArray arrayWithCapacity:layoutAttributes.count];

  if (layoutAttributes.count > 0) {
    UICollectionViewLayoutAttributes *attrs = [layoutAttributes[0] copy];
    attrs.frame = CGRectLeftAlign(attrs.frame);
    [customLayoutAttributes addObject:attrs];
  }

  for (NSUInteger i = 1; i < layoutAttributes.count; i++) {
    UICollectionViewLayoutAttributes *attrs = [layoutAttributes[i] copy];
    UICollectionViewLayoutAttributes *prevAttrs = customLayoutAttributes[i - 1];

    if (CGRectGetMinY(prevAttrs.frame) == CGRectGetMinY(attrs.frame)) {
      attrs.frame =
          CGRectLeftAlignToRect(attrs.frame, prevAttrs.frame, self.minimumInteritemSpacing);
    } else {
      attrs.frame = CGRectLeftAlign(attrs.frame);
    }
    [customLayoutAttributes addObject:attrs];
  }

  return [customLayoutAttributes copy];
}

- (BOOL)flipsHorizontallyInOppositeLayoutDirection {
  return YES;
}

@end
