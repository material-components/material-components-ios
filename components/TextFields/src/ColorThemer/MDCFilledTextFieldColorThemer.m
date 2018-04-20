/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCFilledTextFieldColorThemer.h"

static CGFloat const kFilledTextFieldActiveAlpha = 0.87f;
static CGFloat const kFilledTextFieldOnSurfaceAlpha = 0.6f;
static CGFloat const kFilledTextFieldDisabledAlpha = 0.38f;
static CGFloat const kFilledTextFieldSurfaceOverlayAlpha = 0.04f;
static CGFloat const kFilledTextFieldIndicatorLineAlpha = 0.42f;

@implementation MDCFilledTextFieldColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
     toTextInputControllerFilled:(nonnull MDCTextInputControllerFilled *)textInputControllerFilled {
  textInputControllerFilled.backgroundColor = colorScheme.surfaceColor;
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
  id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
      (id<MDCTextInputControllerFloatingPlaceholder>)textInputControllerFilled;
  textInputControllerFloatingPlaceholder.floatingPlaceholderActiveColor =
      [colorScheme.primaryColor colorWithAlphaComponent:kFilledTextFieldActiveAlpha];
}

@end

