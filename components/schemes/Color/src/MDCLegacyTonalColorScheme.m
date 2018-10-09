// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCLegacyTonalColorScheme.h"

#import "MDCLegacyTonalPalette.h"

@interface MDCTonalColorScheme ()

@property (nonatomic, strong, nonnull) MDCTonalPalette *primaryTonalPalette;
@property (nonatomic, strong, nonnull) MDCTonalPalette *secondaryTonalPalette;

@end

@implementation MDCTonalColorScheme

- (nonnull instancetype)initWithPrimaryTonalPalette:(nonnull MDCTonalPalette *)primaryTonalPalette
                              secondaryTonalPalette:(nonnull MDCTonalPalette *)secondaryTonalPalette
    {
  self = [super init];
  if (self) {
    _primaryTonalPalette = primaryTonalPalette;
    _secondaryTonalPalette = secondaryTonalPalette;
  }
  return self;
}

- (UIColor *)primaryColor {
  return _primaryTonalPalette.mainColor;
}

- (UIColor *)primaryLightColor {
  return _primaryTonalPalette.lightColor;
}

- (UIColor *)primaryDarkColor {
  return _primaryTonalPalette.darkColor;
}

- (UIColor *)secondaryColor {
  return _secondaryTonalPalette.mainColor;
}

- (UIColor *)secondaryLightColor {
  return _secondaryTonalPalette.lightColor;
}

- (UIColor *)secondaryDarkColor {
  return _secondaryTonalPalette.darkColor;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  MDCTonalColorScheme *copy = [[[self class] allocWithZone:zone] init];
  if (copy) {
    copy.primaryTonalPalette = [self primaryTonalPalette];
    copy.secondaryTonalPalette = [self secondaryTonalPalette];
  }
  return copy;
}

@end
