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

/**
 * Material typographic specification.
 *
 * To use these fonts, you must add MDCTypography.bundle to your target.
 *
 * Spec:
 * https://www.google.com/design/spec/style/typography.html#typography-styles
 *
 * @ingroup MDCTypography
 */
@interface MDCTypography : NSObject

#pragma mark - Display fonts (extra large fonts)

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

#pragma mark - Common UI fonts.

/** Returns the headline font. */
+ (UIFont *)headlineFont;

/** Returns the recommended opacity of black text for the headline font. */
+ (CGFloat)headlineFontOpacity;

/** Returns the title font. */
+ (UIFont *)titleFont;

/** Returns the recommended opacity of black text for the title font. */
+ (CGFloat)titleFontOpacity;

/** Returns the subhead font. (subtitle) */
+ (UIFont *)subheadFont;

/** Returns the recommended opacity of black text for the subhead font. */
+ (CGFloat)subheadFontOpacity;

/** Returns the body 2 text font. (bold text) */
+ (UIFont *)body2Font;

/** Returns the recommended opacity of black text for the body 2 font. */
+ (CGFloat)body2FontOpacity;

/** Returns the body 1 text font. (normal text) */
+ (UIFont *)body1Font;

/** Returns the recommended opacity of black text for the body 1 font. */
+ (CGFloat)body1FontOpacity;

/** Returns the caption font. (a small font for image captions) */
+ (UIFont *)captionFont;

/** Returns the recommended opacity of black text for the caption font. */
+ (CGFloat)captionFontOpacity;

/** Returns a font for buttons. */
+ (UIFont *)buttonFont;

/** Returns the recommended opacity of black text for the button font. */
+ (CGFloat)buttonFontOpacity;

#pragma mark - Roboto fonts

/**
 * Returns the regular Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (UIFont *)robotoRegularWithSize:(CGFloat)pointSize;

/**
 * Returns the bold Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (UIFont *)robotoBoldWithSize:(CGFloat)pointSize;

/**
 * Returns the medium Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (UIFont *)robotoMediumWithSize:(CGFloat)pointSize;

/**
 * Returns the light Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (UIFont *)robotoLightWithSize:(CGFloat)pointSize;

/**
 * Returns the italic Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (UIFont *)robotoItalicWithSize:(CGFloat)pointSize;

/**
 * Returns the bold italic Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (UIFont *)robotoBoldItalicWithSize:(CGFloat)pointSize;

@end
