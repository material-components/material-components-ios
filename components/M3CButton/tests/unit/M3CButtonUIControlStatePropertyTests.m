// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "M3CButton.h"

NS_ASSUME_NONNULL_BEGIN

// A value greater than the largest value created by combining normal values of UIControlState.
// This is a complete hack, but UIControlState doesn't expose anything useful here.
// This assumes that UIControlState is actually a set of bitfields and ignores application-specific
// values.
static const UIControlState kNumUIControlStates = 2 * UIControlStateSelected - 1;
static const UIControlState kUIControlStateDisabledHighlighted =
    UIControlStateHighlighted | UIControlStateDisabled;

static UIColor *randomColor(void) {
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

static NSString *controlStateDescription(UIControlState controlState) {
  if (controlState == UIControlStateNormal) {
    return @"Normal";
  }
  NSMutableString *string = [NSMutableString string];
  if ((UIControlStateHighlighted & controlState) == UIControlStateHighlighted) {
    [string appendString:@"Highlighted "];
  }
  if ((UIControlStateDisabled & controlState) == UIControlStateDisabled) {
    [string appendString:@"Disabled "];
  }
  if ((UIControlStateSelected & controlState) == UIControlStateSelected) {
    [string appendString:@"Selected "];
  }
  return [string copy];
}

@interface M3CButton (Testing)

- (nullable UIColor *)backgroundColorForState:(UIControlState)state;
- (nullable UIColor *)borderColorForState:(UIControlState)state;

@end

@interface M3CButtonUIControlStatePropertyTests : XCTestCase
@property(nonatomic, strong, nullable) M3CButton *button;
@end

@implementation M3CButtonUIControlStatePropertyTests

- (void)setUp {
  [super setUp];

  self.button = [[M3CButton alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)testBorderColorForState {
  for (NSUInteger state = 0; state <= kNumUIControlStates; ++state) {
    // Given
    UIColor *color = randomColor();

    // When
    [self.button setBorderColor:color forState:state];

    // Then
    XCTAssertEqualObjects([self.button borderColorForState:state], color,  @"for control state:%@ ", controlStateDescription(state));
  }
}

- (void)testBorderColorForStateFallbackBehavior {
  // When
  [self.button setBorderColor:UIColor.redColor forState:UIControlStateNormal];

  // Then
  for (NSUInteger state = 0; state <= kNumUIControlStates; ++state) {
    XCTAssertEqualObjects([self.button borderColorForState:state], UIColor.redColor,  @"for control state:%@ ", controlStateDescription(state));
  }
}

- (void)testBorderColorForStateBehaviorMatchesTitleColorForStateForward {
  // Given
  M3CButton *testButton = [[M3CButton alloc] init];
  UIButton *uiButton = [[UIButton alloc] init];

  // When
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (UIControlState state = 0; state <= maxState; ++state) {
    UIColor *color = [UIColor colorWithWhite:0 alpha:(CGFloat)(state / (CGFloat)maxState)];
    [testButton setBorderColor:color forState:state];
    [uiButton setTitleColor:color forState:state];
  }

  // Then
  for (UIControlState state = 0; state <= maxState; ++state) {
     if (state & kUIControlStateDisabledHighlighted) {
      // We skip the Disabled Highlighted state because UIButton titleColorForState ignores it.
      continue;
    }
    XCTAssertEqualObjects([testButton borderColorForState:state],
                          [uiButton titleColorForState:state], @"for control state:%@ ",
                          controlStateDescription(state));
  }
}

- (void)testBorderColorForStateBehaviorMatchesTitleColorForStateBackward {
  // Given
  M3CButton *testButton = [[M3CButton alloc] init];
  UIButton *uiButton = [[UIButton alloc] init];

  // When
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (NSInteger state = maxState; state >= 0; --state) {
    UIColor *color = [UIColor colorWithWhite:0 alpha:(CGFloat)(state / (CGFloat)maxState)];
    [testButton setBorderColor:color forState:state];
    [uiButton setTitleColor:color forState:state];
  }

  // Then
  for (UIControlState state = 0; state <= maxState; ++state) {
    if (state & kUIControlStateDisabledHighlighted) {
      // We skip the Disabled Highlighted state because UIButton titleColorForState ignores it.
      continue;
    }
    XCTAssertEqualObjects([testButton borderColorForState:state],
                          [uiButton titleColorForState:state], @"for control state:%@ ",
                          controlStateDescription(state));
  }
}

- (void)testBackgroundColorForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // Given
    UIColor *color = randomColor();

    // When
    [self.button setBackgroundColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([self.button backgroundColorForState:controlState], color,  @"for control state:%@ ", controlStateDescription(controlState));
  }
}

- (void)testBackgroundColorForStateFallbackBehavior {
  // When
  [self.button setBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    XCTAssertEqualObjects([self.button backgroundColorForState:controlState], UIColor.purpleColor);
  }
}

- (void)testBackgroundColorForStateUpdatesBackgroundColor {
  // Given
  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    // Disabling the button removes any highlighted state
    UIControlState testState = controlState;
    if ((testState & UIControlStateDisabled) == UIControlStateDisabled) {
      testState &= ~UIControlStateHighlighted;
    }
    BOOL isDisabled = (testState & UIControlStateDisabled) == UIControlStateDisabled;
    BOOL isSelected = (testState & UIControlStateSelected) == UIControlStateSelected;
    BOOL isHighlighted = (testState & UIControlStateHighlighted) == UIControlStateHighlighted;

    // Also given
    UIColor *color = randomColor();
    [self.button setBackgroundColor:color forState:testState];

    // When
    self.button.enabled = !isDisabled;
    self.button.selected = isSelected;
    self.button.highlighted = isHighlighted;

    XCTAssertEqualObjects(self.button.backgroundColor, color, @"for control state:%@ ",
                          controlStateDescription(controlState));
  }
}

- (void)testBackgroundColorForStateUpdatesBackgroundColorWithFallback {
  // Given
  [self.button setBackgroundColor:UIColor.magentaColor forState:UIControlStateNormal];

  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    BOOL isDisabled = (controlState & UIControlStateDisabled) == UIControlStateDisabled;
    BOOL isSelected = (controlState & UIControlStateSelected) == UIControlStateSelected;
    BOOL isHighlighted = (controlState & UIControlStateHighlighted) == UIControlStateHighlighted;

    // When
    self.button.enabled = !isDisabled;
    self.button.selected = isSelected;
    self.button.highlighted = isHighlighted;

    XCTAssertEqualObjects(self.button.backgroundColor,
                          [self.button backgroundColorForState:UIControlStateNormal],
                          @"for control state:%@ ", controlStateDescription(controlState));
  }
}

// Behavioral test to verify that M3CButton's `backgroundColor:forState:` matches the behavior of
// UIButton's `titleColor:forState:`.  Specifically, to ensure that the special handling of
// (UIControlStateDisabled | UIControlStateHighlighted) is identical.
//
// This test is valuable because clients who are familiar with the fallback behavior of
// `titleColor:forState:` may be surprised if the M3CButton APIs don't match. For example, setting
// the titleColor for (UIControlStateDisabled | UIControlStateHighlighted) will actually update the
// value assigned for UIControlStateHighlighted, but ONLY if it has already been assigned. Otherwise
// no update will take place.
- (void)testBackgroundColorForStateBehaviorMatchesTitleColorForStateWithoutFallbackForward {
  // Given
  UIButton *uiButton = [[UIButton alloc] init];

  // When
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (UIControlState state = 0; state <= maxState; ++state) {
    UIColor *color = [UIColor colorWithWhite:0 alpha:(CGFloat)(state / (CGFloat)maxState)];
    [self.button setBackgroundColor:color forState:state];
    [uiButton setTitleColor:color forState:state];
  }

  // Then
  for (UIControlState state = 0; state <= maxState; ++state) {
    if (state & kUIControlStateDisabledHighlighted) {
      // We skip the Disabled Highlighted state because UIButton titleColorForState ignores it.
      continue;
    }
    XCTAssertEqualObjects([self.button backgroundColorForState:state],
                          [uiButton titleColorForState:state], @"for control state:%@ ",
                          controlStateDescription(state));
  }
}

- (void)testBackgroundColorForStateBehaviorMatchesTitleColorForStateWithoutFallbackBackward {
  // Given
  UIButton *uiButton = [[UIButton alloc] init];

  // When
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (NSInteger state = maxState; state >= 0; --state) {
    UIColor *color = [UIColor colorWithWhite:0 alpha:(CGFloat)(state / (CGFloat)maxState)];
    [self.button setBackgroundColor:color forState:(UIControlState)state];
    [uiButton setTitleColor:color forState:(UIControlState)state];
  }

  // Then
  for (UIControlState state = 0; state <= maxState; ++state) {
     if (state & kUIControlStateDisabledHighlighted) {
      // We skip the Disabled Highlighted state because UIButton titleColorForState ignores it.
      continue;
    }
    XCTAssertEqualObjects([self.button backgroundColorForState:state],
                          [uiButton titleColorForState:state], @"for control state:%@ ",
                          controlStateDescription(state));
  }
}

#pragma mark - backgroundColor:forState:

- (void)testCurrentBackgroundColorNormal {
  // Given
  UIColor *normalColor = [UIColor redColor];
  [self.button setBackgroundColor:normalColor forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects([self.button backgroundColor], normalColor);
}

- (void)testCurrentBackgroundColorHighlighted {
  // Given
  UIColor *normalColor = [UIColor redColor];
  UIColor *color = [UIColor orangeColor];
  [self.button setBackgroundColor:normalColor forState:UIControlStateNormal];
  [self.button setBackgroundColor:color forState:UIControlStateHighlighted];

  // When
  self.button.highlighted = YES;

  // Then
  XCTAssertEqualObjects([self.button backgroundColor], color);
}

- (void)testCurrentBackgroundColorDisabled {
  // Given
  UIColor *normalColor = [UIColor redColor];
  UIColor *color = [UIColor orangeColor];
  [self.button setBackgroundColor:normalColor forState:UIControlStateNormal];
  [self.button setBackgroundColor:color forState:UIControlStateDisabled];

  // When
  self.button.enabled = NO;

  // Then
  XCTAssertEqualObjects([self.button backgroundColor], color);
}

- (void)testCurrentBackgroundColorSelected {
  // Given
  UIColor *normalColor = [UIColor redColor];
  UIColor *color = [UIColor orangeColor];
  [self.button setBackgroundColor:normalColor forState:UIControlStateNormal];
  [self.button setBackgroundColor:color forState:UIControlStateSelected];

  // When
  self.button.selected = YES;

  // Then
  XCTAssertEqualObjects([self.button backgroundColor], color);
}

- (void)testPointInsideWithoutHitAreaInsets {
  // Given
  self.button.frame = CGRectMake(0, 0, 80, 50);

  CGPoint touchPointInsideBoundsTopLeft = CGPointMake(0, 0);
  CGPoint touchPointInsideBoundsTopRight = CGPointMake((CGFloat)79.9, 0);
  CGPoint touchPointInsideBoundsBottomRight = CGPointMake((CGFloat)79.9, (CGFloat)49.9);
  CGPoint touchPointInsideBoundsBottomLeft = CGPointMake(0, (CGFloat)49.9);

  CGPoint touchPointOutsideBoundsTopLeft = CGPointMake(0, (CGFloat)-0.1);
  CGPoint touchPointOutsideBoundsTopRight = CGPointMake(80, 0);
  CGPoint touchPointOutsideBoundsBottomRight = CGPointMake(80, 50);
  CGPoint touchPointOutsideBoundsBottomLeft = CGPointMake(0, 50);

  // Then
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsTopLeft withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsTopRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsBottomRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsBottomLeft withEvent:nil]);

  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsTopLeft withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsTopRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsBottomRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsBottomLeft withEvent:nil]);
}

- (void)testPointInsideWithoutHitAreaInsetsTooSmall {
  // Given
  self.button.frame = CGRectMake(0, 0, 10, 10);

  CGPoint touchPointInsideBoundsTopLeft = CGPointMake(0, 0);
  CGPoint touchPointInsideBoundsTopRight = CGPointMake((CGFloat)9.9, 0);
  CGPoint touchPointInsideBoundsBottomRight = CGPointMake((CGFloat)9.9, (CGFloat)9.9);
  CGPoint touchPointInsideBoundsBottomLeft = CGPointMake(0, (CGFloat)9.9);

  CGPoint touchPointOutsideBoundsTopLeft = CGPointMake(0, (CGFloat)-0.1);
  CGPoint touchPointOutsideBoundsTopRight = CGPointMake(10, 0);
  CGPoint touchPointOutsideBoundsBottomRight = CGPointMake(10, 10);
  CGPoint touchPointOutsideBoundsBottomLeft = CGPointMake(0, 10);

  // Then
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsTopLeft withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsTopRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsBottomRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideBoundsBottomLeft withEvent:nil]);

  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsTopLeft withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsTopRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsBottomRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideBoundsBottomLeft withEvent:nil]);
}

@end

NS_ASSUME_NONNULL_END
