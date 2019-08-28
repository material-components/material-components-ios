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

#import "MDCBaseTextArea+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "private/MDCBaseTextArea+MDCContainedInputView.h"
#import "private/MDCContainedInputView.h"
#import "private/MDCContainedInputViewStyleFilled.h"
#import "private/MDCContainedInputViewStyleOutlined.h"

@implementation MDCBaseTextArea (MaterialTheming)

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

  MDCContainedInputViewColorScheme *disabledColorScheme =
      [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (void)applyMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.textView.font = mdcTypographyScheming.subtitle1;
  self.leadingAssistiveLabel.font = mdcTypographyScheming.caption;
  self.trailingAssistiveLabel.font = mdcTypographyScheming.caption;
}

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  MDCContainedInputViewStyleOutlined *outlinedStyle =
      [[MDCContainedInputViewStyleOutlined alloc] init];
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

  MDCContainedInputViewColorSchemeOutlined *disabledColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                            containedInputViewState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (void)applyFilledThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  MDCContainedInputViewStyleFilled *filledStyle = [[MDCContainedInputViewStyleFilled alloc] init];
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
  UIColor *assistiveLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *placeholderColor = floatingLabelColor;
  UIColor *outlineColor = colorScheming.onSurfaceColor;

  switch (containedInputViewState) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateDisabled:
      floatingLabelColor = [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
      //    case MDCContainedInputViewStateErrored:
      //      floatingLabelColor = colorScheming.errorColor;
      //      assistiveLabelColor = colorScheming.errorColor;
      //      outlineColor = colorScheming.errorColor;
      //      break;
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
  colorScheme.assistiveLabelColor = assistiveLabelColor;
  colorScheme.outlineColor = outlineColor;
  colorScheme.floatingLabelColor = floatingLabelColor;
  colorScheme.normalLabelColor = floatingLabelColor;
  colorScheme.placeholderColor = placeholderColor;
  return colorScheme;
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

  MDCContainedInputViewColorSchemeFilled *colorScheme =
      [[MDCContainedInputViewColorSchemeFilled alloc] init];
  colorScheme.textColor = textColor;
  colorScheme.filledSublayerFillColor = filledSublayerFillColor;
  colorScheme.thickUnderlineFillColor = thickUnderlineFillColor;
  colorScheme.thinUnderlineFillColor = thinUnderlineFillColor;
  colorScheme.assistiveLabelColor = assistiveLabelColor;
  colorScheme.floatingLabelColor = floatingLabelColor;
  colorScheme.normalLabelColor = floatingLabelColor;
  return colorScheme;
}

@end
