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

#import <XCTest/XCTest.h>

#import "MDCShadow.h"

@interface MDCShadowTests : XCTestCase
@end

@implementation MDCShadowTests

- (void)testZeroElevationShouldReturnEmptyShadow {
  // Given
  MDCShadow *shadow = MDCShadowForElevation(0);

  // Then
  XCTAssertEqual(shadow.opacity, 0);
  XCTAssertEqual(shadow.radius, 0);
  XCTAssertEqual(shadow.offset.width + shadow.offset.height, 0);
}

- (void)testLowElevationShouldReturnShadow {
  // Given
  MDCShadow *shadow = MDCShadowForElevation(2);

  // Then
  XCTAssertGreaterThan(shadow.opacity, 0);
  XCTAssertGreaterThan(shadow.radius, 0);
  XCTAssertGreaterThan(shadow.offset.width + shadow.offset.height, 0);
}

- (void)testHighElevationShouldReturnShadow {
  // Given
  MDCShadow *shadow = MDCShadowForElevation(24);

  // Then
  XCTAssertGreaterThan(shadow.opacity, 0);
  XCTAssertGreaterThan(shadow.radius, 0);
  XCTAssertGreaterThan(shadow.offset.width + shadow.offset.height, 0);
}

- (void)testSameElevationShouldBeEqualToSelf {
  // Given
  MDCShadow *lowElevationShadowA = MDCShadowForElevation(2);
  MDCShadow *lowElevationShadowB = MDCShadowForElevation(2);

  // Then
  XCTAssertEqualObjects(lowElevationShadowA, lowElevationShadowB);
}

- (void)testLowElevationShouldReturnDifferentShadowFromHighElevation {
  // Given
  MDCShadow *lowElevationShadow = MDCShadowForElevation(2);
  MDCShadow *highElevationShadow = MDCShadowForElevation(24);

  // Then
  XCTAssertNotEqualObjects(lowElevationShadow, highElevationShadow);
}

- (void)testBuilderReturnsExpectedValues {
  // Given
  MDCShadowBuilder *shadowBuilder = [[MDCShadowBuilder alloc] init];

  // When
  shadowBuilder.opacity = 42;
  shadowBuilder.radius = 23;
  shadowBuilder.offset = CGSizeMake(1, 2);

  MDCShadow *shadow = [shadowBuilder build];

  // Then
  XCTAssertEqualWithAccuracy(shadow.opacity, 42, 1e-6);
  XCTAssertEqualWithAccuracy(shadow.radius, 23, 1e-6);
  XCTAssertEqualWithAccuracy(shadow.offset.width, 1, 1e-6);
  XCTAssertEqualWithAccuracy(shadow.offset.height, 2, 1e-6);
}

@end
