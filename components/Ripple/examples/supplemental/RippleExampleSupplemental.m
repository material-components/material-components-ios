// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import "RippleExampleSupplemental.h"

@implementation RippleSurfaces

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat padding = 8;
    CGFloat bigViewFrameHeight = 130;
    CGRect bigViewFrame =
        CGRectMake(padding, padding, CGRectGetWidth(frame) - 2 * padding, bigViewFrameHeight);
    UIView *bigView = [[UIView alloc] initWithFrame:bigViewFrame];
    bigView.backgroundColor = UIColor.whiteColor;
    bigView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    bigView.layer.borderWidth = (CGFloat)0.5;
    bigView.isAccessibilityElement = YES;
    bigView.accessibilityLabel = @"Big view with ripple";
    bigView.accessibilityTraits = UIAccessibilityTraitButton;
    [self addSubview:bigView];

    CGFloat buttonViewDim = 50;
    CGFloat pseudoButtonViewHeight = 40;
    CGFloat fabPadding = 6;
    CGRect pseudoButtonViewFrame = CGRectMake(
        padding, padding + bigViewFrameHeight + fabPadding + padding,
        frame.size.width - 2 * padding - buttonViewDim - fabPadding * 3, pseudoButtonViewHeight);
    UIView *pseudoButtonView = [[UIView alloc] initWithFrame:pseudoButtonViewFrame];
    pseudoButtonView.backgroundColor = UIColor.whiteColor;
    pseudoButtonView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    pseudoButtonView.layer.borderWidth = (CGFloat)0.5;
    pseudoButtonView.layer.cornerRadius = 5;
    pseudoButtonView.clipsToBounds = YES;
    pseudoButtonView.isAccessibilityElement = YES;
    pseudoButtonView.accessibilityLabel = @"Small view with ripple";
    pseudoButtonView.accessibilityTraits = UIAccessibilityTraitButton;
    [self addSubview:pseudoButtonView];

    CGFloat pseudoFABViewFrameLeft =
        padding + CGRectGetWidth(frame) - 2 * padding - buttonViewDim + padding - fabPadding * 2;
    CGRect pseudoFABViewFrame =
        CGRectMake(pseudoFABViewFrameLeft, padding + bigViewFrameHeight + padding,
                   buttonViewDim + fabPadding, buttonViewDim + fabPadding);
    UIView *pseudoFABView = [[UIView alloc] initWithFrame:pseudoFABViewFrame];
    pseudoFABView.backgroundColor = UIColor.whiteColor;
    pseudoFABView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    pseudoFABView.layer.borderWidth = (CGFloat)0.5;
    pseudoFABView.layer.cornerRadius = 28;
    pseudoFABView.clipsToBounds = YES;
    pseudoFABView.isAccessibilityElement = YES;
    pseudoFABView.accessibilityLabel = @"Small circular view with ripple";
    pseudoFABView.accessibilityTraits = UIAccessibilityTraitButton;
    [self addSubview:pseudoFABView];

    self.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  }
  return self;
}

@end

#pragma mark - RippleTypicalUseExample

@implementation RippleTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Ripple", @"Ripple" ],
    @"description" : @"The Ripple provides a radial action in the form of a visual ripple "
                     @"expanding outward from the user's touch.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end

@implementation RippleTypicalUseExample (Supplemental)

- (void)viewWillLayoutSubviews {
  UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
  self.containerView.frame =
      CGRectMake(safeAreaInsets.left, safeAreaInsets.top,
                 CGRectGetWidth(self.view.frame) - safeAreaInsets.left - safeAreaInsets.right,
                 CGRectGetHeight(self.view.frame) - safeAreaInsets.top - safeAreaInsets.bottom);

  CGFloat offset = 8;
  CGFloat shapeDimension = 200;
  CGFloat spacing = 16;
  if (CGRectGetHeight(self.containerView.frame) > CGRectGetWidth(self.containerView.frame)) {
    self.surfaces.center = CGPointMake(self.containerView.center.x,
                                       self.containerView.center.y - shapeDimension - offset);
  } else {
    self.surfaces.center =
        CGPointMake(self.containerView.center.x - shapeDimension / 2 - spacing * 2,
                    self.containerView.center.y / 2 + spacing * 2);
  }
}

@end
