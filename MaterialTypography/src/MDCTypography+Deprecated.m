#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCTypography+Deprecated.h"

@implementation MDCTypography (Deprecated)

+ (UIFont *)subtitleFont {
  return [self subheadFont];
}

+ (UIFont *)boldTextFont {
  return [self body2Font];
}

+ (UIFont *)textFont {
  return [self body1Font];
}

+ (UIFont *)menuFont {
  return [self buttonFont];
}

+ (UIFont *)textFieldFont {
  return [self robotoRegularWithSize:16];
}

+ (UIFont *)sidebarSectionTitleFont {
  return [self robotoMediumWithSize:14];
}

+ (UIFont *)sidebarCarouselNotificationFont {
  return [self robotoMediumWithSize:13];
}

+ (CGFloat)defaultDisplayOpacity {
  return [self displayFont1Opacity];
}

+ (CGFloat)defaultHeadlineOpacity {
  return [self headlineFontOpacity];
}

+ (CGFloat)defaultTitleOpacity {
  return [self titleFontOpacity];
}

+ (CGFloat)defaultSubtitleOpacity {
  return [self subheadFontOpacity];
}

+ (CGFloat)defaultBoldTextOpacity {
  return [self body2FontOpacity];
}

+ (CGFloat)defaultTextOpacity {
  return [self body1FontOpacity];
}

+ (CGFloat)defaultCaptionOpacity {
  return [self captionFontOpacity];
}

+ (CGFloat)defaultMenuOpacity {
  return [self buttonFontOpacity];
}

+ (CGFloat)defaultButtonOpacity {
  return [self buttonFontOpacity];
}

+ (UIFont *)displayFont4 {
  return [self display4Font];
}

+ (CGFloat)displayFont4Opacity {
  return [self display4FontOpacity];
}

+ (UIFont *)displayFont3 {
  return [self display3Font];
}

+ (CGFloat)displayFont3Opacity {
  return [self display3FontOpacity];
}

+ (UIFont *)displayFont2 {
  return [self display2Font];
}

+ (CGFloat)displayFont2Opacity {
  return [self display2FontOpacity];
}

+ (UIFont *)displayFont1 {
  return [self display1Font];
}

+ (CGFloat)displayFont1Opacity {
  return [self display1FontOpacity];
}

@end
