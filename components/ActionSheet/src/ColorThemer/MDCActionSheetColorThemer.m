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

#import "MDCActionSheetColorThemer.h"

#import "MaterialActionSheet.h"

static const CGFloat kPrimaryAlpha = 0.87f;
static const CGFloat kSecondaryAlpha = 0.6f;

@implementation MDCActionSheetColorThemer

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
         toActionSheetController:(MDCActionSheetController *)actionSheetController {
  if (!actionSheetController.message) {
    actionSheetController.titleColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:secondaryAlpha];
  } else {
    actionSheetController.titleColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:primaryAlpha];
  }
  actionSheetController.messageColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:secondaryAlpha];
  actionSheetController.imageColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:secondaryAlpha];
  actionSheetController.actionColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:primaryAlpha;
}

@end
