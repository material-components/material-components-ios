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

/** Snapshot tests for MDCPillShapeGenerator. */
@interface MDCPillShapeGeneratorSnapshotTests : MDCSnapshotTestCase

/** The view to shape for testing. */
@property(nonatomic, strong) UIView *view;

@end

@implementation MDCPillShapeGeneratorSnapshotTests

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

- (void)applyPillShapeGeneratorLayer {
  MDCPillShapeGenerator *generator = [[MDCPillShapeGenerator alloc] init];
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  maskLayer.path = [generator
      pathForSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
  self.view.layer.mask = maskLayer;
}

#pragma mark - Tests

- (void)testPillShapeGeneratorSmallSquare {
  // Given
  [self setSmallSquareBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorSmallTallRectangle {
  // Given
  [self setSmallTallRectangleBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorSmallWideRectangle {
  // Given
  [self setSmallWideRectangleBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorMediumSquare {
  // Given
  [self setMediumSquareBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorMediumTallRectangle {
  // Given
  [self setMediumTallRectangleBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorMediumWideRectangle {
  // Given
  [self setMediumWideRectangleBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorLargeSquare {
  // Given
  [self setLargeSquareBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorLargeTallRectangle {
  // Given
  [self setLargeTallRectangleBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testPillShapeGeneratorLargeWideRectangle {
  // Given
  [self setLargeWideRectangleBoundsToView];

  // When
  [self applyPillShapeGeneratorLayer];

  // Then
  [self generateAndVerifySnapshot];
}

@end
