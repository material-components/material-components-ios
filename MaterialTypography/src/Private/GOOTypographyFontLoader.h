#import <Foundation/Foundation.h>

@interface GOOTypographyFontLoader : NSObject
/**
 * @internal
 * This class provides conveince methods to grab roboto fonts.
 *
 * @ingroup Typography
 */

// fonts in the spec
+ (void)tryToLoadRobotoLightFont;
+ (void)tryToLoadRobotoRegularFont;
+ (void)tryToLoadRobotoMediumFont;

// others
+ (void)tryToLoadRobotoBoldFont;
+ (void)tryToLoadRobotoRegularItalicFont;
+ (void)tryToLoadRobotoBoldItalicFont;
+ (void)tryToLoadRobotoMediumItalicFont;
+ (void)tryToLoadRobotoLightItalicFont;

@end
