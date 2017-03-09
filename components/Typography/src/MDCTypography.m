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

#import "MDCTypography.h"
#import "private/UIFont+MaterialTypographyPrivate.h"

static id<MDCTypographyFontLoading> gFontLoader = nil;
const CGFloat MDCTypographyStandardOpacity = 0.87f;
const CGFloat MDCTypographySecondaryOpacity = 0.54f;

@implementation MDCTypography

#pragma mark - Font loader access

+ (void)setFontLoader:(id<MDCTypographyFontLoading>)fontLoader {
  gFontLoader = fontLoader;
  NSAssert(gFontLoader,
           @"Font loader can't be null. The font loader will be reset to the default font loader.");
  if (!gFontLoader) {
    gFontLoader = [self defaultFontLoader];
  }
}

+ (id<MDCTypographyFontLoading>)fontLoader {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    if (!gFontLoader) {
      gFontLoader = [self defaultFontLoader];
    }
  });
  return gFontLoader;
}

#pragma mark - Display fonts (extra large fonts)

+ (UIFont *)display4Font {
  return [[self fontLoader] lightFontOfSize:112];
}

+ (CGFloat)display4FontOpacity {
  return MDCTypographySecondaryOpacity;
}

+ (UIFont *)display3Font {
  return [[self fontLoader] regularFontOfSize:56];
}

+ (CGFloat)display3FontOpacity {
  return MDCTypographySecondaryOpacity;
}

+ (UIFont *)display2Font {
  return [[self fontLoader] regularFontOfSize:45];
}

+ (CGFloat)display2FontOpacity {
  return MDCTypographySecondaryOpacity;
}

+ (UIFont *)display1Font {
  return [[self fontLoader] regularFontOfSize:34];
}

+ (CGFloat)display1FontOpacity {
  return MDCTypographySecondaryOpacity;
}

#pragma mark - Common UI fonts.

+ (UIFont *)headlineFont {
  return [[self fontLoader] regularFontOfSize:24];
}

+ (CGFloat)headlineFontOpacity {
  return MDCTypographyStandardOpacity;
}

+ (UIFont *)titleFont {
  return [[self fontLoader] mediumFontOfSize:20];
}

+ (CGFloat)titleFontOpacity {
  return MDCTypographyStandardOpacity;
}

+ (UIFont *)subheadFont {
  return [[self fontLoader] regularFontOfSize:16];
}

+ (CGFloat)subheadFontOpacity {
  return MDCTypographyStandardOpacity;
}

+ (UIFont *)body2Font {
  return [[self fontLoader] mediumFontOfSize:14];
}

+ (CGFloat)body2FontOpacity {
  return MDCTypographyStandardOpacity;
}

+ (UIFont *)body1Font {
  return [[self fontLoader] regularFontOfSize:14];
}

+ (CGFloat)body1FontOpacity {
  return MDCTypographyStandardOpacity;
}

+ (UIFont *)captionFont {
  return [[self fontLoader] regularFontOfSize:12];
}

+ (CGFloat)captionFontOpacity {
  return MDCTypographySecondaryOpacity;
}

+ (UIFont *)buttonFont {
  return [[self fontLoader] mediumFontOfSize:14];
}

+ (CGFloat)buttonFontOpacity {
  return MDCTypographyStandardOpacity;
}

#pragma mark - Private

+ (id<MDCTypographyFontLoading>)defaultFontLoader {
  return [[MDCSystemFontLoader alloc] init];
}

@end

@implementation MDCSystemFontLoader

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  if ([UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
  }
  return [UIFont systemFontOfSize:fontSize];
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  if ([UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
  }
  return [UIFont systemFontOfSize:fontSize];
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  if ([UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
  }
  return [UIFont systemFontOfSize:fontSize];
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  if ([UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
  }
  return [UIFont boldSystemFontOfSize:fontSize];
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  return [UIFont italicSystemFontOfSize:fontSize];
}

- (BOOL)isLargeForContrastRatios:(UIFont *)font {
  if (font.pointSize >= 18) {
    return YES;
  }
  if (font.pointSize < 14) {
    return NO;
  }

  UIFontDescriptor *fontDescriptor = font.fontDescriptor;
  if ((fontDescriptor.symbolicTraits & UIFontDescriptorTraitBold) == UIFontDescriptorTraitBold) {
    return YES;
  }

  CGFloat MDCFontWeightMedium = (CGFloat)0.23;
  // Based on Apple's SDK-Based Development: Using Weakly Linked Methods, Functions, and Symbols.
  // https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/cross_development/Using/using.html#//apple_ref/doc/uid/20002000-1114537-BABHHJBC
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wtautological-pointer-compare"
#pragma clang diagnostic ignored "-Wunreachable-code"
  if (&UIFontWeightMedium != NULL) {
    MDCFontWeightMedium = UIFontWeightMedium;
  }
#pragma clang diagnostic pop

  // We treat system font medium as large for accessibility when larger than 14.
  if (font.mdc_weight >= MDCFontWeightMedium) {
    return YES;
  }

  return NO;
}

@end
