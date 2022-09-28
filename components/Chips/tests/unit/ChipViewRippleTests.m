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

static UIColor *RandomColor(void) {
  switch (arc4random_uniform(5)) {
    case 0:
      return [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
      break;
    case 1:
      return [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
      break;
    case 2:
      return [UIColor redColor];
      break;
    case 3:
      return [UIColor orangeColor];
      break;
    case 4:
      return [UIColor greenColor];
      break;
    default:
      return [UIColor blueColor];
      break;
  }
}

@interface MDCChipView (Testing)
@property(nonatomic, strong) MDCRippleView *rippleView;
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
  XCTAssertEqualObjects([self.chipView rippleColorForState:UIControlStateNormal], nil);
  XCTAssertEqual(self.chipView.rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertFalse(self.chipView.enableRippleBehavior);
  XCTAssertNil(self.chipView.rippleView.superview);
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
  XCTAssertFalse(self.chipView.selected);
  XCTAssertFalse(self.chipView.highlighted);
}

- (void)testSelectionIsAllowedByDefault {
  // When
  self.chipView.selected = YES;

  // Then
  XCTAssertTrue(self.chipView.selected);
  XCTAssertFalse(self.chipView.highlighted);
}

- (void)testNotAllowingSelection {
  // When
  self.chipView.selected = YES;

  // Then
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
  self.chipView.highlighted = YES;

  // Then
  XCTAssertEqualObjects(self.chipView.rippleView.rippleColor, color);
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

- (void)testSetRippleColorForStateReturnsTheCorrectValue {
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (NSUInteger state = 0; state <= maxState; ++state) {
    // Given
    UIColor *color = RandomColor();

    // When
    [self.chipView setRippleColor:color forState:state];

    // Then
    XCTAssertEqualObjects([self.chipView rippleColorForState:state], color);
  }
}

- (void)testSetRippleColorToNilReturnsTheCorrectValueForNormal {
  // Given
  UIColor *color = UIColor.orangeColor;
  [self.chipView setRippleColor:color forState:UIControlStateNormal];

  // When
  [self.chipView setRippleColor:nil forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects([self.chipView rippleColorForState:UIControlStateSelected], color);
}

@end
