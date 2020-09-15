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

#import "MaterialList.h"

#import "MaterialInk.h"
#import "MaterialRipple.h"

#import <XCTest/XCTest.h>

@interface MDCBaseCell (Testing)
@property(nonatomic, strong) MDCRippleView *rippleView;
@property(nonatomic, strong) MDCInkView *inkView;
@end

@interface MDCBaseCellTests : XCTestCase

@property(nonatomic, strong, nullable) MDCBaseCell *baseCell;

@end

@implementation MDCBaseCellTests

- (void)setUp {
  [super setUp];

  self.baseCell = [[MDCBaseCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
}

- (void)tearDown {
  [super tearDown];

  self.baseCell = nil;
}

/**
 Test to confirm behavior of initializing a @c MDCBaseCell without any customization.
 */
- (void)testRippleIsDisabledAndRipplePropertiesAreCorrect {
  // Then
  XCTAssertNotNil(self.baseCell.rippleView);
  XCTAssertEqualObjects(self.baseCell.rippleView.rippleColor,
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqual(self.baseCell.rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertFalse(self.baseCell.enableRippleBehavior);
  XCTAssertNil(self.baseCell.rippleView.superview);
  CGRect baseCellBounds = CGRectStandardize(self.baseCell.bounds);
  CGRect rippleBounds = CGRectStandardize(self.baseCell.rippleView.bounds);
  XCTAssertTrue(CGRectEqualToRect(baseCellBounds, rippleBounds), @"%@ is not equal to %@",
                NSStringFromCGRect(baseCellBounds), NSStringFromCGRect(rippleBounds));
}

/**
 Test to confirm that setting @c enableRippleBehavior adds the @c rippleView as a subview.
 */
- (void)testRippleIsEnabledAndRipplePropertiesAreCorrectWhenRippleBehaviorIsEnabled {
  // When
  self.baseCell.enableRippleBehavior = YES;

  // Then
  XCTAssertNotNil(self.baseCell.rippleView);
  XCTAssertEqualObjects(self.baseCell.rippleView.rippleColor,
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqual(self.baseCell.rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertTrue(self.baseCell.enableRippleBehavior);
  XCTAssertNotNil(self.baseCell.rippleView.superview);
  XCTAssertNil(self.baseCell.inkView.superview);
  CGRect baseCellBounds = CGRectStandardize(self.baseCell.bounds);
  CGRect rippleBounds = CGRectStandardize(self.baseCell.rippleView.bounds);
  XCTAssertTrue(CGRectEqualToRect(baseCellBounds, rippleBounds), @"%@ is not equal to %@",
                NSStringFromCGRect(baseCellBounds), NSStringFromCGRect(rippleBounds));
}

/**
 Test to confirm toggling @c enableRippleBehavior removes the @c rippleView as a subview.
 */
- (void)testSetEnableRippleBehaviorToYesThenNoRemovesRippleViewAsSubviewOfButton {
  // When
  self.baseCell.enableRippleBehavior = YES;
  self.baseCell.enableRippleBehavior = NO;

  // Then
  XCTAssertEqualObjects(self.baseCell.inkView.superview, self.baseCell);
  XCTAssertNil(self.baseCell.rippleView.superview);
}

/**
 Test setting @c rippleColor correctly sets the @c rippleColor on @c rippleView of the base cell.
 */
- (void)testSetCustomRippleColorUpdatesRippleViewColor {
  // Given
  UIColor *color = UIColor.redColor;

  // When
  [self.baseCell setRippleColor:color];

  // Then
  XCTAssertEqualObjects(self.baseCell.rippleView.rippleColor, color);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCBaseCell *passedCell = nil;
  self.baseCell.traitCollectionDidChangeBlock =
      ^(MDCBaseCell *_Nonnull cell, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedCell = cell;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.baseCell traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedCell, self.baseCell);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

#pragma mark - MaterialElevation

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Given
  MDCBaseCell *cell = [[MDCBaseCell alloc] init];

  // Then
  XCTAssertLessThan(cell.mdc_overrideBaseElevation, 0);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat expectedBaseElevation = 99;

  // When
  self.baseCell.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.baseCell.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  const CGFloat finalElevation = 6;
  self.baseCell.elevation = finalElevation - 1;
  __block CGFloat newElevation = -1;
  self.baseCell.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    newElevation = elevation;
  };

  // When
  self.baseCell.elevation = self.baseCell.elevation + 1;

  // Then
  XCTAssertEqualWithAccuracy(newElevation, finalElevation, 0.001);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  self.baseCell.elevation = 5;
  __block BOOL blockCalled = NO;
  self.baseCell.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  self.baseCell.elevation = self.baseCell.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testRippleColorIsNullResettable {
  // Given
  self.baseCell.enableRippleBehavior = YES;
  UIColor *initialRippleColor = self.baseCell.rippleColor;

  // When
  self.baseCell.rippleColor = [UIColor yellowColor];
  self.baseCell.rippleColor = nil;

  // Then
  XCTAssertEqualObjects(initialRippleColor, self.baseCell.rippleColor);
}

@end
