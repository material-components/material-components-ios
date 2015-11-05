#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOFontResource.h"

#import <CoreText/CoreText.h>

@implementation GOOFontResource

- (instancetype)initWithFontName:(NSString *)fontName
                        filename:(NSString *)filename
                  bundleFileName:(NSString *)bundleFilename
                      baseBundle:(NSBundle *)baseBundle {
  self = [super init];
  if (self) {
    _fontName = fontName;
    _filename = filename;
    _bundleFilename = bundleFilename;
    _baseBundle = baseBundle;
  }
  return self;
}

- (NSURL *)fontURL {
  NSString *searchPath = [self.baseBundle bundlePath];
  NSString *fontsBundlePath = [searchPath stringByAppendingPathComponent:self.bundleFilename];
  NSString *fontPath = [fontsBundlePath stringByAppendingPathComponent:self.filename];
  NSURL *fontURL = [NSURL fileURLWithPath:fontPath isDirectory:NO];
  if (!fontURL) {
    NSLog(@"Failed to locate '%@' in bundle at path '%@'.", _filename, fontsBundlePath);
  }
  return fontURL;
}

- (BOOL)registerFont {
  if (_isRegistered) {
    return YES;
  }
  if (_hasFailedRegistration) {
    return NO;
  }
  CFErrorRef error = NULL;
  _isRegistered = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)self.fontURL,
                                                   kCTFontManagerScopeProcess, &error);
  if (!_isRegistered) {
    if (error && CFErrorGetCode(error) == kCTFontManagerErrorAlreadyRegistered) {
      // If it's already been loaded by somebody else, we don't care.
      // We do not check the error domain to make sure they match because
      // kCTFontManagerErrorDomain is not defined in the iOS 8 SDK.
      // Radar 18651170 iOS 8 SDK missing definition for kCTFontManagerErrorDomain
      _isRegistered = YES;
    } else {
      NSLog(@"Failed to load font: %@", error);
      _hasFailedRegistration = YES;
    }
  }
  if (error) {
    CFRelease(error);
  }
  return _isRegistered;
}

- (UIFont *)fontOfSize:(CGFloat)fontSize {
  [self registerFont];
  UIFont *font = [UIFont fontWithName:self.fontName size:fontSize];
  if (!font) {
    // TODO(randallli) setup sysetm to do bold and italics fallback system fonts.
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

@end
