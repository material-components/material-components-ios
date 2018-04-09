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

#import "MDCLegacyTonalPalette.h"

static NSString *const MDCTonalPaletteColorsKey = @"MDCTonalPaletteColorsKey";
static NSString *const MDCTonalPaletteMainColorIndexKey = @"MDCTonalPaletteMainColorIndexKey";
static NSString *const MDCTonalPaletteLightColorIndexKey = @"MDCTonalPaletteLightColorIndexKey";
static NSString *const MDCTonalPaletteDarkColorIndexKey = @"MDCTonalPaletteDarkColorIndexKey";

@interface MDCTonalPalette ()

@property (nonatomic, copy, nonnull) NSArray<UIColor *> *colors;
@property (nonatomic) NSUInteger mainColorIndex;
@property (nonatomic) NSUInteger lightColorIndex;
@property (nonatomic) NSUInteger darkColorIndex;

@end

@implementation MDCTonalPalette

- (nonnull instancetype)initWithColors:(nonnull NSArray<UIColor *> *)colors
                        mainColorIndex:(NSUInteger)mainColorIndex
                       lightColorIndex:(NSUInteger)lightColorIndex
                        darkColorIndex:(NSUInteger)darkColorIndex {
  self = [super init];
  if (self) {
    _colors = [colors copy];
    if (mainColorIndex > colors.count - 1) {
      NSAssert(NO, @"Main color index is greater than color array size.");
    }
    if (lightColorIndex > colors.count - 1) {
      NSAssert(NO, @"Light color index is greater than color array size.");
    }
    if (darkColorIndex > colors.count - 1) {
      NSAssert(NO, @"Dark color index is greater than color array size.");
    }
    _mainColorIndex = mainColorIndex;
    _lightColorIndex = lightColorIndex;
    _darkColorIndex = darkColorIndex;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super init];
  if (self) {
    if ([coder containsValueForKey:MDCTonalPaletteColorsKey]) {
      _colors = [coder decodeObjectOfClass:[NSArray class] forKey:MDCTonalPaletteColorsKey];
    }

    if ([coder containsValueForKey:MDCTonalPaletteMainColorIndexKey]) {
      _mainColorIndex = [coder decodeIntegerForKey:MDCTonalPaletteMainColorIndexKey];
    }

    if ([coder containsValueForKey:MDCTonalPaletteLightColorIndexKey]) {
      _lightColorIndex = [coder decodeIntegerForKey:MDCTonalPaletteLightColorIndexKey];
    }

    if ([coder containsValueForKey:MDCTonalPaletteDarkColorIndexKey]) {
      _darkColorIndex = [coder decodeIntegerForKey:MDCTonalPaletteDarkColorIndexKey];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.colors forKey:MDCTonalPaletteColorsKey];
  [aCoder encodeInteger:self.mainColorIndex forKey:MDCTonalPaletteMainColorIndexKey];
  [aCoder encodeInteger:self.lightColorIndex forKey:MDCTonalPaletteLightColorIndexKey];
  [aCoder encodeInteger:self.darkColorIndex forKey:MDCTonalPaletteDarkColorIndexKey];
}

- (UIColor *)mainColor {
  return _colors[_mainColorIndex];
}

- (UIColor *)lightColor {
  return _colors[_lightColorIndex];
}

- (UIColor *)darkColor {
  return _colors[_darkColorIndex];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTonalPalette *copy = [[[self class] allocWithZone:zone] init];
  if (copy) {
    copy.colors = [self colors];
    copy.mainColorIndex = [self mainColorIndex];
    copy.lightColorIndex = [self lightColorIndex];
    copy.darkColorIndex = [self darkColorIndex];
  }
  return copy;
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
