/*
 Copyright 2016-present Google Inc. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>
#import "MDCShadowElevations.h"
#import "MaterialButtons.h"

// A value greater than the largest value created by combining normal values of UIControlState.
// This is a complete hack, but UIControlState doesn't expose anything useful here.
// This assumes that UIControlState is actually a set of bitfields and ignores application-specific
// values.
static const UIControlState kNumUIControlStates = 2 * UIControlStateSelected - 1;

static CGFloat randomNumber() {
  return arc4random_uniform(100) / (CGFloat)10;
}

static CGFloat randomNumberNotEqualTo(const CGFloat targetNumber) {
  while (1) {
    CGFloat number = randomNumber();
    if (number != targetNumber) {
      return number;
    }
  }
}

static UIColor *randomColor() {
  switch (arc4random_uniform(5)) {
    case 0:
      return [UIColor whiteColor];
      break;
    case 1:
      return [UIColor blackColor];
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

@interface ButtonsTests : XCTestCase
@end

@implementation ButtonsTests

- (void)testUppercaseTitleYes {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  NSString *originalTitle = @"some Text";

  // When
  button.uppercaseTitle = YES;
  [button setTitle:originalTitle forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(button.currentTitle, [originalTitle uppercaseStringWithLocale:[NSLocale currentLocale]]);
}

- (void)testUppercaseTitleNo {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  NSString *originalTitle = @"some Text";

  // When
  button.uppercaseTitle = NO;
  [button setTitle:originalTitle forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(button.currentTitle, originalTitle);
}

- (void)testUppercaseTitleNoChangedToYes {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  NSString *originalTitle = @"some Text";

  // When
  button.uppercaseTitle = NO;
  [button setTitle:originalTitle forState:UIControlStateNormal];
  button.uppercaseTitle = YES;

  // Then
  XCTAssertEqualObjects(button.currentTitle, [originalTitle uppercaseStringWithLocale:[NSLocale currentLocale]]);
}

- (void)testSetEnabledAnimated {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  NSArray *boolValues = @[ @YES, @NO ];
  for (id enabled in boolValues) {
    for (id animated in boolValues) {
      // When
      [button setEnabled:[enabled boolValue] animated:[animated boolValue]];

      // Then
      XCTAssertEqual(button.enabled, [enabled boolValue]);
    }
  }
}

- (void)testElevationForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // And given
    CGFloat elevation = randomNumber();

    // When
    [button setElevation:elevation forState:controlState];

    // Then
    XCTAssertEqual([button elevationForState:controlState], elevation);
  }
}

- (void)testResetElevationForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // And given
    CGFloat defaultValue = [button elevationForState:controlState];

    // When
    [button setElevation:randomNumberNotEqualTo(defaultValue) forState:controlState];
    [button resetElevationForState:controlState];

    // Then
    XCTAssertEqual([button elevationForState:controlState], defaultValue);
  }
}

- (void)testDefaultElevationsForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], 0);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted], 0);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], 0);
  XCTAssertEqual([button elevationForState:UIControlStateSelected], 1);
}

- (void)testDefaultElevationRelationships {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat normalElevation = randomNumber();

  // When
  [button setElevation:normalElevation forState:UIControlStateNormal];

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateSelected], 2 * normalElevation);
}

- (void)testBackgroundColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // And given
    UIColor *color = randomColor();

    // When
    [button setBackgroundColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([button backgroundColorForState:controlState], color);
  }
}

- (void)testCurrentBackgroundColor {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // And given
    UIColor *color = randomColor();

    // When
    [button setBackgroundColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([button backgroundColorForState:controlState], color);
  }
}

- (void)testInkColors {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *color = randomColor();

  // When
  button.inkColor = color;

  // Then
  XCTAssertEqualObjects(button.inkColor, color);
}

/*
 TODO: things to unit test
 (should these even be a thing?)
 - hitAreaInset
 - disabledAlpha
 - underlyingColor (text color)
 */

#pragma mark - UIButton state changes

- (void)testEnabled {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = arc4random_uniform(2);
  button.selected = arc4random_uniform(2);
  button.enabled = arc4random_uniform(2);

  // When
  button.enabled = YES;

  // Then
  XCTAssertTrue(button.enabled);
  XCTAssertFalse(button.state & UIControlStateDisabled);
}

- (void)testDisabled {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = arc4random_uniform(2);
  button.selected = arc4random_uniform(2);
  button.enabled = arc4random_uniform(2);

  // When
  button.enabled = NO;

  // Then
  XCTAssertFalse(button.enabled);
  XCTAssertTrue(button.state & UIControlStateDisabled);
}

- (void)testHighlighted {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = NO;
  button.selected = arc4random_uniform(2);

  // For some reason we can only set the highlighted state to YES if its enabled is also YES.
  button.enabled = YES;

  UIControlState oldState = button.state;
  XCTAssertFalse(button.highlighted);

  // When
  button.highlighted = YES;

  // Then
  XCTAssertTrue(button.highlighted);
  XCTAssertTrue(button.state & UIControlStateHighlighted);
  XCTAssertEqual(button.state, (oldState | UIControlStateHighlighted));
}

- (void)testUnhighlighted {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = YES;
  button.selected = arc4random_uniform(2);
  button.enabled = arc4random_uniform(2);
  UIControlState oldState = button.state;
  XCTAssertTrue(button.highlighted);

  // When
  button.highlighted = NO;

  // Then
  XCTAssertFalse(button.highlighted);
  XCTAssertFalse(button.state & UIControlStateHighlighted);
  XCTAssertEqual(button.state, (oldState & ~UIControlStateHighlighted));
}

- (void)testSelected {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = arc4random_uniform(2);
  button.selected = NO;
  button.enabled = arc4random_uniform(2);
  UIControlState oldState = button.state;

  // When
  button.selected = YES;

  // Then
  XCTAssertTrue(button.selected);
  XCTAssertTrue(button.state & UIControlStateSelected);
  XCTAssertEqual(button.state, (oldState | UIControlStateSelected));
}

- (void)testUnselected {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = arc4random_uniform(2);
  button.selected = YES;
  button.enabled = arc4random_uniform(2);

  // When
  button.selected = NO;

  // Then
  XCTAssertFalse(button.selected);
  XCTAssertFalse(button.state & UIControlStateSelected);
}

@end
