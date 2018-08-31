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

#import "MDCCurvedCornerTreatment.h"
#import "MDCCurvedRectShapeGenerator.h"
#import "MDCPillShapeGenerator.h"
#import "MDCRoundedCornerTreatment.h"
#import "MDCSlantedRectShapeGenerator.h"
#import "MDCTriangleEdgeTreatment.h"

@interface ShapeLibraryNoopTest : XCTestCase

@end

@implementation ShapeLibraryNoopTest

- (void)testCurvedCornerInit {
  MDCCurvedCornerTreatment *treatment = [[MDCCurvedCornerTreatment alloc] init];
  XCTAssertNotNil(treatment);
}

- (void)testCurvedRectShapeGeneratorInit {
  MDCCurvedRectShapeGenerator *generator = [[MDCCurvedRectShapeGenerator alloc] init];
  XCTAssertNotNil(generator);
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
