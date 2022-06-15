#import "MDCTypography.h"

API_DEPRECATED_BEGIN("Follow go/material-ios-dynamic-type instead.", ios(12, API_TO_BE_DEPRECATED))

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
