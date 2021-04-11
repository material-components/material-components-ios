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

#import "MaterialShadow.h"

@interface MDCShadowsCollection (Testing)
- (MDCShadow *)shadowForElevation:(CGFloat)elevation;
@end

@interface MDCShadowTests : XCTestCase
@end

@implementation MDCShadowTests

- (void)testZeroElevationShouldReturnEmptyShadow {
  // Given
  MDCShadow *shadow = MDCShadowForElevation(0, MDCShadowsCollectionDefault());

  // Then
  XCTAssertEqual(shadow.opacity, 0);
  XCTAssertEqual(shadow.radius, 0);
  XCTAssertEqual(shadow.offset.width + shadow.offset.height, 0);
}

- (void)testLowElevationShouldReturnShadow {
  // Given
  MDCShadow *shadow = MDCShadowForElevation(2, MDCShadowsCollectionDefault());

  // Then
  XCTAssertGreaterThan(shadow.opacity, 0);
  XCTAssertGreaterThan(shadow.radius, 0);
  XCTAssertGreaterThan(shadow.offset.width + shadow.offset.height, 0);
}

- (void)testHighElevationShouldReturnShadow {
  // Given
  MDCShadow *shadow = MDCShadowForElevation(24, MDCShadowsCollectionDefault());

  // Then
  XCTAssertGreaterThan(shadow.opacity, 0);
  XCTAssertGreaterThan(shadow.radius, 0);
  XCTAssertGreaterThan(shadow.offset.width + shadow.offset.height, 0);
}

- (void)testSameElevationShouldBeEqualToSelf {
  // Given
  MDCShadow *lowElevationShadowA = MDCShadowForElevation(2, MDCShadowsCollectionDefault());
  MDCShadow *lowElevationShadowB = MDCShadowForElevation(2, MDCShadowsCollectionDefault());

  // Then
  XCTAssertEqualObjects(lowElevationShadowA, lowElevationShadowB);
}

- (void)testLowElevationShouldReturnDifferentShadowFromHighElevation {
  // Given
  MDCShadow *lowElevationShadow = MDCShadowForElevation(2, MDCShadowsCollectionDefault());
  MDCShadow *highElevationShadow = MDCShadowForElevation(24, MDCShadowsCollectionDefault());

  // Then
  XCTAssertNotEqualObjects(lowElevationShadow, highElevationShadow);
}

- (void)testDefaultShadowElevationValuesAreReturnedCorrectlyForGivenElevation {
  // Given
  MDCShadowsCollection *shadowsCollection = MDCShadowsCollectionDefault();

  // When
  MDCShadow *zeroShadow = MDCShadowForElevation(0, shadowsCollection);
  MDCShadow *oneShadow = MDCShadowForElevation(1, shadowsCollection);
  MDCShadow *threeShadow = MDCShadowForElevation(3, shadowsCollection);
  MDCShadow *sixShadow = MDCShadowForElevation(6, shadowsCollection);
  MDCShadow *eightShadow = MDCShadowForElevation(8, shadowsCollection);
  MDCShadow *twelveShadow = MDCShadowForElevation(12, shadowsCollection);

  // Then
  XCTAssertEqualObjects(zeroShadow, [shadowsCollection shadowForElevation:0]);
  XCTAssertEqualObjects(oneShadow, [shadowsCollection shadowForElevation:1]);
  XCTAssertEqualObjects(threeShadow, [shadowsCollection shadowForElevation:3]);
  XCTAssertEqualObjects(sixShadow, [shadowsCollection shadowForElevation:6]);
  XCTAssertEqualObjects(eightShadow, [shadowsCollection shadowForElevation:8]);
  XCTAssertEqualObjects(twelveShadow, [shadowsCollection shadowForElevation:12]);
}

- (void)testDefaultShadowElevationValuesAreReturnedCorrectlyForOutOfBoundsElevations {
  // Given
  MDCShadowsCollection *shadowsCollection = MDCShadowsCollectionDefault();

  // When
  MDCShadow *negativeShadow = MDCShadowForElevation(-4, shadowsCollection);
  MDCShadow *bigShadow = MDCShadowForElevation(13, shadowsCollection);
  MDCShadow *hugeShadow = MDCShadowForElevation(3000, shadowsCollection);

  // Then
  XCTAssertEqualObjects(negativeShadow, [shadowsCollection shadowForElevation:0]);
  XCTAssertEqualObjects(bigShadow, [shadowsCollection shadowForElevation:12]);
  XCTAssertEqualObjects(hugeShadow, [shadowsCollection shadowForElevation:12]);
}

- (void)testDefaultShadowElevationValuesAreReturnedCorrectlyForInBetweenValueElevations {
  // Given
  MDCShadowsCollection *shadowsCollection = MDCShadowsCollectionDefault();

  // When
  MDCShadow *shadow1 = MDCShadowForElevation(0.1, shadowsCollection);
  MDCShadow *shadow2 = MDCShadowForElevation(2.314, shadowsCollection);
  MDCShadow *shadow3 = MDCShadowForElevation(4, shadowsCollection);
  MDCShadow *shadow4 = MDCShadowForElevation(6.01, shadowsCollection);
  MDCShadow *shadow5 = MDCShadowForElevation(9.11, shadowsCollection);

  // Then
  XCTAssertEqualObjects(shadow1, [shadowsCollection shadowForElevation:1]);
  XCTAssertEqualObjects(shadow2, [shadowsCollection shadowForElevation:3]);
  XCTAssertEqualObjects(shadow3, [shadowsCollection shadowForElevation:6]);
  XCTAssertEqualObjects(shadow4, [shadowsCollection shadowForElevation:8]);
  XCTAssertEqualObjects(shadow5, [shadowsCollection shadowForElevation:12]);
}

- (void)testSettingNewShadowInstanceUsingBuilder {
  // Given
  MDCShadow *shadow = [[MDCShadowBuilder builderWithOpacity:0.1
                                                     radius:0.2
                                                     offset:CGSizeMake(0.3, 0.4)] build];

  // When
  MDCShadowsCollection *shadowsCollection =
      [[MDCShadowsCollectionBuilder builderWithShadow:shadow forElevation:4] build];

  // Then
  MDCShadow *fetchedShadow = MDCShadowForElevation(4, shadowsCollection);
  XCTAssertEqualObjects(shadow, fetchedShadow);
}

@end
