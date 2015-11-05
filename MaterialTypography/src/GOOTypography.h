#import <UIKit/UIKit.h>

/**
 * GOOTypography uses this protocol to delegate responsibility of loading the custom fonts.
 *
 * The spec defines the Roboto font family and uses three fonts in the named styles. Use this
 * protocol to define your own fonts if there is a brand need.
 *
 * @see https://www.google.com/design/spec/style/typography.html#typography-styles
 *
 * @ingroup Typography
 */
@protocol GOOTypographyFontLoader <NSObject>
@required

- (nonnull UIFont *)lightFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)mediumFontOfSize:(CGFloat)fontSize;

@end

/**
 * Typographic constants and helpers.
 *
 * To use these fonts, you must add GOOTypography.bundle to your target.
 *
 * Spec:
 * https://www.google.com/design/spec/style/typography.html#typography-styles
 *
 * @ingroup Typography
 */
@interface GOOTypography : NSObject

#pragma mark - Custom font loader

/** Set the font loader in order to use a non-Roboto or non-system font. */
+ (void)setFontLoader:(nonnull id<GOOTypographyFontLoader>)fontLoader;

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

#pragma mark - Common UI fonts.

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

#pragma mark - Roboto fonts

/**
 * Returns the regular Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (nonnull UIFont *)robotoRegularWithSize:(CGFloat)pointSize;

/**
 * Returns the medium Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (nonnull UIFont *)robotoMediumWithSize:(CGFloat)pointSize;

/**
 * Returns the light Roboto font at the indicated point size.
 *
 * @param pointSize The requested point size for the font.
 */
+ (nonnull UIFont *)robotoLightWithSize:(CGFloat)pointSize;

@end

/**
 * GOOSystemFontLoader allows you to use the system font for @c GOOTypography.
 *
 * To use:
 * [GOOTypography setFontLoader:[GOOSystemFontLoader new]];
 */
@interface GOOSystemFontLoader : NSObject <GOOTypographyFontLoader>
@end
