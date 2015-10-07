/*
 Copyright 2015-present Google Inc. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCTypography.h"

#import <CoreText/CoreText.h>

static const CGFloat kStandardOpacity = 0.87f;
static const CGFloat kSecondaryOpacity = 0.54f;

static NSString *const kRegularFontName = @"Roboto-Regular";
static NSString *const kRegularItalicFontName = @"Roboto-Italic";
static NSString *const kBoldFontName = @"Roboto-Bold";
static NSString *const kBoldItalicFontName = @"Roboto-BoldItalic";
static NSString *const kMediumFontName = @"Roboto-Medium";
static NSString *const kMediumItalicFontName = @"Roboto-MediumItalic";
static NSString *const kLightFontName = @"Roboto-Light";
static NSString *const kLightItalicFontName = @"Roboto-LightItalic";

static NSString *const kRegularFontFilename = @"Roboto-Regular.ttf";
static NSString *const kRegularItalicFontFilename = @"Roboto-Italic.ttf";
static NSString *const kBoldFontFilename = @"Roboto-Bold.ttf";
static NSString *const kBoldItalicFontFilename = @"Roboto-BoldItalic.ttf";
static NSString *const kMediumFontFilename = @"Roboto-Medium.ttf";
static NSString *const kMediumItalicFontFilename = @"Roboto-MediumItalic.ttf";
static NSString *const kLightFontFilename = @"Roboto-Light.ttf";
static NSString *const kLightItalicFontFilename = @"Roboto-LightItalic.ttf";

static NSString *const kTypographyBundle = @"MDCTypography.bundle";

@implementation MDCTypography

#pragma mark - Display fonts (extra large fonts)

+ (UIFont *)displayFont4 {
  return [self robotoLightWithSize:112];
}

+ (CGFloat)displayFont4Opacity {
  return kSecondaryOpacity;
}

+ (UIFont *)displayFont3 {
  return [self robotoRegularWithSize:56];
}

+ (CGFloat)displayFont3Opacity {
  return kSecondaryOpacity;
}

+ (UIFont *)displayFont2 {
  return [self robotoRegularWithSize:45];
}

+ (CGFloat)displayFont2Opacity {
  return kSecondaryOpacity;
}

+ (UIFont *)displayFont1 {
  return [self robotoRegularWithSize:34];
}

/** Returns the recommended opacity of black text for the display fonts 1. */
+ (CGFloat)displayFont1Opacity {
  return kSecondaryOpacity;
}

#pragma mark - Common UI fonts.

/** Returns the headline font. */
+ (UIFont *)headlineFont {
  return [self robotoRegularWithSize:24];
}

/** Returns the recommended opacity of black text for the headline font. */
+ (CGFloat)headlineFontOpacity {
  return kStandardOpacity;
}

/** Returns the title font. */
+ (UIFont *)titleFont {
  return [self robotoMediumWithSize:20];
}

/** Returns the recommended opacity of black text for the title font. */
+ (CGFloat)titleFontOpacity {
  return kStandardOpacity;
}

/** Returns the subhead font. (subtitle) */
+ (UIFont *)subheadFont {
  return [self robotoRegularWithSize:16];
}

/** Returns the recommended opacity of black text for the subhead font. */
+ (CGFloat)subheadFontOpacity {
  return kStandardOpacity;
}

/** Returns the body 2 text font. (bold text) */
+ (UIFont *)body2Font {
  return [self robotoMediumWithSize:14];
}

/** Returns the recommended opacity of black text for the body 2 font. */
+ (CGFloat)body2FontOpacity {
  return kStandardOpacity;
}

/** Returns the body 1 text font. (normal text) */
+ (UIFont *)body1Font {
  return [self robotoRegularWithSize:14];
}

/** Returns the recommended opacity of black text for the body 1 font. */
+ (CGFloat)body1FontOpacity {
  return kStandardOpacity;
}

/** Returns the caption font. (a small font for image captions) */
+ (UIFont *)captionFont {
  return [self robotoRegularWithSize:12];
}

/** Returns the recommended opacity of black text for the caption font. */
+ (CGFloat)captionFontOpacity {
  return kSecondaryOpacity;
}

/** Returns a font for buttons. */
+ (UIFont *)buttonFont {
  return [self robotoMediumWithSize:14];
}

/** Returns the recommended opacity of black text for the button font. */
+ (CGFloat)buttonFontOpacity {
  return kStandardOpacity;
}

#pragma mark - Roboto fonts

+ (UIFont *)robotoRegularWithSize:(CGFloat)pointSize {
  UIFont *font = [UIFont fontWithName:kRegularFontName size:pointSize];
  if (!font) {
    [self tryToLoadRobotoRegularFont];
    font = [UIFont fontWithName:kRegularFontName size:pointSize];
  }
  if (!font) {
    font = [UIFont systemFontOfSize:pointSize];
  }
  return font;
}

+ (UIFont *)robotoBoldWithSize:(CGFloat)pointSize {
  UIFont *font = [UIFont fontWithName:kBoldFontName size:pointSize];
  if (!font) {
    [self tryToLoadRobotoBoldFont];
    font = [UIFont fontWithName:kBoldFontName size:pointSize];
  }
  if (!font) {
    font = [UIFont boldSystemFontOfSize:pointSize];
  }
  return font;
}

+ (UIFont *)robotoMediumWithSize:(CGFloat)pointSize {
  UIFont *font = [UIFont fontWithName:kMediumFontName size:pointSize];
  if (!font) {
    [self tryToLoadRobotoMediumFont];
    font = [UIFont fontWithName:kMediumFontName size:pointSize];
  }
  if (!font) {
    font = [UIFont systemFontOfSize:pointSize];
  }
  return font;
}

+ (UIFont *)robotoLightWithSize:(CGFloat)pointSize {
  UIFont *font = [UIFont fontWithName:kLightFontName size:pointSize];
  if (!font) {
    [self tryToLoadRobotoLightFont];
    font = [UIFont fontWithName:kLightFontName size:pointSize];
  }
  if (!font) {
    font = [UIFont systemFontOfSize:pointSize];
  }
  return font;
}

+ (UIFont *)robotoItalicWithSize:(CGFloat)pointSize {
  UIFont *font = [UIFont fontWithName:kRegularItalicFontName size:pointSize];
  if (!font) {
    [self tryToLoadRobotoRegularItalicFont];
    font = [UIFont fontWithName:kRegularItalicFontName size:pointSize];
  }
  if (!font) {
    font = [UIFont systemFontOfSize:pointSize];
  }
  return font;
}

+ (UIFont *)robotoBoldItalicWithSize:(CGFloat)pointSize {
  UIFont *font = [UIFont fontWithName:kBoldItalicFontName size:pointSize];
  if (!font) {
    [self tryToLoadRobotoBoldItalicFont];
    font = [UIFont fontWithName:kBoldItalicFontName size:pointSize];
  }
  if (!font) {
    font = [UIFont systemFontOfSize:pointSize];
  }
  return font;
}

#pragma mark - Private

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

+ (void)tryToLoadRobotoRegularItalicFont {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadFontWithBundleFilename:kRegularItalicFontFilename];
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

@end
