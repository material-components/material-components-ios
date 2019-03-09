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

#import "MDCSimpleTextField+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainerStyleFilled.h"
#import "MDCContainerStyleOutlined.h"

@implementation MDCSimpleTextField (MaterialTheming)

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
      [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  MDCContainedInputViewColorScheme *focusedColorScheme =
      [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  MDCContainedInputViewColorScheme *activatedColorScheme =
      [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateActivated];
  [self setContainedInputViewColorScheming:activatedColorScheme
                                  forState:MDCContainedInputViewStateActivated];

  MDCContainedInputViewColorScheme *erroredColorScheme =
      [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateErrored];
  [self setContainedInputViewColorScheming:erroredColorScheme
                                  forState:MDCContainedInputViewStateErrored];

  MDCContainedInputViewColorScheme *disabledColorScheme =
      [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (void)applyMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingUnderlineLabel.font = mdcTypographyScheming.caption;
  self.trailingUnderlineLabel.font = mdcTypographyScheming.caption;
}

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  MDCContainerStyleOutlined *outlinedStyle = [[MDCContainerStyleOutlined alloc] init];
  MDCSimpleTextFieldOutlinedDensityInformer *densityInformer = [[MDCSimpleTextFieldOutlinedDensityInformer alloc] init];
  outlinedStyle.densityInformer = densityInformer;
  self.containerStyle = outlinedStyle;
  
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
  MDCContainerStyleFilled *filledStyle = [[MDCContainerStyleFilled alloc] init];
  MDCSimpleTextFieldFilledDensityInformer *densityInformer = [[MDCSimpleTextFieldFilledDensityInformer alloc] init];
  filledStyle.densityInformer = densityInformer;
  self.containerStyle = filledStyle;

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
  UIColor *placeholderLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *outlineColor = colorScheming.onSurfaceColor;
  UIColor *clearButtonTintColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];

  switch (containedInputViewState) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      placeholderLabelColor = [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateErrored:
      placeholderLabelColor = colorScheming.errorColor;
      underlineLabelColor = colorScheming.errorColor;
      outlineColor = colorScheming.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      outlineColor = colorScheming.primaryColor;
      placeholderLabelColor = colorScheming.primaryColor;
      break;
    default:
      break;
  }

  MDCContainedInputViewColorSchemeOutlined *simpleTextFieldColorScheme =
      [[MDCContainedInputViewColorSchemeOutlined alloc] init];
  simpleTextFieldColorScheme.textColor = textColor;
  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
  simpleTextFieldColorScheme.outlineColor = outlineColor;
  simpleTextFieldColorScheme.placeholderLabelColor = placeholderLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}

- (MDCContainedInputViewColorSchemeFilled *)
    filledColorSchemeWithMDCColorScheming:(id<MDCColorScheming>)colorScheming
                  containedInputViewState:(MDCContainedInputViewState)containedInputViewState {
  UIColor *textColor = colorScheming.onSurfaceColor;
  UIColor *underlineLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *placeholderLabelColor =
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
      placeholderLabelColor = [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateErrored:
      placeholderLabelColor = colorScheming.errorColor;
      underlineLabelColor = colorScheming.errorColor;
      thinUnderlineFillColor = colorScheming.errorColor;
      thickUnderlineFillColor = colorScheming.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      placeholderLabelColor = colorScheming.primaryColor;
      break;
    default:
      break;
  }

  MDCContainedInputViewColorSchemeFilled *simpleTextFieldColorScheme =
      [[MDCContainedInputViewColorSchemeFilled alloc] init];
  simpleTextFieldColorScheme.textColor = textColor;
  simpleTextFieldColorScheme.filledSublayerFillColor = filledSublayerFillColor;
  simpleTextFieldColorScheme.thickUnderlineFillColor = thickUnderlineFillColor;
  simpleTextFieldColorScheme.thinUnderlineFillColor = thinUnderlineFillColor;
  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
  simpleTextFieldColorScheme.placeholderLabelColor = placeholderLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}

@end

//@interface MDCSimpleTextFieldFilledDensityInformer ()
//@end

@implementation MDCSimpleTextFieldFilledDensityInformer

- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight {
  CGFloat lowestMinY = 4;
  CGFloat highestMinY = 15;
  CGFloat difference = highestMinY - lowestMinY;
  return lowestMinY + (difference * self.verticalDensity);
}

- (CGFloat)contentAreaTopPaddingFloatingPlaceholderWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 3;
  CGFloat maxYAddition = 8;
  CGFloat difference = maxYAddition - minYAddition;
  return floatingPlaceholderMaxY + (minYAddition + (difference * self.verticalDensity));
}

-(CGFloat)contentAreaVerticalPaddingNormalWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 5;
  CGFloat maxYAddition = 12;
  CGFloat difference = maxYAddition - minYAddition;
  return minYAddition + (difference * self.verticalDensity);
}

@end

@implementation MDCSimpleTextFieldOutlinedDensityInformer

- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight {
  return (CGFloat)0 - ((CGFloat)0.5 * floatingPlaceholderHeight);
}

- (CGFloat)contentAreaTopPaddingFloatingPlaceholderWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 3;
  CGFloat maxYAddition = 15;
  CGFloat difference = maxYAddition - minYAddition;
  return floatingPlaceholderMaxY + (minYAddition + (difference * self.verticalDensity));
}

-(CGFloat)contentAreaVerticalPaddingNormalWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  return [self contentAreaTopPaddingFloatingPlaceholderWithFloatingPlaceholderMaxY:floatingPlaceholderMaxY];
}

@end
