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
#import "MaterialShadowLayer.h"
#import "MaterialShapes.h"
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
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
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

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCButtonTests : XCTestCase
@property(nonatomic, strong, nullable) MDCButton *button;
@end

@implementation MDCButtonTests

- (void)setUp {
  [super setUp];

  self.button = [[MDCButton alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)testUppercaseTitleYes {
  // Given
  NSString *originalTitle = @"some Text";

  // When
  self.button.uppercaseTitle = YES;
  [self.button setTitle:originalTitle forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(self.button.currentTitle,
                        [originalTitle uppercaseStringWithLocale:[NSLocale currentLocale]]);
}

- (void)testUppercaseTitleNo {
  // Given
  NSString *originalTitle = @"some Text";

  // When
  self.button.uppercaseTitle = NO;
  [self.button setTitle:originalTitle forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(self.button.currentTitle, originalTitle);
}

- (void)testUppercaseTitleNoChangedToYes {
  // Given
  NSString *originalTitle = @"some Text";

  // When
  self.button.uppercaseTitle = NO;
  [self.button setTitle:originalTitle forState:UIControlStateNormal];
  [self.button setTitle:originalTitle forState:UIControlStateHighlighted];
  [self.button setTitle:originalTitle forState:UIControlStateDisabled];
  self.button.uppercaseTitle = YES;

  // Then
  XCTAssertEqualObjects(self.button.currentTitle,
                        [originalTitle uppercaseStringWithLocale:[NSLocale currentLocale]]);
}

- (void)testUppercaseTitleYesChangedToNo {
  // Given
  NSString *originalTitle = @"some Text";

  // When
  self.button.uppercaseTitle = YES;
  [self.button setTitle:originalTitle forState:UIControlStateNormal];
  [self.button setTitle:originalTitle forState:UIControlStateHighlighted];
  [self.button setTitle:originalTitle forState:UIControlStateDisabled];
  self.button.uppercaseTitle = NO;

  // Then
  XCTAssertEqualObjects(self.button.currentTitle, originalTitle);
}

- (void)testSetEnabledAnimated {
  // Given
  NSArray *boolValues = @[ @YES, @NO ];
  for (id enabled in boolValues) {
    for (id animated in boolValues) {
      // When
      [self.button setEnabled:[enabled boolValue] animated:[animated boolValue]];

      // Then
      XCTAssertEqual(self.button.enabled, [enabled boolValue]);
    }
  }
}

- (void)testElevationForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // Given
    CGFloat elevation = randomNumber();

    // When
    [self.button setElevation:elevation forState:controlState];

    // Then
    XCTAssertEqual([self.button elevationForState:controlState], elevation);
  }
}

- (void)testSetElevationOnlyUpdatesCurrentState {
  // Given
  TestButton *selectedButton = [[TestButton alloc] init];
  TestButton *highlightedButton = [[TestButton alloc] init];

  XCTAssertEqualWithAccuracy([selectedButton elevationForState:UIControlStateNormal],
                             [selectedButton elevationForState:UIControlStateHighlighted], 0.0001,
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
  XCTAssertEqual(selectedButton.shadowLayer.elevationAssignmentCount, selectedButtonElevationCount,
                 @"Updating an unrelated elevation should not update the layer elevation.");
  XCTAssertEqual(highlightedButtonElevationCount + 1,
                 highlightedButton.shadowLayer.elevationAssignmentCount,
                 @"Updating the current elevation should cause one elevation update.");
}

- (void)testElevationNormal {
  // Given
  CGFloat normalElevation = randomNumberNotEqualTo(0);

  // When
  [self.button setElevation:normalElevation forState:UIControlStateNormal];

  // Then
  XCTAssertEqual([self.button elevationForState:UIControlStateNormal], normalElevation);
  XCTAssertEqual([self.button elevationForState:UIControlStateHighlighted], normalElevation);
  XCTAssertEqual([self.button elevationForState:UIControlStateDisabled], normalElevation);
  XCTAssertEqual([self.button elevationForState:UIControlStateSelected], normalElevation);
}

- (void)testElevationNormalZeroElevation {
  // When
  [self.button setElevation:0 forState:UIControlStateNormal];

  // Then
  XCTAssertEqual([self.button elevationForState:UIControlStateNormal], 0);
}

- (void)testDefaultBorderWidth {
  // Then
  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    XCTAssertEqualWithAccuracy([self.button borderWidthForState:controlState], 0, 0.001);
  }
}

- (void)testBorderWidthForStateWithDifferentValues {
  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    // Given
    CGFloat width = (CGFloat)controlState;

    // When
    [self.button setBorderWidth:width forState:controlState];

    // Then
    if (controlState == (UIControlStateHighlighted | UIControlStateDisabled)) {
      XCTAssertEqualWithAccuracy([self.button borderWidthForState:controlState],
                                 [self.button borderWidthForState:UIControlStateHighlighted],
                                 0.001);
    } else if (controlState ==
               (UIControlStateHighlighted | UIControlStateDisabled | UIControlStateSelected)) {
      XCTAssertNotEqualWithAccuracy([self.button borderWidthForState:controlState],
                                    [self.button borderWidthForState:UIControlStateNormal], 0.001);
    } else {
      XCTAssertEqualWithAccuracy([self.button borderWidthForState:controlState], width, 0.001);
    }
  }
}

- (void)testBorderWidthFallbackBehavior {
  // Given
  CGFloat fakeBorderWidth = 99;

  // When
  [self.button setBorderWidth:fakeBorderWidth forState:UIControlStateNormal];

  // Then
  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    XCTAssertEqualWithAccuracy([self.button borderWidthForState:controlState], fakeBorderWidth,
                               0.001);
  }
}

- (void)testBorderColorForState {
  for (NSUInteger state = 0; state <= kNumUIControlStates; ++state) {
    // Given
    UIColor *color = randomColor();

    // When
    [self.button setBorderColor:color forState:state];

    // Then
    XCTAssertEqualObjects([self.button borderColorForState:state], color);
  }
}

- (void)testBorderColorForStateFallbackBehavior {
  // When
  [self.button setBorderColor:UIColor.redColor forState:UIControlStateNormal];

  // Then
  for (NSUInteger state = 0; state <= kNumUIControlStates; ++state) {
    XCTAssertEqualObjects([self.button borderColorForState:state], UIColor.redColor);
  }
}

- (void)testBorderColorForStateBehaviorMatchesTitleColorForStateForward {
  // Given
  MDCButton *testButton = [[MDCButton alloc] init];
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
    XCTAssertEqualObjects([testButton borderColorForState:state],
                          [uiButton titleColorForState:state], @" for state (%lu)",
                          (unsigned long)state);
  }
}

- (void)testBorderColorForStateBehaviorMatchesTitleColorForStateBackward {
  // Given
  MDCButton *testButton = [[MDCButton alloc] init];
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
    XCTAssertEqualObjects([testButton borderColorForState:state],
                          [uiButton titleColorForState:state], @" for state (%lu)",
                          (unsigned long)state);
  }
}

- (void)testBackgroundColorForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // Given
    UIColor *color = randomColor();

    // When
    [self.button setBackgroundColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([self.button backgroundColorForState:controlState], color);
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

    XCTAssertEqualObjects(self.button.backgroundColor, color, @"for state (%lu).",
                          (unsigned long)testState);
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
    XCTAssertEqualObjects([self.button backgroundColorForState:state],
                          [uiButton titleColorForState:state], @" for state (%lu)",
                          (unsigned long)state);
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
    XCTAssertEqualObjects([self.button backgroundColorForState:state],
                          [uiButton titleColorForState:state], @" for state (%lu)",
                          (unsigned long)state);
  }
}

#pragma mark - titleFont:forState:

- (void)testTitleFontForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // Given
    UIFont *randomFont = [UIFont systemFontOfSize:arc4random_uniform(100)];

    // When
    [self.button setTitleFont:randomFont forState:controlState];

    // Then
    XCTAssertEqualObjects([self.button titleFontForState:controlState], randomFont);
  }
}

- (void)testTitleFontForStateFallbackBehavior {
  // Given
  UIFont *fakeFont = [UIFont systemFontOfSize:25];
  // When
  [self.button setTitleFont:fakeFont forState:UIControlStateNormal];

  // Then
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    XCTAssertEqualObjects([self.button titleFontForState:controlState], fakeFont);
  }
}

- (void)testTitleFontForStateFallbackBehaviorWithLegacyDynamicType {
  // Given
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // When
  self.button.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    XCTAssertTrue(
        [[self.button titleFontForState:controlState]
            mdc_isSimplyEqual:[[MDCTypography buttonFont]
                                  mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleButton
                                               scaledForDynamicType:YES]],
        @"(%@) is not equal to (%@)", [self.button titleFontForState:UIControlStateNormal],
        [[MDCTypography buttonFont] mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleButton
                                                 scaledForDynamicType:YES]);
  }
}

- (void)testTitleFontForStateWithLegacyDynamicTypeReturnsRenderedFonts {
  // Given
  UIFont *userFont = [UIFont systemFontOfSize:99];
  [self.button setTitleFont:userFont forState:UIControlStateNormal];

  // When
  self.button.mdc_adjustsFontForContentSizeCategory = YES;
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // Then
  XCTAssertFalse([[self.button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:userFont],
                 @"(%@) is equal to (%@)", [self.button titleFontForState:UIControlStateNormal],
                 userFont);
  XCTAssertFalse([self.button.titleLabel.font mdc_isSimplyEqual:userFont], @"(%@) is equal to (%@)",
                 self.button.titleLabel.font, userFont);
  XCTAssertTrue([[self.button titleFontForState:UIControlStateNormal]
                    mdc_isSimplyEqual:self.button.titleLabel.font],
                @"(%@) is not equal to (%@)", [self.button titleFontForState:UIControlStateNormal],
                self.button.titleLabel.font);
}

- (void)testTitleFontForStateWithLegacyDynamicTypeRestoresUserFonts {
  // Given
  UIFont *userFont = [UIFont systemFontOfSize:99];
  [self.button setTitleFont:userFont forState:UIControlStateNormal];
  self.button.mdc_adjustsFontForContentSizeCategory = YES;
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // When
  self.button.mdc_adjustsFontForContentSizeCategory = NO;

  // Then
  XCTAssertTrue([[self.button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:userFont],
                @"(%@) is not equal to (%@)", [self.button titleFontForState:UIControlStateNormal],
                userFont);
  XCTAssertTrue([self.button.titleLabel.font mdc_isSimplyEqual:userFont],
                @"(%@) is not equal to (%@)", self.button.titleLabel.font, userFont);
  XCTAssertTrue([[self.button titleFontForState:UIControlStateNormal]
                    mdc_isSimplyEqual:self.button.titleLabel.font],
                @"(%@) is not equal to (%@)", [self.button titleFontForState:UIControlStateNormal],
                self.button.titleLabel.font);
}

/**
 Verifies that disabling the @c titleFont:forState: APIs after setting fonts preserves the
 directly-assigned font on the button's @c titleLabel.
 */
- (void)testTitleFontForStateDisabledAfterSettingFontsPreventsFontChange {
  // Given
  UIFont *normalFont = [UIFont systemFontOfSize:10];
  UIFont *selectedFont = [UIFont systemFontOfSize:40];
  UIFont *directlyAssignedFont = [UIFont systemFontOfSize:25];
  [self.button setTitleFont:normalFont forState:UIControlStateNormal];
  [self.button setTitleFont:selectedFont forState:UIControlStateSelected];

  // When
  self.button.enableTitleFontForState = NO;
  self.button.titleLabel.font = directlyAssignedFont;
  self.button.selected = YES;

  // Then
  XCTAssertEqualObjects(self.button.titleLabel.font, directlyAssignedFont);
}

/**
 Verifies that disabling @c titleFont:forState: APIs before setting fonts preserves the
 directly-assigned font on the button's @c titleLabel.
 */
- (void)testTitleFontForStateDisabledBeforeSettingFontsPreventsFontChange {
  // Given
  UIFont *normalFont = [UIFont systemFontOfSize:10];
  UIFont *selectedFont = [UIFont systemFontOfSize:40];
  UIFont *directlyAssignedFont = [UIFont systemFontOfSize:25];
  self.button.enableTitleFontForState = NO;
  self.button.titleLabel.font = directlyAssignedFont;

  // When
  [self.button setTitleFont:normalFont forState:UIControlStateNormal];
  [self.button setTitleFont:selectedFont forState:UIControlStateSelected];
  self.button.selected = YES;

  // Then
  XCTAssertEqualObjects(self.button.titleLabel.font, directlyAssignedFont);
}

/**
 Verifies that after enabling @c titleFont:forState: APIs, that @c titleLabel.font will be
 replaced by the next time the state is changed.
 */
- (void)testTitleFontForStateReenabledUpdatesFontsOnNextStateChange {
  // Given
  UIFont *normalFont = [UIFont systemFontOfSize:10];
  UIFont *selectedFont = [UIFont systemFontOfSize:40];
  UIFont *directlyAssignedFont = [UIFont systemFontOfSize:25];
  self.button.enableTitleFontForState = NO;
  [self.button setTitleFont:normalFont forState:UIControlStateNormal];
  [self.button setTitleFont:selectedFont forState:UIControlStateSelected];
  self.button.titleLabel.font = directlyAssignedFont;
  self.button.selected = YES;

  // When
  self.button.enableTitleFontForState = YES;
  self.button.selected = NO;

  // Then
  XCTAssertEqualObjects(self.button.titleLabel.font, normalFont);
}

#pragma mark - shadowColor:forState:

- (void)testRemovedShadowColorForState {
  // When
  [self.button setShadowColor:nil forState:UIControlStateNormal];

  // Then
  XCTAssertNil([self.button shadowColorForState:UIControlStateNormal]);
  XCTAssertNil([self.button shadowColorForState:UIControlStateHighlighted]);
}

- (void)testDefaultShadowColorForState {
  // Then
  XCTAssertNotNil([self.button shadowColorForState:UIControlStateSelected]);
}

- (void)testShadowColorForUnspecifiedStateEqualsNormalState {
  // Given
  UIColor *color = randomColor();

  // When
  [self.button setShadowColor:color forState:UIControlStateNormal];

  XCTAssertEqual([self.button shadowColorForState:UIControlStateHighlighted], color);
}

- (void)testShadowColorForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // Given
    UIColor *color = randomColor();

    // When
    [self.button setShadowColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([self.button shadowColorForState:controlState], color);
  }
}

- (void)testLayerShadowColorForState {
  for (NSUInteger controlState = 0; controlState <= kNumUIControlStates; ++controlState) {
    // Given
    NSUInteger effectiveControlState = controlState;
    UIColor *color = randomColor();

    // When
    [self.button setShadowColor:color forState:controlState];
    if ((effectiveControlState & UIControlStateHighlighted) == UIControlStateHighlighted) {
      self.button.highlighted = YES;
    } else {
      self.button.highlighted = NO;
    }

    if ((effectiveControlState & UIControlStateDisabled) == UIControlStateDisabled) {
      self.button.enabled = NO;
      // Disabling a button turns off "highlighted"
      effectiveControlState = (effectiveControlState & ~UIControlStateHighlighted);
    } else {
      self.button.enabled = YES;
    }

    if ((effectiveControlState & UIControlStateSelected) == UIControlStateSelected) {
      self.button.selected = YES;
    } else {
      self.button.selected = NO;
    }

    // Then
    UIColor *layerShadowColor = [UIColor colorWithCGColor:self.button.layer.shadowColor];
    XCTAssertEqualObjects([self.button shadowColorForState:effectiveControlState],
                          layerShadowColor);
  }
}

#pragma mark - imageTintColor:forState:

- (void)testRemovedImageTintColorForState {
  // When
  [self.button setImageTintColor:nil forState:UIControlStateNormal];

  // Then
  XCTAssertNil([self.button imageTintColorForState:UIControlStateNormal]);
  XCTAssertNil([self.button imageTintColorForState:UIControlStateHighlighted]);
}

- (void)testDefaultImageTintColorForState {
  // Then
  XCTAssertNil([self.button imageTintColorForState:UIControlStateSelected]);
}

- (void)testImageTintForUnspecifiedStateEqualsNormalState {
  // Given
  UIColor *color = randomColor();

  // When
  [self.button setImageTintColor:color forState:UIControlStateNormal];

  XCTAssertEqual([self.button imageTintColorForState:UIControlStateHighlighted], color);
}

- (void)testImageTintColorForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    // Given
    UIColor *color = randomColor();

    // When
    [self.button setImageTintColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([self.button imageTintColorForState:controlState], color);
  }
}

- (void)testImageTintColorForStateFallsBackToDefault {
  // Given
  UIColor *normalTint = [UIColor yellowColor];
  UIColor *selectedTint = [UIColor redColor];

  // When
  [self.button setImageTintColor:normalTint forState:UIControlStateNormal];
  [self.button setImageTintColor:selectedTint forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects([self.button imageTintColorForState:UIControlStateNormal], normalTint);
  XCTAssertEqualObjects([self.button imageTintColorForState:UIControlStateSelected], selectedTint);
  XCTAssertEqualObjects([self.button imageTintColorForState:UIControlStateHighlighted], normalTint);
}

- (void)testImageTintColorForStateSetsImageViewTintColor {
  // Given
  UIColor *normalTint = [UIColor yellowColor];
  UIColor *selectedTint = [UIColor redColor];

  // When
  [self.button setImageTintColor:normalTint forState:UIControlStateNormal];
  [self.button setImageTintColor:selectedTint forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects(self.button.imageView.tintColor, normalTint);

  // When
  self.button.selected = YES;

  // Then
  XCTAssertEqualObjects(self.button.imageView.tintColor, selectedTint);
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

#pragma mark - elevation:forState:

- (void)testCurrentElevationNormal {
  // Given
  CGFloat normalElevation = 10;
  [self.button setElevation:normalElevation forState:UIControlStateNormal];

  // Then
  XCTAssertEqualWithAccuracy([self.button elevationForState:self.button.state], normalElevation,
                             kEpsilonAccuracy);
}

- (void)testCurrentElevationHighlighted {
  // Given
  CGFloat normalElevation = 10;
  CGFloat elevation = 40;
  [self.button setElevation:normalElevation forState:UIControlStateNormal];
  [self.button setElevation:elevation forState:UIControlStateHighlighted];

  // When
  self.button.highlighted = YES;

  // Then
  XCTAssertEqualWithAccuracy([self.button elevationForState:self.button.state], elevation,
                             kEpsilonAccuracy);
}

- (void)testCurrentElevationDisabled {
  // Given
  CGFloat normalElevation = 10;
  CGFloat elevation = 40;
  [self.button setElevation:normalElevation forState:UIControlStateNormal];
  [self.button setElevation:elevation forState:UIControlStateDisabled];

  // When
  self.button.enabled = NO;

  // Then
  XCTAssertEqualWithAccuracy([self.button elevationForState:self.button.state], elevation,
                             kEpsilonAccuracy);
}

- (void)testCurrentElevationSelected {
  // Given
  CGFloat normalElevation = 10;
  CGFloat elevation = 40;
  [self.button setElevation:normalElevation forState:UIControlStateNormal];
  [self.button setElevation:elevation forState:UIControlStateSelected];

  // When
  self.button.selected = YES;

  // Then
  XCTAssertEqualWithAccuracy([self.button elevationForState:self.button.state], elevation,
                             kEpsilonAccuracy);
}

#pragma mark - Ink Color

- (void)testInkColors {
  // Given
  UIColor *color = randomColor();

  // When
  self.button.inkColor = color;

  // Then
  XCTAssertEqualObjects(self.button.inkColor, color);
}

/*
 TODO: things to unit test
 (should these even be a thing?)
 - hitAreaInset
 - underlyingColor (text color)
 */

- (void)testAlphaRestoredWhenReenabled {
  // Given
  CGFloat alpha = (CGFloat)0.5;

  // When
  self.button.alpha = alpha;
  self.button.enabled = NO;
  self.button.enabled = YES;

  // Then
  XCTAssertEqualWithAccuracy(alpha, self.button.alpha, 0.0001);
}

- (void)testEnabledAlphaNotSetWhileDisabled {
  // Given
  CGFloat alpha = (CGFloat)0.2;

  // When
  self.button.alpha = alpha;
  self.button.enabled = NO;
  self.button.alpha = 1 - alpha;
  self.button.enabled = YES;

  // Then
  XCTAssertEqualWithAccuracy(alpha, self.button.alpha, (CGFloat)0.0001);
}

- (void)testDisabledAlpha {
  // Given
  CGFloat alpha = 0.5;

  // When
  [self.button setDisabledAlpha:alpha];
  self.button.enabled = NO;

  // Then
  XCTAssertEqualWithAccuracy(alpha, self.button.alpha, (CGFloat)0.0001);
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

- (void)testPointInsideWithCustomHitAreaInsets {
  // Given
  self.button.frame = CGRectMake(0, 0, 10, 10);

  CGPoint touchPointInsideHitAreaTopLeft = CGPointMake(-5, -5);
  CGPoint touchPointInsideHitAreaTopRight = CGPointMake(-5, (CGFloat)14.9);
  CGPoint touchPointInsideHitAreaBottomRight = CGPointMake((CGFloat)14.9, (CGFloat)14.9);
  CGPoint touchPointInsideHitAreaBottomLeft = CGPointMake((CGFloat)14.9, -5);

  CGPoint touchPointOutsideHitAreaTopLeft = CGPointMake((CGFloat)-5.1, -5);
  CGPoint touchPointOutsideHitAreaTopRight = CGPointMake(-5, 15);
  CGPoint touchPointOutsideHitAreaBottomRight = CGPointMake(15, 15);
  CGPoint touchPointOutsideHitAreaBottomLeft = CGPointMake(15, -5);

  // When
  self.button.hitAreaInsets = UIEdgeInsetsMake(-5, -5, -5, -5);

  // Then
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaTopLeft withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaTopRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaBottomRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaBottomLeft withEvent:nil]);

  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaTopLeft withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaTopRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaBottomRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaBottomLeft withEvent:nil]);
}

- (void)testPointInsideWithNonStandardizedBounds {
  // Given
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
  self.button.bounds = bounds;
  self.button.hitAreaInsets = insets;

  // Then
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaTopLeft withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaTopRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaBottomRight withEvent:nil]);
  XCTAssertTrue([self.button pointInside:touchPointInsideHitAreaBottomLeft withEvent:nil]);

  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaTopLeft withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaTopRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaBottomRight withEvent:nil]);
  XCTAssertFalse([self.button pointInside:touchPointOutsideHitAreaBottomLeft withEvent:nil]);
}

#pragma mark - UIButton strangeness

- (void)testTitleColorForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    if (controlState & kUIControlStateDisabledHighlighted) {
      // We skip the Disabled Highlighted state because UIButton titleColorForState ignores it.
      continue;
    }
    // Given
    UIColor *color = [UIColor blueColor];

    // When
    [self.button setTitleColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([self.button titleColorForState:controlState], color,
                          @"for control state:%@ ", controlStateDescription(controlState));
  }
}
- (void)testTitleColorForStateDisabledHighlight {
  // This is strange that setting the color for a state does not return the value of that state.
  // It turns out that it returns the value set to the normal state.

  // Given
  UIControlState controlState = kUIControlStateDisabledHighlighted;
  UIColor *color = [UIColor blueColor];
  UIColor *normalColor = [UIColor greenColor];
  [self.button setTitleColor:normalColor forState:UIControlStateNormal];

  // When
  [self.button setTitleColor:color forState:controlState];

  // Then
  XCTAssertEqualObjects([self.button titleColorForState:controlState], normalColor,
                        @"for control state:%@ ", controlStateDescription(controlState));
  XCTAssertNotEqualObjects([self.button titleColorForState:controlState], color,
                           @"for control state:%@ ", controlStateDescription(controlState));
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
  // Then
  XCTAssertEqualObjects(self.button.titleLabel.font, [MDCTypography buttonFont]);
}

- (void)testDefaultAdjustsFontProperty {
  // Then
  XCTAssertFalse(self.button.mdc_adjustsFontForContentSizeCategory);
}

- (void)testAdjustsFontProperty {
  UIFont *preferredFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleButton];

  // When
  self.button.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertTrue(self.button.mdc_adjustsFontForContentSizeCategory);
  XCTAssertEqualWithAccuracy(self.button.titleLabel.font.pointSize, preferredFont.pointSize,
                             kEpsilonAccuracy,
                             @"Font size should be equal to MDCFontTextStyleButton's.");
}

/**
 Test legacy dynamic type has no impact on a @c MDCButton when @c
 adjustFontForContentSizeCategoryWhenScaledFontIsUnavailable is set to @c NO before setting @c
 mdc_adjustsFontForContentSizeCategory to @c YES that the font stays the same.
 */
- (void)testLegacyDynamicTypeDisabledThenDynamicTypeTurnedOn {
  // Given
  UIFont *fakeFont = [UIFont systemFontOfSize:55];
  [self.button setTitleFont:fakeFont forState:UIControlStateNormal];
  UIFont *originalFont = self.button.titleLabel.font;
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.button.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertTrue([self.button.titleLabel.font mdc_isSimplyEqual:originalFont],
                @"(%@) is not equal to (%@)", self.button.titleLabel.font, originalFont);
  XCTAssertTrue(
      [[self.button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:originalFont],
      @"(%@) is not equal to (%@)", [self.button titleFontForState:UIControlStateNormal],
      originalFont);
}

/**
 Test legacy dynamic type impacts a @c MDCButton when @c
 adjustFontForContentSizeCategoryWhenScaledFontIsUnavailable is set to @c YES that the font changes.
 */
- (void)testLegacyDynamicTypeEnabled {
  // Given
  UIFont *fakeFont = [UIFont systemFontOfSize:55];
  [self.button setTitleFont:fakeFont forState:UIControlStateNormal];
  UIFont *originalFont = self.button.titleLabel.font;
  self.button.mdc_adjustsFontForContentSizeCategory = YES;

  // When
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // Then
  XCTAssertFalse([self.button.titleLabel.font mdc_isSimplyEqual:originalFont], @"%@ is equal to %@",
                 self.button.titleLabel.font, originalFont);
}

#pragma mark - Size-related tests

- (void)testSizeThatFitsWithMinimumOnly {
  // Given
  [self.button sizeToFit];
  CGRect expectedFrame = CGRectMake(0, 0, CGRectGetWidth(self.button.frame) + 15,
                                    CGRectGetHeight(self.button.frame) + 21);

  // When
  self.button.minimumSize = expectedFrame.size;
  [self.button sizeToFit];

  // Then
  XCTAssertTrue(CGRectEqualToRect(expectedFrame, self.button.frame), @"\nE: %@\nA: %@",
                NSStringFromCGRect(expectedFrame), NSStringFromCGRect(self.button.frame));
}

- (void)testSizeThatFitsWithMaximumOnly {
  // Given
  [self.button sizeToFit];
  CGRect expectedFrame = CGRectMake(0, 0, CGRectGetWidth(self.button.frame) - 7,
                                    CGRectGetHeight(self.button.frame) - 3);

  // When
  self.button.maximumSize = expectedFrame.size;
  [self.button sizeToFit];

  // Then
  XCTAssertTrue(CGRectEqualToRect(expectedFrame, self.button.frame), @"\nE: %@\nA: %@",
                NSStringFromCGRect(expectedFrame), NSStringFromCGRect(self.button.frame));
}

- (void)testSizeThatFitsWithMinimumAndMaximum {
  // Given
  [self.button sizeToFit];
  CGRect expectedFrame = CGRectMake(0, 0, CGRectGetWidth(self.button.frame) + 21,
                                    CGRectGetHeight(self.button.frame) - 4);

  // When
  self.button.maximumSize = CGSizeMake(0, CGRectGetHeight(expectedFrame));  // Only bound max height
  self.button.minimumSize = CGSizeMake(CGRectGetWidth(expectedFrame), 0);   // Only bound min width
  [self.button sizeToFit];

  // Then
  XCTAssertTrue(CGRectEqualToRect(expectedFrame, self.button.frame), @"\nE: %@\nA: %@",
                NSStringFromCGRect(expectedFrame), NSStringFromCGRect(self.button.frame));
}

- (void)testIntrinsicContentSizeWithMinimumSizeIncreasesSize {
  // Given
  CGSize originalSize = self.button.intrinsicContentSize;
  CGSize expectedSize = CGSizeMake(originalSize.width + 10, originalSize.height + 10);

  // When
  self.button.minimumSize = expectedSize;

  // Then
  XCTAssertTrue(CGSizeEqualToSize(expectedSize, self.button.intrinsicContentSize));
}

- (void)testIntrinsicContentSizeWithMaximumDecreasesSize {
  // Given
  CGSize originalSize = self.button.intrinsicContentSize;
  CGSize expectedSize = CGSizeMake(originalSize.width - 5, originalSize.height - 5);

  // When
  self.button.maximumSize = expectedSize;

  // Then
  XCTAssertTrue(CGSizeEqualToSize(expectedSize, self.button.intrinsicContentSize));
}

- (void)testIntrinsicContentSizeWithMaximumAndMinimumSizeBehavior {
  // Given
  CGSize originalSize = self.button.intrinsicContentSize;
  CGSize expectedSize = CGSizeMake(originalSize.width + 5, originalSize.height - 5);

  // When
  self.button.maximumSize = CGSizeMake(0, expectedSize.height);
  self.button.minimumSize = CGSizeMake(expectedSize.width, 0);

  // Then
  XCTAssertTrue(CGSizeEqualToSize(expectedSize, self.button.intrinsicContentSize));
}

#pragma mark - UIAccessibility

- (void)testAccessibilityTraitsDefault {
  // Then
  XCTAssertEqual(self.button.accessibilityTraits, UIAccessibilityTraitButton);
}

- (void)testAccessibilityTraitsDefaultIncludesButtonExplicitlyTrue {
  // When
  self.button.accessibilityTraitsIncludesButton = YES;

  // Then
  XCTAssertEqual(self.button.accessibilityTraits, UIAccessibilityTraitButton);
}

- (void)testAccessibilityTraitsDefaultIncludesButtonExplicitlyFalse {
  // Given
  UIButton *referenceButton = [[UIButton alloc] init];
  [referenceButton setTitle:@"title" forState:UIControlStateNormal];

  // When
  self.button.accessibilityTraitsIncludesButton = NO;

  // Then
  // UIButton does not return `.button` in unit tests, but will in a simulator. The best this test
  // can do is confirm the behavior matches UIButton.
  XCTAssertEqual(self.button.accessibilityTraits, referenceButton.accessibilityTraits);
}

- (void)testSetAccessibilityTraitsIncludesButtonByDefault {
  // When
  self.button.accessibilityTraits = UIAccessibilityTraitLink;

  // Then
  XCTAssertEqual(self.button.accessibilityTraits,
                 UIAccessibilityTraitLink | UIAccessibilityTraitButton);
}

- (void)testSetAccessibilityTraitsExcludesButtonExplicitly {
  // When
  self.button.accessibilityTraitsIncludesButton = NO;
  self.button.accessibilityTraits = UIAccessibilityTraitAllowsDirectInteraction;

  // Then
  XCTAssertEqual(self.button.accessibilityTraits, UIAccessibilityTraitAllowsDirectInteraction);
}

- (void)testSetAccessibilityTraitsIncludesButtonExplicitly {
  // When
  self.button.accessibilityTraitsIncludesButton = YES;
  self.button.accessibilityTraits = UIAccessibilityTraitAllowsDirectInteraction;

  // Then
  XCTAssertEqual(self.button.accessibilityTraits,
                 UIAccessibilityTraitAllowsDirectInteraction | UIAccessibilityTraitButton);
}

#pragma mark - UITraitCollection

- (void)testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChanges {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];

  __block MDCButton *passedButton;
  button.traitCollectionDidChangeBlock =
      ^(MDCButton *_Nonnull buttonInBlock, UITraitCollection *_Nullable previousTraitCollection) {
        passedButton = buttonInBlock;
        [expectation fulfill];
      };

  // When
  [button traitCollectionDidChange:nil];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedButton, button);
}

#pragma mark - MaterialElevation

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // Then
  XCTAssertLessThan(button.mdc_overrideBaseElevation, 0);
}

- (void)testCurrentElevationMatchesElevationForState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];

  // When
  UIControlState allStatesCombined = UIControlStateNormal | UIControlStateDisabled |
                                     UIControlStateSelected | UIControlStateHighlighted;
  MDCShadowElevation startingElevation = 100;

  for (NSUInteger state = 0; state <= allStatesCombined; ++state) {
    [button setElevation:startingElevation + state forState:state];
  }

  // Then
  for (NSUInteger state = 0; state <= allStatesCombined; ++state) {
    if (state & (UIControlStateDisabled | UIControlStateHighlighted)) {
      continue;
    }
    button.enabled = (state & UIControlStateDisabled) == UIControlStateDisabled ? NO : YES;
    button.selected = (state & UIControlStateSelected) == UIControlStateSelected ? YES : NO;
    button.highlighted =
        (state & UIControlStateHighlighted) == UIControlStateHighlighted ? YES : NO;
    XCTAssertEqualWithAccuracy(button.mdc_currentElevation, [button elevationForState:state],
                               0.001);
  }
}

- (void)testElevationDidChangeBlockCalledWhenStateChangeCausesElevationChange {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  [button setElevation:1 forState:UIControlStateNormal];
  [button setElevation:9 forState:UIControlStateSelected];
  __block CGFloat newElevation = 0;
  button.mdc_elevationDidChangeBlock = ^(MDCButton *object, CGFloat elevation) {
    newElevation = elevation;
  };

  // When
  button.selected = YES;

  // Then
  XCTAssertEqualWithAccuracy(newElevation, [button elevationForState:UIControlStateSelected],
                             0.001);
}

- (void)testElevationDidChangeBlockNotCalledWhenStateChangeDoesNotCauseElevationChange {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  [button setElevation:1 forState:UIControlStateNormal];
  [button setElevation:1 forState:UIControlStateHighlighted];
  __block BOOL blockCalled = NO;
  button.mdc_elevationDidChangeBlock = ^(MDCButton *object, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  button.highlighted = YES;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesForCurrentState {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  button.selected = YES;
  __block CGFloat newElevation = 0;
  button.mdc_elevationDidChangeBlock = ^(MDCButton *object, CGFloat elevation) {
    newElevation = elevation;
  };

  // When
  [button setElevation:99 forState:button.state];

  // Then
  XCTAssertEqualWithAccuracy(newElevation, [button elevationForState:button.state], 0.001);
}

@end
