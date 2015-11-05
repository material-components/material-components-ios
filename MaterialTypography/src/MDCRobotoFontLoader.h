#import <UIKit/UIKit.h>

#import "MDCFontResource.h"
#import "MDCTypography.h"

/**
 * This class provides references to a set of @c MDCFontResources for the Roboto fonts.
 *
 * @ingroup Typography
 */
// TODO:(b/24810716) Move into separate target so that font assets can be excluded.
@interface MDCRobotoFontLoader : NSObject <MDCTypographyFontLoader>

/** Shared singleton instance. */
+ (nonnull instancetype)sharedInstance;

@property(nonatomic, strong, nonnull) MDCFontResource *lightFontResource;
@property(nonatomic, strong, nonnull) MDCFontResource *regularFontResource;
@property(nonatomic, strong, nonnull) MDCFontResource *mediumFontResource;
@property(nonatomic, strong, nonnull) MDCFontResource *boldFontResource;

@property(nonatomic, strong, nonnull) MDCFontResource *lightItalicFontResource;
@property(nonatomic, strong, nonnull) MDCFontResource *italicFontResource;
@property(nonatomic, strong, nonnull) MDCFontResource *mediumItalicFontResource;
@property(nonatomic, strong, nonnull) MDCFontResource *boldItalicFontResource;

- (nonnull UIFont *)lightFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)mediumFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize;

- (nonnull UIFont *)lightItalicFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize;
- (nonnull UIFont *)boldItalicFontOfSize:(CGFloat)fontSize;

@end
