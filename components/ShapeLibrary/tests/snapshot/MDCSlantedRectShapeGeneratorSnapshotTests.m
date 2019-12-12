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

#import <UIKit/UIKit.h>

#import "MaterialShapeLibrary.h"

/** Snapshot tests for MDCSlantedRectShapeGenerator. */
@interface MDCSlantedRectShapeGeneratorSnapshotTests : MDCSnapshotTestCase

/** The view to shape for testing. */
@property(nonatomic, strong) UIView *view;

@end

@implementation MDCSlantedRectShapeGeneratorSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.view = [[UIView alloc] init];
  self.view.backgroundColor = UIColor.cyanColor;
}

- (void)tearDown {
  self.view = nil;

  [super tearDown];
}

- (void)generateAndVerifySnapshot {
  [self.view layoutIfNeeded];
  UIView *backgroundView = [self.view mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)setSmallSquareBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 24, 24);
}

- (void)setSmallTallRectangleBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 12, 24);
}

- (void)setSmallWideRectangleBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 24, 12);
}

- (void)setMediumSquareBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 80, 80);
}

- (void)setMediumTallRectangleBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 40, 80);
}

- (void)setMediumWideRectangleBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 80, 40);
}

- (void)setLargeSquareBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 360, 360);
}

- (void)setLargeTallRectangleBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 180, 360);
}

- (void)setLargeWideRectangleBoundsToView {
  self.view.bounds = CGRectMake(0, 0, 360, 180);
}

- (void)applySlantedRectShapeGeneratorLayer {
  MDCSlantedRectShapeGenerator *generator = [[MDCSlantedRectShapeGenerator alloc] init];
  generator.slant = MAX(4, CGRectGetWidth(self.view.bounds) / 10);
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  maskLayer.path = [generator
      pathForSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
  self.view.layer.mask = maskLayer;
}

#pragma mark - Tests

- (void)testSlantedRectShapeGeneratorSmallSquare {
  // Given
  [self setSmallSquareBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorSmallTallRectangle {
  // Given
  [self setSmallTallRectangleBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorSmallWideRectangle {
  // Given
  [self setSmallWideRectangleBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorMediumSquare {
  // Given
  [self setMediumSquareBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorMediumTallRectangle {
  // Given
  [self setMediumTallRectangleBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorMediumWideRectangle {
  // Given
  [self setMediumWideRectangleBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorLargeSquare {
  // Given
  [self setLargeSquareBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorLargeTallRectangle {
  // Given
  [self setLargeTallRectangleBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testSlantedRectShapeGeneratorLargeWideRectangle {
  // Given
  [self setLargeWideRectangleBoundsToView];

  // When
  [self applySlantedRectShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

@end
