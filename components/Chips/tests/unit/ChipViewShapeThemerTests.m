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

#import "MaterialChips+ShapeThemer.h"
#import "MaterialChips.h"

@interface ChipViewShapeThemerTests : XCTestCase

@property(nonatomic, strong) MDCChipView *chip;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;

@end

@implementation ChipViewShapeThemerTests

- (void)setUp {
  self.chip = [[MDCChipView alloc] init];
  self.shapeScheme = [[MDCShapeScheme alloc] init];
}

- (void)tearDown {
  self.chip = nil;
  self.shapeScheme = nil;
}

- (void)testChipViewShapeThemer {
  // Given
  self.shapeScheme.smallSurfaceShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyAngled andSize:10];
  self.chip.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  // When
  [MDCChipViewShapeThemer applyShapeScheme:self.shapeScheme toChipView:self.chip];

  // Then
  MDCRectangleShapeGenerator *rect = (MDCRectangleShapeGenerator *)self.chip.shapeGenerator;
  MDCCornerTreatment *corner = [MDCCornerTreatment cornerWithRadius:0.5f];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  XCTAssertEqualObjects(rect.topLeftCorner, corner);
  XCTAssertEqualObjects(rect.topRightCorner, corner);
  XCTAssertEqualObjects(rect.bottomLeftCorner, corner);
  XCTAssertEqualObjects(rect.bottomRightCorner, corner);
}

@end
