/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MaterialShadowElevations.h"
#import "MaterialTypography.h"

static const CGFloat kEpsilonAccuracy = 0.001f;
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
  XCTAssertEqualObjects(button.currentTitle,
                        [originalTitle uppercaseStringWithLocale:[NSLocale currentLocale]]);
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
  XCTAssertEqualObjects(button.currentTitle,
                        [originalTitle uppercaseStringWithLocale:[NSLocale currentLocale]]);
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

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], 0);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted], 0);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], 0);
  XCTAssertEqual([button elevationForState:UIControlStateSelected], 1);
}

- (void)testDefaultElevationRelationships {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat normalElevation = randomNumberNotEqualTo(0);

  // When
  [button setElevation:normalElevation forState:UIControlStateNormal];

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateSelected], 2 * normalElevation);
}

- (void)testDefaultElevationRelationshipsZeroElevation {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When
  [button setElevation:0 forState:UIControlStateNormal];

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], 0);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted], 0);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], 0);
  XCTAssertEqual([button elevationForState:UIControlStateSelected], 1);
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

- (void)testEncode {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  button.inkStyle = arc4random_uniform(2) ? MDCInkStyleBounded : MDCInkStyleUnbounded;
  button.inkMaxRippleRadius = randomNumber();
  button.disabledAlpha = randomNumber();
  button.uppercaseTitle = arc4random_uniform(2) ? YES : NO;
  button.hitAreaInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  button.customTitleColor = randomColor();
  button.inkColor = randomColor();
  button.underlyingColorHint = randomColor();
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    [button setBackgroundColor:randomColor() forState:controlState];
    [button setElevation:randomNumber() forState:controlState];
  }
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:button];

  // When
  MDCButton *unarchivedButton = [NSKeyedUnarchiver unarchiveObjectWithData:data];

  // Then
  XCTAssertEqualObjects(button.inkColor, unarchivedButton.inkColor);
  XCTAssertEqual(button.uppercaseTitle, unarchivedButton.uppercaseTitle);
  XCTAssertEqual(button.inkStyle, unarchivedButton.inkStyle);
  XCTAssertEqualWithAccuracy(button.inkMaxRippleRadius, unarchivedButton.inkMaxRippleRadius,
                             kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy(button.disabledAlpha, unarchivedButton.disabledAlpha,
                             kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy(button.hitAreaInsets.bottom, unarchivedButton.hitAreaInsets.bottom,
                             kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy(button.hitAreaInsets.top, unarchivedButton.hitAreaInsets.top,
                             kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy(button.hitAreaInsets.right, unarchivedButton.hitAreaInsets.right,
                             kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy(button.hitAreaInsets.left, unarchivedButton.hitAreaInsets.left,
                             kEpsilonAccuracy);
  XCTAssertEqual(button.customTitleColor, unarchivedButton.customTitleColor);
  XCTAssertEqual(button.underlyingColorHint, unarchivedButton.underlyingColorHint);
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    XCTAssertEqualWithAccuracy([button elevationForState:controlState],
                               [unarchivedButton elevationForState:controlState], kEpsilonAccuracy);
    XCTAssertEqual([button backgroundColorForState:controlState],
                   [unarchivedButton backgroundColorForState:controlState]);
  }
}

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

- (void)testDefaultAdjustsFontProperty {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // Then
  XCTAssertFalse(button.mdc_adjustsFontForContentSizeCategory);
}

- (void)testAdjustsFontProperty {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIFont *preferredFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleButton];

  // When
  button.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertTrue(button.mdc_adjustsFontForContentSizeCategory);
  XCTAssertEqualWithAccuracy(button.titleLabel.font.pointSize, preferredFont.pointSize,
                             kEpsilonAccuracy,
                             @"Font size should be equal to MDCFontTextStyleButton's.");
}

@end
