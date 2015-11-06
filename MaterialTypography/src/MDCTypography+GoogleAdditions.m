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

#import "MDCRobotoFontLoader.h"
#import "MDCTypography+Deprecated.h"
#import "MDCTypography+Constants.h"

static const CGFloat kHintOpacity = 0.26f;

static BOOL isItalicFontName(NSString *fontName) {
  return [fontName isEqual:kRegularItalicFontName] || [fontName isEqual:kBoldItalicFontName] ||
         [fontName isEqual:kMediumItalicFontName] || [fontName isEqual:kLightItalicFontName];
}

/** Returns YES if the font name represents what we consider to be a "bold" font. */
static BOOL isBoldFontName(NSString *fontName) {
  return [fontName isEqualToString:kMediumFontName] || [fontName isEqualToString:kBoldFontName] ||
         [fontName isEqualToString:kMediumItalicFontName] ||
         [fontName isEqualToString:kBoldItalicFontName];
}

@implementation MDCTypography (GoogleAdditions)

+ (UIFont *)italicFontFromFont:(UIFont *)font {
  NSString *fontName = font.fontName;
  CGFloat fontSize = font.pointSize;
  if (isItalicFontName(fontName)) {
    return font;
  } else if ([fontName isEqual:kRegularFontName]) {
    return [[MDCRobotoFontLoader sharedInstance] italicFontOfSize:fontSize];
  } else if ([fontName isEqual:kBoldFontName]) {
    return [[MDCRobotoFontLoader sharedInstance] boldItalicFontOfSize:fontSize];
  } else if ([fontName isEqual:kMediumFontName]) {
    return [[MDCRobotoFontLoader sharedInstance] mediumItalicFontOfSize:fontSize];
  } else if ([fontName isEqual:kLightFontName]) {
    return [[MDCRobotoFontLoader sharedInstance] lightItalicFontOfSize:fontSize];
  }
  return [UIFont italicSystemFontOfSize:fontSize];
}

+ (BOOL)isLargeForContrastRatios:(UIFont *)font {
  return font.pointSize >= 18 || (isBoldFontName(font.fontName) && font.pointSize >= 14);
}

+ (CGFloat)defaultHintOpacity {
  return kHintOpacity;
}

+ (UIFont *)robotoItalicWithSize:(CGFloat)pointSize {
  return [[MDCRobotoFontLoader sharedInstance] italicFontOfSize:pointSize];
}

+ (UIFont *)robotoBoldWithSize:(CGFloat)pointSize {
  return [[MDCRobotoFontLoader sharedInstance] boldFontOfSize:pointSize];
}

+ (UIFont *)robotoBoldItalicWithSize:(CGFloat)pointSize {
  return [[MDCRobotoFontLoader sharedInstance] boldItalicFontOfSize:pointSize];
}

@end
