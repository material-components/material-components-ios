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

#import "MDCSnackbarColorThemer.h"

@implementation MDCSnackbarColorThemer

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme {
  [self applySemanticColorScheme:colorScheme toSnackbarManager:MDCSnackbarManager.defaultManager];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
               toSnackbarManager:(MDCSnackbarManager *)snackbarManager {
  snackbarManager.snackbarMessageViewBackgroundColor = [MDCSemanticColorScheme
               blendColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.8]
      withBackgroundColor:colorScheme.surfaceColor];
  snackbarManager.messageTextColor =
      [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *buttonTitleColor = [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.6];
  [snackbarManager setButtonTitleColor:buttonTitleColor forState:UIControlStateNormal];
  [snackbarManager setButtonTitleColor:buttonTitleColor forState:UIControlStateHighlighted];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
   toSnackbarMessageView:(nonnull MDCSnackbarMessageView *)snackbarMessageView {
}
#pragma clang diagnostic pop

@end
