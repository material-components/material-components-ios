// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "ButtonsTypicalUseSupplemental.h"
#import "MaterialButtons.h"
#import "MaterialMath.h"
#import "MaterialTypography.h"

static const CGFloat kViewOffsetToCenter = 20;

#pragma mark - ButtonsTypicalUseViewController

@implementation ButtonsTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Buttons", @"Buttons" ],
    @"description" : @"Buttons allow users to take actions, and make choices, with a single tap."
                     @"\nA floating action button (FAB) represents the primary action of a screen.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end

@implementation ButtonsShapesExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Buttons", @"Shaped Buttons" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end

@implementation ButtonsTypicalUseViewController

- (UILabel *)addLabelWithText:(NSString *)text {
  UILabel *label = [[UILabel alloc] init];
  label.text = text;
  label.font = [MDCTypography captionFont];
  label.alpha = [MDCTypography captionFontOpacity];
  [label sizeToFit];
  [self.view addSubview:label];

  return label;
}

- (CGRect)contentBounds {
  CGRect bounds = self.view.bounds;
  __block CGRect contentBounds = CGRectZero;

  void (^preiOS11Behavior)(void) = ^{
    CGRect safeAreaBounds;
    CGRectDivide(bounds, &safeAreaBounds, &contentBounds, self.topLayoutGuide.length,
                 CGRectMinYEdge);
  };
  if (@available(iOS 11.0, *)) {
    UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
    contentBounds = UIEdgeInsetsInsetRect(bounds, safeAreaInsets);
  } else {
    preiOS11Behavior();
  }

  return contentBounds;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  CGRect contentBounds = [self contentBounds];
  CGFloat centerX = CGRectGetMidX(contentBounds);
  [self layoutButtonsInRange:NSMakeRange(0, self.buttons.count) around:centerX];

  UIView *lastButton = self.buttons.lastObject;
  CGFloat lastButtonMaxY = (CGRectGetHeight(lastButton.bounds) / 2) + lastButton.center.y;
  if (lastButtonMaxY > CGRectGetMaxY(contentBounds)) {
    CGFloat columnOffset = CGRectGetWidth(contentBounds) / 4;
    NSUInteger splitIndex = (NSUInteger)ceil(self.buttons.count / 2);

    if (((MDCButton *)self.buttons[splitIndex - 1]).enabled) {
      splitIndex++;
    }

    [self layoutButtonsInRange:NSMakeRange(0, splitIndex) around:centerX - columnOffset];
    [self layoutButtonsInRange:NSMakeRange(splitIndex, self.buttons.count - splitIndex)
                        around:centerX + columnOffset];
  }
}

- (void)layoutButtonsInRange:(NSRange)range around:(CGFloat)centerX {
  CGFloat heightSum = 0;
  CGRect contentBounds = [self contentBounds];
  CGFloat viewHeight = CGRectGetHeight(contentBounds);

  // Calculate the overall height of the labels + buttons
  for (NSUInteger i = range.location; i < NSMaxRange(range); i++) {
    MDCButton *button = self.buttons[i];
    UILabel *label = self.labels[i];

    button.center = CGPointMake(centerX + kViewOffsetToCenter + (CGRectGetWidth(button.bounds) / 2),
                                heightSum + (CGRectGetHeight(button.bounds) / 2));
    CGFloat labelOffset = (CGRectGetHeight(button.bounds) - CGRectGetHeight(label.bounds)) / 2;
    label.center = CGPointMake(centerX - (CGRectGetWidth(label.bounds) / 2) - kViewOffsetToCenter,
                               heightSum + labelOffset + (CGRectGetHeight(label.bounds) / 2));

    // Pin the label's frame to pixel boundaries to reduce snapshot flakiness due to inaccuracies in
    // floating point rounding behavior on the GPU when taking snapshots.
    CGRect labelFrame = label.frame;
    labelFrame.origin.x = floor(labelFrame.origin.x);
    labelFrame.origin.y = floor(labelFrame.origin.y);
    label.frame = labelFrame;

    heightSum += CGRectGetHeight(button.bounds);
    if (i < self.buttons.count - 1) {
      heightSum += button.enabled ? 24 : 36;
    }
  }

  // Center the labels and buttons within the content bounds
  MDCButton *lastButton = self.buttons[NSMaxRange(range) - 1];
  CGFloat verticalCenterY =
      (viewHeight - (lastButton.center.y + (CGRectGetHeight(lastButton.bounds) / 2))) / 2;
  verticalCenterY += CGRectGetMinY(contentBounds);
  for (NSUInteger i = range.location; i < NSMaxRange(range); i++) {
    MDCButton *button = self.buttons[i];
    UILabel *label = self.labels[i];
    button.center = MDCRoundCenterWithBoundsAndScale(
        CGPointMake(button.center.x, button.center.y + verticalCenterY), button.bounds,
        self.view.window.screen.scale);

    CGFloat labelWidth = CGRectGetWidth(label.bounds);
    CGFloat labelHeight = CGRectGetHeight(label.bounds);
    CGPoint labelOrigin = CGPointMake(label.center.x - (labelWidth / 2),
                                      label.center.y - (labelHeight / 2) + verticalCenterY);
    CGRect alignedFrame = MDCRectAlignToScale(
        (CGRect){labelOrigin, CGSizeMake(labelWidth, labelHeight)}, [UIScreen mainScreen].scale);
    label.center = CGPointMake(CGRectGetMidX(alignedFrame), CGRectGetMidY(alignedFrame));
    label.bounds = (CGRect){label.bounds.origin, alignedFrame.size};

    // Adjust the label's center and bounds so it doesn't exceed the safe area on the left side of
    // the screen, the situation that button exceeds the safe area on the right side is not
    // considered yet
    CGFloat labelOriginX = label.center.x - label.bounds.size.width / 2;
    if (labelOriginX < contentBounds.origin.x) {
      CGFloat labelXOffset = contentBounds.origin.x - labelOriginX;
      CGFloat maxLabelWidth = label.bounds.size.width - labelXOffset;
      label.numberOfLines = 0;
      CGSize newSizeToFitLabel = [label sizeThatFits:CGSizeMake(maxLabelWidth, CGFLOAT_MAX)];
      label.center =
          CGPointMake(centerX - newSizeToFitLabel.width / 2 - kViewOffsetToCenter, label.center.y);
      label.bounds = CGRectMake(label.center.x - newSizeToFitLabel.width / 2, label.center.y,
                                newSizeToFitLabel.width, newSizeToFitLabel.height);
      label.textAlignment = NSTextAlignmentRight;
    }
  }
}

@end
