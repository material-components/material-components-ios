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

#import "MDCOutlinedTextField+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainerStylerOutlined.h"
#import "MDCInputTextField+Private.h"

@implementation MDCOutlinedTextField (MaterialTheming)
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

- (MDCContainedInputViewColorSchemeOutlined *)
    outlinedColorSchemeWithMDCColorScheming:(id<MDCColorScheming>)colorScheming
                    containedInputViewState:(MDCContainedInputViewState)containedInputViewState {
  UIColor *textColor = colorScheming.onSurfaceColor;
  UIColor *underlineLabelColor =
      [colorScheming.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColor =
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

  MDCContainedInputViewColorSchemeOutlined *simpleTextFieldColorScheme =
      [[MDCContainedInputViewColorSchemeOutlined alloc] init];
  simpleTextFieldColorScheme.textColor = textColor;
  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
  simpleTextFieldColorScheme.outlineColor = outlineColor;
  simpleTextFieldColorScheme.floatingLabelColor = floatingLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}

@end
