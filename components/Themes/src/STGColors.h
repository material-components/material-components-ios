#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Singleton color-loader.  Loads color palettes from colors.plist.
 */
@interface STGColors : NSObject

/**
 * If no arguments are supplied when fetching a color, the default palette is used.  The default
 * palette is set to the first palette name encountered in colors.plist.
 *
 * Note: |defaultPalette| will not update if you attempt to set it to a palette name that does not
 * exist in colors.plist, and instead will log an error.
 */
@property(nonatomic) NSString *defaultPalette;

/**
 * Singleton loader for STGColorLoader.
 */
+ (STGColors *)sharedInstance;

/**
 * Returns an NSDictionary mapping from color names (NSString*) to colors (UIColor),
 * or nil if no such palette exists for |paletteName|.
 */
- (NSDictionary *)paletteWithName:(NSString *)paletteName;

/**
 * Returns a UIColor for the color name from |defaultPalette|, or nil if no such color exists.
 */
- (UIColor *)colorWithName:(NSString *)colorName;

/**
 * Returns a UIColor for the color name from the specified palette, nil if no
 * such palette or color exists.
 */
- (UIColor *)colorWithName:(NSString *)colorName fromPalette:(NSString *)paletteName;

@end
