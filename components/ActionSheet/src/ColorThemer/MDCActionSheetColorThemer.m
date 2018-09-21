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

static const CGFloat kHighOpacity = 0.87f;
static const CGFloat kMediumOpacity = 0.6f;

@implementation MDCActionSheetColorThemer

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
                   toActionSheet:(MDCActionSheetController *)actionSheet {
  actionSheet.backgroundColor = colorScheme.surfaceColor;
  if (actionSheet.message && ![actionSheet.message isEqualToString:@""]) {
    // If there is a message then this can be high opacity and won't clash with actions.
    actionSheet.titleTextColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighOpacity];
  } else {
    actionSheet.titleTextColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumOpacity];
  }
  actionSheet.messageTextColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumOpacity];
  actionSheet.imageRenderingMode = UIImageRenderingModeAlwaysTemplate;
  actionSheet.actionTintColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumOpacity];
  actionSheet.actionTextColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighOpacity];
}

@end
