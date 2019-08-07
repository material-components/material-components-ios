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

#import "MDCBaseInputChipView+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "MDCBaseInputChipView+Private.h"
#import "MDCContainedInputView.h"

@implementation MDCBaseInputChipView (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:[self typographySchemeWithContainerScheme:containerScheme]];
  [self applyDefaultColorTheme:[self colorSchemeWithContainerScheme:containerScheme]];
}

- (void)applyErrorThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:[self typographySchemeWithContainerScheme:containerScheme]];
  [self applyErrorColorTheme:[self colorSchemeWithContainerScheme:containerScheme]];
}

- (id<MDCColorScheming>)colorSchemeWithContainerScheme:
    (nonnull id<MDCContainerScheming>)containerScheme {
  id<MDCColorScheming> mdcColorScheme = containerScheme.colorScheme;
  if (!mdcColorScheme) {
    mdcColorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  return mdcColorScheme;
}

- (id<MDCTypographyScheming>)typographySchemeWithContainerScheme:
    (nonnull id<MDCContainerScheming>)containerScheme {
  id<MDCTypographyScheming> mdcTypographyScheme = containerScheme.typographyScheme;
  if (!mdcTypographyScheme) {
    mdcTypographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
  }
  return mdcTypographyScheme;
}

- (void)applyTypographyScheme:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.textField.font = mdcTypographyScheming.subtitle1;
  self.leadingAssistiveLabel.font = mdcTypographyScheming.caption;
  self.trailingAssistiveLabel.font = mdcTypographyScheming.caption;
}

- (void)applyDefaultColorTheme:(id<MDCColorScheming>)mdcColorScheming {
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

- (void)applyErrorColorTheme:(id<MDCColorScheming>)mdcColorScheming {
  //  UIColor *errorColor = mdcColorScheming.errorColor;
  //  UIColor *errorColorLowAlpha = [errorColor colorWithAlphaComponent:0.5];
  //  [self setTextColor:errorColor forState:UIControlStateNormal];
  //  [self setTextColor:errorColor forState:UIControlStateDisabled];
  //  [self setTextColor:errorColorLowAlpha forState:UIControlStateEditing];
  //  [self setLabelColor:errorColor forState:UIControlStateNormal];
  //  [self setLabelColor:errorColor forState:UIControlStateDisabled];
  //  [self setLabelColor:errorColorLowAlpha forState:UIControlStateEditing];
  //
  //
  //  MDCContainedInputViewColorScheme *normalColorScheme =
  //  [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  //  [self setContainedInputViewColorScheming:normalColorScheme
  //                                  forState:MDCContainedInputViewStateNormal];
  //
  //  MDCContainedInputViewColorScheme *focusedColorScheme =
  //  [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  //  [self setContainedInputViewColorScheming:focusedColorScheme
  //                                  forState:MDCContainedInputViewStateFocused];
  //
  //  MDCContainedInputViewColorScheme *disabledColorScheme =
  //  [self.containerStyle defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  //  [self setContainedInputViewColorScheming:disabledColorScheme
  //                                  forState:MDCContainedInputViewStateDisabled];
  //
  //  self.tintColor = mdcColorScheming.primaryColor;
}

@end
