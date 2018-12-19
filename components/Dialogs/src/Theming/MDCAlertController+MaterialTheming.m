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

#import "MDCButton+MaterialTheming.h"

#import "../MDCAlertController+ButtonForAction.h"
#import "MaterialButtons+Theming.h"
#import <MaterialComponents/MaterialDialogs+ColorThemer.h>
#import <MaterialComponents/MaterialDialogs+TypographyThemer.h>
#import <MaterialComponents/MaterialShadowElevations.h>

static const CGFloat kCornerRadius = 4;

@implementation MDCAlertController (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  // Color
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [MDCAlertColorThemer applySemanticColorScheme:colorScheme toAlertController:self];

  // Typography
  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [MDCAlertTypographyThemer applyTypographyScheme:typographyScheme toAlertController:self];

  // Other properties
  self.cornerRadius = kCornerRadius;
  self.elevation = MDCShadowElevationDialog;

  // Buttons
  for (MDCAlertAction *action in self.actions) {
    MDCButton *button = [self buttonForAction:action];
    // todo: b/117265609: Incorporate dynamic type support in semantic themers
    switch (action.emphasis) {
      case MDCActionEmphasisHigh:
        [button applyContainedThemeWithScheme:scheme];
        break;
      case MDCActionEmphasisMedium:
        [button applyOutlinedThemeWithScheme:scheme];
        break;
      case MDCActionEmphasisLow:  // fallthrough
      default:
        [button applyTextThemeWithScheme:scheme];
        break;
    }
  }
}

@end
