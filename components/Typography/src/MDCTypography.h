/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#pragma mark - Soon to be deprecated

/**
 MDCTypography uses this protocol to delegate responsibility of loading the custom fonts.

 The spec defines the Roboto font family and uses three fonts in the named styles. Use this
 protocol to define your own fonts if there is a brand need.

 @warning This protocol will soon be deprecated. Consider using MDCTypographyScheme from the
 schemes/Typography component instead.

 @see https://material.io/go/design-typography#typography-styles
 */
@protocol MDCTypographyFontLoading <NSObject>
@required

/** Asks the receiver to return a font with a light weight. FontSize must be larger tha 0. */
- (nullable UIFont *)lightFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with a normal weight. FontSize must be larger tha 0. */
- (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with a medium weight. FontSize must be larger tha 0. */
- (nullable UIFont *)mediumFontOfSize:(CGFloat)fontSize;

@optional

/** Asks the receiver to return a font with a bold weight. FontSize must be larger tha 0. */
- (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return an italic font. FontSize must be larger tha 0. */
- (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with an italic bold weight. FontSize must be larger tha 0. */
- (nullable UIFont *)boldItalicFontOfSize:(CGFloat)fontSize;

/** Returns a bold version of the specified font. */
- (nonnull UIFont *)boldFontFromFont:(nonnull UIFont *)font;

/** Returns an italic version of the specified font. */
- (nonnull UIFont *)italicFontFromFont:(nonnull UIFont *)font;
/**
 Asks the receiver to determine if a particular font would be considered "large" for the purposes of
 calculating contrast ratios.

 Large fonts are defined as greater than 18pt normal or 14pt bold.
 For more see: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html

 @param font The font to examine.
 @return YES if the font is considered "large".
 */
- (BOOL)isLargeForContrastRatios:(nonnull UIFont *)font;

@end

/**
 Typographic constants and helpers.

 To use these fonts, you must add MaterialTypography.bundle to your target.

 @warning This class will soon be deprecated. Consider using MDCTypographyScheme from the
 schemes/Typography component instead.

 @see https://material.io/go/design-typography#typography-styles
 */
@interface MDCTypography : NSObject

#pragma mark - Font loader access

/** Set the font loader in order to use a non-system font. */
+ (void)setFontLoader:(nonnull id<MDCTypographyFontLoading>)fontLoader;

/** Get the current font loader. */
+ (nonnull id<MDCTypographyFontLoading>)fontLoader;

#pragma mark - Display fonts (extra large fonts)

/** Returns the display 4 font. (largest of the display font sizes) */
+ (nonnull UIFont *)display4Font;

/** Returns the recommended opacity of black text for the display fonts 4. */
+ (CGFloat)display4FontOpacity;

/** Returns the display 3 font. (second largest of the display font sizes) */
+ (nonnull UIFont *)display3Font;

/** Returns the recommended opacity of black text for the display fonts 3. */
+ (CGFloat)display3FontOpacity;

/** Returns the display 2 font. (third largest of the display font sizes) */
+ (nonnull UIFont *)display2Font;

/** Returns the recommended opacity of black text for the display fonts 2. */
+ (CGFloat)display2FontOpacity;

/** Returns the display 1 font. (smallest of the display font sizes) */
+ (nonnull UIFont *)display1Font;

/** Returns the recommended opacity of black text for the display fonts 1. */
+ (CGFloat)display1FontOpacity;

#pragma mark - Common UI fonts

/** Returns the headline font. */
+ (nonnull UIFont *)headlineFont;

/** Returns the recommended opacity of black text for the headline font. */
+ (CGFloat)headlineFontOpacity;

/** Returns the title font. */
+ (nonnull UIFont *)titleFont;

/** Returns the recommended opacity of black text for the title font. */
+ (CGFloat)titleFontOpacity;

/** Returns the subhead font. (subtitle) */
+ (nonnull UIFont *)subheadFont;

/** Returns the recommended opacity of black text for the subhead font. */
+ (CGFloat)subheadFontOpacity;

/** Returns the body 2 text font. (bold text) */
+ (nonnull UIFont *)body2Font;

/** Returns the recommended opacity of black text for the body 2 font. */
+ (CGFloat)body2FontOpacity;

/** Returns the body 1 text font. (normal text) */
+ (nonnull UIFont *)body1Font;

/** Returns the recommended opacity of black text for the body 1 font. */
+ (CGFloat)body1FontOpacity;

/** Returns the caption font. (a small font for image captions) */
+ (nonnull UIFont *)captionFont;

/** Returns the recommended opacity of black text for the caption font. */
+ (CGFloat)captionFontOpacity;

/** Returns a font for buttons. */
+ (nonnull UIFont *)buttonFont;

/** Returns the recommended opacity of black text for the button font. */
+ (CGFloat)buttonFontOpacity;

/** Returns a bold version of the specified font. */
+ (nonnull UIFont *)boldFontFromFont:(nonnull UIFont *)font;

/** Returns an italic version of the specified font. */
+ (nonnull UIFont *)italicFontFromFont:(nonnull UIFont *)font;

/**
 Asks the receiver to determine if a particular font would be considered "large" for the purposes of
 calculating contrast ratios.

 Large fonts are defined as greater than 18pt normal or 14pt bold. If the passed font is nil, then
 this method returns NO.
 For more see: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html

 @param font The font to examine.
 @return YES if the font is non-nil and is considered "large".
 */
+ (BOOL)isLargeForContrastRatios:(nonnull UIFont *)font;

@end

/**
 MDCSystemFontLoader allows you to use the system font for @c MDCTypography.

 @warning This class will soon be deprecated. Consider using MDCTypographyScheme from the
 schemes/Typography component instead.

 #### Example

 ```
 [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];
 ```
 */
@interface MDCSystemFontLoader : NSObject <MDCTypographyFontLoading>
@end
