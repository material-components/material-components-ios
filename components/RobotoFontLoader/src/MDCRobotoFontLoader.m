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

#import "MDCRobotoFontLoader.h"

#import "MDCFontDiskLoader.h"
#import "private/MDCRoboto+Constants.h"

@interface MDCRobotoFontLoader ()
@property(nonatomic, strong) MDCFontDiskLoader *lightFontResource;
@property(nonatomic, strong) MDCFontDiskLoader *regularFontResource;
@property(nonatomic, strong) MDCFontDiskLoader *mediumFontResource;
@property(nonatomic, strong) MDCFontDiskLoader *boldFontResource;

@property(nonatomic, strong) MDCFontDiskLoader *lightItalicFontResource;
@property(nonatomic, strong) MDCFontDiskLoader *italicFontResource;
@property(nonatomic, strong) MDCFontDiskLoader *mediumItalicFontResource;
@property(nonatomic, strong) MDCFontDiskLoader *boldItalicFontResource;

@property(nonatomic, strong) NSBundle *baseBundle;
@property(nonatomic, strong) NSString *bundleFileName;

@property(nonatomic, assign) BOOL disableSanityChecks;

@end

@implementation MDCRobotoFontLoader

- (instancetype)init {
  self = [super init];
  if (self) {
    [self doesNotRecognizeSelector:_cmd];
    self = nil;
  }
  return nil;
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

+ (instancetype)sharedInstance {
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] initInternal];
  });
  return sharedInstance;
}

- (void)setBundleFileName:(NSString *)bundleFileName {
  if ([bundleFileName isEqualToString:_bundleFileName]) {
    return;
  }
  if (bundleFileName) {
    _bundleFileName = bundleFileName;
  } else {
    _bundleFileName = MDCRobotoBundle;
  }
  [self resetFontResources];
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
  [self resetFontResources];
}

- (void)resetFontResources {
  _regularFontResource = nil;
  _lightFontResource = nil;
  _mediumFontResource = nil;
  _boldFontResource = nil;
  _italicFontResource = nil;
  _lightItalicFontResource = nil;
  _mediumItalicFontResource = nil;
  _boldItalicFontResource = nil;
}

- (MDCFontDiskLoader *)regularFontResource {
  if (!_regularFontResource) {
    _regularFontResource = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoRegularFontName
                                                              filename:MDCRobotoRegularFontFilename
                                                        bundleFileName:_bundleFileName
                                                            baseBundle:_baseBundle];
  }
  return _regularFontResource;
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.regularFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontDiskLoader *)mediumFontResource {
  if (!_mediumFontResource) {
    _mediumFontResource = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoMediumFontName
                                                             filename:MDCRobotoMediumFontFilename
                                                       bundleFileName:_bundleFileName
                                                           baseBundle:_baseBundle];
  }
  return _mediumFontResource;
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.mediumFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontDiskLoader *)lightFontResource {
  if (!_lightFontResource) {
    _lightFontResource = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoLightFontName
                                                            filename:MDCRobotoLightFontFilename
                                                      bundleFileName:_bundleFileName
                                                          baseBundle:_baseBundle];
  }
  return _lightFontResource;
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.lightFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontDiskLoader *)boldFontResource {
  if (!_boldFontResource) {
    _boldFontResource = [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoBoldFontName
                                                           filename:MDCRobotoBoldFontFilename
                                                     bundleFileName:_bundleFileName
                                                         baseBundle:_baseBundle];
  }
  return _boldFontResource;
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.boldFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontDiskLoader *)italicFontResource {
  if (!_italicFontResource) {
    _italicFontResource =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoRegularItalicFontName
                                           filename:MDCRobotoRegularItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _italicFontResource;
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.italicFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontDiskLoader *)lightItalicFontResource {
  if (!_lightItalicFontResource) {
    _lightItalicFontResource =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoLightItalicFontName
                                           filename:MDCRobotoLightItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _lightItalicFontResource;
}

- (UIFont *)lightItalicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.lightItalicFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontDiskLoader *)mediumItalicFontResource {
  if (!_mediumItalicFontResource) {
    _mediumItalicFontResource =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoMediumItalicFontName
                                           filename:MDCRobotoMediumItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _mediumItalicFontResource;
}

- (UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.mediumItalicFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontDiskLoader *)boldItalicFontResource {
  if (!_boldItalicFontResource) {
    _boldItalicFontResource =
        [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoBoldItalicFontName
                                           filename:MDCRobotoBoldItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _boldItalicFontResource;
}

- (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
  MDCFontDiskLoader *fontResource = self.boldItalicFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

#pragma mark private

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

@end
