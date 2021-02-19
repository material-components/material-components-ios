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

#import "MDCAlertTypographyThemer.h"

#import "MaterialButtons+TypographyThemer.h"
#import "MDCAlertController+ButtonForAction.h"
#import "MaterialDialogs.h"
#import "MaterialTypographyScheme+Scheming.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
@implementation MDCAlertTypographyThemer
#pragma clang diagnostic pop

+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
            toAlertController:(nonnull MDCAlertController *)alertController {
  alertController.titleFont = typographyScheme.headline6;
  alertController.messageFont = typographyScheme.body1;

  // Apply emphasis-based button theming, if enabled
  for (MDCAlertAction *action in alertController.actions) {
    MDCButton *button = [alertController buttonForAction:action];
    // todo: b/117265609: Incorporate dynamic type support in button themers
    [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:button];
  }
}

@end
