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

/**
 A simple typography scheme that provides semantic fonts. There are no optional
 properties, all fonts must be provided, supporting more reliable typography theming.
 */
@protocol MDCTypographyScheming <NSObject>

/**
 The headline 1 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline1;

/**
 The headline 2 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline2;

/**
 The headline 3 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline3;

/**
 The headline 4 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline4;

/**
 The headline 5 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline5;

/**
 The headline 6 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline6;

/**
 The subtitle 1 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *subtitle1;

/**
 The subtitle 2 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *subtitle2;

/**
 The body 1 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *body1;

/**
 Return the body 2 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *body2;

/**
 Return the caption font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *caption;

/**
 Return the button font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *button;

/**
 Return the overline font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *overline;

/**
 Whether user interface elements should automatically resize based on the device's setting.

 This can be used by client to communicate whether they support dynamic type to both our theming
 functionality and embedded frameworks that also render UI.

 @warning This API will eventually be deprecated. Please use
 @c useCurrentContentSizeCategoryWhenApplied instead.

 @note  The value of @c useCurrentContentSizeCategoryWhenApplied (if implemented) and @c
 mdc_adjustsFontForContentSizeCategory must always be the same.

*/
@property(nonatomic, readonly) BOOL mdc_adjustsFontForContentSizeCategory __deprecated_msg(
    "Use useCurrentContentSizeCategoryWhenApplied instead.");

@optional

/**
 A hint for how fonts in this scheme should be applied to components in relation to Dynamic Type.

 If this flag is enabled and the typography scheme's font is scalable with Dynamic Type, then fonts
 should be adjusted for the current Dynamic Type content size category prior to being assigned to
 the component.

 @note This flag will become required in the future as a replacement for
 @c mdc_adjustsFontForContentSizeCategory. The value of this flag needs to be the same as @c
 mdc_adjustsFontForContentSizeCategory.
 */
@property(nonatomic, assign, readonly) BOOL useCurrentContentSizeCategoryWhenApplied;

@end
