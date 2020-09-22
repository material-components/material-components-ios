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

#import "MaterialShapeLibrary.h"

@interface ShapeLibraryTests : XCTestCase
void GetCGPathAddLineToPointValues(void *info, const CGPathElement *element);
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
  XCTAssertEqual(curvedCorner.hash, curvedCorner2.hash);
  XCTAssertEqualObjects(curvedCorner, cornerTreatment);
  XCTAssertEqualObjects(curvedCorner, curvedCorner2);
  XCTAssertEqualObjects(curvedCorner, curvedCorner);
}

- (void)testRoundedCornerEquality {
  // Given
  MDCRoundedCornerTreatment *roundedCorner =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:(CGFloat)3.2];
  MDCRoundedCornerTreatment *roundedCorner2 =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:(CGFloat)4.3];
  MDCCornerTreatment *cornerTreatment = [MDCCornerTreatment cornerWithRadius:(CGFloat)3.2];

  // When
  XCTAssertNotEqual(roundedCorner.hash, roundedCorner2.hash);
  XCTAssertNotEqualObjects(roundedCorner, roundedCorner2);
  roundedCorner2.radius = (CGFloat)3.2;

  // Then
  XCTAssertEqual(roundedCorner.hash, roundedCorner2.hash);
  XCTAssertEqualObjects(roundedCorner, cornerTreatment);
  XCTAssertEqualObjects(roundedCorner, roundedCorner2);
  XCTAssertEqualObjects(roundedCorner, roundedCorner);
}

- (void)testCutCornerEquality {
  // Given
  MDCCutCornerTreatment *cutCorner = [[MDCCutCornerTreatment alloc] initWithCut:(CGFloat)3.2];
  MDCCutCornerTreatment *cutCorner2 = [[MDCCutCornerTreatment alloc] initWithCut:(CGFloat)4.3];
  MDCCornerTreatment *cornerTreatment = [MDCCornerTreatment cornerWithCut:(CGFloat)3.2];

  // When
  XCTAssertNotEqual(cutCorner.hash, cutCorner2.hash);
  XCTAssertNotEqualObjects(cutCorner, cutCorner2);
  cutCorner2.cut = (CGFloat)3.2;

  // Then
  XCTAssertEqual(cutCorner.hash, cutCorner2.hash);
  XCTAssertEqualObjects(cutCorner, cornerTreatment);
  XCTAssertEqualObjects(cutCorner, cutCorner2);
  XCTAssertEqualObjects(cutCorner, cutCorner);
}

- (void)testPercentageValueInequalityForCorners {
  // Given
  MDCCutCornerTreatment *corner = [[MDCCutCornerTreatment alloc] initWithCut:(CGFloat)3.2];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  MDCCornerTreatment *cornerTreatment = [MDCCornerTreatment cornerWithCut:(CGFloat)3.2];

  // Then
  XCTAssertNotEqualObjects(corner, cornerTreatment);
}

- (void)testPercentageValueEqualityForCorners {
  // Given
  MDCRoundedCornerTreatment *corner =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:(CGFloat)1.2];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  MDCCornerTreatment *cornerTreatment =
      [MDCCornerTreatment cornerWithRadius:(CGFloat)1.2
                                 valueType:MDCCornerTreatmentValueTypePercentage];

  // Then
  XCTAssertEqualObjects(corner, cornerTreatment);
}

- (void)testPathGeneratorForPercentages {
  // Given
  MDCRectangleShapeGenerator *shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  MDCCutCornerTreatment *corner = [[MDCCutCornerTreatment alloc] initWithCut:(CGFloat)0.5];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  [shapeGenerator setCorners:corner];

  // When
  CGPathRef path = [shapeGenerator pathForSize:CGSizeMake(100, 100)];
  NSMutableArray<NSValue *> *pathPoints = [NSMutableArray array];
  CGPathApply(path, (__bridge void *)pathPoints, GetCGPathAddLineToPointValues);

  // Then
  // The outcome of an 100x100 square with 50% cut corners is a diamond with points at
  // (0, 50), (50, 0), (100, 50), (50, 100)
  XCTAssertEqual([pathPoints count], (NSUInteger)8);
  NSArray<NSValue *> *points =
      [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(50, 0)],
                                [NSValue valueWithCGPoint:CGPointMake(100, 50)],
                                [NSValue valueWithCGPoint:CGPointMake(50, 100)],
                                [NSValue valueWithCGPoint:CGPointMake(0, 50)], nil];
  for (NSUInteger i = 0; i < [pathPoints count]; i += 2) {
    CGPoint point = points[i / 2].CGPointValue;
    CGPoint p1 = pathPoints[i].CGPointValue;
    XCTAssertEqualWithAccuracy(point.x, p1.x, (CGFloat)0.0001);
    XCTAssertEqualWithAccuracy(point.y, p1.y, (CGFloat)0.0001);

    CGPoint p2 = pathPoints[i + 1].CGPointValue;
    XCTAssertEqualWithAccuracy(point.x, p2.x, (CGFloat)0.0001);
    XCTAssertEqualWithAccuracy(point.y, p2.y, (CGFloat)0.0001);
  }
}

void GetCGPathAddLineToPointValues(void *info, const CGPathElement *element) {
  NSMutableArray *pathPoints = (__bridge NSMutableArray *)info;
  CGPoint *points = element->points;
  CGPathElementType type = element->type;
  if (type == kCGPathElementAddLineToPoint) {
    [pathPoints addObject:[NSValue valueWithCGPoint:points[0]]];
  }
}

- (void)testCopyForCorners {
  // Given
  MDCRoundedCornerTreatment *corner =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:(CGFloat)1.2];
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
