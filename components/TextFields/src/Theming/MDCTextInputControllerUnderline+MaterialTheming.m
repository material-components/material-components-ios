// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextInputControllerUnderline+MaterialTheming.h"

@implementation MDCTextInputControllerUnderline (MaterialTheming)

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  // Color
  [self applyColorThemeWithColorScheme:scheme.colorScheme];

  // Typography
  [self applyTypographyThemeWithScheme:scheme.typographyScheme];
}

- (void)applyColorThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.activeColor = colorScheme.primaryColor;
  if ([textInputController
          conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;

    if ([textInputControllerFloatingPlaceholder
            respondsToSelector:@selector(setFloatingPlaceholderNormalColor:)]) {
      textInputControllerFloatingPlaceholder.floatingPlaceholderNormalColor =
          colorScheme.primaryColor;
    }
  }

  if ([textInputController
          conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;
    UIColor *primary87Opacity = [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.87];
    textInputControllerFloatingPlaceholder.floatingPlaceholderNormalColor = onSurface60Opacity;
    textInputControllerFloatingPlaceholder.floatingPlaceholderActiveColor = primary87Opacity;
  }

  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface60Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  textInputController.activeColor = colorScheme.primaryColor;
  textInputController.errorColor = colorScheme.errorColor;
  textInputController.normalColor = onSurface87Opacity;
  textInputController.inlinePlaceholderColor = onSurface60Opacity;
  textInputController.trailingUnderlineLabelTextColor = onSurface60Opacity;
  textInputController.leadingUnderlineLabelTextColor = onSurface60Opacity;
}

- (void)applyTypographyThemeWithScheme:(id<MDCTypographyScheming>)typographyScheme {
  
}

@end
