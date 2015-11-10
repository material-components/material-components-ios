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
#import "Private/MDCTypography+Constants.h"

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

- (void)setBaseBundle:(NSBundle *)baseBundle {
  if (baseBundle == _baseBundle) {
    return;
  }
  if (baseBundle) {
    _baseBundle = baseBundle;
  } else {
    _baseBundle = [MDCRobotoFontLoader baseBundle];
  }
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
    _regularFontResource = [[MDCFontResource alloc] initWithFontName:kRegularFontName
                                                            filename:kRegularFontFilename
                                                      bundleFileName:kTypographyBundle
                                                          baseBundle:_baseBundle];
  }
  return _regularFontResource;
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.regularFontResource fontOfSize:fontSize];
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)mediumFontResource {
  if (!_mediumFontResource) {
    _mediumFontResource = [[MDCFontResource alloc] initWithFontName:kMediumFontName
                                                           filename:kMediumFontFilename
                                                     bundleFileName:kTypographyBundle
                                                         baseBundle:_baseBundle];
  }
  return _mediumFontResource;
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.mediumFontResource fontOfSize:fontSize];
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)lightFontResource {
  if (!_lightFontResource) {
    _lightFontResource = [[MDCFontResource alloc] initWithFontName:kLightFontName
                                                          filename:kLightFontFilename
                                                    bundleFileName:kTypographyBundle
                                                        baseBundle:_baseBundle];
  }
  return _lightFontResource;
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.lightFontResource fontOfSize:fontSize];
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)boldFontResource {
  if (!_boldFontResource) {
    _boldFontResource = [[MDCFontResource alloc] initWithFontName:kBoldFontName
                                                         filename:kBoldFontFilename
                                                   bundleFileName:kTypographyBundle
                                                       baseBundle:_baseBundle];
  }
  return _boldFontResource;
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.boldFontResource fontOfSize:fontSize];
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;

}

- (MDCFontResource *)italicFontResource {
  if (!_italicFontResource) {
    _italicFontResource = [[MDCFontResource alloc] initWithFontName:kRegularItalicFontName
                                                           filename:kRegularItalicFontFilename
                                                     bundleFileName:kTypographyBundle
                                                         baseBundle:_baseBundle];
  }
  return _italicFontResource;
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.italicFontResource fontOfSize:fontSize];
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)lightItalicFontResource {
  if (!_lightItalicFontResource) {
    _lightItalicFontResource = [[MDCFontResource alloc] initWithFontName:kLightItalicFontName
                                                                filename:kLightItalicFontFilename
                                                          bundleFileName:kTypographyBundle
                                                              baseBundle:_baseBundle];
  }
  return _lightItalicFontResource;
}

- (UIFont *)lightItalicFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.lightItalicFontResource fontOfSize:fontSize];
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)mediumItalicFontResource {
  if (!_mediumItalicFontResource) {
    _mediumItalicFontResource =
        [[MDCFontResource alloc] initWithFontName:kMediumItalicFontName
                                         filename:kMediumItalicFontFilename
                                   bundleFileName:kTypographyBundle
                                       baseBundle:_baseBundle];
  }
  return _mediumItalicFontResource;
}

- (UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.mediumItalicFontResource fontOfSize:fontSize];
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (MDCFontResource *)boldItalicFontResource {
  if (!_boldItalicFontResource) {
    _boldItalicFontResource = [[MDCFontResource alloc] initWithFontName:kBoldItalicFontName
                                                               filename:kBoldItalicFontFilename
                                                         bundleFileName:kTypographyBundle
                                                             baseBundle:_baseBundle];
  }
  return _boldItalicFontResource;
}

- (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
  UIFont *font = [self.boldItalicFontResource fontOfSize:fontSize];
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
