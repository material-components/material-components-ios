// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCAlertColorThemer.h"

#import "../../../Buttons/src/ColorThemer/MaterialButtons+ColorThemer.h"
#import "../MDCAlertController+ButtonForAction.h"
#import "MaterialButtons.h"

@implementation MDCAlertColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
               toAlertController:(nonnull MDCAlertController *)alertController {
  alertController.titleColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  alertController.messageColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  alertController.titleIconTintColor = colorScheme.primaryColor;
  alertController.scrimColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.32];

  // Apply theming to buttons based on the action emphasis
  for (MDCAlertAction *action in alertController.actions) {
    MDCButton *button = [alertController buttonForAction:action];
    switch (action.emphasis) {
      case MDCActionEmphasisHigh:
        [MDCContainedButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];
        break;
      case MDCActionEmphasisMedium:
        [MDCOutlinedButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];
        break;
      case MDCActionEmphasisLow:  // fallthrough
      default:
        [MDCTextButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];
        break;
    }
  }
}

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme {
  #if defined(__IPHONE_9_0) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
  [[MDCButton appearanceWhenContainedInInstancesOfClasses:@[[MDCAlertController class]]]
      setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  #else
  [[MDCButton appearanceWhenContainedIn:[MDCAlertController class], nil]
      setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  #endif
}

@end
