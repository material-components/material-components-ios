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

#import <XCTest/XCTest.h>

#import "MaterialChips.h"
#import "MaterialInk.h"
#import "MaterialRipple.h"

@interface MDCChipView (Testing)
@property(nonatomic, strong) MDCStatefulRippleView *rippleView;
@property(nonatomic, strong) MDCInkView *inkView;
@end

/**
 This class confirms behavior of @c MDCChipView when used with @c MDCStatefulRippleView.
 */
@interface ChipViewRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCChipView *chipView;

@end

@implementation ChipViewRippleTests

- (void)setUp {
  [super setUp];

  self.chipView = [[MDCChipView alloc] init];
}

- (void)tearDown {
  self.chipView = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCChipView without any customization.
 */
- (void)testDefaultChipViewBehaviorWithRipple {
  // Then
  XCTAssertNotNil(self.chipView.rippleView);
  XCTAssertEqualObjects([self.chipView.rippleView rippleColorForState:MDCRippleStateNormal],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects([self.chipView.rippleView rippleColorForState:MDCRippleStateHighlighted],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqual(self.chipView.rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertFalse(self.chipView.enableRippleBehavior);
  XCTAssertNil(self.chipView.rippleView.superview);
  XCTAssertTrue(self.chipView.rippleAllowsSelection);
  XCTAssertTrue(self.chipView.rippleView.allowsSelection);
  CGRect chipViewBounds = CGRectStandardize(self.chipView.bounds);
  CGRect rippleBounds = CGRectStandardize(self.chipView.rippleView.bounds);
  XCTAssertTrue(CGRectEqualToRect(chipViewBounds, rippleBounds), @"%@ is not equal to %@",
                NSStringFromCGRect(chipViewBounds), NSStringFromCGRect(rippleBounds));
}

/**
 Test to confirm that setting @c enableRippleBehavior adds the @c rippleView as a subview.
 */
- (void)testEnableRippleBehaviorAddsRippleViewAsSubviewOfButton {
  // When
  self.chipView.enableRippleBehavior = YES;

  // Then
  XCTAssertNil(self.chipView.inkView.superview);
  XCTAssertEqualObjects(self.chipView.rippleView.superview, self.chipView);
}

/**
 Test to confirm toggling @c enableRippleBehavior removes the @c rippleView as a subview.
 */
- (void)testSetEnableRippleBehaviorToYesThenNoRemovesRippleViewAsSubviewOfButton {
  // When
  self.chipView.enableRippleBehavior = YES;
  self.chipView.enableRippleBehavior = NO;

  // Then
  XCTAssertEqualObjects(self.chipView.inkView.superview, self.chipView);
  XCTAssertNil(self.chipView.rippleView.superview);
}

- (void)testAllowsSelectionDefaultState {
  // Then
  XCTAssertTrue(self.chipView.rippleAllowsSelection);
  XCTAssertFalse(self.chipView.selected);
  XCTAssertFalse(self.chipView.highlighted);
}

- (void)testSelectionIsAllowedByDefault {
  // When
  self.chipView.selected = YES;

  // Then
  XCTAssertTrue(self.chipView.rippleAllowsSelection);
  XCTAssertTrue(self.chipView.selected);
  XCTAssertFalse(self.chipView.highlighted);
}

- (void)testNotAllowingSelection {
  // When
  self.chipView.rippleAllowsSelection = NO;
  self.chipView.selected = YES;

  // Then
  XCTAssertFalse(self.chipView.rippleAllowsSelection);
  XCTAssertFalse(self.chipView.rippleView.allowsSelection);
  XCTAssertTrue(self.chipView.selected);
  XCTAssertFalse(self.chipView.highlighted);
}

/**
 Test setting @c inkColor correctly sets the @c rippleColor on @c rippleView of the chip view.
 */
- (void)testSetCustomInkColorUpdatesRippleViewForHighlightedState {
  // Given
  UIColor *color = UIColor.redColor;

  // When
  [self.chipView setInkColor:color forState:UIControlStateHighlighted];

  // Then
  XCTAssertEqualObjects([self.chipView.rippleView rippleColorForState:MDCRippleStateHighlighted],
                        color);
}

/**
 Test setting @c inkColor to an unsupported stateful ripple state still updates the ripple to the
 correct color when that state is set.
 */
- (void)testNonSupportedRippleStateStillUpdatesRippleColor {
  // Given
  UIColor *color = UIColor.redColor;

  // When
  [self.chipView setInkColor:color forState:UIControlStateDisabled];
  self.chipView.enabled = NO;

  // Then
  XCTAssertEqualObjects(self.chipView.rippleView.rippleColor, color);
}

- (void)testChipViewHighlightedSetsRippleHighlightedToYES {
  // Given
  self.chipView.enableRippleBehavior = YES;

  // When
  self.chipView.highlighted = YES;

  // Then
  XCTAssertTrue(self.chipView.rippleView.isRippleHighlighted);
}

- (void)testChipViewNotHighlightedSetsRippleHighlightedToNO {
  // Given
  self.chipView.enableRippleBehavior = YES;
  self.chipView.rippleView.rippleHighlighted = YES;

  // When
  self.chipView.highlighted = NO;

  // Then
  XCTAssertFalse(self.chipView.rippleView.isRippleHighlighted);
}

@end
