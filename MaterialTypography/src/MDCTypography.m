#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCRobotoFontLoader.h"
#import "MDCTypography.h"
#import "Private/MDCTypography+Constants.h"

static id<MDCTypographyFontLoader> sFontLoader = nil;

@implementation MDCTypography

#pragma mark - Custom font loader

+ (void)setFontLoader:(id<MDCTypographyFontLoader>)fontLoader {
  sFontLoader = fontLoader;
  NSAssert(sFontLoader, @"Font loader can't be null."
                        @"The font loader will be reset to the default.");
  if (!sFontLoader) {
    sFontLoader = [self defaultFontLoader];
  }
}

+ (id<MDCTypographyFontLoader>)fontLoader {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    if (!sFontLoader) {
      sFontLoader = [self defaultFontLoader];
    }
  });
  return sFontLoader;
}

#pragma mark - Display fonts (extra large fonts)

+ (UIFont *)display4Font {
  return [[self fontLoader] lightFontOfSize:112];
}

+ (CGFloat)display4FontOpacity {
  return kSecondaryOpacity;
}

+ (UIFont *)display3Font {
  return [[self fontLoader] regularFontOfSize:56];
}

+ (CGFloat)display3FontOpacity {
  return kSecondaryOpacity;
}

+ (UIFont *)display2Font {
  return [[self fontLoader] regularFontOfSize:45];
}

+ (CGFloat)display2FontOpacity {
  return kSecondaryOpacity;
}

+ (UIFont *)display1Font {
  return [[self fontLoader] regularFontOfSize:34];
}

+ (CGFloat)display1FontOpacity {
  return kSecondaryOpacity;
}

#pragma mark - Common UI fonts.

/** Returns the headline font. */
+ (UIFont *)headlineFont {
  return [[self fontLoader] regularFontOfSize:24];
}

/** Returns the recommended opacity of black text for the headline font. */
+ (CGFloat)headlineFontOpacity {
  return kStandardOpacity;
}

/** Returns the title font. */
+ (UIFont *)titleFont {
  return [[self fontLoader] mediumFontOfSize:20];
}

/** Returns the recommended opacity of black text for the title font. */
+ (CGFloat)titleFontOpacity {
  return kStandardOpacity;
}

/** Returns the subhead font. (subtitle) */
+ (UIFont *)subheadFont {
  return [[self fontLoader] regularFontOfSize:16];
}

/** Returns the recommended opacity of black text for the subhead font. */
+ (CGFloat)subheadFontOpacity {
  return kStandardOpacity;
}

/** Returns the body 2 text font. (bold text) */
+ (UIFont *)body2Font {
  return [[self fontLoader] mediumFontOfSize:14];
}

/** Returns the recommended opacity of black text for the body 2 font. */
+ (CGFloat)body2FontOpacity {
  return kStandardOpacity;
}

/** Returns the body 1 text font. (normal text) */
+ (UIFont *)body1Font {
  return [[self fontLoader] regularFontOfSize:14];
}

/** Returns the recommended opacity of black text for the body 1 font. */
+ (CGFloat)body1FontOpacity {
  return kStandardOpacity;
}

/** Returns the caption font. (a small font for image captions) */
+ (UIFont *)captionFont {
  return [[self fontLoader] regularFontOfSize:12];
}

/** Returns the recommended opacity of black text for the caption font. */
+ (CGFloat)captionFontOpacity {
  return kSecondaryOpacity;
}

/** Returns a font for buttons. */
+ (UIFont *)buttonFont {
  return [[self fontLoader] mediumFontOfSize:14];
}

/** Returns the recommended opacity of black text for the button font. */
+ (CGFloat)buttonFontOpacity {
  return kStandardOpacity;
}

#pragma mark - Roboto fonts

+ (UIFont *)robotoRegularWithSize:(CGFloat)pointSize {
  return [[self fontLoader] regularFontOfSize:pointSize];
}

+ (UIFont *)robotoMediumWithSize:(CGFloat)pointSize {
  return [[self fontLoader] mediumFontOfSize:pointSize];
}

+ (UIFont *)robotoLightWithSize:(CGFloat)pointSize {
  return [[self fontLoader] lightFontOfSize:pointSize];
}

#pragma mark - Private

+ (id<MDCTypographyFontLoader>)defaultFontLoader {
  Class fontLoaderClass = NSClassFromString(@"MDCRobotoFontLoader");
  if (fontLoaderClass) {
    return [MDCRobotoFontLoader sharedInstance];
  }
  return [[MDCSystemFontLoader alloc] init];
}

@end

@implementation MDCSystemFontLoader

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  return [UIFont systemFontOfSize:fontSize];
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  return [UIFont boldSystemFontOfSize:fontSize];
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  return [UIFont systemFontOfSize:fontSize];
}

@end
