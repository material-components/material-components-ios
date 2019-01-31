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

#import "SimpleTextField+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "SimpleTextFieldColorScheme.h"
#import "MDCContainedInputView.h"

//#import "MDCSemanticColorScheme.h"

@implementation SimpleTextField (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  id<MDCTypographyScheming> mdcTypographyScheming = containerScheme.typographyScheme;
  if (!mdcTypographyScheming) {
    mdcTypographyScheming = [[MDCTypographyScheme alloc] init];
  }
  [self applyThemeWithMDCTypographyScheming:mdcTypographyScheming];

  id<MDCColorScheming> mdcColorScheme = containerScheme.colorScheme;
  if (!mdcColorScheme) {
    mdcColorScheme = [[MDCSemanticColorScheme alloc] init];
  }
  [self applyThemeWithMDCColorScheming:mdcColorScheme];
}

- (void)applyThemeWithMDCColorScheming:(id<MDCColorScheming>)mdcColorScheming {
  
}

- (void)applyThemeWithMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingUnderlineLabel.font = mdcTypographyScheming.caption;
  self.trailingUnderlineLabel.font = mdcTypographyScheming.caption;
}

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  MDCContainerStyleOutlined *outlinedStyle = [[MDCContainerStyleOutlined alloc] init];
  self.containerStyle = outlinedStyle;
  // ^ if you have side effects in this setter then you can just access them and modify them
  
  id<MDCColorScheming> mdcColorScheming = scheme.colorScheme ?: [[MDCSemanticColorScheme alloc] init];

  MDCContainedInputViewColorSchemeOutlined *normalColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme forState:MDCContainedInputViewStateNormal];

  MDCContainedInputViewColorSchemeOutlined *focusedColorScheme =
      [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming containedInputViewState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme forState:MDCContainedInputViewStateFocused];

  MDCContainedInputViewColorSchemeOutlined *activatedColorScheme =
  [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                                 containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:activatedColorScheme forState:MDCContainedInputViewStateActivated];

  MDCContainedInputViewColorSchemeOutlined *erroredColorScheme =
  [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                                 containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:erroredColorScheme forState:MDCContainedInputViewStateErrored];

  MDCContainedInputViewColorSchemeOutlined *disabledColorScheme =
  [self outlinedColorSchemeWithMDCColorScheming:mdcColorScheming
                                 containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:disabledColorScheme forState:MDCContainedInputViewStateDisabled];
}


- (void)applyFilledThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  MDCContainerStyleFilled *filledStyle = [[MDCContainerStyleFilled alloc] init];
  self.containerStyle = filledStyle;
  // ^ if you have side effects in this setter then you can just access them and modify them
  
  id<MDCColorScheming> mdcColorScheming = scheme.colorScheme ?: [[MDCSemanticColorScheme alloc] init];
  
  MDCContainedInputViewColorSchemeFilled *normalColorScheme =
  [self filledColorSchemeWithMDCColorScheming:mdcColorScheming containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme forState:MDCContainedInputViewStateNormal];
  
  MDCContainedInputViewColorSchemeFilled *focusedColorScheme =
  [self filledColorSchemeWithMDCColorScheming:mdcColorScheming containedInputViewState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme forState:MDCContainedInputViewStateFocused];
  
  MDCContainedInputViewColorSchemeFilled *activatedColorScheme =
  [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                                 containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:activatedColorScheme forState:MDCContainedInputViewStateActivated];
  
  MDCContainedInputViewColorSchemeFilled *erroredColorScheme =
  [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                                 containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:erroredColorScheme forState:MDCContainedInputViewStateErrored];
  
  MDCContainedInputViewColorSchemeFilled *disabledColorScheme =
  [self filledColorSchemeWithMDCColorScheming:mdcColorScheming
                                 containedInputViewState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:disabledColorScheme forState:MDCContainedInputViewStateDisabled];
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
  UIColor *filledSublayerUnderlineFillColor = colorScheming.onSurfaceColor;
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
      filledSublayerUnderlineFillColor = colorScheming.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      placeholderLabelColor = colorScheming.primaryColor;
      filledSublayerUnderlineFillColor = colorScheming.primaryColor;
      break;
    default:
      break;
  }
  
  MDCContainedInputViewColorSchemeFilled *simpleTextFieldColorScheme =
  [[MDCContainedInputViewColorSchemeFilled alloc] init];
  simpleTextFieldColorScheme.textColor = textColor;
  simpleTextFieldColorScheme.filledSublayerFillColor = filledSublayerFillColor;
  simpleTextFieldColorScheme.filledSublayerUnderlineFillColor = filledSublayerUnderlineFillColor;
  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
  simpleTextFieldColorScheme.placeholderLabelColor = placeholderLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}

@end
