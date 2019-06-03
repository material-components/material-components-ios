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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"

@implementation MDCContainedInputViewColorScheme

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCContainedInputViewColorSchemeInit];
  }
  return self;
}

- (void)commonMDCContainedInputViewColorSchemeInit {
  UIColor *textColor = [UIColor blackColor];
  UIColor *underlineLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *errorColor = [UIColor redColor];
  UIColor *clearButtonTintColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.20];
  self.textColor = textColor;
  self.underlineLabelColor = underlineLabelColor;
  self.floatingLabelColor = floatingLabelColor;
  self.placeholderColor = floatingLabelColor;
  self.clearButtonTintColor = clearButtonTintColor;
  self.errorColor = errorColor;
}

@end

@implementation MDCContainerStylerBase
@synthesize positioningDelegate = _positioningDelegate;

- (instancetype)initWithPositioningDelegate:
    (id<MDCContainedInputViewStylerPositioningDelegate>)positioningDelegate {
  self = [super init];
  if (self) {
    _positioningDelegate = positioningDelegate;
  }
  return self;
}

- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state {
  MDCContainedInputViewColorScheme *colorScheme = [[MDCContainedInputViewColorScheme alloc] init];

  UIColor *floatingLabelColor = colorScheme.floatingLabelColor;
  UIColor *underlineLabelColor = colorScheme.underlineLabelColor;
  UIColor *textColor = colorScheme.textColor;

  switch (state) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateDisabled:
      floatingLabelColor = [floatingLabelColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateFocused:
      floatingLabelColor = [UIColor blackColor];
      break;
    default:
      break;
  }

  colorScheme.textColor = textColor;
  colorScheme.underlineLabelColor = underlineLabelColor;
  colorScheme.floatingLabelColor = floatingLabelColor;

  return colorScheme;
}

- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)inputView
    withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme {
}

- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView {
}

- (CGFloat)floatingFontSizeScaleFactor {
  return 0.75;
}

@end

@implementation MDCContainerStylerBasePositioningDelegate
@synthesize verticalDensity = _verticalDensity;

- (instancetype)init {
  self = [super init];
  if (self) {
    self.verticalDensity = 0.5;
  }
  return self;
}

- (CGFloat)floatingLabelMinYWithFloatingLabelHeight:(CGFloat)floatingPlaceholderHeight {
  CGFloat lowestMinY = 4;
  CGFloat highestMinY = 10;
  CGFloat difference = highestMinY - lowestMinY;
  return lowestMinY + (difference * (1 - self.verticalDensity));
}

- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingLabelMaxY:(CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 5;
  CGFloat maxYAddition = 8;
  CGFloat difference = maxYAddition - minYAddition;
  return minYAddition + (difference * (1 - self.verticalDensity));
}

- (CGFloat)contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:
(CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 3;
  CGFloat maxYAddition = 8;
  CGFloat difference = maxYAddition - minYAddition;
  return floatingPlaceholderMaxY + (minYAddition + (difference * (1 - self.verticalDensity)));
}

@end

