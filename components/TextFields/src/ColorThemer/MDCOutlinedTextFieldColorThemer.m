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

#import "MDCOutlinedTextFieldColorThemer.h"
#import "MDCTextInputControllerBase.h"

static CGFloat const kOutlinedTextFieldActiveAlpha = (CGFloat)0.87;
static CGFloat const kOutlinedTextFieldOnSurfaceAlpha = (CGFloat)0.6;
static CGFloat const kOutlinedTextFieldDisabledAlpha = (CGFloat)0.38;
static CGFloat const kOutlinedTextFieldIconAlpha = (CGFloat)0.54;

@implementation MDCOutlinedTextFieldColorThemer

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
           toTextInputController:(id<MDCTextInputController>)textInputController {
  UIColor *onSurfaceOpacity =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldOnSurfaceAlpha];
  textInputController.activeColor = colorScheme.primaryColor;
  textInputController.errorColor = colorScheme.errorColor;
  textInputController.trailingUnderlineLabelTextColor = onSurfaceOpacity;
  textInputController.normalColor = onSurfaceOpacity;
  textInputController.inlinePlaceholderColor = onSurfaceOpacity;
  textInputController.textInput.textColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldActiveAlpha];
  textInputController.leadingUnderlineLabelTextColor = onSurfaceOpacity;
  textInputController.disabledColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldDisabledAlpha];

  if ([textInputController isKindOfClass:[MDCTextInputControllerBase class]]) {
    MDCTextInputControllerBase *baseController = (MDCTextInputControllerBase *)textInputController;
    baseController.textInputClearButtonTintColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldIconAlpha];
  }

  if ([textInputController
          conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;
    if ([textInputControllerFloatingPlaceholder
            respondsToSelector:@selector(setFloatingPlaceholderNormalColor:)]) {
      textInputControllerFloatingPlaceholder.floatingPlaceholderNormalColor = onSurfaceOpacity;
      textInputControllerFloatingPlaceholder.floatingPlaceholderActiveColor =
          [colorScheme.primaryColor colorWithAlphaComponent:kOutlinedTextFieldActiveAlpha];
    }
  }
}

@end
