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

#import "MDCBaseTextField2+ContainedInputView.h"
#import "MDCContainedInputView.h"
#import "MDCContainedInputViewStyleOutlined.h"

@implementation MDCOutlinedTextField (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:[self typographySchemeWithContainerScheme:containerScheme]];
  [self applyDefaultColorScheme:[self colorSchemeWithContainerScheme:containerScheme]];
}

- (void)applyErrorThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographyScheme:[self typographySchemeWithContainerScheme:containerScheme]];
  [self applyErrorColorScheme:[self colorSchemeWithContainerScheme:containerScheme]];
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
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingAssistiveLabel.font = mdcTypographyScheming.caption;
  self.trailingAssistiveLabel.font = mdcTypographyScheming.caption;
}

- (void)applyDefaultColorScheme:(id<MDCColorScheming>)colorScheme {
  UIColor *textColor = colorScheme.onSurfaceColor;
  UIColor *assistiveLabelColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *labelColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *labelColorDisabled = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
  UIColor *labelColorFocused = colorScheme.primaryColor;

  UIColor *outlineColorNormal = colorScheme.onSurfaceColor;
  UIColor *outlineColorEditing = colorScheme.primaryColor;
  UIColor *outlineColorDisabled =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];

  //  UIColor *clearButtonTintColor =
  //  [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];
  // TODO: Figure out what to do with this. There's no stateful API for it, it only exists on the
  // color view model

  [self setLabelColor:labelColor forState:UIControlStateNormal];
  [self setLabelColor:labelColorFocused forState:UIControlStateEditing];
  [self setLabelColor:labelColorDisabled forState:UIControlStateDisabled];
  [self setTextColor:textColor forState:UIControlStateNormal];
  [self setTextColor:textColor forState:UIControlStateEditing];
  [self setTextColor:textColor forState:UIControlStateDisabled];
  [self setOutlineColor:outlineColorNormal forState:UIControlStateNormal];
  [self setOutlineColor:outlineColorEditing forState:UIControlStateEditing];
  [self setOutlineColor:outlineColorDisabled forState:UIControlStateDisabled];
  self.trailingAssistiveLabel.textColor = assistiveLabelColor;
  self.leadingAssistiveLabel.textColor = assistiveLabelColor;
  self.tintColor = colorScheme.primaryColor;
}

- (void)applyErrorColorScheme:(id<MDCColorScheming>)colorScheme {
  UIColor *textColor = colorScheme.errorColor;
  UIColor *assistiveLabelColor = [colorScheme.errorColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *labelColor = colorScheme.errorColor;
  UIColor *labelColorDisabled = [colorScheme.errorColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *labelColorFocused = colorScheme.errorColor;

  UIColor *outlineColorNormal = colorScheme.errorColor;
  UIColor *outlineColorEditing = colorScheme.errorColor;
  UIColor *outlineColorDisabled = [colorScheme.errorColor colorWithAlphaComponent:(CGFloat)0.60];

  //  UIColor *clearButtonTintColor =
  //  [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];
  // TODO: Figure out what to do with this. There's no stateful API for it, it only exists on the
  // color view model

  [self setLabelColor:labelColor forState:UIControlStateNormal];
  [self setLabelColor:labelColorFocused forState:UIControlStateEditing];
  [self setLabelColor:labelColorDisabled forState:UIControlStateDisabled];
  [self setTextColor:textColor forState:UIControlStateNormal];
  [self setTextColor:textColor forState:UIControlStateEditing];
  [self setTextColor:textColor forState:UIControlStateDisabled];
  [self setOutlineColor:outlineColorNormal forState:UIControlStateNormal];
  [self setOutlineColor:outlineColorEditing forState:UIControlStateEditing];
  [self setOutlineColor:outlineColorDisabled forState:UIControlStateDisabled];
  self.trailingAssistiveLabel.textColor = assistiveLabelColor;
  self.leadingAssistiveLabel.textColor = assistiveLabelColor;
  self.tintColor = colorScheme.errorColor;
}

@end
