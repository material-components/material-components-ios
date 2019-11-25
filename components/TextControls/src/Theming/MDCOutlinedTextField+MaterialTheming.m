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

static const CGFloat kDisabledOpacity = (CGFloat)0.60;

static const CGFloat kTextColorNormalOpacity = (CGFloat)0.87;
static const CGFloat kAssistiveLabelColorNormalOpacity = (CGFloat)0.60;
static const CGFloat kFloatingLabelColorNormalOpacity = (CGFloat)0.60;
static const CGFloat kFloatingLabelColorEditingOpacity = (CGFloat)0.87;
static const CGFloat kNormalLabelColorNormalOpacity = (CGFloat)0.60;
static const CGFloat kOutlineColorNormalOpacity = (CGFloat)0.38;

static const CGFloat kTextColorNormalErrorOpacity = (CGFloat)0.87;
static const CGFloat kNormalLabelColorNormalErrorOpacity = (CGFloat)0.60;

@implementation MDCOutlinedTextField (MaterialTheming)

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
  UIColor *textColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kTextColorNormalOpacity];
  UIColor *textColorEditing = textColorNormal;
  UIColor *textColorDisabled = [textColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *assistiveLabelColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kAssistiveLabelColorNormalOpacity];
  UIColor *assistiveLabelColorEditing = assistiveLabelColorNormal;
  UIColor *assistiveLabelColorDisabled =
      [assistiveLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *floatingLabelColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFloatingLabelColorNormalOpacity];
  UIColor *floatingLabelColorEditing =
      [colorScheme.primaryColor colorWithAlphaComponent:kFloatingLabelColorEditingOpacity];
  UIColor *floatingLabelColorDisabled =
      [floatingLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *normalLabelColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kNormalLabelColorNormalOpacity];
  UIColor *normalLabelColorEditing = normalLabelColorNormal;
  UIColor *normalLabelColorDisabled =
      [normalLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *outlineColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlineColorNormalOpacity];
  UIColor *outlineColorEditing = colorScheme.primaryColor;
  UIColor *outlineColorDisabled = [outlineColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *tintColor = colorScheme.primaryColor;

  [self setFloatingLabelColor:floatingLabelColorNormal forState:MDCTextControlStateNormal];
  [self setFloatingLabelColor:floatingLabelColorEditing forState:MDCTextControlStateEditing];
  [self setFloatingLabelColor:floatingLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setNormalLabelColor:normalLabelColorNormal forState:MDCTextControlStateNormal];
  [self setNormalLabelColor:normalLabelColorEditing forState:MDCTextControlStateEditing];
  [self setNormalLabelColor:normalLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setTextColor:textColorNormal forState:MDCTextControlStateNormal];
  [self setTextColor:textColorEditing forState:MDCTextControlStateEditing];
  [self setTextColor:textColorDisabled forState:MDCTextControlStateDisabled];
  [self setOutlineColor:outlineColorNormal forState:MDCTextControlStateNormal];
  [self setOutlineColor:outlineColorEditing forState:MDCTextControlStateEditing];
  [self setOutlineColor:outlineColorDisabled forState:MDCTextControlStateDisabled];
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
  self.tintColor = tintColor;
}

- (void)applyErrorColorScheme:(id<MDCColorScheming>)colorScheme {
  UIColor *textColorNormal =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kTextColorNormalErrorOpacity];
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
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kNormalLabelColorNormalErrorOpacity];
  UIColor *normalLabelColorEditing = normalLabelColorNormal;
  UIColor *normalLabelColorDisabled =
      [normalLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *outlineColorNormal = colorScheme.errorColor;
  UIColor *outlineColorEditing = outlineColorNormal;
  UIColor *outlineColorDisabled = [outlineColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *tintColor = colorScheme.errorColor;

  [self setFloatingLabelColor:floatingLabelColorNormal forState:MDCTextControlStateNormal];
  [self setFloatingLabelColor:floatingLabelColorEditing forState:MDCTextControlStateEditing];
  [self setFloatingLabelColor:floatingLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setNormalLabelColor:normalLabelColorNormal forState:MDCTextControlStateNormal];
  [self setNormalLabelColor:normalLabelColorEditing forState:MDCTextControlStateEditing];
  [self setNormalLabelColor:normalLabelColorDisabled forState:MDCTextControlStateDisabled];
  [self setTextColor:textColorNormal forState:MDCTextControlStateNormal];
  [self setTextColor:textColorEditing forState:MDCTextControlStateEditing];
  [self setTextColor:textColorDisabled forState:MDCTextControlStateDisabled];
  [self setOutlineColor:outlineColorNormal forState:MDCTextControlStateNormal];
  [self setOutlineColor:outlineColorEditing forState:MDCTextControlStateEditing];
  [self setOutlineColor:outlineColorDisabled forState:MDCTextControlStateDisabled];
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
  self.tintColor = tintColor;
}

@end
