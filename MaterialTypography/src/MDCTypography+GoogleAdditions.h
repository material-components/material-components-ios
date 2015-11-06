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

#import "MaterialTypography.h"

@interface MDCTypography (GoogleAdditions)  // not in Material Components

/**
 * Returns YES if the font is considered "large" for the purposes of calculating contrast ratios.
 *
 * If font was obtained from MDCTypography then the result will be accurate, otherwise the
 * implementation guesses conservatively.
 *
 * @ingroup ContrastRatios
 * @see QTMColorGroup
 * @see <a href="http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html#larger-scaledef">
W3 Reference on contrast and text size</a>
 */
+ (BOOL)isLargeForContrastRatios:(nonnull UIFont *)font;

/**
 * Default opacity of hints (like those in text fields or labels).
 * Use only if QTMColorGroup does not provide a proper color.
 */
+ (CGFloat)defaultHintOpacity;

#pragma mark - Bold and italic
// TODO(randallli): Split out rich text from the vanilla typography bundle. b/24810716

/**
 * Returns the italic Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (nonnull UIFont *)robotoItalicWithSize:(CGFloat)pointSize;

/**
 * Returns the bold Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (nonnull UIFont *)robotoBoldWithSize:(CGFloat)pointSize;

/**
 * Returns the bold italic Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (nonnull UIFont *)robotoBoldItalicWithSize:(CGFloat)pointSize;

/** Returns an italic version of the specified font. */
+ (nonnull UIFont *)italicFontFromFont:(nonnull UIFont *)font;

@end

@interface MDCRobotoFontLoader (GoogleAdditions)

/**
 * Provides a way to set the bundle where the Roboto fonts can be found.
 *
 * The default value is MDCRobotoFontLoader's bundle.
 */
@property(nonatomic, strong, null_resettable) NSBundle *baseBundle;

@end
