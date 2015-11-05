#import "MDCTypographyFontLoader.h"

#import <CoreText/CoreText.h>

#import "MDCTypography+Constants.h"

@implementation MDCTypographyFontLoader

+ (NSBundle *)baseBundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // We may not be included by the main bundle, but rather by an embedded framework, so figure out
    // to which bundle our code is compiled, and use that as the starting point for bundle loading.
    bundle = [NSBundle bundleForClass:[self class]];
  });

  return bundle;
}

+ (BOOL)loadFontWithBundleFilename:(NSString *)filename {
  NSString *searchPath = [[self baseBundle] bundlePath];
  NSString *fontsBundlePath = [searchPath stringByAppendingPathComponent:kTypographyBundle];
  NSString *fontPath = [fontsBundlePath stringByAppendingPathComponent:filename];
  NSURL *fontURL = [NSURL fileURLWithPath:fontPath isDirectory:NO];
  if (!fontURL) {
    NSLog(@"Failed to locate '%@' in bundle at path '%@'.", filename, fontsBundlePath);
    return NO;
  }

  CFErrorRef error = NULL;
  BOOL registerResult = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)fontURL,
                                                         kCTFontManagerScopeProcess, &error);
  if (!registerResult) {
    if (error && CFErrorGetCode(error) == kCTFontManagerErrorAlreadyRegistered) {
      // If it's already been loaded by somebody else, we don't care.
      // We do not check the error domain to make sure they match because
      // kCTFontManagerErrorDomain is not defined in the iOS 8 SDK.
      // Radar 18651170 iOS 8 SDK missing definition for kCTFontManagerErrorDomain
      registerResult = YES;
    } else {
      NSLog(@"Failed to load font: %@", error);
    }
  }
  if (error) {
    CFRelease(error);
  }
  return registerResult;
}

+ (void)tryToLoadRobotoRegularFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kRegularFontFilename];
  });
}

+ (void)tryToLoadRobotoBoldFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kBoldFontFilename];
  });
}

+ (void)tryToLoadRobotoBoldItalicFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kBoldItalicFontFilename];
  });
}

+ (void)tryToLoadRobotoMediumFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kMediumFontFilename];
  });
}

+ (void)tryToLoadRobotoMediumItalicFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kMediumItalicFontFilename];
  });
}

+ (void)tryToLoadRobotoLightFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kLightFontFilename];
  });
}

+ (void)tryToLoadRobotoLightItalicFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kLightItalicFontFilename];
  });
}

+ (void)tryToLoadRobotoRegularItalicFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [MDCTypographyFontLoader loadFontWithBundleFilename:kRegularItalicFontFilename];
  });
}

@end
