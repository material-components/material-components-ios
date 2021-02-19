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

#import "MDCTextInputControllerFloatingPlaceholder.h"

#import "MaterialTextFields.h"

#import "MaterialColorScheme.h"

#import "MaterialContainerScheme.h"

#import "MaterialTypographyScheme+Scheming.h"

@implementation MDCTextInputControllerUnderline (MaterialTheming)

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  // Color
  [self applyColorThemeWithColorScheme:scheme.colorScheme];

  // Typography
  [self applyTypographyThemeWithScheme:scheme.typographyScheme];
}

- (void)applyColorThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface60Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *primary87Opacity = [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.87];

  self.activeColor = colorScheme.primaryColor;
  self.errorColor = colorScheme.errorColor;
  self.normalColor = onSurface87Opacity;
  self.inlinePlaceholderColor = onSurface60Opacity;
  self.trailingUnderlineLabelTextColor = onSurface60Opacity;
  self.leadingUnderlineLabelTextColor = onSurface60Opacity;

  if ([self conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)self;

    if ([textInputControllerFloatingPlaceholder
            respondsToSelector:@selector(setFloatingPlaceholderNormalColor:)]) {
      textInputControllerFloatingPlaceholder.floatingPlaceholderNormalColor = onSurface60Opacity;
      textInputControllerFloatingPlaceholder.floatingPlaceholderActiveColor = primary87Opacity;
    }
  }
}

- (void)applyTypographyThemeWithScheme:(id<MDCTypographyScheming>)typographyScheme {
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
