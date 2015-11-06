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

#import "MDCFontResource.h"

#import <CoreText/CoreText.h>

@interface MDCFontResource ()
@property(nonatomic, strong) NSURL *fontURL;
@end

@implementation MDCFontResource

- (instancetype)initWithName:(NSString *)fontName URL:(NSURL *)fontURL {
  self = [super init];
  if (self) {
    _fontName = fontName;
    _fontURL = fontURL;
  }
  return self;
}

- (instancetype)initWithFontName:(NSString *)fontName
                        filename:(NSString *)filename
                  bundleFileName:(NSString *)bundleFilename
                      baseBundle:(NSBundle *)baseBundle {
  NSString *searchPath = [baseBundle bundlePath];
  NSString *fontsBundlePath = [searchPath stringByAppendingPathComponent:bundleFilename];
  NSString *fontPath = [fontsBundlePath stringByAppendingPathComponent:filename];
  NSURL *fontURL = [NSURL fileURLWithPath:fontPath isDirectory:NO];
  if (!fontURL) {
    NSLog(@"Failed to locate '%@' in bundle at path '%@'.", filename, fontsBundlePath);
  }
  return [self initWithName:fontName URL:fontURL];
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
  return [UIFont fontWithName:self.fontName size:fontSize];
}

@end
