#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOORobotoFontLoader.h"

#import "googlemac/iPhone/Shared/GoogleKit/Typography/Private/GOOTypography+Constants.h"

@implementation GOORobotoFontLoader

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

- (GOOFontResource *)regularFontResource {
  if (!_regularFontResource) {
    _regularFontResource = [[GOOFontResource alloc] initWithFontName:kRegularFontName
                                                            filename:kRegularFontFilename
                                                      bundleFileName:kTypographyBundle
                                                          baseBundle:[[self class] baseBundle]];
  }
  return _regularFontResource;
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  return [self.regularFontResource fontOfSize:fontSize];
}

- (GOOFontResource *)mediumFontResource {
  if (!_mediumFontResource) {
    _mediumFontResource = [[GOOFontResource alloc] initWithFontName:kMediumFontName
                                                           filename:kMediumFontFilename
                                                     bundleFileName:kTypographyBundle
                                                         baseBundle:[[self class] baseBundle]];
  }
  return _mediumFontResource;
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  return [self.mediumFontResource fontOfSize:fontSize];
}

- (GOOFontResource *)lightFontResource {
  if (!_lightFontResource) {
    _lightFontResource = [[GOOFontResource alloc] initWithFontName:kLightFontName
                                                          filename:kLightFontFilename
                                                    bundleFileName:kTypographyBundle
                                                        baseBundle:[[self class] baseBundle]];
  }
  return _lightFontResource;
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  return [self.lightFontResource fontOfSize:fontSize];
}

- (GOOFontResource *)boldFontResource {
  if (!_boldFontResource) {
    _boldFontResource = [[GOOFontResource alloc] initWithFontName:kBoldFontName
                                                         filename:kBoldFontFilename
                                                   bundleFileName:kTypographyBundle
                                                       baseBundle:[[self class] baseBundle]];
  }
  return _boldFontResource;
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  return [self.boldFontResource fontOfSize:fontSize];
}

- (GOOFontResource *)italicFontResource {
  if (!_italicFontResource) {
    _italicFontResource = [[GOOFontResource alloc] initWithFontName:kRegularItalicFontName
                                                           filename:kRegularItalicFontFilename
                                                     bundleFileName:kTypographyBundle
                                                         baseBundle:[[self class] baseBundle]];
  }
  return _italicFontResource;
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  return [self.italicFontResource fontOfSize:fontSize];
}

- (GOOFontResource *)lightItalicFontResource {
  if (!_lightItalicFontResource) {
    _lightItalicFontResource = [[GOOFontResource alloc] initWithFontName:kLightItalicFontName
                                                                filename:kLightItalicFontFilename
                                                          bundleFileName:kTypographyBundle
                                                              baseBundle:[[self class] baseBundle]];
  }
  return _lightItalicFontResource;
}

- (UIFont *)lightItalicFontOfSize:(CGFloat)fontSize {
  return [self.lightItalicFontResource fontOfSize:fontSize];
}

- (GOOFontResource *)mediumItalicFontResource {
  if (!_mediumItalicFontResource) {
    _mediumItalicFontResource =
        [[GOOFontResource alloc] initWithFontName:kMediumItalicFontName
                                         filename:kMediumItalicFontFilename
                                   bundleFileName:kTypographyBundle
                                       baseBundle:[[self class] baseBundle]];
  }
  return _mediumItalicFontResource;
}

- (UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize {
  return [self.mediumItalicFontResource fontOfSize:fontSize];
}

- (GOOFontResource *)boldItalicFontResource {
  if (!_boldItalicFontResource) {
    _boldItalicFontResource = [[GOOFontResource alloc] initWithFontName:kBoldItalicFontName
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
