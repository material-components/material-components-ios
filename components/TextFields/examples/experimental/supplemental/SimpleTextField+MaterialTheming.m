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

#import "SimpleTextFieldColorSchemeAdapter.h"

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

- (void)applyThemeWithMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingUnderlineLabel.font = mdcTypographyScheming.caption;
  self.trailingUnderlineLabel.font = mdcTypographyScheming.caption;
}

- (void)applyThemeWithMDCColorScheming:(id<MDCColorScheming>)mdcColorScheming {
//  SimpleTextFieldColorSchemeAdapter *normalColorScheme =
//      [self simpleTextFieldColorSchemeWithMDCColorScheming:mdcColorScheming
//                                            textFieldState:MDCContainedInputViewStateNormal];
//  [self setSimpleTextFieldColorScheme:normalColorScheme forState:MDCContainedInputViewStateNormal];
//
//  SimpleTextFieldColorSchemeAdapter *focusedColorScheme =
//      [self simpleTextFieldColorSchemeWithMDCColorScheming:mdcColorScheming
//                                            textFieldState:MDCContainedInputViewStateNormal];
//  [self setSimpleTextFieldColorScheme:focusedColorScheme forState:MDCContainedInputViewStateFocused];
//
//  SimpleTextFieldColorSchemeAdapter *activatedColorScheme =
//      [self simpleTextFieldColorSchemeWithMDCColorScheming:mdcColorScheming
//                                            textFieldState:MDCContainedInputViewStateNormal];
//  [self setSimpleTextFieldColorScheme:activatedColorScheme forState:MDCContainedInputViewStateActivated];
//
//  SimpleTextFieldColorSchemeAdapter *erroredColorScheme =
//      [self simpleTextFieldColorSchemeWithMDCColorScheming:mdcColorScheming
//                                            textFieldState:MDCContainedInputViewStateNormal];
//  [self setSimpleTextFieldColorScheme:erroredColorScheme forState:MDCContainedInputViewStateErrored];
//
//  SimpleTextFieldColorSchemeAdapter *disabledColorScheme =
//      [self simpleTextFieldColorSchemeWithMDCColorScheming:mdcColorScheming
//                                            textFieldState:MDCContainedInputViewStateNormal];
//  [self setSimpleTextFieldColorScheme:disabledColorScheme forState:MDCContainedInputViewStateDisabled];
}

- (SimpleTextFieldColorSchemeAdapter *)
    simpleTextFieldColorSchemeWithMDCColorScheming:(id<MDCColorScheming>)colorScheming
                                    textFieldState:(MDCContainedInputViewState)textFieldState {
  UIColor *textColor = colorScheming.onSurfaceColor;
  UIColor *underlineLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *placeholderLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *outlineColor = colorScheming.onSurfaceColor;
  UIColor *filledSublayerUnderlineFillColor = colorScheming.onSurfaceColor;
  UIColor *filledSublayerFillColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.15];
  UIColor *clearButtonTintColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];

  switch (textFieldState) {
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
      outlineColor = colorScheming.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      outlineColor = colorScheming.primaryColor;
      placeholderLabelColor = colorScheming.primaryColor;
      filledSublayerUnderlineFillColor = colorScheming.primaryColor;
      break;
    default:
      break;
  }

  SimpleTextFieldColorSchemeAdapter *simpleTextFieldColorScheme =
      [[SimpleTextFieldColorSchemeAdapter alloc] init];
  simpleTextFieldColorScheme.textColor = textColor;
  simpleTextFieldColorScheme.filledSublayerFillColor = filledSublayerFillColor;
  simpleTextFieldColorScheme.filledSublayerUnderlineFillColor = filledSublayerUnderlineFillColor;
  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
  simpleTextFieldColorScheme.outlineColor = outlineColor;
  simpleTextFieldColorScheme.placeholderLabelColor = placeholderLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}


- (void)applyFilledThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  MDCContainerStyleFilled *filledStyle = [[MDCContainerStyleFilled alloc] init];
  self.containerStyleObject = filledStyle;
}


@end
