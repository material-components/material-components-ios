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

+ (MDCShadowBuilder *)builderWithOpacity:(CGFloat)opacity
                                  radius:(CGFloat)radius
                                  offset:(CGSize)offset {
  MDCShadowBuilder *builder = [[MDCShadowBuilder alloc] init];
  builder.opacity = opacity;
  builder.radius = radius;
  builder.offset = offset;
  return builder;
}

@end
