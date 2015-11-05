#import <UIKit/UIKit.h>

#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypographyConfig.h"

#import "googlemac/iPhone/Shared/GoogleKit/Typography/GoogleKitTypography.h"

@interface GOOTypography (GoogleAdditions)  // not in Material Components

/**
 * Returns YES if the font is considered "large" for the purposes of calculating contrast ratios.
 *
 * If font was obtained from GOOTypography then the result will be accurate, otherwise the
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
