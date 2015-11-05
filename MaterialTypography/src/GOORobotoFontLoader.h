#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypographyConfig.h"

#import <UIKit/UIKit.h>

#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOFontResource.h"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypography.h"

/**
 * This class provides references to a set of @c GOOFontResources for the Roboto fonts.
 *
 * @ingroup Typography
 */
// TODO:(b/24810716) Move into separate target so that font assets can be excluded.
@interface GOORobotoFontLoader : NSObject <GOOTypographyFontLoader>

/** Shared singleton instance. */
+ (nonnull instancetype)sharedInstance;

@property(nonatomic, strong, nonnull) GOOFontResource *lightFontResource;
@property(nonatomic, strong, nonnull) GOOFontResource *regularFontResource;
@property(nonatomic, strong, nonnull) GOOFontResource *mediumFontResource;
@property(nonatomic, strong, nonnull) GOOFontResource *boldFontResource;

@property(nonatomic, strong, nonnull) GOOFontResource *lightItalicFontResource;
@property(nonatomic, strong, nonnull) GOOFontResource *italicFontResource;
@property(nonatomic, strong, nonnull) GOOFontResource *mediumItalicFontResource;
@property(nonatomic, strong, nonnull) GOOFontResource *boldItalicFontResource;

- (nonnull UIFont *)lightFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)mediumFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize;

- (nonnull UIFont *)lightItalicFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)boldItalicFontOfSize:(CGFloat)fontSize;

@end
