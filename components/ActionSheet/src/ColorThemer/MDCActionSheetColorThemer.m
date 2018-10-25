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

#import "MDCActionSheetColorThemer.h"

#import "MaterialColorScheme.h"

static const CGFloat kHighAlpha = 0.87f;
static const CGFloat kMediumAlpha = 0.6f;
static const CGFloat kInkAlpha = 0.16f;

@implementation MDCActionSheetColorThemer

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
         toActionSheetController:(MDCActionSheetController *)actionSheetController {
  actionSheetController.backgroundColor = colorScheme.surfaceColor;
  if (actionSheetController.message && ![actionSheetController.message isEqualToString:@""]) {
    // If there is a message then this can be high opacity and won't clash with actions.
    actionSheetController.titleTextColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  } else {
    actionSheetController.titleTextColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha];
  }
  actionSheetController.messageTextColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha];
  actionSheetController.imageRenderingMode = UIImageRenderingModeAlwaysTemplate;
  actionSheetController.actionTintColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha];
  actionSheetController.actionTextColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  actionSheetController.inkColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kInkAlpha];
}

@end
