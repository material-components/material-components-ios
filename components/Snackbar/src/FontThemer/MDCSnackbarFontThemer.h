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

#import "MaterialSnackbar.h"
#import "MaterialThemes.h"

#pragma mark - Soon to be deprecated

/**
 Used to apply a font scheme to theme to MDCSnackbarMessageView.
 
 @warning This class will soon be deprecated. Please consider using MDCSnackbarTypographyThemer
 instead.
 */
@interface MDCSnackbarFontThemer : NSObject

/**
 Applies a font scheme to theme to a MDCSnackbarMessageView.

 @warning This API will soon be deprecated. Please consider using MDCSnackbarTypographyThemer
 instead.

 @param fontScheme The font scheme to apply to MDCSnackbarMessageView.
 @param snackbarMessageView A MDCSnackbarMessageView instance to apply a font scheme.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
    toSnackbarMessageView:(nonnull MDCSnackbarMessageView *)snackbarMessageView;

/**
 Applies a font scheme to theme to a MDCSnackbarMessageView.

 @warning This API will soon be deprecated. Please consider using MDCSnackbarTypographyThemer
 instead.

 @param fontScheme The font scheme to apply to MDCSnackbarMessageView.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme;

@end
