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

#import "MDCFilledTextField.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainerStylerFilled.h"
#import "MDCInputTextField+Private.h"

@interface MDCFilledTextFieldPositioningDelegate
    : NSObject <MDCContainedInputViewStylerPositioningDelegate>
@end

@interface MDCFilledTextField ()
@end

@implementation MDCFilledTextField

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCFilledTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFilledTextFieldInit];
  }
  return self;
}

- (void)commonMDCFilledTextFieldInit {
  MDCFilledTextFieldPositioningDelegate *positioningDelegate =
      [[MDCFilledTextFieldPositioningDelegate alloc] init];
  MDCContainerStylerFilled *filledStyle =
      [[MDCContainerStylerFilled alloc] initWithPositioningDelegate:positioningDelegate];
  self.containerStyler = filledStyle;
}

- (UIColor *)filledBackgroundColor {
  id<MDCContainedInputViewColorScheming> normalScheme =
      [self containedInputViewColorSchemingForState:MDCContainedInputViewStateNormal];
  if ([normalScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)normalScheme;
    return filledColorScheme.filledSublayerFillColor;
  }
  return nil;
}

- (void)setFilledBackgroundColor:(UIColor *)filledBackgroundColor {
  id<MDCContainedInputViewColorScheming> normalScheme =
      [self containedInputViewColorSchemingForState:MDCContainedInputViewStateNormal];
  if ([normalScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)normalScheme;
    filledColorScheme.filledSublayerFillColor = filledBackgroundColor;
  }
}

- (UIColor *)underlineColorNormal {
  id<MDCContainedInputViewColorScheming> normalScheme =
      [self containedInputViewColorSchemingForState:MDCContainedInputViewStateNormal];
  if ([normalScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)normalScheme;
    return filledColorScheme.thinUnderlineFillColor;
  }
  return nil;
}

- (void)setUnderlineColorNormal:(UIColor *)underlineColorNormal {
  id<MDCContainedInputViewColorScheming> normalScheme =
      [self containedInputViewColorSchemingForState:MDCContainedInputViewStateNormal];
  if ([normalScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)normalScheme;
    filledColorScheme.thinUnderlineFillColor = underlineColorNormal;
  }
}

- (UIColor *)underlineColorDisabled {
  id<MDCContainedInputViewColorScheming> disabledScheme =
  [self containedInputViewColorSchemingForState:MDCContainedInputViewStateDisabled];
  if ([disabledScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)disabledScheme;
    return filledColorScheme.thinUnderlineFillColor;
  }
  return nil;
}

- (void)setUnderlineColorDisabled:(UIColor *)underlineColorDisabled {
  id<MDCContainedInputViewColorScheming> disabledScheme =
  [self containedInputViewColorSchemingForState:MDCContainedInputViewStateDisabled];
  if ([disabledScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)disabledScheme;
    filledColorScheme.thinUnderlineFillColor = underlineColorDisabled;
  }
}

- (UIColor *)underlineColorEditing {
  id<MDCContainedInputViewColorScheming> normalScheme =
  [self containedInputViewColorSchemingForState:MDCContainedInputViewStateFocused];
  if ([normalScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)normalScheme;
    return filledColorScheme.thickUnderlineFillColor;
  }
  return nil;
}

- (void)setUnderlineColorEditing:(UIColor *)underlineColorEditing {
  id<MDCContainedInputViewColorScheming> normalScheme =
  [self containedInputViewColorSchemingForState:MDCContainedInputViewStateFocused];
  if ([normalScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme = (MDCContainedInputViewColorSchemeFilled *)normalScheme;
    filledColorScheme.thickUnderlineFillColor = underlineColorEditing;
  }
}

@end

@implementation MDCFilledTextFieldPositioningDelegate
@synthesize verticalDensity = _verticalDensity;

- (CGFloat)floatingLabelMinYWithFloatingLabelHeight:(CGFloat)floatingPlaceholderHeight {
  CGFloat lowestMinY = 4;
  CGFloat highestMinY = 10;
  CGFloat difference = highestMinY - lowestMinY;
  return lowestMinY + (difference * (1 - self.verticalDensity));
}

- (CGFloat)contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:
    (CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 3;
  CGFloat maxYAddition = 8;
  CGFloat difference = maxYAddition - minYAddition;
  return floatingPlaceholderMaxY + (minYAddition + (difference * (1 - self.verticalDensity)));
}

- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingLabelMaxY:(CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 5;
  CGFloat maxYAddition = 8;
  CGFloat difference = maxYAddition - minYAddition;
  return minYAddition + (difference * (1 - self.verticalDensity));
}

@end
