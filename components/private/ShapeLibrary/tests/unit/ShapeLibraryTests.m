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
#import "MaterialMath.h"

@interface ShapeLibraryTests : XCTestCase

@end

@implementation ShapeLibraryTests

- (void)testCurvedCornerEquality {
  // Given
  MDCCurvedCornerTreatment *curvedCorner =
      [[MDCCurvedCornerTreatment alloc] initWithSize:CGSizeMake(2, 5)];
  MDCCurvedCornerTreatment *curvedCorner2 =
      [[MDCCurvedCornerTreatment alloc] initWithSize:CGSizeMake(1, 3)];
  MDCCornerTreatment *cornerTreatment = [MDCCornerTreatment cornerWithCurve:CGSizeMake(2, 5)];

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
  MDCCornerTreatment *cornerTreatment = [MDCCornerTreatment cornerWithRadius:3.2f];

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
  MDCCutCornerTreatment *cutCorner = [[MDCCutCornerTreatment alloc] initWithCut:3.2f];
  MDCCutCornerTreatment *cutCorner2 = [[MDCCutCornerTreatment alloc] initWithCut:4.3f];
  MDCCornerTreatment *cornerTreatment = [MDCCornerTreatment cornerWithCut:3.2f];

  // When
  XCTAssertNotEqualObjects(cutCorner, cutCorner2);
  cutCorner2.cut = 3.2f;

  // Then
  XCTAssertEqualObjects(cutCorner, cornerTreatment);
  XCTAssertEqualObjects(cutCorner, cutCorner2);
  XCTAssertEqualObjects(cutCorner, cutCorner);
}

- (void)testPercentageValueInequalityForCorners {
  // Given
  MDCCutCornerTreatment *corner = [[MDCCutCornerTreatment alloc] initWithCut:3.2f];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  MDCCornerTreatment *cornerTreatment = [MDCCornerTreatment cornerWithCut:3.2f];

  // Then
  XCTAssertNotEqualObjects(corner, cornerTreatment);
}

- (void)testPercentageValueEqualityForCorners {
  // Given
  MDCRoundedCornerTreatment *corner = [[MDCRoundedCornerTreatment alloc] initWithRadius:1.2f];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  MDCCornerTreatment *cornerTreatment =
      [MDCCornerTreatment cornerWithRadius:1.2f valueType:MDCCornerTreatmentValueTypePercentage];

  // Then
  XCTAssertEqualObjects(corner, cornerTreatment);
}

- (void)testPathGeneratorForPercentages {
  // Given
  MDCRectangleShapeGenerator *shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  MDCCutCornerTreatment *corner = [[MDCCutCornerTreatment alloc] initWithCut:0.5f];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  [shapeGenerator setCorners:corner];

  // When
  CGPathRef path = [shapeGenerator pathForSize:CGSizeMake(100, 100)];
  NSMutableArray *pathPoints = [NSMutableArray array];
  CGPathApply(path, (__bridge void *)pathPoints, GetCGPathAddLineToPointValues);

  // Then
  // The outcome of an 100x100 square with 50% cut corners is a diamond with points at
  // (0, 50), (50, 0), (100, 50), (50, 100)
  XCTAssertEqual([pathPoints count], 8);
  for (NSValue *value in pathPoints) {
    CGPoint point = value.CGPointValue;
    XCTAssert(MDCCGFloatEqual(MDCRound(point.x), 0.f) ||
              MDCCGFloatEqual(MDCRound(point.x), 50.f) ||
              MDCCGFloatEqual(MDCRound(point.x), 100.f));
    XCTAssert(MDCCGFloatEqual(MDCRound(point.y), 0.f) ||
              MDCCGFloatEqual(MDCRound(point.y), 50.f) ||
              MDCCGFloatEqual(MDCRound(point.y), 100.f));
  }
}

void GetCGPathAddLineToPointValues (void *info, const CGPathElement *element) {
  NSMutableArray *pathPoints = (__bridge NSMutableArray *)info;
  CGPoint *points = element->points;
  CGPathElementType type = element->type;
  if (type == kCGPathElementAddLineToPoint) {
    [pathPoints addObject:[NSValue valueWithCGPoint:points[0]]];
  }
}

- (void)testCopyForCorners {
  // Given
  MDCRoundedCornerTreatment *corner = [[MDCRoundedCornerTreatment alloc] initWithRadius:1.2f];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;

  // When
  MDCCornerTreatment *copy = [corner copy];

  // Then
  XCTAssertEqualObjects(corner, copy);
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
