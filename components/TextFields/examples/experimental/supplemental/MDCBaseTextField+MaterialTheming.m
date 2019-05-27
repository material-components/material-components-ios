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

#import "MDCBaseTextField+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCBaseTextField+Private.h"

@implementation MDCBaseTextField (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographySchemeWith:containerScheme];
  [self applyDefaultColorScheme:[self colorSchemeWithContainerScheme:containerScheme]];
}

- (void)applyTypographySchemeWith:(id<MDCContainerScheming>)containerScheme {
  id<MDCTypographyScheming> mdcTypographyScheming = containerScheme.typographyScheme;
  if (!mdcTypographyScheming) {
    mdcTypographyScheming =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyMDCTypographyScheming:mdcTypographyScheming];
}

- (id<MDCColorScheming>)colorSchemeWithContainerScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  id<MDCColorScheming> mdcColorScheme = containerScheme.colorScheme;
  if (!mdcColorScheme) {
    mdcColorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  return mdcColorScheme;
}

- (void)applyMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.font = mdcTypographyScheming.subtitle1;
  self.leadingUnderlineLabel.font = mdcTypographyScheming.caption;
  self.trailingUnderlineLabel.font = mdcTypographyScheming.caption;
}

- (void)applyDefaultColorScheme:(id<MDCColorScheming>)mdcColorScheming {
  MDCContainedInputViewColorScheme *normalColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  MDCContainedInputViewColorScheme *focusedColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  MDCContainedInputViewColorScheme *disabledColorScheme =
      [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];

  self.tintColor = mdcColorScheming.primaryColor;
}

- (void)applyErrorColorScheme:(id<MDCColorScheming>)mdcColorScheming {
  MDCContainedInputViewColorScheme *normalColorScheme =
  [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];
  
  MDCContainedInputViewColorScheme *focusedColorScheme =
  [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];
  
  MDCContainedInputViewColorScheme *disabledColorScheme =
  [self.containerStyler defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];
  
  self.tintColor = mdcColorScheming.primaryColor;
}


- (void)applyErrorThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  UIColor *errorColor = [UIColor redColor];
  UIColor *errorColorLowAlpha = [[UIColor redColor] colorWithAlphaComponent:0.5];
  [self applyTypographySchemeWith:containerScheme];
  [self applyErrorColorScheme:[self colorSchemeWithContainerScheme:containerScheme]];
  [self setTextColor:errorColor forState:UIControlStateNormal];
  [self setTextColor:errorColor forState:UIControlStateDisabled];
  [self setTextColor:errorColorLowAlpha forState:UIControlStateEditing];
  [self setLabelColor:errorColor forState:UIControlStateNormal];
  [self setLabelColor:errorColor forState:UIControlStateDisabled];
  [self setLabelColor:errorColorLowAlpha forState:UIControlStateEditing];
}

@end
