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

#import "MDCTabBarIndicatorAttributes.h"

@implementation MDCTabBarIndicatorAttributes

#pragma mark - NSCopying

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCTabBarIndicatorAttributes *attributes = [[[self class] alloc] init];
  attributes.path = _path;
  return attributes;
}

#pragma mark - NSObject

- (NSString *)description {
  return [NSString stringWithFormat:@"%@ path:%@", [super description], _path];
}

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) {
    return NO;
  }

  MDCTabBarIndicatorAttributes *otherAttributes = object;

  if ((_path != otherAttributes.path) && ![_path isEqual:otherAttributes.path]) {
    return NO;
  }

  return YES;
}

- (NSUInteger)hash {
  return _path.hash;
}

@end
