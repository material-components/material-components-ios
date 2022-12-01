#import "MDCTypography.h"

API_DEPRECATED_BEGIN(
    "🤖👀 Use Typescale tokens instead. "
    "See go/material-ios-dynamic-type and go/material-ios-tokens#typescale-tokens for more info. "
    "This has go/material-ios-migrations#scriptable-potential 🤖👀",
    ios(12, 12))

/**
 Typographic helper for setting a custom font loader.

 @warning This class will soon be deprecated.

 @see https://material.io/go/design-typography#typography-styles
 */
@interface MDCTypography (FontLoader)

#pragma mark - Font loader access

/** Set the font loader in order to use a non-system font. */
+ (void)setFontLoader:(nonnull id<MDCTypographyFontLoading>)fontLoader;

@end

API_DEPRECATED_END
