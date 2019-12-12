// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnapshot.h"

#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"

/** Snapshot tests for MDCShapeView. */
@interface MDCShapedViewSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCShapedView *shapedView;

@end

@implementation MDCShapedViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.shapedView = [[MDCShapedView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  self.shapedView.backgroundColor = UIColor.magentaColor;
}

- (void)tearDown {
  self.shapedView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyView {
  UIView *snapshotView =
      [self.shapedView mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(40, 40, 80, 40)];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testCurvedRectShapedViewElevation00 {
  // When
  self.shapedView.shapeGenerator =
      [[MDCCurvedRectShapeGenerator alloc] initWithCornerSize:CGSizeMake(8, 8)];
  self.shapedView.elevation = 0;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testCurvedRectShapedViewElevation12 {
  // When
  self.shapedView.shapeGenerator =
      [[MDCCurvedRectShapeGenerator alloc] initWithCornerSize:CGSizeMake(8, 8)];
  self.shapedView.elevation = 12;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testCurvedRectShapedViewElevation24 {
  // When
  self.shapedView.shapeGenerator =
      [[MDCCurvedRectShapeGenerator alloc] initWithCornerSize:CGSizeMake(8, 8)];
  self.shapedView.elevation = 24;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testPillShapedViewElevation00 {
  // When
  self.shapedView.shapeGenerator = [[MDCPillShapeGenerator alloc] init];
  self.shapedView.elevation = 0;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testPillShapedViewElevation12 {
  // When
  self.shapedView.shapeGenerator = [[MDCPillShapeGenerator alloc] init];
  self.shapedView.elevation = 12;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testPillShapedViewElevation24 {
  // When
  self.shapedView.shapeGenerator = [[MDCPillShapeGenerator alloc] init];
  self.shapedView.elevation = 24;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testedSlantedRectShapedViewElevation00 {
  // Given
  MDCSlantedRectShapeGenerator *shapeGenerator = [[MDCSlantedRectShapeGenerator alloc] init];
  shapeGenerator.slant = 5;

  // When
  self.shapedView.shapeGenerator = shapeGenerator;
  self.shapedView.elevation = 0;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testedSlantedRectShapedViewElevation12 {
  // Given
  MDCSlantedRectShapeGenerator *shapeGenerator = [[MDCSlantedRectShapeGenerator alloc] init];
  shapeGenerator.slant = 5;

  // When
  self.shapedView.shapeGenerator = shapeGenerator;
  self.shapedView.elevation = 12;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testedSlantedRectShapedViewElevation24 {
  // Given
  MDCSlantedRectShapeGenerator *shapeGenerator = [[MDCSlantedRectShapeGenerator alloc] init];
  shapeGenerator.slant = 5;

  // When
  self.shapedView.shapeGenerator = shapeGenerator;
  self.shapedView.elevation = 24;

  // Then
  [self generateSnapshotAndVerifyView];
}

@end
