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

#import "MDCTextInputControllerFilled+MaterialTheming.h"

#import <MaterialComponents/MaterialTextFields+ColorThemer.h>

@implementation MDCTextInputControllerFilled (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  // Color
  [self applyColorThemeWithScheme:scheme.colorScheme];

  // Typography
  [self applyTypographyThemeWithScheme:scheme.typographyScheme];
}

- (void)applyColorThemeWithScheme:(nonnull id<MDCColorScheming>)colorScheme {
  [MDCFilledTextFieldColorThemer applySemanticColorScheme:colorScheme
                              toTextInputControllerFilled:self];
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
