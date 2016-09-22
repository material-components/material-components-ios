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
@property(nonatomic) BOOL disableSanityChecks;  // For tests to turn off asserts
@end

// Use |isFontURLLoaded:| and |setFontURL:loaded:| for access to loaded fonts.
static NSMutableSet<NSURL *> *gLoadedFonts;
// The queue that ensures |gLoadedFonts| is accessed in a thread safe manner.
static dispatch_queue_t gLoadedFontsQueue;

/*
 This class caches the registered state of fileURL because it is much faster than calling the
 CoreText api.

 Benchmark testing results for a iPod touch Model A1421 running 9.2.1 (13D11) on 7/21/2016:
 ==============================
 first load runtime: 6.729903 ms
 iterations: 1000

 single instance of FontDiskLoader
 unoptimizedLoad Avg. Runtime: 1.312834 ms
 load Avg. Runtime: 0.006540 ms
 ratio first/unoptimized: 5.126241
 ratio first/optimized: 1029.037109
 ratio unoptimized/optimized: 200.739151

 new instances of FontDiskLoader
 unoptimizedLoad Avg. Runtime: 1.384893 ms
 load Avg. Runtime: 0.096831 ms
 ratio first/unoptimized: 4.859511
 ratio first/optimized: 69.501534
 ratio unoptimized/optimized: 14.302166
 ==============================

 The unoptimizedLoad was calling just the CoreText API. As you can see the unoptimizedLoad was on
 average 1.3 ms. This is unacceptable in situations in which you may want to display more than 20
 different labels as is the case for a scrolling collection view because it would cause frame drops.
 */
@implementation MDCFontDiskLoader

@synthesize loadFailed = _loadFailed;

+ (void)initialize {
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    gLoadedFonts = [[NSMutableSet alloc] init];
    gLoadedFontsQueue =
        dispatch_queue_create("com.google.mdc.FontDiskLoaderQueue", DISPATCH_QUEUE_SERIAL);
  });
}

// A font's loaded state is shared accross all fontloaders that share the same URL. This class
// method ensures that the collection of URLs that are loaded are set in a thread safe manner.
// By using a serial queue we ensure that reads and writes do not occur at the same time.
+ (void)setFontURL:(NSURL *)fontURL loaded:(BOOL)loaded {
  if (!fontURL) {
    return;
  }
  dispatch_async(gLoadedFontsQueue, ^{
    // Defensive bool cast because https://www.bignerdranch.com/blog/bools-sharp-corners
    if ((bool)loaded == (bool)[gLoadedFonts containsObject:fontURL]) {
      return;  // Already in the correct state;
    }
    if (loaded) {
      [gLoadedFonts addObject:fontURL];
    } else {
      [gLoadedFonts removeObject:fontURL];
    }
  });
}

// A font's loaded state is shared accross all fontloaders that share the same URL. This class
// method ensures that the collection of URLs that are loaded are gotten in a thread safe manner.
// By using a serial queue we ensure that reads and writes do not occur at the same time.
+ (BOOL)isFontURLLoaded:(NSURL *)fontURL {
  if (!fontURL) {
    return NO;
  }
  __block BOOL isLoaded = NO;
  dispatch_sync(gLoadedFontsQueue, ^{
    isLoaded = [gLoadedFonts containsObject:fontURL];
  });
  return isLoaded;
}

- (instancetype)initWithFontName:(NSString *)fontName fontURL:(NSURL *)fontURL {
  self = [super init];
  if (self) {
    _fontName = [fontName copy];
    _fontURL = [fontURL copy];
  }
  return self;
}

- (instancetype)initWithFontName:(NSString *)fontName
                        filename:(NSString *)filename
                  bundleFileName:(NSString *)bundleFilename
                      baseBundle:(NSBundle *)baseBundle {
  NSURL *fontURL =
      [baseBundle URLForResource:filename withExtension:nil subdirectory:bundleFilename];
  if (!fontURL) {
    NSLog(@"Failed to locate: %@ in bundle: %@ %@.", filename, baseBundle, bundleFilename);
    return nil;
  }
  return [self initWithFontName:fontName fontURL:fontURL];
}

#pragma mark - NSObject overridden methods

- (NSString *)description {
  NSMutableString *description = [super.description mutableCopy];
  [description appendFormat:@" font name: %@;", _fontName];
  if (self.loaded) {
    [description appendString:@" loaded = YES;"];
  } else if (_loadFailed) {
    [description appendString:@" failed registration = YES;"];
  }
  [description appendFormat:@" font url: %@;", _fontURL];
  return [description copy];
}

- (BOOL)isEqual:(id)object {
  if (!object || ![object isKindOfClass:[self class]]) {
    return NO;
  }
  MDCFontDiskLoader *otherObject = (MDCFontDiskLoader *)object;
  BOOL fontNamesAreEqual = [otherObject.fontName isEqualToString:_fontName];
  return fontNamesAreEqual && [otherObject.fontURL isEqual:_fontURL];
}

- (NSUInteger)hash {
  return _fontName.hash ^ _fontURL.hash;
}

- (id)copyWithZone:(NSZone *)zone {
  return self;
}

#pragma mark - Public methods

- (BOOL)load {
  @synchronized(self) {
    BOOL loaded = [MDCFontDiskLoader isFontURLLoaded:_fontURL];
    if (loaded) {
      return YES;
    }
    if (_loadFailed) {
      return NO;
    }
    CFErrorRef error = NULL;
    loaded = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)_fontURL,
                                              kCTFontManagerScopeProcess, &error);
    if (!loaded) {
      if (error && CFErrorGetCode(error) == kCTFontManagerErrorAlreadyRegistered) {
        // If it's already been loaded by somebody else, we don't care.
        // We do not check the error domain to make sure they match because
        // kCTFontManagerErrorDomain is not defined in the iOS 8 SDK.
        // Radar 18651170 iOS 8 SDK missing definition for kCTFontManagerErrorDomain
        loaded = YES;
      } else {
        NSLog(@"Failed to load font: %@", error);
        _loadFailed = YES;
      }
    }
    if (error) {
      CFRelease(error);
    }
    [MDCFontDiskLoader setFontURL:_fontURL loaded:loaded];
    return loaded;
  }
}

- (BOOL)unload {
  @synchronized(self) {
    BOOL loaded = [MDCFontDiskLoader isFontURLLoaded:_fontURL];
    _loadFailed = NO;
    if (!loaded) {
      return YES;
    }
    CFErrorRef error = NULL;
    loaded = !CTFontManagerUnregisterFontsForURL((__bridge CFURLRef)_fontURL,
                                                 kCTFontManagerScopeProcess, &error);

    if (loaded || error) {
      NSLog(@"Failed to unload font: %@", error);
    }
    [MDCFontDiskLoader setFontURL:_fontURL loaded:loaded];
    return !loaded;
  }
}

- (UIFont *)fontOfSize:(CGFloat)fontSize {
  [self load];
  UIFont *font = [UIFont fontWithName:_fontName size:fontSize];
  NSAssert(_disableSanityChecks || font, @"Failed to find font: %@ in file at %@", _fontName,
           _fontURL);
  return font;
}

- (BOOL)isLoaded {
  return [MDCFontDiskLoader isFontURLLoaded:_fontURL];
}

- (BOOL)hasLoadFailed {
  @synchronized(self) {
    return _loadFailed;
  }
}

@end
