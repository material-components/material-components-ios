// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCShadow.h"

#import "MaterialAvailability.h"
#import "MDCShadow+Internal.h"

@implementation MDCShadow

- (instancetype)initWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
  self = [super init];
  if (self) {
    _opacity = opacity;
    _radius = radius;
    _offset = offset;
  }
  return self;
}

- (BOOL)isEqual:(id)other {
  if (self == other) {
    return YES;
  }
  if (![other isKindOfClass:[MDCShadow class]]) {
    return NO;
  }
  MDCShadow *otherShadow = other;
  return _opacity == otherShadow.opacity && _radius == otherShadow.radius &&
         CGSizeEqualToSize(_offset, otherShadow.offset);
}

- (NSUInteger)hash {
  const NSUInteger kPrime = 31;
  NSUInteger result = 1;
  result = result * kPrime + (NSUInteger)_opacity;
  result = result * kPrime + (NSUInteger)_radius;
  result = result * kPrime + (NSUInteger)(_offset.width);
  result = result * kPrime + (NSUInteger)(_offset.height);
  return result;
}

@end

@implementation MDCShadowBuilder

- (MDCShadow *)build {
  return [[MDCShadow alloc] initWithOpacity:self.opacity radius:self.radius offset:self.offset];
}

@end

static UIColor *LightStyleShadowColor(void) {
  static UIColor *lightStyleShadowColor;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    lightStyleShadowColor = [UIColor colorWithRed:0.235 green:0.251 blue:0.263 alpha:1];
  });
  return lightStyleShadowColor;
}

UIColor *MDCShadowColor(void) {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    return [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
      switch (traitCollection.userInterfaceStyle) {
        case UIUserInterfaceStyleUnspecified:
          __attribute__((fallthrough));
        case UIUserInterfaceStyleLight:
          return LightStyleShadowColor();
        case UIUserInterfaceStyleDark:
          return UIColor.blackColor;
      }
      __builtin_unreachable();
    }];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
  return LightStyleShadowColor();
}

static int ShadowElevationToLevel(CGFloat elevation) {
  if (elevation < 1) {
    return 0;
  }
  if (elevation < 3) {
    return 1;
  }
  if (elevation < 6) {
    return 2;
  }
  if (elevation < 8) {
    return 3;
  }
  if (elevation < 12) {
    return 4;
  }
  return 5;
}

MDCShadow *MDCShadowForElevation(CGFloat elevation) {
  static NSArray *shadowLevels;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shadowLevels = @[
      [[MDCShadow alloc] initWithOpacity:0 radius:0 offset:CGSizeMake(0, 0)],
      [[MDCShadow alloc] initWithOpacity:0.43 radius:2.5 offset:CGSizeMake(0, 1)],
      [[MDCShadow alloc] initWithOpacity:0.4 radius:3.25 offset:CGSizeMake(0, 1.25)],
      [[MDCShadow alloc] initWithOpacity:0.34 radius:4.75 offset:CGSizeMake(0, 2.25)],
      [[MDCShadow alloc] initWithOpacity:0.42 radius:6 offset:CGSizeMake(0, 3)],
      [[MDCShadow alloc] initWithOpacity:0.4 radius:7.25 offset:CGSizeMake(0, 5)],
    ];
  });
  int shadowLevel = ShadowElevationToLevel(elevation);
  return shadowLevels[shadowLevel];
}
