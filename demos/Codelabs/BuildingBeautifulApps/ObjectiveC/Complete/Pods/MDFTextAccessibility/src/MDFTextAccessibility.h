/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

/** Options for selecting text colors that provide acceptable contrast ratios. */
typedef NS_OPTIONS(NSUInteger, MDFTextAccessibilityOptions) {
  /** No options. */
  MDFTextAccessibilityOptionsNone = 0,

  /** Font size is at least 14pt bold or 18pt normal. */
  MDFTextAccessibilityOptionsLargeFont = 1 << 0,

  /** Do not modify alpha values to find good colors. */
  MDFTextAccessibilityOptionsPreserveAlpha = 1 << 1,

  /** Prefer darker colors to lighter colors. */
  MDFTextAccessibilityOptionsPreferDarker = 1 << 2,

  /** Prefer lighter colors to darker colors. */
  MDFTextAccessibilityOptionsPreferLighter = 1 << 3,

  /** Use enhanced contrast ratios (level AAA) instead of minimum ratios (level AA). */
  MDFTextAccessibilityOptionsEnhancedContrast = 1 << 4,
};

/**
 MDFTextAccessiblity provides methods to compute accessible text colors.
 */
@interface MDFTextAccessibility : NSObject

/**
 An optionally transparent text color suitable for displaying on a background color with a
 particular font.

 The color returned will be white or black with an alpha value of targetTextAlpha, unless the
 contrast ratio is insufficient, in which case the alpha is increased (made more opaque).

 If the passed font is nil, then a conservative guess is used.

 @param backgroundColor The opaque background color the text will be displayed on.
 @param targetTextAlpha The target alpha of the text.
 @param font The font the text will use or nil.
 @return A color with acceptable contrast ratio for displaying text on |color|.
 */
+ (nonnull UIColor *)textColorOnBackgroundColor:(nonnull UIColor *)backgroundColor
                                targetTextAlpha:(CGFloat)targetTextAlpha
                                           font:(nullable UIFont *)font;

/**
 An optionally transparent text color suitable for displaying on a background image with a
 particular font.

 The color returned will be white or black with an alpha value of targetTextAlpha, unless the
 contrast ratio is insufficient, in which case the alpha is increased (made more opaque).

 If the passed font is nil, then a conservative guess is used.

 The content of the background image is simply averaged to make an average color, which is then used
 as if it were the background color of the text. Depending on the contents of the image, this
 approximation may or may not result in legible text.

 The supplied image region will be intersected with the image's bounds. If the resulting region is
 null or empty then this method returns nil.

 @param backgroundImage The opaque background image the text will be displayed on.
 @param region The region in which the text will be displayed. Can be conservatively large.
 @param targetTextAlpha The target alpha of the text.
 @param font The font to be used to display the text. Can be nil.
 @return A color with acceptable contrast ratio, or nil if the region is out of bounds of the image.
 */
+ (nullable UIColor *)textColorOnBackgroundImage:(nonnull UIImage *)backgroundImage
                                        inRegion:(CGRect)region
                                 targetTextAlpha:(CGFloat)targetTextAlpha
                                            font:(nullable UIFont *)font;

#pragma mark Advanced methods

/**
 An optionally transparent text color suitable for displaying text on a given opaque background
 color.

 This method calls textColorFromChoices:onColor:options: with the choices [white, black], both
 with their alpha set to targetTextAlpha.

 If MDFTextAccessibilityOptionsPreserveAlpha is included in the options, then the algorithm will not
 modify the alpha values, which may result in no color being returned at all.

 @param backgroundColor The opaque background color the text will be displayed on.
 @param targetTextAlpha The target alpha of the text.
 @param options A combination of MDFTextAccessibilityOptions values.
 @return A color with acceptable contrast ratio or nil if no such color exists.
 */
+ (nullable UIColor *)textColorOnBackgroundColor:(nonnull UIColor *)backgroundColor
                                 targetTextAlpha:(CGFloat)targetTextAlpha
                                         options:(MDFTextAccessibilityOptions)options;

/**
 A color selected from a set which is suitable for displaying text on a given opaque background
 color.

 Since the minimum ratio for "large" text is less stringent, set
 the MDFTextAccessibilityOptionsLargeFont bit if the font size will be greater than or
 equal to 18pt normal or 14pt bold. If in doubt or if the text size can vary, be conservative and do
 not specify MDFTextAccessibilityOptionsLargeFont in the options.

 By default, the first acceptable color in |choices| will be returned. If
 MDFTextAccessibilityOptionsPreferLighter is set, then the lightest acceptable color will be
 returned, and if MDFTextAccessibilityOptionsPreferDarker is set, then the darkest acceptable color
 will be returned. This allows for a standard set of text colors to be used in different situations.

 By default, the algorithm will attempt to modify the alpha value of colors in |choices| instead
 of switching to an alternate color, under the assumption that text with slightly different
 alpha values is less noticible than, for example, black text where white text is usually used.
 If MDFTextAccessibilityOptionsPreserveAlpha is included in the options, then the algorithm will not
 modify the alpha values, which may result in no color being returned at all.

 @param choices An array of text color UIColor objects with optional alpha values.
 @param backgroundColor The opaque background color the text will be displayed on.
 @param options A combination of MDFTextAccessibilityOptions values.
 @return A color with acceptable contrast ratio or nil if no such color exists.
 */
+ (nullable UIColor *)textColorFromChoices:(nonnull NSArray<UIColor *> *)choices
                         onBackgroundColor:(nonnull UIColor *)backgroundColor
                                   options:(MDFTextAccessibilityOptions)options;

/**
 The minimum alpha that text can have and still have an acceptable contrast ratio. Depending on
 color combinations, the minimum useable alpha can vary.

 Since the minimum ratio for "large" text is less stringent, set
 the MDFTextAccessibilityOptionsLargeFont bit if the font size will be greater than or
 equal to 18pt normal or 14pt bold. If in doubt or if the text size can vary, be conservative and do
 not specify MDFTextAccessibilityOptionsLargeFont in the options.

 @note There are some color combinations (white on white) for which an acceptable alpha value
 doesn't exist.

 @param textColor The text color (alpha is ignored).
 @param backgroundColor The opaque background color the text will be displayed on.
 @param options A combination of MDFTextAccessibilityOptions values.
 @return The minimum alpha value to use in this situation, or -1 if there is no such alpha.
 */
+ (CGFloat)minAlphaOfTextColor:(nonnull UIColor *)textColor
             onBackgroundColor:(nonnull UIColor *)backgroundColor
                       options:(MDFTextAccessibilityOptions)options;

/**
 The contrast ratio of a text color when displayed on an opaque background color.

 @param textColor A text color with optional transparency.
 @param backgroundColor The opaque background color the text will be displayed on.
 @return The contrast ratio of the text color on the background color.
 */
+ (CGFloat)contrastRatioForTextColor:(nonnull UIColor *)textColor
                   onBackgroundColor:(nonnull UIColor *)backgroundColor;

/**
 Whether a text color passes accessibility standards when displayed on an opaque background color.

 MDFTextAccessibilityOptionsLargeFont and MDFTextAccessibilityOptionsEnhancedContrast are relevant
 options for this method.

 @param textColor A text color with optional transparency.
 @param backgroundColor The opaque background color the text will be displayed on.
 @param options A combination of MDFTextAccessibilityOptions values.
 @return YES if the text color would meet accessibility standards.
 */
+ (BOOL)textColor:(nonnull UIColor *)textColor
    passesOnBackgroundColor:(nonnull UIColor *)backgroundColor
                    options:(MDFTextAccessibilityOptions)options;

/**
 Whether a particular font would be considered "large" for the purposes of calculating
 contrast ratios.

 Large fonts are defined as greater than 18pt normal or 14pt bold. If the passed font is nil, then
 this method returns NO.
 For more see: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html

 @param font The font to examine, or nil.
 @return YES if the font is non-nil and is considered "large".
 */
+ (BOOL)isLargeForContrastRatios:(nullable UIFont *)font;

@end
