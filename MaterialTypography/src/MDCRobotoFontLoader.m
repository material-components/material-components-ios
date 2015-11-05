#import "MDCRobotoFontLoader.h"

#import "Private/MDCTypography+Constants.h"

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
  return [super init];
}

+ (instancetype)sharedInstance {
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] initInternal];
  });
  return sharedInstance;
}

- (MDCFontResource *)regularFontResource {
  if (!_regularFontResource) {
    _regularFontResource = [[MDCFontResource alloc] initWithFontName:kRegularFontName
                                                            filename:kRegularFontFilename
                                                      bundleFileName:kTypographyBundle
                                                          baseBundle:[[self class] baseBundle]];
  }
  return _regularFontResource;
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  return [self.regularFontResource fontOfSize:fontSize];
}

- (MDCFontResource *)mediumFontResource {
  if (!_mediumFontResource) {
    _mediumFontResource = [[MDCFontResource alloc] initWithFontName:kMediumFontName
                                                           filename:kMediumFontFilename
                                                     bundleFileName:kTypographyBundle
                                                         baseBundle:[[self class] baseBundle]];
  }
  return _mediumFontResource;
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  return [self.mediumFontResource fontOfSize:fontSize];
}

- (MDCFontResource *)lightFontResource {
  if (!_lightFontResource) {
    _lightFontResource = [[MDCFontResource alloc] initWithFontName:kLightFontName
                                                          filename:kLightFontFilename
                                                    bundleFileName:kTypographyBundle
                                                        baseBundle:[[self class] baseBundle]];
  }
  return _lightFontResource;
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  return [self.lightFontResource fontOfSize:fontSize];
}

- (MDCFontResource *)boldFontResource {
  if (!_boldFontResource) {
    _boldFontResource = [[MDCFontResource alloc] initWithFontName:kBoldFontName
                                                         filename:kBoldFontFilename
                                                   bundleFileName:kTypographyBundle
                                                       baseBundle:[[self class] baseBundle]];
  }
  return _boldFontResource;
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  return [self.boldFontResource fontOfSize:fontSize];
}

- (MDCFontResource *)italicFontResource {
  if (!_italicFontResource) {
    _italicFontResource = [[MDCFontResource alloc] initWithFontName:kRegularItalicFontName
                                                           filename:kRegularItalicFontFilename
                                                     bundleFileName:kTypographyBundle
                                                         baseBundle:[[self class] baseBundle]];
  }
  return _italicFontResource;
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  return [self.italicFontResource fontOfSize:fontSize];
}

- (MDCFontResource *)lightItalicFontResource {
  if (!_lightItalicFontResource) {
    _lightItalicFontResource = [[MDCFontResource alloc] initWithFontName:kLightItalicFontName
                                                                filename:kLightItalicFontFilename
                                                          bundleFileName:kTypographyBundle
                                                              baseBundle:[[self class] baseBundle]];
  }
  return _lightItalicFontResource;
}

- (UIFont *)lightItalicFontOfSize:(CGFloat)fontSize {
  return [self.lightItalicFontResource fontOfSize:fontSize];
}

- (MDCFontResource *)mediumItalicFontResource {
  if (!_mediumItalicFontResource) {
    _mediumItalicFontResource =
        [[MDCFontResource alloc] initWithFontName:kMediumItalicFontName
                                         filename:kMediumItalicFontFilename
                                   bundleFileName:kTypographyBundle
                                       baseBundle:[[self class] baseBundle]];
  }
  return _mediumItalicFontResource;
}

- (UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize {
  return [self.mediumItalicFontResource fontOfSize:fontSize];
}

- (MDCFontResource *)boldItalicFontResource {
  if (!_boldItalicFontResource) {
    _boldItalicFontResource = [[MDCFontResource alloc] initWithFontName:kBoldItalicFontName
                                                               filename:kBoldItalicFontFilename
                                                         bundleFileName:kTypographyBundle
                                                             baseBundle:[[self class] baseBundle]];
  }
  return _boldItalicFontResource;
}

- (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
  return [self.boldItalicFontResource fontOfSize:fontSize];
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
