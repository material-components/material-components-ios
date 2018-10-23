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

#import "MaterialMath.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapeScheme.h"

@interface MDCShapeSchemeTests : XCTestCase
@end

@implementation MDCShapeSchemeTests

- (void)testShapeCategoryEquality {
  // Given
  MDCShapeCategory *cat1 = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut
                                                                   andSize:2.1f];
  MDCShapeCategory *cat2 = [[MDCShapeCategory alloc] init];
  MDCCornerTreatment *corner =
      [MDCCornerTreatment cornerWithCut:2.1f valueType:MDCCornerTreatmentValueTypeAbsolute];
  cat2.topLeftCorner = corner;
  cat2.topRightCorner = corner;
  cat2.bottomLeftCorner = corner;
  cat2.bottomRightCorner = corner;

  // Then
  XCTAssertEqualObjects(cat1, cat2);
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
                                                                andSize:0.f]);
  XCTAssertEqualObjects(shapeScheme.mediumComponentShape,
                        [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                                andSize:4.f]);
  XCTAssertEqualObjects(shapeScheme.smallComponentShape,
                        [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                                andSize:4.f]);
}

@end
