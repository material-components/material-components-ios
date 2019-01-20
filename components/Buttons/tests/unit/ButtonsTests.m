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

#import "MaterialButtons.h"
#import "MaterialShadowElevations.h"
#import "MaterialShapes.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static const CGFloat kEpsilonAccuracy = (CGFloat)0.001;
// A value greater than the largest value created by combining normal values of UIControlState.
// This is a complete hack, but UIControlState doesn't expose anything useful here.
// This assumes that UIControlState is actually a set of bitfields and ignores application-specific
// values.
static const UIControlState kNumUIControlStates = 2 * UIControlStateSelected - 1;
static const UIControlState kUIControlStateDisabledHighlighted =
    UIControlStateHighlighted | UIControlStateDisabled;

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

@interface FakeShadowLayer : MDCShapedShadowLayer
@property(nonatomic, assign) NSInteger elevationAssignmentCount;
@end

@implementation FakeShadowLayer

- (void)setElevation:(MDCShadowElevation)elevation {
  ++self.elevationAssignmentCount;
  [super setElevation:elevation];
}
@end

@interface TestButton : MDCButton
@property(nonatomic, strong) FakeShadowLayer *shadowLayer;
@end

@implementation TestButton
+ (Class)layerClass {
  return [FakeShadowLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _shadowLayer = (FakeShadowLayer *)self.layer;
  }
  return self;
}
@end

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
  [button setTitle:originalTitle forState:UIControlStateHighlighted];
  [button setTitle:originalTitle forState:UIControlStateDisabled];
  button.uppercaseTitle = YES;

  // Then
  XCTAssertEqualObjects(button.currentTitle,
                        [originalTitle uppercaseStringWithLocale:[NSLocale currentLocale]]);
}

- (void)testUppercaseTitleYesChangedToNo {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  NSString *originalTitle = @"some Text";

  // When
  button.uppercaseTitle = YES;
  [button setTitle:originalTitle forState:UIControlStateNormal];
  [button setTitle:originalTitle forState:UIControlStateHighlighted];
  [button setTitle:originalTitle forState:UIControlStateDisabled];
  button.uppercaseTitle = NO;

  // Then
  XCTAssertEqualObjects(button.currentTitle, originalTitle);
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

- (void)testSetElevationOnlyUpdatesCurrentState {
  // Given
  TestButton *selectedButton = [[TestButton alloc] init];
  TestButton *highlightedButton = [[TestButton alloc] init];

  XCTAssertEqualWithAccuracy([selectedButton elevationForState:UIControlStateNormal],
                             [selectedButton elevationForState:UIControlStateHighlighted],
                             0.0001,
                             @"This test assumes that .normal and .highlighted start with the same "
                              "elevation values.");

  [selectedButton setSelected:YES];
  [highlightedButton setHighlighted:YES];
  NSInteger selectedButtonElevationCount = selectedButton.shadowLayer.elevationAssignmentCount;
  NSInteger highlightedButtonElevationCount =
      highlightedButton.shadowLayer.elevationAssignmentCount;

  // When
  [selectedButton setElevation:77 forState:UIControlStateHighlighted];
  [highlightedButton setElevation:75 forState:UIControlStateNormal];

  // Then
  XCTAssertEqual(selectedButton.shadowLayer.elevationAssignmentCount,
                 selectedButtonElevationCount,
                 @"Updating an unrelated elevation should not update the layer elevation.");
  XCTAssertEqual(highlightedButtonElevationCount + 1,
                 highlightedButton.shadowLayer.elevationAssignmentCount,
                 @"Updating the current elevation should cause one elevation update.");
}

- (void)testElevationNormal {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat normalElevation = randomNumberNotEqualTo(0);

  // When
  [button setElevation:normalElevation forState:UIControlStateNormal];

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], normalElevation);
  XCTAssertEqual([button elevationForState:UIControlStateSelected], normalElevation);
}

- (void)testElevationNormalZeroElevation {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When
  [button setElevation:0 forState:UIControlStateNormal];

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], 0);
}

- (void)testDefaultBorderWidth {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // Then
  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    XCTAssertEqualWithAccuracy([button borderWidthForState:controlState], 0, 0.001);
  }
}

- (void)testBorderWidthForStateWithDifferentValues {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    CGFloat width = (CGFloat)controlState;

    // When
    [button setBorderWidth:width forState:controlState];

    // Then
    if (controlState == (UIControlStateHighlighted | UIControlStateDisabled)) {
      XCTAssertEqualWithAccuracy([button borderWidthForState:controlState],
                                 [button borderWidthForState:UIControlStateHighlighted], 0.001);
    } else if (controlState ==
               (UIControlStateHighlighted | UIControlStateDisabled | UIControlStateSelected)) {
      XCTAssertNotEqualWithAccuracy([button borderWidthForState:controlState],
                                    [button borderWidthForState:UIControlStateNormal], 0.001);
    } else {
      XCTAssertEqualWithAccuracy([button borderWidthForState:controlState], width, 0.001);
    }
  }
}

- (void)testBorderWidthFallbackBehavior {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat fakeBorderWidth = 99;

  // When
  [button setBorderWidth:fakeBorderWidth forState:UIControlStateNormal];

  // Then
  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    XCTAssertEqualWithAccuracy([button borderWidthForState:controlState], fakeBorderWidth, 0.001);
  }
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

- (void)testBackgroundColorForStateFallbackBehavior {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    XCTAssertEqualObjects([button backgroundColorForState:controlState], UIColor.purpleColor);
  }
}

- (void)testBackgroundColorForStateUpdatesBackgroundColor {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

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
    [button setBackgroundColor:color forState:testState];

    // When
    button.enabled = !isDisabled;
    button.selected = isSelected;
    button.highlighted = isHighlighted;

    XCTAssertEqualObjects(button.backgroundColor, color, @"for state (%lu).",
                          (unsigned long)testState);
  }
}

- (void)testBackgroundColorForStateUpdatesBackgroundColorWithFallback {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  [button setBackgroundColor:UIColor.magentaColor forState:UIControlStateNormal];

  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    BOOL isDisabled = (controlState & UIControlStateDisabled) == UIControlStateDisabled;
    BOOL isSelected = (controlState & UIControlStateSelected) == UIControlStateSelected;
    BOOL isHighlighted = (controlState & UIControlStateHighlighted) == UIControlStateHighlighted;

    // When
    button.enabled = !isDisabled;
    button.selected = isSelected;
    button.highlighted = isHighlighted;

    XCTAssertEqualObjects(button.backgroundColor,
                          [button backgroundColorForState:UIControlStateNormal],
                          @"for state (%lu).", (unsigned long)controlState);
  }
}

// Behavioral test to verify that MDCButton's `backgroundColor:forState:` matches the behavior of
// UIButton's `titleColor:forState:`.  Specifically, to ensure that the special handling of
// (UIControlStateDisabled | UIControlStateHighlighted) is identical.
//
// This test is valuable because clients who are familiar with the fallback behavior of
// `titleColor:forState:` may be surprised if the MDCButton APIs don't match. For example, setting
// the titleColor for (UIControlStateDisabled | UIControlStateHighlighted) will actually update the
// value assigned for UIControlStateHighlighted, but ONLY if it has already been assigned. Otherwise
// no update will take place.
- (void)testBackgroundColorForStateBehaviorMatchesTitleColorForStateWithoutFallbackForward {
  // Given
  MDCButton *testButton = [[MDCButton alloc] init];
  UIButton *uiButton = [[UIButton alloc] init];

  // When
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (UIControlState state = 0; state <= maxState; ++state) {
    UIColor *color = [UIColor colorWithWhite:0 alpha:(CGFloat)(state / (CGFloat)maxState)];
    [testButton setBackgroundColor:color forState:state];
    [uiButton setTitleColor:color forState:state];
  }

  // Then
  for (UIControlState state = 0; state <= maxState; ++state) {
    XCTAssertEqualObjects([testButton backgroundColorForState:state],
                          [uiButton titleColorForState:state], @" for state (%lu)",
                          (unsigned long)state);
  }
}

- (void)testBackgroundColorForStateBehaviorMatchesTitleColorForStateWithoutFallbackBackward {
  // Given
  MDCButton *testButton = [[MDCButton alloc] init];
  UIButton *uiButton = [[UIButton alloc] init];

  // When
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (NSInteger state = maxState; state >= 0; --state) {
    UIColor *color = [UIColor colorWithWhite:0 alpha:(CGFloat)(state / (CGFloat)maxState)];
    [testButton setBackgroundColor:color forState:(UIControlState)state];
    [uiButton setTitleColor:color forState:(UIControlState)state];
  }

  // Then
  for (UIControlState state = 0; state <= maxState; ++state) {
    XCTAssertEqualObjects([testButton backgroundColorForState:state],
                          [uiButton titleColorForState:state], @" for state (%lu)",
                          (unsigned long)state);
  }
}

#pragma mark - shadowColor:forState:

- (void)testRemovedShadowColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When
  [button setShadowColor:nil forState:UIControlStateNormal];

  // Then
  XCTAssertNil([button shadowColorForState:UIControlStateNormal]);
  XCTAssertNil([button shadowColorForState:UIControlStateHighlighted]);
}

- (void)testDefaultShadowColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // Then
  XCTAssertNotNil([button shadowColorForState:UIControlStateSelected]);
}

- (void)testShadowColorForUnspecifiedStateEqualsNormalState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *color = randomColor();

  // When
  [button setShadowColor:color forState:UIControlStateNormal];

  XCTAssertEqual([button shadowColorForState:UIControlStateHighlighted], color);
}

- (void)testShadowColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // And given
    UIColor *color = randomColor();

    // When
    [button setShadowColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([button shadowColorForState:controlState], color);
  }
}

- (void)testLayerShadowColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    NSUInteger effectiveControlState = controlState;

    // And given
    UIColor *color = randomColor();

    // When
    [button setShadowColor:color forState:controlState];
    if ((effectiveControlState & UIControlStateHighlighted) == UIControlStateHighlighted) {
      button.highlighted = YES;
    } else {
      button.highlighted = NO;
    }

    if ((effectiveControlState & UIControlStateDisabled) == UIControlStateDisabled) {
      button.enabled = NO;
      // Disabling a button turns off "highlighted"
      effectiveControlState = (effectiveControlState & ~UIControlStateHighlighted);
    } else {
      button.enabled = YES;
    }

    if ((effectiveControlState & UIControlStateSelected) == UIControlStateSelected) {
      button.selected = YES;
    } else {
      button.selected = NO;
    }

    // Then
    UIColor *layerShadowColor = [UIColor colorWithCGColor:button.layer.shadowColor];
    XCTAssertEqualObjects([button shadowColorForState:effectiveControlState], layerShadowColor);
  }
}

#pragma mark - imageTintColor:forState:

- (void)testRemovedImageTintColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When
  [button setImageTintColor:nil forState:UIControlStateNormal];

  // Then
  XCTAssertNil([button imageTintColorForState:UIControlStateNormal]);
  XCTAssertNil([button imageTintColorForState:UIControlStateHighlighted]);
}

- (void)testDefaultImageTintColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // Then
  XCTAssertNil([button imageTintColorForState:UIControlStateSelected]);
}

- (void)testImageTintForUnspecifiedStateEqualsNormalState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *color = randomColor();

  // When
  [button setImageTintColor:color forState:UIControlStateNormal];

  XCTAssertEqual([button imageTintColorForState:UIControlStateHighlighted], color);
}

- (void)testImageTintColorForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // And given
    UIColor *color = randomColor();

    // When
    [button setImageTintColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([button imageTintColorForState:controlState], color);
  }
}

- (void)testImageTintColorForStateFallsBackToDefault {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *normalTint = [UIColor yellowColor];
  UIColor *selectedTint = [UIColor redColor];

  // When
  [button setImageTintColor:normalTint forState:UIControlStateNormal];
  [button setImageTintColor:selectedTint forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects([button imageTintColorForState:UIControlStateNormal], normalTint);
  XCTAssertEqualObjects([button imageTintColorForState:UIControlStateSelected], selectedTint);
  XCTAssertEqualObjects([button imageTintColorForState:UIControlStateHighlighted], normalTint);
}

- (void)testImageTintColorForStateSetsImageViewTintColor {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *normalTint = [UIColor yellowColor];
  UIColor *selectedTint = [UIColor redColor];

  // When
  [button setImageTintColor:normalTint forState:UIControlStateNormal];
  [button setImageTintColor:selectedTint forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects(button.imageView.tintColor, normalTint);

  // When
  button.selected = YES;

  // Then
  XCTAssertEqualObjects(button.imageView.tintColor, selectedTint);
}

#pragma mark - backgroundColor:forState:

- (void)testCurrentBackgroundColorNormal {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *normalColor = [UIColor redColor];
  [button setBackgroundColor:normalColor forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects([button backgroundColor], normalColor);
}

- (void)testCurrentBackgroundColorHighlighted {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *normalColor = [UIColor redColor];
  UIColor *color = [UIColor orangeColor];
  [button setBackgroundColor:normalColor forState:UIControlStateNormal];
  [button setBackgroundColor:color forState:UIControlStateHighlighted];

  // When
  button.highlighted = YES;

  // Then
  XCTAssertEqualObjects([button backgroundColor], color);
}

- (void)testCurrentBackgroundColorDisabled {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *normalColor = [UIColor redColor];
  UIColor *color = [UIColor orangeColor];
  [button setBackgroundColor:normalColor forState:UIControlStateNormal];
  [button setBackgroundColor:color forState:UIControlStateDisabled];

  // When
  button.enabled = NO;

  // Then
  XCTAssertEqualObjects([button backgroundColor], color);
}

- (void)testCurrentBackgroundColorSelected {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *normalColor = [UIColor redColor];
  UIColor *color = [UIColor orangeColor];
  [button setBackgroundColor:normalColor forState:UIControlStateNormal];
  [button setBackgroundColor:color forState:UIControlStateSelected];

  // When
  button.selected = YES;

  // Then
  XCTAssertEqualObjects([button backgroundColor], color);
}

#pragma mark - elevation:forState:

- (void)testCurrentElevationNormal {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat normalElevation = 10;
  [button setElevation:normalElevation forState:UIControlStateNormal];

  // Then
  XCTAssertEqualWithAccuracy([button elevationForState:button.state],
                             normalElevation,
                             kEpsilonAccuracy);
}

- (void)testCurrentElevationHighlighted {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat normalElevation = 10;
  CGFloat elevation = 40;
  [button setElevation:normalElevation forState:UIControlStateNormal];
  [button setElevation:elevation forState:UIControlStateHighlighted];

  // When
  button.highlighted = YES;

  // Then
  XCTAssertEqualWithAccuracy([button elevationForState:button.state], elevation, kEpsilonAccuracy);
}

- (void)testCurrentElevationDisabled {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat normalElevation = 10;
  CGFloat elevation = 40;
  [button setElevation:normalElevation forState:UIControlStateNormal];
  [button setElevation:elevation forState:UIControlStateDisabled];

  // When
  button.enabled = NO;

  // Then
  XCTAssertEqualWithAccuracy([button elevationForState:button.state], elevation, kEpsilonAccuracy);
}

- (void)testCurrentElevationSelected {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGFloat normalElevation = 10;
  CGFloat elevation = 40;
  [button setElevation:normalElevation forState:UIControlStateNormal];
  [button setElevation:elevation forState:UIControlStateSelected];

  // When
  button.selected = YES;

  // Then
  XCTAssertEqualWithAccuracy([button elevationForState:button.state], elevation, kEpsilonAccuracy);
}

#pragma mark - Ink Color

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
 - underlyingColor (text color)
 */

- (void)testAlphaRestoredWhenReenabled {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 80, 48)];
  CGFloat alpha = (CGFloat)0.5;

  // When
  button.alpha = alpha;
  button.enabled = NO;
  button.enabled = YES;

  // Then
  XCTAssertEqualWithAccuracy(alpha, button.alpha, 0.0001);
}

- (void)testEnabledAlphaNotSetWhileDisabled {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 80, 48)];
  CGFloat alpha = (CGFloat)0.2;

  // When
  button.alpha = alpha;
  button.enabled = NO;
  button.alpha = 1 - alpha;
  button.enabled = YES;

  // Then
  XCTAssertEqualWithAccuracy(alpha, button.alpha, (CGFloat)0.0001);
}

- (void)testDisabledAlpha {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 80, 48)];
  CGFloat alpha = 0.5;

  // When
  [button setDisabledAlpha:alpha];
  button.enabled = NO;

  // Then
  XCTAssertEqualWithAccuracy(alpha, button.alpha, (CGFloat)0.0001);
}

- (void)testPointInsideWithoutHitAreaInsets {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];

  CGPoint touchPointInsideBoundsTopLeft = CGPointMake(0, 0);
  CGPoint touchPointInsideBoundsTopRight = CGPointMake((CGFloat)79.9, 0);
  CGPoint touchPointInsideBoundsBottomRight = CGPointMake((CGFloat)79.9, (CGFloat)49.9);
  CGPoint touchPointInsideBoundsBottomLeft = CGPointMake(0, (CGFloat)49.9);

  CGPoint touchPointOutsideBoundsTopLeft = CGPointMake(0, (CGFloat)-0.1);
  CGPoint touchPointOutsideBoundsTopRight = CGPointMake(80, 0);
  CGPoint touchPointOutsideBoundsBottomRight = CGPointMake(80, 50);
  CGPoint touchPointOutsideBoundsBottomLeft = CGPointMake(0, 50);

  // Then
  XCTAssertTrue([button pointInside:touchPointInsideBoundsTopLeft withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideBoundsTopRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideBoundsBottomRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideBoundsBottomLeft withEvent:nil]);

  XCTAssertFalse([button pointInside:touchPointOutsideBoundsTopLeft withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideBoundsTopRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideBoundsBottomRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideBoundsBottomLeft withEvent:nil]);
}

- (void)testPointInsideWithoutHitAreaInsetsTooSmall {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];

  CGPoint touchPointInsideBoundsTopLeft = CGPointMake(0, 0);
  CGPoint touchPointInsideBoundsTopRight = CGPointMake((CGFloat)9.9, 0);
  CGPoint touchPointInsideBoundsBottomRight = CGPointMake((CGFloat)9.9, (CGFloat)9.9);
  CGPoint touchPointInsideBoundsBottomLeft = CGPointMake(0, (CGFloat)9.9);

  CGPoint touchPointOutsideBoundsTopLeft = CGPointMake(0, (CGFloat)-0.1);
  CGPoint touchPointOutsideBoundsTopRight = CGPointMake(10, 0);
  CGPoint touchPointOutsideBoundsBottomRight = CGPointMake(10, 10);
  CGPoint touchPointOutsideBoundsBottomLeft = CGPointMake(0, 10);

  // Then
  XCTAssertTrue([button pointInside:touchPointInsideBoundsTopLeft withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideBoundsTopRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideBoundsBottomRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideBoundsBottomLeft withEvent:nil]);

  XCTAssertFalse([button pointInside:touchPointOutsideBoundsTopLeft withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideBoundsTopRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideBoundsBottomRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideBoundsBottomLeft withEvent:nil]);
}

- (void)testPointInsideWithCustomHitAreaInsets {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];

  CGPoint touchPointInsideHitAreaTopLeft = CGPointMake(-5, -5);
  CGPoint touchPointInsideHitAreaTopRight = CGPointMake(-5, (CGFloat)14.9);
  CGPoint touchPointInsideHitAreaBottomRight = CGPointMake((CGFloat)14.9, (CGFloat)14.9);
  CGPoint touchPointInsideHitAreaBottomLeft = CGPointMake((CGFloat)14.9, -5);

  CGPoint touchPointOutsideHitAreaTopLeft = CGPointMake((CGFloat)-5.1, -5);
  CGPoint touchPointOutsideHitAreaTopRight = CGPointMake(-5, 15);
  CGPoint touchPointOutsideHitAreaBottomRight = CGPointMake(15, 15);
  CGPoint touchPointOutsideHitAreaBottomLeft = CGPointMake(15, -5);

  // When
  button.hitAreaInsets = UIEdgeInsetsMake(-5, -5, -5, -5);

  // Then
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaTopLeft withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaTopRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaBottomRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaBottomLeft withEvent:nil]);

  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaTopLeft withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaTopRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaBottomRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaBottomLeft withEvent:nil]);
}

- (void)testPointInsideWithNonStandardizedBounds {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  // This is (-10, -10, 20, 20) in standardized form
  CGRect bounds = CGRectMake(10, 10, -20, -20);
  // Once applied, these insets should increase the hitArea to (-15, -20, 30, 40)
  UIEdgeInsets insets = UIEdgeInsetsMake(-10, -5, -10, -5);

  CGPoint touchPointInsideHitAreaTopLeft = CGPointMake(-15, -20);
  CGPoint touchPointInsideHitAreaTopRight = CGPointMake((CGFloat)14.9, -20);
  CGPoint touchPointInsideHitAreaBottomRight = CGPointMake((CGFloat)14.9, (CGFloat)19.9);
  CGPoint touchPointInsideHitAreaBottomLeft = CGPointMake(-15, (CGFloat)19.9);

  CGPoint touchPointOutsideHitAreaTopLeft = CGPointMake((CGFloat)-15.1, -20);
  CGPoint touchPointOutsideHitAreaTopRight = CGPointMake(20, -20);
  CGPoint touchPointOutsideHitAreaBottomRight = CGPointMake(15, 20);
  CGPoint touchPointOutsideHitAreaBottomLeft = CGPointMake(-15, 20);

  // When
  button.bounds = bounds;
  button.hitAreaInsets = insets;

  // Then
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaTopLeft withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaTopRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaBottomRight withEvent:nil]);
  XCTAssertTrue([button pointInside:touchPointInsideHitAreaBottomLeft withEvent:nil]);

  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaTopLeft withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaTopRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaBottomRight withEvent:nil]);
  XCTAssertFalse([button pointInside:touchPointOutsideHitAreaBottomLeft withEvent:nil]);
}

#pragma mark - UIButton strangeness

- (void)testTitleColorForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    if (controlState & kUIControlStateDisabledHighlighted) {
      // We skip the Disabled Highlighted state because UIButton titleColorForState ignores it.
      continue;
    }
    // Given
    MDCButton *button = [[MDCButton alloc] init];
    UIColor *color = [UIColor blueColor];

    // When
    [button setTitleColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([button titleColorForState:controlState],
                          color,
                          @"for control state:%@ ",
                          controlStateDescription(controlState));
  }
}
- (void)testTitleColorForStateDisabledHighlight {
  // This is strange that setting the color for a state does not return the value of that state.
  // It turns out that it returns the value set to the normal state.

  // Given
  UIControlState controlState = kUIControlStateDisabledHighlighted;
  MDCButton *button = [[MDCButton alloc] init];
  UIColor *color = [UIColor blueColor];
  UIColor *normalColor = [UIColor greenColor];
  [button setTitleColor:normalColor forState:UIControlStateNormal];

  // When
  [button setTitleColor:color forState:controlState];

  // Then
  XCTAssertEqualObjects([button titleColorForState:controlState],
                        normalColor,
                        @"for control state:%@ ",
                        controlStateDescription(controlState));
  XCTAssertNotEqualObjects([button titleColorForState:controlState],
                           color,
                           @"for control state:%@ ",
                           controlStateDescription(controlState));
}

#pragma mark - UIButton state changes

- (void)testEnabled {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = (BOOL)arc4random_uniform(2);
  button.enabled = (BOOL)arc4random_uniform(2);

  // When
  button.enabled = YES;

  // Then
  XCTAssertTrue(button.enabled);
  XCTAssertFalse(button.state & UIControlStateDisabled);
}

- (void)testDisabled {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = (BOOL)arc4random_uniform(2);
  button.enabled = (BOOL)arc4random_uniform(2);

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
  button.selected = (BOOL)arc4random_uniform(2);

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
  button.selected = (BOOL)arc4random_uniform(2);
  button.enabled = (BOOL)arc4random_uniform(2);
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
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = NO;
  button.enabled = (BOOL)arc4random_uniform(2);
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
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = YES;
  button.enabled = (BOOL)arc4random_uniform(2);

  // When
  button.selected = NO;

  // Then
  XCTAssertFalse(button.selected);
  XCTAssertFalse(button.state & UIControlStateSelected);
}

- (void)testDefaultFont {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // Then
  XCTAssertEqualObjects(button.titleLabel.font, [MDCTypography buttonFont]);
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
  XCTAssertEqualWithAccuracy(button.titleLabel.font.pointSize,
                             preferredFont.pointSize,
                             kEpsilonAccuracy,
                             @"Font size should be equal to MDCFontTextStyleButton's.");
}

#pragma mark - Size-related tests

- (void)testSizeThatFitsWithMinimumOnly {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [button sizeToFit];
  CGRect expectedFrame = CGRectMake(0, 0,
                                    CGRectGetWidth(button.frame) + 15,
                                    CGRectGetHeight(button.frame) + 21);

  // When
  button.minimumSize = expectedFrame.size;
  [button sizeToFit];

  // Then
  XCTAssertTrue(CGRectEqualToRect(expectedFrame, button.frame),
                @"\nE: %@\nA: %@",
                NSStringFromCGRect(expectedFrame),
                NSStringFromCGRect(button.frame));
}

- (void)testSizeThatFitsWithMaximumOnly {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [button sizeToFit];
  CGRect expectedFrame = CGRectMake(0, 0,
                                    CGRectGetWidth(button.frame) - 7,
                                    CGRectGetHeight(button.frame) - 3);

  // When
  button.maximumSize = expectedFrame.size;
  [button sizeToFit];

  // Then
  XCTAssertTrue(CGRectEqualToRect(expectedFrame, button.frame),
                @"\nE: %@\nA: %@",
                NSStringFromCGRect(expectedFrame),
                NSStringFromCGRect(button.frame));
}

- (void)testSizeThatFitsWithMinimumAndMaximum {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [button sizeToFit];
  CGRect expectedFrame = CGRectMake(0, 0,
                                    CGRectGetWidth(button.frame) + 21,
                                    CGRectGetHeight(button.frame) - 4);

  // When
  button.maximumSize = CGSizeMake(0, CGRectGetHeight(expectedFrame)); // Only bound max height
  button.minimumSize = CGSizeMake(CGRectGetWidth(expectedFrame), 0); // Only bound min width
  [button sizeToFit];

  // Then
  XCTAssertTrue(CGRectEqualToRect(expectedFrame, button.frame),
                @"\nE: %@\nA: %@",
                NSStringFromCGRect(expectedFrame),
                NSStringFromCGRect(button.frame));
}

@end
