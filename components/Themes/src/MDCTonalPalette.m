/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTonalPalette.h"

@implementation MDCTonalPalette

- (nonnull instancetype)initWithColors:(nonnull NSArray<UIColor *> *)colors
                             mainColor:(UIColor *)mainColor
                            lightColor:(UIColor *)lightColor
                             darkColor:(UIColor *)darkColor {
  self = [super init];
  if (self) {
    _colors = [colors copy];
    _mainColor = mainColor;
    _lightColor = lightColor;
    _darkColor = darkColor;
  }
  return self;
}

- (NSUInteger)mainColorIndex {
  for (NSUInteger i = 0; i < _colors.count; i++) {
    UIColor *color = _colors[i];
    if (CGColorEqualToColor(_mainColor.CGColor, color.CGColor)) {
      return i;
    }
  }
  NSAssert(YES, @"Main color not found in color array.");
  return 0;
}

- (NSUInteger)lightColorIndex {
  for (NSUInteger i = 0; i < _colors.count; i++) {
    UIColor *color = _colors[i];
    if (CGColorEqualToColor(_lightColor.CGColor, color.CGColor)) {
      return i;
    }
  }
  NSAssert(YES, @"Light color not found in color array.");
  return 0;
}

- (NSUInteger)darkColorIndex {
  for (NSUInteger i = 0; i < _colors.count; i++) {
    UIColor *color = _colors[i];
    if (CGColorEqualToColor(_darkColor.CGColor, color.CGColor)) {
      return i;
    }
  }
  NSAssert(YES, @"Dark color not found in color array.");
  return 0;
}

@end
