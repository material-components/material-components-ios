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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCTypography.h"

static id<MDCTypographyFontLoading> sFontLoader = nil;
const CGFloat MDCTypographyStandardOpacity = 0.87f;
const CGFloat MDCTypographySecondaryOpacity = 0.54f;

// This protocal is not intended for actual use. It allows us to weakly reference MDCRoboto with
// less warnings. @c defaultFontLoader
@protocol MDCRobotoFontLoaderWeakLink
// Shared singleton instance.
+ (nonnull instancetype)sharedInstance;
@end

@implementation MDCTypography

#pragma mark - Font loader access

+ (void)setFontLoader:(id<MDCTypographyFontLoading>)fontLoader {
  sFontLoader = fontLoader;
  NSAssert(sFontLoader,
           @"Font loader can't be null. The font loader will be reset to the default font loader.");
  if (!sFontLoader) {
    sFontLoader = [self defaultFontLoader];
  }
}

+ (id<MDCTypographyFontLoading>)fontLoader {
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
  Class fontLoaderClass = NSClassFromString(@"MDCRobotoFontLoader");
  if (fontLoaderClass && [fontLoaderClass respondsToSelector:@selector(sharedInstance)]) {
    return [fontLoaderClass sharedInstance];
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
