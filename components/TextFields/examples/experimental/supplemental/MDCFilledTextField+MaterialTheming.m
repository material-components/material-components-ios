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
#import "MDCInputTextField+Private.h"

@implementation MDCFilledTextField (MaterialTheming)

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

- (void)applyMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingUnderlineLabel.font = mdcTypographyScheming.caption;
  self.trailingUnderlineLabel.font = mdcTypographyScheming.caption;
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

  MDCContainedInputViewColorSchemeFilled *simpleTextFieldColorScheme =
      [[MDCContainedInputViewColorSchemeFilled alloc] init];
  simpleTextFieldColorScheme.textColor = textColor;
  simpleTextFieldColorScheme.filledSublayerFillColor = filledSublayerFillColor;
  simpleTextFieldColorScheme.thickUnderlineFillColor = thickUnderlineFillColor;
  simpleTextFieldColorScheme.thinUnderlineFillColor = thinUnderlineFillColor;
  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
  simpleTextFieldColorScheme.floatingLabelColor = floatingLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}

@end
