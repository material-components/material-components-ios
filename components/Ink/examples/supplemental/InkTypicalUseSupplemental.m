/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "InkTypicalUseSupplemental.h"

#import "MaterialTypography.h"

#import "MDCCatalogStyle.h"

// A set of UILabels in an variety of shapes to tap on.

@interface ExampleShapes ()
@end

@implementation ExampleShapes

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat padding = 8;
    CGFloat bigViewFrameHeight = 130;
    CGRect bigViewFrame =
        CGRectMake(padding, padding, frame.size.width - 2 * padding, bigViewFrameHeight);
    UIView *bigView = [[UIView alloc] initWithFrame:bigViewFrame];
    bigView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bigView];

    CGFloat buttonViewDim = 50;
    CGFloat pseudoButtonViewHeight = 40;
    CGFloat fabPadding = 6;
    CGRect pseudoButtonViewFrame = CGRectMake(
        padding, padding + bigViewFrameHeight + fabPadding + padding,
        frame.size.width - 2 * padding - buttonViewDim - fabPadding * 3, pseudoButtonViewHeight);
    UIView *pseudoButtonView = [[UIView alloc] initWithFrame:pseudoButtonViewFrame];
    pseudoButtonView.backgroundColor = [UIColor whiteColor];
    pseudoButtonView.layer.cornerRadius = 5;
    pseudoButtonView.clipsToBounds = YES;
    [self addSubview:pseudoButtonView];

    CGFloat pseudoFABViewFrameLeft =
        padding + frame.size.width - 2 * padding - buttonViewDim + padding - fabPadding * 2;
    CGRect pseudoFABViewFrame =
        CGRectMake(pseudoFABViewFrameLeft, padding + bigViewFrameHeight + padding,
                   buttonViewDim + fabPadding, buttonViewDim + fabPadding);
    UIView *pseudoFABView = [[UIView alloc] initWithFrame:pseudoFABViewFrame];
    pseudoFABView.backgroundColor = [UIColor whiteColor];
    pseudoFABView.layer.cornerRadius = 28;
    pseudoFABView.clipsToBounds = YES;
    [self addSubview:pseudoFABView];

    self.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  }
  return self;
}

@end

#pragma mark - InkTypicalUseViewController

@implementation InkTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Ink", @"Ink" ];
}

+ (NSString *)catalogDescription {
  return @"The Ink component provides a radial action in the form of a visual ripple of ink"
          " expanding outward from the user's touch.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation InkTypicalUseViewController (Supplemental)

- (void)setupExampleViews {
  self.view.backgroundColor = [MDCCatalogStyle greyColor];

  CGRect boundedTitleLabelFrame =
      CGRectMake(0, self.boundedShapes.frame.size.height, self.boundedShapes.frame.size.width, 24);
  UILabel *boundedTitleLabel = [[UILabel alloc] initWithFrame:boundedTitleLabelFrame];
  boundedTitleLabel.text = @"Bounded";
  boundedTitleLabel.textAlignment = NSTextAlignmentCenter;
  boundedTitleLabel.font = [MDCTypography captionFont];
  boundedTitleLabel.alpha = [MDCTypography captionFontOpacity];
  [self.boundedShapes addSubview:boundedTitleLabel];

  self.unboundedShape.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  self.unboundedShape.backgroundColor = [UIColor whiteColor];

  CGRect unboundedTitleLabelFrame = CGRectMake(0, self.unboundedShape.frame.size.height,
                                               self.unboundedShape.frame.size.width, 36);
  UILabel *unboundedTitleLabel = [[UILabel alloc] initWithFrame:unboundedTitleLabelFrame];
  unboundedTitleLabel.text = @"Unbounded";
  unboundedTitleLabel.textAlignment = NSTextAlignmentCenter;
  unboundedTitleLabel.font = [MDCTypography captionFont];
  unboundedTitleLabel.alpha = [MDCTypography captionFontOpacity];
  [self.unboundedShape addSubview:unboundedTitleLabel];
}

- (void)viewWillLayoutSubviews {
  CGFloat offset = 8;
  CGFloat shapeDimension = 200;
  CGFloat spacing = 16;
  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.boundedShapes.center =
        CGPointMake(self.view.center.x, self.view.center.y - shapeDimension - offset);
    self.unboundedShape.center =
        CGPointMake(self.view.center.x, self.view.center.y + spacing * 2 + offset);
  } else {
    self.boundedShapes.center = CGPointMake(self.view.center.x - shapeDimension / 2 - spacing * 2,
                                            self.view.center.y / 2 + spacing * 2);
    self.unboundedShape.center = CGPointMake(self.view.center.x + shapeDimension / 2 + spacing * 2,
                                             self.view.center.y / 2 + spacing * 2);
  }
}

@end
