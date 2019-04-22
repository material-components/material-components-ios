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

#import <UIKit/UIKit.h>

#import "MaterialColorScheme.h"
#import "MaterialSnackbar.h"

/**
 The Material Design color system's themer for all snackbar messages.

 @warning This API will eventually be deprecated. See the individual method documentation for
 details on replacement APIs.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCSnackbarColorThemer : NSObject
@end

@interface MDCSnackbarColorThemer (Deprecated)

/**
 Applies a color scheme's properties to all snackbar messages.

 @param colorScheme The color scheme to apply to all snackbar messages.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme;

/**
 Applies a color scheme's properties to all snackbar messages for an instance of MDCSnackbarManager.

 @param colorScheme The color scheme to apply to all snackbar messages.
 @param snackbarManager The MDCSnackbarManager instance to theme.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
               toSnackbarManager:(nonnull MDCSnackbarManager *)snackbarManager;

/**
 Applies a color scheme to theme to a MDCSnackbarMessageView.

 @param colorScheme The color scheme to apply to MDCSnackbarMessageView.
 @param snackbarMessageView A MDCSnackbarMessageView instance to apply a color scheme.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
    toSnackbarMessageView:(nonnull MDCSnackbarMessageView *)snackbarMessageView
    __deprecated_msg("use applySemanticColorScheme: instead.");

@end
