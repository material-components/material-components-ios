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

#import "MaterialButtons+ShapeThemer.h"
#import "MaterialButtons.h"
#import "MaterialShapeLibrary.h"

@interface ButtonsShapeThemerTests : XCTestCase

@property(nonatomic, strong) MDCButton *button;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;

@end

@implementation ButtonsShapeThemerTests

- (void)setUp {
  self.button = [[MDCButton alloc] init];
  self.shapeScheme = [[MDCShapeScheme alloc] init];
}

- (void)tearDown {
  self.button = nil;
  self.shapeScheme = nil;
}

- (void)testMDCButtonShapeThemer {
  // Given
  self.shapeScheme.smallComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut andSize:10];
  self.shapeScheme.smallComponentShape.topRightCorner = [MDCCornerTreatment cornerWithRadius:3];
  self.button.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  // When
  [MDCButtonShapeThemer applyShapeScheme:self.shapeScheme toButton:self.button];

  // Then
  MDCRectangleShapeGenerator *rect = (MDCRectangleShapeGenerator *)self.button.shapeGenerator;
  XCTAssertEqualObjects(rect.topLeftCorner, self.shapeScheme.smallComponentShape.topLeftCorner);
  XCTAssertEqualObjects(rect.topRightCorner, self.shapeScheme.smallComponentShape.topRightCorner);
  XCTAssertEqualObjects(rect.bottomLeftCorner,
                        self.shapeScheme.smallComponentShape.bottomLeftCorner);
  XCTAssertEqualObjects(rect.bottomRightCorner,
                        self.shapeScheme.smallComponentShape.bottomRightCorner);
}

- (void)testMDCFloatingButtonShapeThemer {
  // Given
  MDCFloatingButton *FAB = [[MDCFloatingButton alloc] initWithFrame:CGRectZero
                                                              shape:MDCFloatingButtonShapeDefault];
  self.shapeScheme.smallComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut andSize:10];
  FAB.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  // When
  [MDCFloatingButtonShapeThemer applyShapeScheme:self.shapeScheme toButton:FAB];

  // Then
  MDCRectangleShapeGenerator *rect = (MDCRectangleShapeGenerator *)FAB.shapeGenerator;
  MDCCornerTreatment *corner = [MDCCornerTreatment cornerWithRadius:(CGFloat)0.5];
  corner.valueType = MDCCornerTreatmentValueTypePercentage;
  XCTAssertEqualObjects(rect.topLeftCorner, corner);
  XCTAssertEqualObjects(rect.topRightCorner, corner);
  XCTAssertEqualObjects(rect.bottomLeftCorner, corner);
  XCTAssertEqualObjects(rect.bottomRightCorner, corner);
}

- (void)testBackgroundColorAfterButtonTheming {
  // Given
  UIColor *bgColor = [UIColor blueColor];
  self.button.backgroundColor = bgColor;

  // When
  [MDCButtonShapeThemer applyShapeScheme:self.shapeScheme toButton:self.button];

  // Then
  XCTAssertEqualObjects(bgColor, self.button.backgroundColor);
}

@end
