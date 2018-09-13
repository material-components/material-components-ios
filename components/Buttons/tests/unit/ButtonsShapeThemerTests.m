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

#import "MaterialButtons.h"
#import "MaterialButtons+ShapeThemer.h"

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
  self.shapeScheme.smallSurfaceShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyAngled andSize:10];
  self.button.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  // When
  [MDCButtonShapeThemer applyShapeScheme:self.shapeScheme toButton:self.button];

  // Then
  MDCRectangleShapeGenerator *rect = (MDCRectangleShapeGenerator *)self.button.shapeGenerator;
  XCTAssertEqualObjects(rect.topLeftCorner, self.shapeScheme.smallSurfaceShape.topLeftCorner);
  XCTAssertEqualObjects(rect.topRightCorner, self.shapeScheme.smallSurfaceShape.topRightCorner);
  XCTAssertEqualObjects(rect.bottomLeftCorner, self.shapeScheme.smallSurfaceShape.bottomLeftCorner);
  XCTAssertEqualObjects(rect.bottomRightCorner,
                        self.shapeScheme.smallSurfaceShape.bottomRightCorner);
}

@end
