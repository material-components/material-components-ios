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

#import "MaterialButtons.h"
#import "MaterialRipple.h"

@interface MDCButton (Testing)
@property(nonatomic, strong, readonly) MDCStatefulRippleView *rippleView;
@property(nonatomic, strong) MDCInkView *inkView;
@end

/**
 This class confirms behavior of @c MDCButton when used with @c MDCStatefulRippleView.
 */
@interface ButtonRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCButton *button;

@end

@implementation ButtonRippleTests

- (void)setUp {
  [super setUp];

  self.button = [[MDCButton alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCButton without any customization.
 */
- (void)testDefaultButtonBehaviorWithRipple {
  // Then
  XCTAssertNotNil(self.button.rippleView);
  XCTAssertEqualObjects(self.button.rippleView.rippleColor, [UIColor colorWithWhite:1
                                                                              alpha:(CGFloat)0.12]);
  XCTAssertEqual(self.button.rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertFalse(self.button.enableRippleBehavior);
  XCTAssertNil(self.button.rippleView.superview);
  XCTAssertFalse(self.button.rippleView.allowsSelection);
  CGRect buttonBounds = CGRectStandardize(self.button.bounds);
  CGRect rippleBounds = CGRectStandardize(self.button.rippleView.bounds);
  XCTAssertTrue(CGRectEqualToRect(buttonBounds, rippleBounds), @"%@ is not equal to %@",
                NSStringFromCGRect(buttonBounds), NSStringFromCGRect(rippleBounds));
}

/**
 Test to confirm that setting @c enableRippleBehavior adds the @c rippleView as a subview.
 */
- (void)testEnableRippleBehaviorAddsRippleViewAsSubviewOfButton {
  // When
  self.button.enableRippleBehavior = YES;

  // Then
  XCTAssertNil(self.button.inkView.superview);
  XCTAssertEqualObjects(self.button.rippleView.superview, self.button);
}

/**
 Test to confirm toggling @c enableRippleBehavior removes the @c rippleView as a subview.
 */
- (void)testSetEnableRippleBehaviorToYesThenNoRemovesRippleViewAsSubviewOfButton {
  // When
  self.button.enableRippleBehavior = YES;
  self.button.enableRippleBehavior = NO;

  // Then
  XCTAssertEqualObjects(self.button.inkView.superview, self.button);
  XCTAssertNil(self.button.rippleView.superview);
}

/**
 Test setting @c inkColor correctly sets the @c rippleColor on @c rippleView of the button.
 */
- (void)testSetCustomInkColorUpdatesRippleViewForHighlightedState {
  // Given
  UIColor *fakeColor = UIColor.redColor;

  // When
  self.button.inkColor = fakeColor;

  // Then
  XCTAssertEqualObjects([self.button.rippleView rippleColorForState:MDCRippleStateHighlighted],
                        fakeColor);
}

/**
 Test setting @c inkStyle correctly sets the @c rippleStyle on @c rippleView of the button.
 */
- (void)testSetInkStyleUnboundedUpdatesRippleView {
  // When
  self.button.inkStyle = MDCInkStyleUnbounded;

  // Then
  XCTAssertEqual(self.button.rippleView.rippleStyle, MDCRippleStyleUnbounded);
}

/**
 Test setting @c inkStyle correctly sets the @c rippleStyle on @c rippleView of the button.
 */
- (void)testSetInkStyleBoundedUpdatesRippleView {
  // When
  self.button.inkStyle = MDCInkStyleBounded;

  // Then
  XCTAssertEqual(self.button.rippleView.rippleStyle, MDCRippleStyleBounded);
}

- (void)testSetInkMaxRippleRadiusSetsRippleViewMaximumRadius {
  // Given
  CGFloat fakeRadius = 10;

  // When
  self.button.inkMaxRippleRadius = fakeRadius;

  // Then
  XCTAssertEqual(self.button.rippleView.maximumRadius, fakeRadius);
}

#pragma mark - Touch tests

- (void)testSettingHighlightedUpdatesRippleTheming {
  // Given
  self.button.enableRippleBehavior = YES;

  // When
  self.button.highlighted = YES;

  // Then
  XCTAssertTrue(self.button.rippleView.isRippleHighlighted);

  // And When
  self.button.highlighted = NO;

  // Then
  XCTAssertFalse(self.button.rippleView.isRippleHighlighted);
}

- (void)testSettingSelectedWhenNotAllowedDoesntUpdateRippleTheming {
  // Given
  self.button.enableRippleBehavior = YES;

  // When
  self.button.selected = YES;

  // Then
  XCTAssertFalse(self.button.rippleView.isSelected);
}

- (void)testSettingSelectedUpdatesRippleTheming {
  // Given
  self.button.enableRippleBehavior = YES;
  self.button.rippleView.allowsSelection = YES;
  self.button.selected = YES;

  // Then
  XCTAssertTrue(self.button.rippleView.isSelected);

  // And When
  self.button.selected = NO;

  // Then
  XCTAssertFalse(self.button.rippleView.isSelected);
}

@end
