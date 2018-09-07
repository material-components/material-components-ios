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

#import <XCTest/XCTest.h>

#import "MDCCornerTreatment+CornerTypeInitalizer.h"
#import "MDCCurvedCornerTreatment.h"
#import "MDCCurvedRectShapeGenerator.h"
#import "MDCCutCornerTreatment.h"
#import "MDCPillShapeGenerator.h"
#import "MDCRoundedCornerTreatment.h"
#import "MDCSlantedRectShapeGenerator.h"
#import "MDCTriangleEdgeTreatment.h"

@interface ShapeLibraryTests : XCTestCase

@end

@implementation ShapeLibraryTests

- (void)testCurvedCornerEquality {
  // Given
  MDCCurvedCornerTreatment *curvedCorner =
      [[MDCCurvedCornerTreatment alloc] initWithSize:CGSizeMake(2, 5)];
  MDCCurvedCornerTreatment *curvedCorner2 =
      [[MDCCurvedCornerTreatment alloc] initWithSize:CGSizeMake(1, 3)];
  NSNumber *value = (NSNumber *)[NSValue valueWithCGSize:CGSizeMake(2, 5)];
  MDCCornerTreatment *cornerTreatment =
      [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeCurved
                                             andSize:value];

  // When
  XCTAssertNotEqualObjects(curvedCorner, curvedCorner2);
  curvedCorner2.size = CGSizeMake(2, 5);

  // Then
  XCTAssertEqualObjects(curvedCorner, cornerTreatment);
  XCTAssertEqualObjects(curvedCorner, curvedCorner2);
  XCTAssertEqualObjects(curvedCorner, curvedCorner);
}

- (void)testRoundedCornerEquality {
  // Given
  MDCRoundedCornerTreatment *roundedCorner =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:3.2f];
  MDCRoundedCornerTreatment *roundedCorner2 =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:4.3f];
  NSNumber *value = @(3.2f);
  MDCCornerTreatment *cornerTreatment =
      [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeRounded
                                             andSize:value];

  // When
  XCTAssertNotEqualObjects(roundedCorner, roundedCorner2);
  roundedCorner2.radius = 3.2f;

  // Then
  XCTAssertEqualObjects(roundedCorner, cornerTreatment);
  XCTAssertEqualObjects(roundedCorner, roundedCorner2);
  XCTAssertEqualObjects(roundedCorner, roundedCorner);
}

- (void)testCutCornerEquality {
  // Given
  MDCCutCornerTreatment *cutCorner =
      [[MDCCutCornerTreatment alloc] initWithCut:3.2f];
  MDCCutCornerTreatment *cutCorner2 =
      [[MDCCutCornerTreatment alloc] initWithCut:4.3f];
  NSNumber *value = @(3.2f);
  MDCCornerTreatment *cornerTreatment =
      [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeCut
                                             andSize:value];

  // When
  XCTAssertNotEqualObjects(cutCorner, cutCorner2);
  cutCorner2.cut = 3.2f;

  // Then
  XCTAssertEqualObjects(cutCorner, cornerTreatment);
  XCTAssertEqualObjects(cutCorner, cutCorner2);
  XCTAssertEqualObjects(cutCorner, cutCorner);
}

- (void)testCurvedCornerInit {
  MDCCurvedCornerTreatment *treatment = [[MDCCurvedCornerTreatment alloc] init];
  XCTAssertNotNil(treatment);
}

- (void)testCurvedRectShapeGeneratorInit {
  MDCCurvedRectShapeGenerator *generator = [[MDCCurvedRectShapeGenerator alloc] init];
  XCTAssertNotNil(generator);
}

- (void)testCutCornerInit {
  MDCCutCornerTreatment *treatment = [[MDCCutCornerTreatment alloc] init];
  XCTAssertNotNil(treatment);
}

- (void)testPillShapeGeneratorInit {
  MDCPillShapeGenerator *generator = [[MDCPillShapeGenerator alloc] init];
  XCTAssertNotNil(generator);
}

- (void)testRoundedCornerTreatmentInit {
  MDCRoundedCornerTreatment *treatment = [[MDCRoundedCornerTreatment alloc] init];
  XCTAssertNotNil(treatment);
}

- (void)testSlantedRectShapeGeneratorInit {
  MDCSlantedRectShapeGenerator *generator = [[MDCSlantedRectShapeGenerator alloc] init];
  XCTAssertNotNil(generator);
}

- (void)testTriangleEdgeTreatmentInit {
  MDCTriangleEdgeTreatment *treatment =
      [[MDCTriangleEdgeTreatment alloc] initWithSize:0 style:MDCTriangleEdgeStyleCut];
  XCTAssertNotNil(treatment);
}
@end
