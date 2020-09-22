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

#import "MaterialShapeLibrary.h"
#import "MaterialShapeScheme.h"

@interface MDCShapeSchemeTests : XCTestCase
@end

@implementation MDCShapeSchemeTests

- (void)testShapeCategoryEquality {
  // Given
  MDCShapeCategory *originalCategory =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut andSize:(CGFloat)2.1];
  MDCShapeCategory *testCategory = [[MDCShapeCategory alloc] init];
  MDCCornerTreatment *corner =
      [MDCCornerTreatment cornerWithCut:(CGFloat)2.1 valueType:MDCCornerTreatmentValueTypeAbsolute];
  testCategory.topLeftCorner = corner;
  testCategory.topRightCorner = corner;
  testCategory.bottomLeftCorner = corner;
  testCategory.bottomRightCorner = corner;

  // Then
  XCTAssertEqual(originalCategory.hash, testCategory.hash);
  XCTAssertEqualObjects(originalCategory, testCategory);
}

- (void)testInitMatchesInitWithMaterialDefaults {
  // Given
  MDCShapeScheme *initScheme = [[MDCShapeScheme alloc] init];
  MDCShapeScheme *mdDefaultScheme =
      [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];

  // Then
  XCTAssertEqualObjects(initScheme.largeComponentShape, mdDefaultScheme.largeComponentShape);
  XCTAssertEqualObjects(initScheme.mediumComponentShape, mdDefaultScheme.mediumComponentShape);
  XCTAssertEqualObjects(initScheme.smallComponentShape, mdDefaultScheme.smallComponentShape);
}

- (void)testInitWithMaterialDefaults {
  // Given
  MDCShapeScheme *shapeScheme =
      [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];

  // Then
  XCTAssertEqualObjects(shapeScheme.largeComponentShape,
                        [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                                andSize:0]);
  XCTAssertEqualObjects(shapeScheme.mediumComponentShape,
                        [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                                andSize:4]);
  XCTAssertEqualObjects(shapeScheme.smallComponentShape,
                        [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                                andSize:4]);
}

- (void)testShapeCategoryCopy {
  // Given
  MDCShapeCategory *cat = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut
                                                                  andSize:(CGFloat)2.2];

  // When
  MDCShapeCategory *copiedCat = [cat copy];

  // Then
  XCTAssertNotEqual(cat, copiedCat);
  XCTAssertEqualObjects(cat, copiedCat);
  XCTAssertEqualObjects(cat.topRightCorner, copiedCat.topRightCorner);
  XCTAssertEqualObjects(cat.topLeftCorner, copiedCat.topLeftCorner);
  XCTAssertEqualObjects(cat.bottomRightCorner, copiedCat.bottomRightCorner);
  XCTAssertEqualObjects(cat.bottomLeftCorner, copiedCat.bottomLeftCorner);
}
@end
