#import <UIKit/UIKit.h>

/**
 * This class provides a way to register and load a custom font.
 *
 * @ingroup Typography
 */
@interface MDCFontResource : NSObject

/** The name of the font within the *.ttf file. */
@property(nonatomic, strong, nonnull) NSString *fontName;

/** The name of the font file. A *.ttf file. */
@property(nonatomic, strong, nonnull) NSString *filename;

/** The name of the bundle. */
@property(nonatomic, strong, nonnull) NSString *bundleFilename;

/** The bundle to look in for fonts. Required because resources may not be in the main bundle. */
@property(nonatomic, strong, nonnull) NSBundle *baseBundle;

/** The derived URL for the font asset. */
@property(nonatomic, strong, readonly, nullable) NSURL *fontURL;

/** The registered state of the custom font. */
@property(nonatomic) BOOL isRegistered;

/** This flag is true when the registration failed. It prevents future attempts at registration. */
@property(nonatomic) BOOL hasFailedRegistration;

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 * Designated initializer for the MDCFontResource.
 *
 * @param fontName The font's name as it is defined in the ttf file.
 * @param filename The name of the font file. usually a *.ttf file.
 * @param bundleFilename The name of the bundle.
 * @param baseBundle The bundle to look in.
 */
- (nonnull instancetype)initWithFontName:(nonnull NSString *)fontName
                                filename:(nonnull NSString *)filename
                          bundleFileName:(nonnull NSString *)bundleFilename
                              baseBundle:(nonnull NSBundle *)baseBundle NS_DESIGNATED_INITIALIZER;

/**
 * Attempts to register the font.
 *
 * The @c isRegistered and @c hasFailedRegistration flags reflect the results of this registration 
 * attempt. Returns the value of isRegistered.
 */
- (BOOL)registerFont;

/** A convience method for getting a font. */
- (nonnull UIFont *)fontOfSize:(CGFloat)fontSize;

@end
