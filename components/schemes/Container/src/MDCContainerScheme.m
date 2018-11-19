// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCContainerScheme.h"

@implementation MDCContainerScheme

- (instancetype)initWithDefaults:(MDCContainerSchemeDefaults)defaults {
  self = [super init];
  if (self) {
    MDCColorSchemeDefaults colorSchemeDefaults;
    MDCTypographySchemeDefaults typographySchemeDefaults;
    MDCShapeSchemeDefaults shapeSchemeDefaults;
    switch (defaults) {
      case MDCContainerSchemeDefaultsMaterial201811:
        colorSchemeDefaults = MDCColorSchemeDefaultsMaterial201804;
        typographySchemeDefaults = MDCTypographySchemeDefaultsMaterial201804;
        shapeSchemeDefaults = MDCShapeSchemeDefaultsMaterial201809;
        break;
    }
    _colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:colorSchemeDefaults];
    _typographyScheme = [[MDCTypographyScheme alloc] initWithDefaults:typographySchemeDefaults];
    _shapeScheme = [[MDCShapeScheme alloc] initWithDefaults:shapeSchemeDefaults];
  }
  return self;
}

- (BOOL)isEqual:(id)object {
  if (object == self) {
    return YES;
  }

  if (!object || ![[object class] isEqual:[self class]]) {
    return NO;
  }

  MDCContainerScheme *scheme = (MDCContainerScheme *)object;
  return [self.colorScheme isEqual:scheme.colorScheme] &&
         [self.typographyScheme isEqual:scheme.typographyScheme] &&
         [self.shapeScheme isEqual:scheme.shapeScheme];
}

@end
