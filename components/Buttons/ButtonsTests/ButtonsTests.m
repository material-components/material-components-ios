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
#import "MaterialButtons.h"
#import "MDCShadowElevations.h"

static const NSUInteger kNumberOfRepeats = 20;
static const CGFloat kEpsilonAccuracy = 0.0001f;

static inline UIColor *MDCColorFromRGB(NSInteger rgbValue) {
  return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0
                         green:((float)((rgbValue & 0x00FF00) >> 8)) / 255.0
                          blue:((float)((rgbValue & 0x0000FF) >> 0)) / 255.0
                         alpha:1.0];
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

- (void)testUppercaseTitleNOChangedToYes {
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

- (void)testSetEnabledAnimatedNO {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When
  [button setEnabled:NO animated:arc4random_uniform(2)];

  // Then
  XCTAssertFalse(button.enabled);
}

- (void)testSetEnabledAnimatedYES {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  button.enabled = NO;

  // When
  [button setEnabled:YES animated:arc4random_uniform(2)];

  // Then
  XCTAssertTrue(button.enabled);
}

- (void)testElevationForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIControlState controlState = [self randomControlState];
  CGFloat elevation = [self randomNumber];

  // When
  [button setElevation:elevation forState:controlState];

  // Then
  XCTAssertEqualWithAccuracy([button elevationForState:controlState], elevation, kEpsilonAccuracy);
}

- (void)testResetElevationForState {
  for (int ii = 0; ii < kNumberOfRepeats; ++ii) {
    // Given
    MDCButton *button = [[MDCButton alloc] init];
    UIControlState controlState = [self randomControlState];
    CGFloat elevation = [self randomNumber];
    [button setElevation:elevation forState:controlState];

    // When
    [button resetElevationForState:controlState];

    // Then
    if (controlState & UIControlStateSelected) {
      XCTAssertNotEqualWithAccuracy([button elevationForState:controlState], MDCShadowElevationNone, kEpsilonAccuracy);
    } else {
      XCTAssertEqualWithAccuracy([button elevationForState:controlState], MDCShadowElevationNone, kEpsilonAccuracy);
    }
  }
}

- (void)testBackgroundColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIControlState controlState = [self randomControlState];
  UIColor *color = [self randomColor];

  // When
  [button setBackgroundColor:color forState:controlState];

  // Then
  XCTAssertEqualObjects([button backgroundColorForState:controlState], color);
}

- (void)testCurrentBackgroundColor {
  for (int ii = 0; ii < kNumberOfRepeats; ++ii) {
    // Given
    MDCButton *button = [[MDCButton alloc] init];
    UIControlState controlState = [self randomControlState];
    UIColor *color = [self randomColor];
    [button setBackgroundColor:color forState:controlState];

    // When
    button.highlighted = (controlState & UIControlStateHighlighted) == UIControlStateHighlighted;
    button.selected = (controlState & UIControlStateSelected) == UIControlStateSelected;
    button.enabled = (controlState & UIControlStateDisabled) != UIControlStateDisabled;
    NSLog(@"controlstate:%i", button.state);

    // Then
    XCTAssertEqual(button.state, controlState);
    XCTAssertEqualObjects(button.currentBackgroundColor, color);
  }
}

- (void)testCurrentBackgroundColorFallbackToNormal {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIControlState controlState = [self randomControlState];
  UIColor *color = [self randomColor];
  [button setBackgroundColor:color forState:UIControlStateNormal];

  // When
  button.highlighted = (controlState & UIControlStateHighlighted) == UIControlStateHighlighted;
  button.selected = (controlState & UIControlStateSelected) == UIControlStateSelected;
  button.enabled = (controlState & UIControlStateDisabled) != UIControlStateDisabled;

  // Then
  XCTAssertEqual(button.state, controlState);
  XCTAssertEqualObjects(button.currentBackgroundColor, color);
}

- (void)testInkColors {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *color = [self randomColor];

  // When
  button.inkColor = color;

  // Then
  XCTAssertEqualObjects(button.inkColor, color);
}

- (void)testDefaultColors {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When

  // Then
  // Colors chosen from: https://www.google.com/design/spec/style/color.html#color-color-palette
  UIColor *blue500 = MDCColorFromRGB(0x2196F3);
  UIColor *blue300 = MDCColorFromRGB(0x64B5F6);
  XCTAssertEqualObjects([button currentBackgroundColor], blue500);
  UIColor *lightBlueInk = [blue300 colorWithAlphaComponent:0.25f];
  XCTAssertEqualObjects(button.inkColor, lightBlueInk);
}

/*
 TODO: things to unit test
 (should these even be a thing?)
 - hitAreaInset
 - disabledAlpha
 - underlyingColor (text color)
 */

#pragma mark private test helpers

- (UIControlState)randomControlState {
  if (arc4random_uniform(2)) {
    return UIControlStateNormal;  // Test normal the most.
  }
  if (arc4random_uniform(2)) {
    return UIControlStateSelected;  // Test selected the second most.
  }
  // Everything else including overlapping states.
  return arc4random_uniform(UIControlStateDisabled | UIControlStateHighlighted | UIControlStateSelected + 1);
  //  UIButton *button = [[UIButton alloc] init];
  //  button.enabled = arc4random_uniform(2);
  //  button.highlighted = arc4random_uniform(2);
  //  button.selected = arc4random_uniform(2);
  //  return button.state;
}

- (CGFloat)randomNumber {
  return arc4random_uniform(1000) / (CGFloat)(arc4random_uniform(9) + 1);
}

- (UIColor *)randomColor {
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

#pragma mark - tests exploring UIButton state changes

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
  button.enabled = YES;  // For some reason we can only set the highlighted state to YES if its enabled is also YES
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

- (void)testButtonState {
  for (int ii = 0; ii < kNumberOfRepeats; ++ii) {
    // Given
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIControlState controlState = [self randomControlState];
    // When
    button.highlighted = (controlState & UIControlStateHighlighted) == UIControlStateHighlighted;
    button.selected = (controlState & UIControlStateSelected) == UIControlStateSelected;
    button.enabled = (controlState & UIControlStateDisabled) != UIControlStateDisabled;

    // Then
    NSLog(@"controlstate:%i==%i highlight:%i enabled:%i selected:%i", controlState, button.state, button.highlighted, button.enabled, button.selected);
    XCTAssertEqual(button.state, controlState);
  }
}

@end
