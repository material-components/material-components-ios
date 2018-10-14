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

#import "MDCAlertControllerThemer.h"
#import "MDCAlertColorThemer.h"
#import "MDCAlertTypographyThemer.h"
#import "MaterialButtons+ButtonThemer.h" // todo: update podspec?

@implementation MDCAlertControllerThemer

+ (void)applyScheme:(nonnull id<MDCAlertScheming>)alertScheme
    toAlertController:(nonnull MDCAlertController *)alertController {
  [MDCAlertColorThemer applySemanticColorScheme:alertScheme.colorScheme
                              toAlertController:alertController];

  [MDCAlertTypographyThemer applyTypographyScheme:alertScheme.typographyScheme
                                toAlertController:alertController];

  alertController.cornerRadius = alertScheme.cornerRadius;
  alertController.elevation = alertScheme.elevation;

  for (MDCAlertAction *action in alertController.actions) {
    MDCButton *button = [alertController buttonForAction:action];
    switch (action.emphasis) {
      case MDCActionEmphasisHigh:
        [MDCContainedButtonThemer applyScheme:alertScheme.buttonScheme toButton:button];
        break;

      case MDCActionEmphasisMedium:
        [MDCOutlinedButtonThemer applyScheme:alertScheme.buttonScheme toButton:button];
        break;

      case MDCActionEmphasisLow:
      default:
        [MDCTextButtonThemer applyScheme:alertScheme.buttonScheme toButton:button];
        break;
    }
  }
}

@end
