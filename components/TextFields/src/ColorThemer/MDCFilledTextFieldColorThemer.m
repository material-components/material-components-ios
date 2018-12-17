// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFilledTextFieldColorThemer.h"

static CGFloat const kFilledTextFieldActiveAlpha = (CGFloat)0.87;
static CGFloat const kFilledTextFieldOnSurfaceAlpha = (CGFloat)0.6;
static CGFloat const kFilledTextFieldDisabledAlpha = (CGFloat)0.38;
static CGFloat const kFilledTextFieldSurfaceOverlayAlpha = (CGFloat)0.04;
static CGFloat const kFilledTextFieldIndicatorLineAlpha = (CGFloat)0.42;
static CGFloat const kFilledTextFieldIconAlpha = (CGFloat)0.54;

@implementation MDCFilledTextFieldColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
     toTextInputControllerFilled:(nonnull MDCTextInputControllerFilled *)textInputControllerFilled {
  textInputControllerFilled.borderFillColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldSurfaceOverlayAlpha];
  textInputControllerFilled.normalColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldIndicatorLineAlpha];
  textInputControllerFilled.inlinePlaceholderColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldOnSurfaceAlpha];
  textInputControllerFilled.leadingUnderlineLabelTextColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldOnSurfaceAlpha];
  textInputControllerFilled.activeColor = colorScheme.primaryColor;
  textInputControllerFilled.textInput.textColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldActiveAlpha];
  textInputControllerFilled.errorColor = colorScheme.errorColor;
  textInputControllerFilled.disabledColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldDisabledAlpha];
  textInputControllerFilled.floatingPlaceholderNormalColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldOnSurfaceAlpha];
  textInputControllerFilled.floatingPlaceholderActiveColor =
      [colorScheme.primaryColor colorWithAlphaComponent:kFilledTextFieldActiveAlpha];
  textInputControllerFilled.textInputClearButtonTintColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kFilledTextFieldIconAlpha];
}

@end

