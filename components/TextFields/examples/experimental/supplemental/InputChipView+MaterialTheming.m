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

#import "InputChipView+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainerStylerFilled.h"
#import "MDCContainerStylerOutlined.h"

@implementation InputChipView (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographySchemeWith:containerScheme];
  [self applyColorSchemeWith:containerScheme];
}

- (void)applyTypographySchemeWith:(id<MDCContainerScheming>)containerScheme {
  id<MDCTypographyScheming> mdcTypographyScheming = containerScheme.typographyScheme;
  if (!mdcTypographyScheming) {
    mdcTypographyScheming =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyMDCTypographyScheming:mdcTypographyScheming];
}

- (void)applyColorSchemeWith:(id<MDCContainerScheming>)containerScheme {
  id<MDCColorScheming> mdcColorScheme = containerScheme.colorScheme;
  if (!mdcColorScheme) {
    mdcColorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyMDCColorScheming:mdcColorScheme];
}

- (void)applyMDCColorScheming:(id<MDCColorScheming>)mdcColorScheming {
  MDCContainedInputViewColorScheme *normalColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  MDCContainedInputViewColorScheme *focusedColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  MDCContainedInputViewColorScheme *activatedColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateActivated];
  [self setContainedInputViewColorScheming:activatedColorScheme
                                  forState:MDCContainedInputViewStateActivated];

  MDCContainedInputViewColorScheme *erroredColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateErrored];
  [self setContainedInputViewColorScheming:erroredColorScheme
                                  forState:MDCContainedInputViewStateErrored];

  MDCContainedInputViewColorScheme *disabledColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (void)applyMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.textField.font = mdcTypographyScheming.subtitle1;
  self.leadingUnderlineLabel.font = mdcTypographyScheming.caption;
  self.trailingUnderlineLabel.font = mdcTypographyScheming.caption;
}

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  InputChipViewOutlinedPositioningDelegate *positioningDelegate =
      [[InputChipViewOutlinedPositioningDelegate alloc] init];
  MDCContainerStylerOutlined *outlinedStyle =
      [[MDCContainerStylerOutlined alloc] initWithPositioningDelegate:positioningDelegate];
  self.containerStyler = outlinedStyle;

  [self applyTypographySchemeWith:containerScheme];

  id<MDCColorScheming> mdcColorScheming =
      containerScheme.colorScheme ?: [[MDCSemanticColorScheme alloc] init];

  MDCContainedInputViewColorSchemeOutlined *normalColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                            containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  MDCContainedInputViewColorSchemeOutlined *focusedColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                            containedInputViewState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  MDCContainedInputViewColorSchemeOutlined *activatedColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                            containedInputViewState:MDCContainedInputViewStateActivated];
  [self setContainedInputViewColorScheming:activatedColorScheme
                                  forState:MDCContainedInputViewStateActivated];

  MDCContainedInputViewColorSchemeOutlined *erroredColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                            containedInputViewState:MDCContainedInputViewStateErrored];
  [self setContainedInputViewColorScheming:erroredColorScheme
                                  forState:MDCContainedInputViewStateErrored];

  MDCContainedInputViewColorSchemeOutlined *disabledColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                            containedInputViewState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (void)applyFilledThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  InputChipViewFilledPositioningDelegate *positioningDelegate =
      [[InputChipViewFilledPositioningDelegate alloc] init];
  MDCContainerStylerFilled *filledStyle =
      [[MDCContainerStylerFilled alloc] initWithPositioningDelegate:positioningDelegate];
  self.containerStyler = filledStyle;

  [self applyTypographySchemeWith:containerScheme];

  id<MDCColorScheming> mdcColorScheming =
      containerScheme.colorScheme ?: [[MDCSemanticColorScheme alloc] init];

  MDCContainedInputViewColorSchemeFilled *normalColorScheme =
      [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                          containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  MDCContainedInputViewColorSchemeFilled *focusedColorScheme =
      [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                          containedInputViewState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  MDCContainedInputViewColorSchemeFilled *activatedColorScheme =
      [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                          containedInputViewState:MDCContainedInputViewStateActivated];
  [self setContainedInputViewColorScheming:activatedColorScheme
                                  forState:MDCContainedInputViewStateActivated];

  MDCContainedInputViewColorSchemeFilled *erroredColorScheme =
      [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                          containedInputViewState:MDCContainedInputViewStateErrored];
  [self setContainedInputViewColorScheming:erroredColorScheme
                                  forState:MDCContainedInputViewStateErrored];

  MDCContainedInputViewColorSchemeFilled *disabledColorScheme =
      [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                          containedInputViewState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (MDCContainedInputViewColorSchemeOutlined *)
    outlinedColorSchemeWithMDCColorScheming:(id<MDCColorScheming>)colorScheming
                    containedInputViewState:(MDCContainedInputViewState)containedInputViewState {
  UIColor *textColor = colorScheming.onSurfaceColor;
  UIColor *underlineLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *placeholderColor = floatingLabelColor;
  UIColor *outlineColor = colorScheming.onSurfaceColor;
  UIColor *clearButtonTintColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];

  switch (containedInputViewState) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      floatingLabelColor = [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateErrored:
      floatingLabelColor = colorScheming.errorColor;
      underlineLabelColor = colorScheming.errorColor;
      outlineColor = colorScheming.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      outlineColor = colorScheming.primaryColor;
      floatingLabelColor = colorScheming.primaryColor;
      break;
    default:
      break;
  }

  MDCContainedInputViewColorSchemeOutlined *colorScheme =
      [[MDCContainedInputViewColorSchemeOutlined alloc] init];
  colorScheme.textColor = textColor;
  colorScheme.underlineLabelColor = underlineLabelColor;
  colorScheme.outlineColor = outlineColor;
  colorScheme.floatingLabelColor = floatingLabelColor;
  colorScheme.clearButtonTintColor = clearButtonTintColor;
  colorScheme.placeholderColor = placeholderColor;
  return colorScheme;
}

- (MDCContainedInputViewColorSchemeFilled *)
    filledColorSchemeWithMDCColorScheming:(id<MDCColorScheming>)colorScheming
                  containedInputViewState:(MDCContainedInputViewState)containedInputViewState {
  UIColor *textColor = colorScheming.onSurfaceColor;
  UIColor *underlineLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *thinUnderlineFillColor = colorScheming.onBackgroundColor;
  UIColor *thickUnderlineFillColor = colorScheming.primaryColor;
  UIColor *filledSublayerFillColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.15];
  UIColor *clearButtonTintColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];

  switch (containedInputViewState) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      floatingLabelColor = [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateErrored:
      floatingLabelColor = colorScheming.errorColor;
      underlineLabelColor = colorScheming.errorColor;
      thinUnderlineFillColor = colorScheming.errorColor;
      thickUnderlineFillColor = colorScheming.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      floatingLabelColor = colorScheming.primaryColor;
      break;
    default:
      break;
  }

  MDCContainedInputViewColorSchemeFilled *colorScheme =
      [[MDCContainedInputViewColorSchemeFilled alloc] init];
  colorScheme.textColor = textColor;
  colorScheme.filledSublayerFillColor = filledSublayerFillColor;
  colorScheme.thickUnderlineFillColor = thickUnderlineFillColor;
  colorScheme.thinUnderlineFillColor = thinUnderlineFillColor;
  colorScheme.underlineLabelColor = underlineLabelColor;
  colorScheme.floatingLabelColor = floatingLabelColor;
  colorScheme.clearButtonTintColor = clearButtonTintColor;
  return colorScheme;
}

@end

@implementation InputChipViewFilledPositioningDelegate
@synthesize verticalDensity = _verticalDensity;

- (CGFloat)floatingLabelMinYWithFloatingLabelHeight:(CGFloat)floatingPlaceholderHeight {
  CGFloat lowestMinY = 4;
  CGFloat highestMinY = 15;
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
  CGFloat minYAddition = 10;
  CGFloat maxYAddition = 15;
  CGFloat difference = maxYAddition - minYAddition;
  return minYAddition + (difference * (1 - self.verticalDensity));
}

@end

@implementation InputChipViewOutlinedPositioningDelegate
@synthesize verticalDensity = _verticalDensity;

- (CGFloat)floatingLabelMinYWithFloatingLabelHeight:(CGFloat)floatingPlaceholderHeight {
  return (CGFloat)0 - ((CGFloat)0.5 * floatingPlaceholderHeight);
}

- (CGFloat)contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:
    (CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 3;
  CGFloat maxYAddition = 10;
  CGFloat difference = maxYAddition - minYAddition;
  return floatingPlaceholderMaxY + (minYAddition + (difference * (1 - self.verticalDensity)));
}

- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingLabelMaxY:(CGFloat)floatingPlaceholderMaxY {
  return [self contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:floatingPlaceholderMaxY];
}

@end
