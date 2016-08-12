/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFontDiskLoader.h"

#import <CoreText/CoreText.h>

@interface MDCFontDiskLoader ()
@property(nonatomic, strong) NSURL *fontURL;
@property(nonatomic) BOOL isRegistered;
@property(nonatomic) BOOL disableSanityChecks;
@property(nonatomic) BOOL hasFailedRegistration;
@end

static NSMutableSet *registeredFonts;

@implementation MDCFontDiskLoader

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
    return nil;
  }
  return [self initWithName:fontName URL:fontURL];
}

- (BOOL)registerFont {
  if (self.isRegistered) {
    return YES;
  }
  if (_hasFailedRegistration) {
    return NO;
  }
  if (![[NSFileManager defaultManager] fileExistsAtPath:[self.fontURL path]]) {
    _hasFailedRegistration = YES;
    NSLog(@"Failed to load font: file not found at %@", self.fontURL);
    return NO;
  }
  CFErrorRef error = NULL;
  self.isRegistered = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)self.fontURL,
                                                       kCTFontManagerScopeProcess, &error);

  if (!self.isRegistered) {
    if (error && CFErrorGetCode(error) == kCTFontManagerErrorAlreadyRegistered) {
      // If it's already been loaded by somebody else, we don't care.
      // We do not check the error domain to make sure they match because
      // kCTFontManagerErrorDomain is not defined in the iOS 8 SDK.
      // Radar 18651170 iOS 8 SDK missing definition for kCTFontManagerErrorDomain
      self.isRegistered = YES;
    } else {
      NSLog(@"Failed to load font: %@", error);
      _hasFailedRegistration = YES;
    }
  }
  if (error) {
    CFRelease(error);
  }
  return self.isRegistered;
}

- (BOOL)unregisterFont {
  if (!self.isRegistered) {
    _hasFailedRegistration = NO;
    return YES;
  }
  CFErrorRef error = NULL;
  self.isRegistered = !CTFontManagerUnregisterFontsForURL((__bridge CFURLRef)self.fontURL,
                                                          kCTFontManagerScopeProcess, &error);

  if (self.isRegistered || error) {
    NSLog(@"Failed to unregister font: %@", error);
  }
  return !self.isRegistered;
}

- (UIFont *)fontOfSize:(CGFloat)fontSize {
  [self registerFont];
  UIFont *font = [UIFont fontWithName:self.fontName size:fontSize];
  NSAssert(_disableSanityChecks || font, @"Failed to find font: %@ in file at %@", self.fontName,
           self.fontURL);
  return font;
}

- (NSString *)description {
  NSMutableString *description = [super.description mutableCopy];
  [description appendString:[NSString stringWithFormat:@" font name: %@;", self.fontName]];
  if (self.isRegistered) {
    [description appendString:@" registered = YES;"];
  } else if (self.hasFailedRegistration) {
    [description appendString:@" failed registration = YES;"];
  }
  [description appendString:[NSString stringWithFormat:@" font url: %@;", self.fontURL]];
  return [description copy];
}

- (BOOL)isEqual:(id)object {
  if (!object || ![object isKindOfClass:[self class]]) {
    return NO;
  }
  MDCFontDiskLoader *otherObject = (MDCFontDiskLoader *)object;
  BOOL fontNamesAreEqual = [otherObject.fontName isEqualToString:self.fontName];
  return fontNamesAreEqual && [otherObject.fontURL isEqual:self.fontURL];
}

- (NSUInteger)hash {
  return self.fontName.hash ^ self.fontURL.hash;
}

- (id)copyWithZone:(NSZone *)zone {
  return self;
}

- (BOOL)isRegistered {
  @synchronized(registeredFonts) {
    return [registeredFonts containsObject:self.fontURL];
  }
}

- (void)setIsRegistered:(BOOL)isRegistered {
  @synchronized(registeredFonts) {
    if (isRegistered == [registeredFonts containsObject:self.fontURL]) {
      return;  // Already in the correct state;
    }
    if (isRegistered) {
      [registeredFonts addObject:self.fontURL];
    } else {
      [registeredFonts removeObject:self.fontURL];
    }
  }
}

+ (void)load {
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    registeredFonts = [[NSMutableSet alloc] init];
  });
}

@end
