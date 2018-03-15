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

#import "MDCPaddedLabel.h"

static NSString *const MDCPaddedLabelHorizontalPaddingKey = @"MDCPaddedLabelHorizontalPaddingKey";

@implementation MDCPaddedLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _horizontalPadding = (CGFloat)[aDecoder decodeDoubleForKey:MDCPaddedLabelHorizontalPaddingKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeDouble:(double)_horizontalPadding forKey:MDCPaddedLabelHorizontalPaddingKey];
}

#pragma mark - Setters

- (void)setHorizontalPadding:(CGFloat)horizontalPadding {
  _horizontalPadding = horizontalPadding;

  [self invalidateIntrinsicContentSize];
}

#pragma mark - UILabel Overrides

- (void)drawTextInRect:(CGRect)rect {
  [super drawTextInRect:CGRectInset(rect, self.horizontalPadding, 0)];
}

#pragma mark - UIView Overrides

- (CGSize)intrinsicContentSize {
  CGSize size = [super intrinsicContentSize];

  size.width += self.horizontalPadding * 2.f;

  return size;
}

@end
