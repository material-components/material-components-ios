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

- (void)testWithMaterialInit {
  // Given
  MDCContainerScheme *defaultContainerScheme = [[MDCContainerScheme alloc] init];

  // Then
  XCTAssertNotNil(defaultContainerScheme.colorScheme);
  XCTAssertEqualObjects(
      defaultContainerScheme.colorScheme,
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804]);
  XCTAssertNotNil(defaultContainerScheme.typographyScheme);
  XCTAssertEqualObjects(
      defaultContainerScheme.typographyScheme,
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804]);
  XCTAssertNil(defaultContainerScheme.shapeScheme);
}

@end
