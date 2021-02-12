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

#import "MDCShapeScheme.h"

#import "MDCShapeCategory.h"

@implementation MDCShapeScheme

- (instancetype)init {
  return [self initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
}

- (instancetype)initWithDefaults:(MDCShapeSchemeDefaults)defaults {
  self = [super init];
  if (self) {
    switch (defaults) {
      case MDCShapeSchemeDefaultsMaterial201809:
        _smallComponentShape =
            [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded andSize:4];
        _mediumComponentShape =
            [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded andSize:4];
        _largeComponentShape =
            [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded andSize:0];
        break;
    }
  }
  return self;
}

@end
