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

/**
 Used to apply a font scheme to theme to MDCSnackbarMessageView.
 This class will soon be deprecated, please use MDCSnackbarTypographyThemer instead.
 */
@interface MDCSnackbarFontThemer : NSObject

/**
 Applies a font scheme to theme to a MDCSnackbarMessageView.
 
 @param fontScheme The font scheme to apply to MDCSnackbarMessageView.
 @param snackbarMessageView A MDCSnackbarMessageView instance to apply a font scheme. Use a
     UIAppearance proxy to apply a font scheme to all instances of MDCSnackbarMessageView.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
    toSnackbarMessageView:(nonnull MDCSnackbarMessageView *)snackbarMessageView;

/**
 Applies a font scheme to theme to a MDCSnackbarMessageView.

 @param fontScheme The font scheme to apply to MDCSnackbarMessageView.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme;

@end
