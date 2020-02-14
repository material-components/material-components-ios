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

#import "MDCTextInputControllerOutlined+MaterialTheming.h"

static CGFloat const kOutlinedTextFieldActiveAlpha = (CGFloat)0.87;
static CGFloat const kOutlinedTextFieldOnSurfaceAlpha = (CGFloat)0.6;
static CGFloat const kOutlinedTextFieldDisabledAlpha = (CGFloat)0.38;
static CGFloat const kOutlinedTextFieldIconAlpha = (CGFloat)0.54;

@implementation MDCTextInputControllerOutlined (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  // Color
  [self applyColorThemeWithScheme:scheme.colorScheme];

  // Typography
  [self applyTypographyThemeWithScheme:scheme.typographyScheme];
}

- (void)applyColorThemeWithScheme:(nonnull id<MDCColorScheming>)colorScheme {
  UIColor *onSurfaceOpacity =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldOnSurfaceAlpha];
  self.activeColor = colorScheme.primaryColor;
  self.errorColor = colorScheme.errorColor;
  self.trailingUnderlineLabelTextColor = onSurfaceOpacity;
  self.normalColor = onSurfaceOpacity;
  self.inlinePlaceholderColor = onSurfaceOpacity;
  self.textInput.textColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldActiveAlpha];
  self.leadingUnderlineLabelTextColor = onSurfaceOpacity;
  self.disabledColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldDisabledAlpha];

  self.textInputClearButtonTintColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlinedTextFieldIconAlpha];

  if ([self conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)self;
    if ([textInputControllerFloatingPlaceholder
            respondsToSelector:@selector(setFloatingPlaceholderNormalColor:)]) {
      textInputControllerFloatingPlaceholder.floatingPlaceholderNormalColor = onSurfaceOpacity;
      textInputControllerFloatingPlaceholder.floatingPlaceholderActiveColor =
          [colorScheme.primaryColor colorWithAlphaComponent:kOutlinedTextFieldActiveAlpha];
    }
  }
}

- (void)applyTypographyThemeWithScheme:(nonnull id<MDCTypographyScheming>)typographyScheme {
  self.inlinePlaceholderFont = typographyScheme.subtitle1;
  self.leadingUnderlineLabelFont = typographyScheme.caption;
  self.trailingUnderlineLabelFont = typographyScheme.caption;
  if ([self conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> floatingPlaceholderController =
        (id<MDCTextInputControllerFloatingPlaceholder>)self;

    // if caption.pointSize <= 0 there is no meaningful ratio so we fallback to default.
    if (typographyScheme.caption.pointSize <= 0) {
      floatingPlaceholderController.floatingPlaceholderScale = nil;
    } else {
      double ratio = typographyScheme.caption.pointSize / typographyScheme.subtitle1.pointSize;
      floatingPlaceholderController.floatingPlaceholderScale = [NSNumber numberWithDouble:ratio];
    }
  }
}

@end
