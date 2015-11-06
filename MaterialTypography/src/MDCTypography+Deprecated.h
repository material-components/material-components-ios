/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MDCTypography.h"

// TODO(randallli): Methods in this file are scheduled for deprecation. (b/24808912)
@interface MDCTypography (Deprecated)

#pragma mark - deprecated API
// TODO(randallli): move these api into the components that use them. (b/24811114)

/** Returns a font for text fields. */
+ (UIFont *)textFieldFont;

/** Returns a font for section header in side bar lists. */
+ (UIFont *)sidebarSectionTitleFont;

/** Returns a font for notification badges in side bar carousel. */
+ (UIFont *)sidebarCarouselNotificationFont;

#pragma mark - renamed API

/** Returns the subtitle font, used for cell subtitles. (aka Subheader) */
+ (UIFont *)subtitleFont __deprecated_msg(
    "subtitleFont is deprecated."
    " Please use subheadFont instead."
    " Will be removed on or after November 11, 2015.");

/** Returns the bold text font. (aka. body font 2) */
+ (UIFont *)boldTextFont __deprecated_msg(
    "boldTextFont is deprecated."
    " Please use body2Font instead."
    " Will be removed on or after November 11, 2015.");

/** Returns the regular text font. (aka. body font 1) */
+ (UIFont *)textFont __deprecated_msg(
    "textFont is deprecated."
    " Please use body1Font instead."
    " Will be removed on or after November 11, 2015.");

/** Returns a menu font. */
+ (UIFont *)menuFont __deprecated_msg(
    "menuFont is deprecated."
    " Please use buttonFont instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity value for headlineFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultDisplayOpacity __deprecated_msg(
    "defaultDisplayOpacity is deprecated."
    " Please use displayFont1Opacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity value for headlineFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultHeadlineOpacity __deprecated_msg(
    "defaultHeadlineOpacity is deprecated."
    " Please use headlineFontOpacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opactiy for titleFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultTitleOpacity __deprecated_msg(
    "defalutTitleOpacity is deprecated."
    " Please use titleFontOpacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity for subtitleFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultSubtitleOpacity __deprecated_msg(
    "defaultSubtitleOpacity is deprecated."
    " Please use subheadFontOpacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity for boldTextFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultBoldTextOpacity __deprecated_msg(
    "defaultBoldTextOpacity is deprecated."
    " Please use body2FontOpacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity for textFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultTextOpacity __deprecated_msg(
    "defaultTextOpacity is deprecated."
    " Please use body1FontOpacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity for caption.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultCaptionOpacity __deprecated_msg(
    "defaultCaptionOpacity is deprecated."
    " Please use captionFontOpacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity for menuFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultMenuOpacity __deprecated_msg(
    "defaultMenuOpacity is deprecated."
    " Please use buttonFontOpacity instead."
    " Will be removed on or after November 11, 2015.");

/**
 * Default opacity for buttonFont.
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultButtonOpacity __deprecated_msg(
    "defaultButtonOpacity is deprecated."
    " Please use buttonFontOpacity instead."
    " Will be removed on or after November 11, 2015.");

#pragma mark - Incorrect rename

/** Returns the display 4 font. (largest of the display font sizes) */
+ (UIFont *)displayFont4;

/** Returns the recommended opacity of black text for the display fonts 4. */
+ (CGFloat)displayFont4Opacity;

/** Returns the display 3 font. (second largest of the display font sizes) */
+ (UIFont *)displayFont3;

/** Returns the recommended opacity of black text for the display fonts 3. */
+ (CGFloat)displayFont3Opacity;

/** Returns the display 2 font. (third largest of the display font sizes) */
+ (UIFont *)displayFont2;

/** Returns the recommended opacity of black text for the display fonts 2. */
+ (CGFloat)displayFont2Opacity;

/** Returns the display 1 font. (smallest of the display font sizes) */
+ (UIFont *)displayFont1;

/** Returns the recommended opacity of black text for the display fonts 1. */
+ (CGFloat)displayFont1Opacity;

@end
