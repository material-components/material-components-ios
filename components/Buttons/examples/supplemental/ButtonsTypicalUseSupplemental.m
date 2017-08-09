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

#import "ButtonsTypicalUseSupplemental.h"
#import "MaterialButtons.h"
#import "MaterialMath.h"
#import "MaterialTypography.h"

#pragma mark - ButtonsTypicalUseViewController

@implementation ButtonsTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Buttons", @"Buttons" ];
}

+ (NSString *)catalogDescription {
  return @"Buttons is a collection of Material Design buttons, including a flat button, a raised"
          " button and a floating action button.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation ButtonsTypicalUseViewController (Supplemental)

- (UILabel *)addLabelWithText:(NSString *)text {
  UILabel *label = [[UILabel alloc] init];
  label.text = text;
  label.font = [MDCTypography captionFont];
  label.alpha = [MDCTypography captionFontOpacity];
  [label sizeToFit];
  label.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:label];

  return label;
}

- (void)setupExampleViews {
  UILabel *raisedButtonLabel = [self addLabelWithText:@"Raised"];
  UILabel *disabledRaisedButtonLabel = [self addLabelWithText:@"Disabled Raised"];
  UILabel *flatButtonLabel = [self addLabelWithText:@"Flat"];
  UILabel *disabledFlatButtonLabel = [self addLabelWithText:@"Disabled Flat"];
  UILabel *strokedButtonLabel = [self addLabelWithText:@"Stroked"];
  UILabel *disabledStrokedButtonLabel = [self addLabelWithText:@"Disabled Stroked"];
  UILabel *floatingButtonLabel = [self addLabelWithText:@"Floating Action"];

  self.labels = @[
    raisedButtonLabel,
    disabledRaisedButtonLabel,
    flatButtonLabel,
    disabledFlatButtonLabel,
    strokedButtonLabel,
    disabledStrokedButtonLabel,
    floatingButtonLabel
  ];
}

- (void)viewWillLayoutSubviews {
  CGFloat centerX = CGRectGetMidX(self.view.frame);

  [self layoutButtonsInRange:NSMakeRange(0, self.buttons.count) around:centerX];

  UIView *lastButton = self.buttons.lastObject;
  if (CGRectGetMaxY(lastButton.frame) > CGRectGetHeight(self.view.frame)) {
    CGFloat colOffset = CGRectGetWidth(self.view.frame) / 4;
    NSUInteger splitIndex = ceil(self.buttons.count / 2);

    if (((MDCButton*)self.buttons[splitIndex - 1]).enabled) {
      splitIndex++;
    }

    [self layoutButtonsInRange:NSMakeRange(0, splitIndex)
                        around:centerX - colOffset];
    [self layoutButtonsInRange:NSMakeRange(splitIndex, self.buttons.count - splitIndex)
                        around:centerX + colOffset];
  }
}

- (void)layoutButtonsInRange:(NSRange)range around:(CGFloat)centerX {
  CGFloat heightSum = 0;
  CGFloat viewHeight = CGRectGetHeight(self.view.frame);

  for (NSUInteger i = range.location; i < NSMaxRange(range); i++) {
    MDCButton *button = self.buttons[i];
    UILabel *label = self.labels[i];

    button.frame = (CGRect) {
      CGPointMake(centerX + 20, heightSum),
      button.frame.size
    };
    CGFloat labelOffset = (button.frame.size.height - label.frame.size.height) / 2;
    label.frame = (CGRect) {
      CGPointMake(centerX - label.frame.size.width - 20, heightSum + labelOffset),
      label.frame.size
    };

    heightSum += button.frame.size.height;
    if (i < self.buttons.count - 1) {
      heightSum += button.enabled ? 24 : 36;
    }
  }

  MDCButton *lastButton = self.buttons[NSMaxRange(range) - 1];
  CGFloat verticalCenterY = (viewHeight - CGRectGetMaxY(lastButton.frame)) / 2;
  for (NSInteger i = range.location; i < NSMaxRange(range); i++) {
    MDCButton *button = self.buttons[i];
    UILabel *label = self.labels[i];

    button.frame = CGRectOffset(button.frame, 0, verticalCenterY);
    label.frame = MDCRectAlignToScale(CGRectOffset(label.frame, 0, verticalCenterY),
                                      [UIScreen mainScreen].scale);
  }
}

@end
