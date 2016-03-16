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

#import "MDCFontResource.h"
#import "privateWasCapitalPrivate/MDCTypography+Constants.h"

@interface MDCRobotoFontLoader ()
@property(nonatomic, strong) MDCFontResource *lightFontResource;
@property(nonatomic, strong) MDCFontResource *regularFontResource;
@property(nonatomic, strong) MDCFontResource *mediumFontResource;
@property(nonatomic, strong) MDCFontResource *boldFontResource;

@property(nonatomic, strong) MDCFontResource *lightItalicFontResource;
@property(nonatomic, strong) MDCFontResource *italicFontResource;
@property(nonatomic, strong) MDCFontResource *mediumItalicFontResource;
@property(nonatomic, strong) MDCFontResource *boldItalicFontResource;

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
    _bundleFileName = MDCTypographyBundle;
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
    _bundleFileName = MDCTypographyBundle;
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

- (MDCFontResource *)regularFontResource {
  if (!_regularFontResource) {
    _regularFontResource = [[MDCFontResource alloc] initWithFontName:MDCTypographyRegularFontName
                                                            filename:MDCTypographyRegularFontFilename
                                                      bundleFileName:_bundleFileName
                                                          baseBundle:_baseBundle];
  }
  return _regularFontResource;
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.regularFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)mediumFontResource {
  if (!_mediumFontResource) {
    _mediumFontResource = [[MDCFontResource alloc] initWithFontName:MDCTypographyMediumFontName
                                                           filename:MDCTypographyMediumFontFilename
                                                     bundleFileName:_bundleFileName
                                                         baseBundle:_baseBundle];
  }
  return _mediumFontResource;
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.mediumFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)lightFontResource {
  if (!_lightFontResource) {
    _lightFontResource = [[MDCFontResource alloc] initWithFontName:MDCTypographyLightFontName
                                                          filename:MDCTypographyLightFontFilename
                                                    bundleFileName:_bundleFileName
                                                        baseBundle:_baseBundle];
  }
  return _lightFontResource;
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.lightFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)boldFontResource {
  if (!_boldFontResource) {
    _boldFontResource = [[MDCFontResource alloc] initWithFontName:MDCTypographyBoldFontName
                                                         filename:MDCTypographyBoldFontFilename
                                                   bundleFileName:_bundleFileName
                                                       baseBundle:_baseBundle];
  }
  return _boldFontResource;
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.boldFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)italicFontResource {
  if (!_italicFontResource) {
    _italicFontResource = [[MDCFontResource alloc] initWithFontName:MDCTypographyRegularItalicFontName
                                                           filename:MDCTypographyRegularItalicFontFilename
                                                     bundleFileName:_bundleFileName
                                                         baseBundle:_baseBundle];
  }
  return _italicFontResource;
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.italicFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)lightItalicFontResource {
  if (!_lightItalicFontResource) {
    _lightItalicFontResource = [[MDCFontResource alloc] initWithFontName:MDCTypographyLightItalicFontName
                                                                filename:MDCTypographyLightItalicFontFilename
                                                          bundleFileName:_bundleFileName
                                                              baseBundle:_baseBundle];
  }
  return _lightItalicFontResource;
}

- (UIFont *)lightItalicFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.lightItalicFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)mediumItalicFontResource {
  if (!_mediumItalicFontResource) {
    _mediumItalicFontResource =
        [[MDCFontResource alloc] initWithFontName:MDCTypographyMediumItalicFontName
                                         filename:MDCTypographyMediumItalicFontFilename
                                   bundleFileName:_bundleFileName
                                       baseBundle:_baseBundle];
  }
  return _mediumItalicFontResource;
}

- (UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.mediumItalicFontResource;
  UIFont *font = [fontResource fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font,
           @"Font %@ not found in location: %@.", fontResource.fontName, fontResource.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)boldItalicFontResource {
  if (!_boldItalicFontResource) {
    _boldItalicFontResource = [[MDCFontResource alloc] initWithFontName:MDCTypographyBoldItalicFontName
                                                               filename:MDCTypographyBoldItalicFontFilename
                                                         bundleFileName:_bundleFileName
                                                             baseBundle:_baseBundle];
  }
  return _boldItalicFontResource;
}

- (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
  MDCFontResource *fontResource = self.boldItalicFontResource;
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
