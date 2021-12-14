// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCDotBadgeView.h"

#import <QuartzCore/QuartzCore.h>

@implementation MDCDotBadgeView {
  UIColor *_Nullable _borderColor;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor systemRedColor];
    _innerRadius = 4;

    // CALayer's background color will bleed through the outer edges of its border, unless
    // clipsToBounds is enabled *and* there is at least one text layer with a non-zero frame.
    // We don't have a label on this view, so we create an empty CATextLayer and assign it a
    // non-zero frame.
    CALayer *childLayer = [CATextLayer layer];
    childLayer.frame = CGRectMake(0, 0, 1, 1);
    [self.layer addSublayer:childLayer];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
}

- (CGSize)sizeThatFits:(CGSize)size {
  const CGFloat squareDimension = (_innerRadius + self.layer.borderWidth) * 2;
  return CGSizeMake(squareDimension, squareDimension);
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  [self updateBorderColor];
}

- (void)updateBorderColor {
  self.layer.borderColor = _borderColor.CGColor;
}

#pragma mark - Public APIs

- (void)setBorderWidth:(CGFloat)borderWidth {
  self.layer.borderWidth = borderWidth;

  // When a CALayer has both a background color and a border, we need to clip the bounds otherwise
  // the layer's background color will bleed through on the outer edges of the border.
  self.clipsToBounds = borderWidth > 0;

  [self invalidateIntrinsicContentSize];
}

- (CGFloat)borderWidth {
  return self.layer.borderWidth;
}

- (void)setBorderColor:(nullable UIColor *)borderColor {
  _borderColor = borderColor;

  [self updateBorderColor];
}

- (nullable UIColor *)borderColor {
  return _borderColor;
}

@end
