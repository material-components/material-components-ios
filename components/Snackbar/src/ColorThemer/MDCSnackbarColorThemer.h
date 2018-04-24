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

#import <UIKit/UIKit.h>

#import "MaterialColorScheme.h"
#import "MaterialSnackbar.h"

/**
 The Material Design color system's themer for all snackbar messages.
 */
@interface MDCSnackbarColorThemer : NSObject

/**
 Applies a color scheme's properties to all snackbar messages.

 @param colorScheme The color scheme to apply to all snackbar messages.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme;

#pragma mark - Deprecated

/**
 Applies a color scheme to theme to a MDCSnackbarMessageView.

 @warning This method is deprecated. Consider using applySemanticColorScheme:colorScheme.

 @param colorScheme The color scheme to apply to MDCSnackbarMessageView.
 @param snackbarMessageView A MDCSnackbarMessageView instance to apply a color scheme.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
   toSnackbarMessageView:(nonnull MDCSnackbarMessageView *)snackbarMessageView
       __deprecated_msg("use applySemanticColorScheme: instead.");
@end
