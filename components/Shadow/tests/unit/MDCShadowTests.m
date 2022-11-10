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
#import "MDCShadowsCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDCShadowsCollection (Testing)
- (MDCShadow *)shadowForElevation:(CGFloat)elevation;
@end

@interface MDCShadowTests : XCTestCase
@end

@implementation MDCShadowTests

- (void)testZeroElevationShouldReturnEmptyShadow {
  // Given
  MDCShadow *shadow = [MDCShadowsCollectionDefault() shadowForElevation:0];

  // Then
  XCTAssertEqual(shadow.opacity, 0);
  XCTAssertEqual(shadow.radius, 0);
  XCTAssertEqual(shadow.offset.width + shadow.offset.height, 0);
  XCTAssertEqual(shadow.spread, 0);
}

- (void)testLowElevationShouldReturnShadow {
  // Given
  MDCShadow *shadow = [MDCShadowsCollectionDefault() shadowForElevation:2];

  // Then
  XCTAssertGreaterThan(shadow.opacity, 0);
  XCTAssertGreaterThan(shadow.radius, 0);
  XCTAssertGreaterThan(shadow.offset.width + shadow.offset.height, 0);
  XCTAssertEqual(shadow.spread, 0);
}

- (void)testHighElevationShouldReturnShadow {
  // Given
  MDCShadow *shadow = [MDCShadowsCollectionDefault() shadowForElevation:24];

  // Then
  XCTAssertGreaterThan(shadow.opacity, 0);
  XCTAssertGreaterThan(shadow.radius, 0);
  XCTAssertGreaterThan(shadow.offset.width + shadow.offset.height, 0);
  XCTAssertEqual(shadow.spread, 0);
}

- (void)testSameElevationShouldBeEqualToSelf {
  // Given
  MDCShadow *lowElevationShadowA = [MDCShadowsCollectionDefault() shadowForElevation:2];
  MDCShadow *lowElevationShadowB = [MDCShadowsCollectionDefault() shadowForElevation:2];

  // Then
  XCTAssertEqualObjects(lowElevationShadowA, lowElevationShadowB);
}

- (void)testLowElevationShouldReturnDifferentShadowFromHighElevation {
  // Given
  MDCShadow *lowElevationShadow = [MDCShadowsCollectionDefault() shadowForElevation:2];
  MDCShadow *highElevationShadow = [MDCShadowsCollectionDefault() shadowForElevation:24];

  // Then
  XCTAssertNotEqualObjects(lowElevationShadow, highElevationShadow);
}

- (void)testDefaultShadowElevationValuesAreReturnedCorrectlyForOutOfBoundsElevations {
  // Given
  MDCShadowsCollection *shadowsCollection = MDCShadowsCollectionDefault();

  // When
  MDCShadow *negativeShadow = [shadowsCollection shadowForElevation:-4];
  MDCShadow *bigShadow = [shadowsCollection shadowForElevation:13];
  MDCShadow *hugeShadow = [shadowsCollection shadowForElevation:3000];

  // Then
  XCTAssertEqualObjects(negativeShadow, [shadowsCollection shadowForElevation:0]);
  XCTAssertEqualObjects(bigShadow, [shadowsCollection shadowForElevation:12]);
  XCTAssertEqualObjects(hugeShadow, [shadowsCollection shadowForElevation:12]);
}

- (void)testDefaultShadowElevationValuesAreReturnedCorrectlyForInBetweenValueElevations {
  // Given
  MDCShadowsCollection *shadowsCollection = MDCShadowsCollectionDefault();

  // When
  MDCShadow *shadow1 = [shadowsCollection shadowForElevation:0.1];
  MDCShadow *shadow2 = [shadowsCollection shadowForElevation:2.314];
  MDCShadow *shadow3 = [shadowsCollection shadowForElevation:4];
  MDCShadow *shadow4 = [shadowsCollection shadowForElevation:6.01];
  MDCShadow *shadow5 = [shadowsCollection shadowForElevation:9.11];

  // Then
  XCTAssertEqualObjects(shadow1, [shadowsCollection shadowForElevation:1]);
  XCTAssertEqualObjects(shadow2, [shadowsCollection shadowForElevation:3]);
  XCTAssertEqualObjects(shadow3, [shadowsCollection shadowForElevation:6]);
  XCTAssertEqualObjects(shadow4, [shadowsCollection shadowForElevation:8]);
  XCTAssertEqualObjects(shadow5, [shadowsCollection shadowForElevation:12]);
}

- (void)testSettingNewShadowInstanceUsingBuilder {
  // Given
  MDCShadow *shadow = [[MDCShadowBuilder builderWithColor:UIColor.whiteColor
                                                  opacity:0.1
                                                   radius:0.2
                                                   offset:CGSizeMake(0.3, 0.4)] build];

  // When
  MDCShadowsCollection *shadowsCollection =
      [[MDCShadowsCollectionBuilder builderWithShadow:shadow forElevation:4] build];

  // Then
  MDCShadow *fetchedShadow = [shadowsCollection shadowForElevation:4];
  XCTAssertEqualObjects(shadow, fetchedShadow);
}

@end

NS_ASSUME_NONNULL_END
