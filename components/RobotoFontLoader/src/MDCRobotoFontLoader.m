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

#import "MDCRobotoFontLoader.h"

#import "MDCFontDiskLoader.h"
#import "private/MDCRoboto+Constants.h"

@interface MDCRobotoFontLoader ()
@property(nonatomic, strong) MDCFontDiskLoader *lightFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *regularFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *mediumFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *boldFontLoader;

@property(nonatomic, strong) MDCFontDiskLoader *lightItalicFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *italicFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *mediumItalicFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *boldItalicFontLoader;

@property(nonatomic, strong) NSBundle *baseBundle;
@property(nonatomic, strong) NSString *bundleFileName;

@property(nonatomic, assign) BOOL disableSanityChecks;

@end

@implementation MDCRobotoFontLoader

+ (MDCRobotoFontLoader *)sharedInstance {
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] initInternal];
  });
  return sharedInstance;
}

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

- (instancetype)initInternal {
  self = [super init];
  if (self) {
    self = [super init];
    _baseBundle = [MDCRobotoFontLoader baseBundle];
    _bundleFileName = MDCRobotoBundle;
  }
  return self;
}

- (NSString *)description {
  NSMutableString *description = [super.description mutableCopy];
  [description appendString:@" (\n"];
  NSNull *null = [NSNull null];
  NSDictionary *selectors = @{
    NSStringFromSelector(@selector(lightFontLoader)) : _lightFontLoader ?: null,
    NSStringFromSelector(@selector(regularFontLoader)) : _regularFontLoader ?: null,
    NSStringFromSelector(@selector(mediumFontLoader)) : _mediumFontLoader ?: null,
    NSStringFromSelector(@selector(boldFontLoader)) : _boldFontLoader ?: null,
    NSStringFromSelector(@selector(lightItalicFontLoader)) : _lightItalicFontLoader ?: null,
    NSStringFromSelector(@selector(italicFontLoader)) : _italicFontLoader ?: null,
    NSStringFromSelector(@selector(mediumItalicFontLoader)) : _mediumItalicFontLoader ?: null,
    NSStringFromSelector(@selector(boldItalicFontLoader)) : _boldItalicFontLoader ?: null,
  };
  for (NSString *selectorName in selectors) {
    MDCFontDiskLoader *loader = [selectors objectForKey:selectorName];
    if ([loader isEqual:[NSNull null]]) {
      continue;
    }
    [description appendFormat:@"%@: %@\n", selectorName, loader];
  }

  [description appendString:@")\n"];
  return description;
}

#pragma mark - Private

- (void)setBundleFileName:(NSString *)bundleFileName {
  if ([bundleFileName isEqualToString:_bundleFileName]) {
    return;
  }
  if (bundleFileName) {
    _bundleFileName = bundleFileName;
  } else {
    _bundleFileName = MDCRobotoBundle;
  }
  [self resetFontLoaders];
}

- (void)setBaseBundle:(NSBundle *)baseBundle {
  if ([baseBundle isEqual:_baseBundle]) {
    return;
  }
  if (baseBundle) {
    _baseBundle = baseBundle;
  } else {
    _baseBundle = [MDCRobotoFontLoader baseBundle];
  }
  [self resetFontLoaders];
}

- (void)resetFontLoaders {
  _regularFontLoader = nil;
  _lightFontLoader = nil;
  _mediumFontLoader = nil;
  _boldFontLoader = nil;
  _italicFontLoader = nil;
  _lightItalicFontLoader = nil;
  _mediumItalicFontLoader = nil;
  _boldItalicFontLoader = nil;
}

- (MDCFontDiskLoader *)regularFontLoader {
  if (!_regularFontLoader) {
    _regularFontLoader = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoRegularFontName
                                                            filename:MDCRobotoRegularFontFilename
                                                      bundleFileName:_bundleFileName
                                                          baseBundle:_baseBundle];
  }
  return _regularFontLoader;
}

- (MDCFontDiskLoader *)mediumFontLoader {
  if (!_mediumFontLoader) {
    _mediumFontLoader = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoMediumFontName
                                                           filename:MDCRobotoMediumFontFilename
                                                     bundleFileName:_bundleFileName
                                                         baseBundle:_baseBundle];
  }
  return _mediumFontLoader;
}

- (MDCFontDiskLoader *)lightFontLoader {
  if (!_lightFontLoader) {
    _lightFontLoader = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoLightFontName
                                                          filename:MDCRobotoLightFontFilename
                                                    bundleFileName:_bundleFileName
                                                        baseBundle:_baseBundle];
  }
  return _lightFontLoader;
}

- (MDCFontDiskLoader *)boldFontLoader {
  if (!_boldFontLoader) {
    _boldFontLoader = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoBoldFontName
                                                         filename:MDCRobotoBoldFontFilename
                                                   bundleFileName:_bundleFileName
                                                       baseBundle:_baseBundle];
  }
  return _boldFontLoader;
}

- (MDCFontDiskLoader *)italicFontLoader {
  if (!_italicFontLoader) {
    _italicFontLoader =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoRegularItalicFontName
                                           filename:MDCRobotoRegularItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _italicFontLoader;
}

- (MDCFontDiskLoader *)lightItalicFontLoader {
  if (!_lightItalicFontLoader) {
    _lightItalicFontLoader =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoLightItalicFontName
                                           filename:MDCRobotoLightItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _lightItalicFontLoader;
}

- (MDCFontDiskLoader *)mediumItalicFontLoader {
  if (!_mediumItalicFontLoader) {
    _mediumItalicFontLoader =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoMediumItalicFontName
                                           filename:MDCRobotoMediumItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _mediumItalicFontLoader;
}

- (MDCFontDiskLoader *)boldItalicFontLoader {
  if (!_boldItalicFontLoader) {
    _boldItalicFontLoader =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoBoldItalicFontName
                                           filename:MDCRobotoBoldItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _boldItalicFontLoader;
}

#pragma mark - Public

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.regularFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.mediumFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.lightFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.boldFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.italicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)lightItalicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.lightItalicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.mediumItalicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontLoader = self.boldItalicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

@end
