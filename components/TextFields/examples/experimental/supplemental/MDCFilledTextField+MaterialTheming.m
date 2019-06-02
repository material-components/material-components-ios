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

#import "MDCFilledTextField+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainerStylerFilled.h"
#import "MDCBaseTextField+Private.h"

@implementation MDCFilledTextField (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:[self typographySchemeWithContainerScheme:containerScheme]];
  [self applyDefaultColorScheme:[self colorSchemeWithContainerScheme:containerScheme]];
}

- (void)applyErrorThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:[self typographySchemeWithContainerScheme:containerScheme]];
  [self applyErrorColorScheme:[self colorSchemeWithContainerScheme:containerScheme]];
}

- (id<MDCColorScheming>)colorSchemeWithContainerScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  id<MDCColorScheming> mdcColorScheme = containerScheme.colorScheme;
  if (!mdcColorScheme) {
    mdcColorScheme =
    [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  return mdcColorScheme;
}

- (id<MDCTypographyScheming>)typographySchemeWithContainerScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  id<MDCTypographyScheming> mdcTypographyScheme = containerScheme.typographyScheme;
  if (!mdcTypographyScheme) {
    mdcTypographyScheme =
    [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
  }
  return mdcTypographyScheme;
}

- (void)applyTypographyScheme:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingAssistiveLabel.font = mdcTypographyScheming.caption;
  self.trailingAssistiveLabel.font = mdcTypographyScheming.caption;
}

- (void)applyMDCColorScheming:(id<MDCColorScheming>)mdcColorScheming {
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

  MDCContainedInputViewColorSchemeFilled *disabledColorScheme =
      [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                          containedInputViewState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (MDCContainedInputViewColorSchemeFilled *)
    filledColorSchemeWithMDCColorScheming:(id<MDCColorScheming>)colorScheming
                  containedInputViewState:(MDCContainedInputViewState)containedInputViewState {
  UIColor *textColor = colorScheming.onSurfaceColor;
  UIColor *assistiveLabelColor =
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
    case MDCContainedInputViewStateDisabled:
      floatingLabelColor = [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateFocused:
      floatingLabelColor = colorScheming.primaryColor;
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
  simpleTextFieldColorScheme.underlineLabelColor = assistiveLabelColor;
  simpleTextFieldColorScheme.floatingLabelColor = floatingLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}

- (void)applyDefaultColorScheme:(id<MDCColorScheming>)colorScheme {
  UIColor *textColor = colorScheme.onSurfaceColor;
  UIColor *assistiveLabelColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *labelColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *labelColorDisabled =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
  UIColor *labelColorFocused =
      colorScheme.primaryColor;
  
  UIColor *thinUnderlineFillColor = colorScheme.onBackgroundColor;
  UIColor *thickUnderlineFillColor = colorScheme.primaryColor;
  
  UIColor *filledSublayerFillColor =
     [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.15];
//  UIColor *clearButtonTintColor =
//  [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];
  // TODO: Figure out what to do with this. There's no stateful API for it, it only exists on the color view model
  
  [self setLabelColor:labelColor forState:UIControlStateNormal];
  [self setLabelColor:labelColorFocused forState:UIControlStateEditing];
  [self setLabelColor:labelColorDisabled forState:UIControlStateDisabled];
  [self setTextColor:textColor forState:UIControlStateNormal];
  [self setTextColor:textColor forState:UIControlStateEditing];
  [self setTextColor:textColor forState:UIControlStateDisabled];
  [self setUnderlineColor:thinUnderlineFillColor forState:UIControlStateNormal];
  [self setUnderlineColor:thickUnderlineFillColor forState:UIControlStateEditing];
  [self setUnderlineColor:thinUnderlineFillColor forState:UIControlStateDisabled];
  [self setFilledBackgroundColor:filledSublayerFillColor forState:UIControlStateNormal];
  [self setFilledBackgroundColor:filledSublayerFillColor forState:UIControlStateEditing];
  [self setFilledBackgroundColor:filledSublayerFillColor forState:UIControlStateDisabled];
  self.trailingAssistiveLabel.textColor = assistiveLabelColor;
  self.leadingAssistiveLabel.textColor = assistiveLabelColor;
  self.tintColor = colorScheme.primaryColor;
//  MDCContainedInputViewColorScheme *normalColorScheme =
//  [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateNormal];
//  [self setContainedInputViewColorScheming:normalColorScheme
//                                  forState:MDCContainedInputViewStateNormal];
//
//  MDCContainedInputViewColorScheme *focusedColorScheme =
//  [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateFocused];
//  [self setContainedInputViewColorScheming:focusedColorScheme
//                                  forState:MDCContainedInputViewStateFocused];
//
//  MDCContainedInputViewColorScheme *disabledColorScheme =
//  [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
//  [self setContainedInputViewColorScheming:disabledColorScheme
//                                  forState:MDCContainedInputViewStateDisabled];
//
//  self.tintColor = mdcColorScheming.primaryColor;
}

- (void)applyErrorColorScheme:(id<MDCColorScheming>)mdcColorScheming {
  UIColor *errorColor = mdcColorScheming.errorColor;
  UIColor *errorColorDisabled = [mdcColorScheming.errorColor colorWithAlphaComponent:0.5];
  [self setLabelColor:errorColor forState:UIControlStateNormal];
  [self setLabelColor:errorColor forState:UIControlStateEditing];
  [self setLabelColor:errorColorDisabled forState:UIControlStateDisabled];
  [self setTextColor:errorColor forState:UIControlStateNormal];
  [self setTextColor:errorColor forState:UIControlStateEditing];
  [self setTextColor:errorColorDisabled forState:UIControlStateDisabled];
  [self setUnderlineColor:errorColor forState:UIControlStateNormal];
  [self setUnderlineColor:errorColor forState:UIControlStateEditing];
  [self setUnderlineColor:errorColorDisabled forState:UIControlStateDisabled];
  self.trailingAssistiveLabel.textColor = errorColorDisabled;
  self.leadingAssistiveLabel.textColor = errorColorDisabled;
  self.tintColor = errorColor;
}

@end
