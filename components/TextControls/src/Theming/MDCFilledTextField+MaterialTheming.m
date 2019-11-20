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

static const CGFloat kDisabledOpacity = (CGFloat)0.60;

@implementation MDCFilledTextField (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:containerScheme.typographyScheme];
  [self applyDefaultColorScheme:containerScheme.colorScheme];
}

- (void)applyErrorThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:containerScheme.typographyScheme];
  [self applyErrorColorScheme:containerScheme.colorScheme];
}

- (void)applyTypographyScheme:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingAssistiveLabel.font = mdcTypographyScheming.caption;
  self.trailingAssistiveLabel.font = mdcTypographyScheming.caption;
}

- (void)applyDefaultColorScheme:(id<MDCColorScheming>)colorScheme {
  UIColor *textColorNormal = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *textColorEditing = textColorNormal;
  UIColor *textColorDisabled = [textColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *assistiveLabelColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *assistiveLabelColorEditing = assistiveLabelColorNormal;
  UIColor *assistiveLabelColorDisabled =
      [assistiveLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *floatingLabelColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColorEditing =
      [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *floatingLabelColorDisabled =
      [floatingLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *normalLabelColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *normalLabelColorEditing = normalLabelColorNormal;
  UIColor *normalLabelColorDisabled =
      [normalLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *underlineColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.42];
  UIColor *underlineColorEditing = colorScheme.primaryColor;
  UIColor *underlineColorDisabled = [underlineColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *filledSublayerFillColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
  UIColor *filledSublayerFillColorEditing = filledSublayerFillColorNormal;
  UIColor *filledSublayerFillColorDisabled =
      [filledSublayerFillColorNormal colorWithAlphaComponent:kDisabledOpacity];

  self.tintColor = colorScheme.primaryColor;

  [self setFloatingLabelColor:floatingLabelColorNormal forState:MDCTextControlStateNormal];
  [self setFloatingLabelColor:floatingLabelColorEditing forState:MDCTextControlStateEditing];
  [self setFloatingLabelColor:floatingLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setNormalLabelColor:normalLabelColorNormal forState:MDCTextControlStateNormal];
  [self setNormalLabelColor:normalLabelColorEditing forState:MDCTextControlStateEditing];
  [self setNormalLabelColor:normalLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setTextColor:textColorNormal forState:MDCTextControlStateNormal];
  [self setTextColor:textColorEditing forState:MDCTextControlStateEditing];
  [self setTextColor:textColorDisabled forState:MDCTextControlStateDisabled];
  [self setUnderlineColor:underlineColorNormal forState:MDCTextControlStateNormal];
  [self setUnderlineColor:underlineColorEditing forState:MDCTextControlStateEditing];
  [self setUnderlineColor:underlineColorDisabled forState:MDCTextControlStateDisabled];
  [self setFilledBackgroundColor:filledSublayerFillColorNormal forState:MDCTextControlStateNormal];
  [self setFilledBackgroundColor:filledSublayerFillColorEditing
                        forState:MDCTextControlStateEditing];
  [self setFilledBackgroundColor:filledSublayerFillColorDisabled
                        forState:MDCTextControlStateDisabled];
  [self setLeadingAssistiveLabelColor:assistiveLabelColorNormal forState:MDCTextControlStateNormal];
  [self setLeadingAssistiveLabelColor:assistiveLabelColorEditing
                             forState:MDCTextControlStateEditing];
  [self setLeadingAssistiveLabelColor:assistiveLabelColorDisabled
                             forState:MDCTextControlStateDisabled];
  [self setTrailingAssistiveLabelColor:assistiveLabelColorNormal
                              forState:MDCTextControlStateNormal];
  [self setTrailingAssistiveLabelColor:assistiveLabelColorEditing
                              forState:MDCTextControlStateEditing];
  [self setTrailingAssistiveLabelColor:assistiveLabelColorDisabled
                              forState:MDCTextControlStateDisabled];
}

- (void)applyErrorColorScheme:(id<MDCColorScheming>)colorScheme {
  UIColor *textColorNormal = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *textColorEditing = textColorNormal;
  UIColor *textColorDisabled = [textColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *assistiveLabelColorNormal = colorScheme.errorColor;
  UIColor *assistiveLabelColorEditing = assistiveLabelColorNormal;
  UIColor *assistiveLabelColorDisabled =
      [assistiveLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *floatingLabelColorNormal = colorScheme.errorColor;
  UIColor *floatingLabelColorEditing = floatingLabelColorNormal;
  UIColor *floatingLabelColorDisabled =
      [floatingLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *normalLabelColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *normalLabelColorEditing = normalLabelColorNormal;
  UIColor *normalLabelColorDisabled =
      [normalLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *underlineColorNormal = colorScheme.errorColor;
  UIColor *underlineColorEditing = underlineColorNormal;
  UIColor *underlineColorDisabled = [underlineColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *filledSublayerFillColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
  UIColor *filledSublayerFillColorEditing = filledSublayerFillColorNormal;
  UIColor *filledSublayerFillColorDisabled =
      [filledSublayerFillColorNormal colorWithAlphaComponent:kDisabledOpacity];

  self.tintColor = colorScheme.errorColor;

  [self setFloatingLabelColor:floatingLabelColorNormal forState:MDCTextControlStateNormal];
  [self setFloatingLabelColor:floatingLabelColorEditing forState:MDCTextControlStateEditing];
  [self setFloatingLabelColor:floatingLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setNormalLabelColor:normalLabelColorNormal forState:MDCTextControlStateNormal];
  [self setNormalLabelColor:normalLabelColorEditing forState:MDCTextControlStateEditing];
  [self setNormalLabelColor:normalLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setTextColor:textColorNormal forState:MDCTextControlStateNormal];
  [self setTextColor:textColorEditing forState:MDCTextControlStateEditing];
  [self setTextColor:textColorDisabled forState:MDCTextControlStateDisabled];
  [self setUnderlineColor:underlineColorNormal forState:MDCTextControlStateNormal];
  [self setUnderlineColor:underlineColorEditing forState:MDCTextControlStateEditing];
  [self setUnderlineColor:underlineColorDisabled forState:MDCTextControlStateDisabled];
  [self setFilledBackgroundColor:filledSublayerFillColorNormal forState:MDCTextControlStateNormal];
  [self setFilledBackgroundColor:filledSublayerFillColorEditing
                        forState:MDCTextControlStateEditing];
  [self setFilledBackgroundColor:filledSublayerFillColorDisabled
                        forState:MDCTextControlStateDisabled];
  [self setLeadingAssistiveLabelColor:assistiveLabelColorNormal forState:MDCTextControlStateNormal];
  [self setLeadingAssistiveLabelColor:assistiveLabelColorEditing
                             forState:MDCTextControlStateEditing];
  [self setLeadingAssistiveLabelColor:assistiveLabelColorDisabled
                             forState:MDCTextControlStateDisabled];
  [self setTrailingAssistiveLabelColor:assistiveLabelColorNormal
                              forState:MDCTextControlStateNormal];
  [self setTrailingAssistiveLabelColor:assistiveLabelColorEditing
                              forState:MDCTextControlStateEditing];
  [self setTrailingAssistiveLabelColor:assistiveLabelColorDisabled
                              forState:MDCTextControlStateDisabled];
}

@end
