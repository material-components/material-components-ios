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

#import <XCTest/XCTest.h>

#import "MaterialContainerScheme.h"

@interface MDCContainerSchemeTests : XCTestCase
@end

@implementation MDCContainerSchemeTests

- (void)testInitWithMaterialDefaults {
  // Given
  MDCContainerScheme *defaultContainerScheme =
      [[MDCContainerScheme alloc] initWithDefaults:MDCContainerSchemeDefaultsMaterial201811];

  MDCSemanticColorScheme *defaultColorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  XCTAssertEqualObjects(defaultContainerScheme.colorScheme, defaultColorScheme);

  MDCTypographyScheme *defaultTypographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  XCTAssertEqualObjects(defaultContainerScheme.typographyScheme, defaultTypographyScheme);

  MDCShapeScheme *defaultShapeScheme =
      [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
  XCTAssertEqualObjects(defaultContainerScheme.shapeScheme, defaultShapeScheme);
}

@end
