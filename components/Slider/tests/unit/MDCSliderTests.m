// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "../../src/private/MDCSlider+Private.h"
#import "MaterialPalettes.h"
#import "MaterialSlider.h"
#import "MaterialThumbTrack.h"
#import "MaterialTypography.h"
#import "MockUIImpactFeedbackGenerator.h"

static const int kNumberOfRepeats = 20;
static const CGFloat kEpsilonAccuracy = (CGFloat)0.001;

@interface MDCSlider (TestInterface)

- (NSString *)thumbTrack:(MDCThumbTrack *)thumbTrack stringForValue:(CGFloat)value;
- (void)thumbTrackValueChanged:(__unused MDCThumbTrack *)thumbTrack;
@property(nonnull, nonatomic, strong)
    UIImpactFeedbackGenerator *feedbackGenerator API_AVAILABLE(ios(10.0));
@end

@interface MDCSliderTests : XCTestCase
@property(nonatomic, nullable) MDCSlider *slider;
@property(nonatomic, nullable) UIColor *aNonDefaultColor;
@property(nonatomic, nullable) UIColor *defaultBlue;
@property(nonatomic, nullable) UIColor *defaultGray;
@end

@implementation MDCSliderTests {
  MockUIImpactFeedbackGenerator *_mockFeedbackGenerator API_AVAILABLE(ios(10.0));
}

- (void)setUp {
  [super setUp];
  self.slider = [[MDCSlider alloc] init];
  self.aNonDefaultColor = [UIColor orangeColor];
  self.defaultBlue = MDCPalette.bluePalette.tint500;
  self.defaultGray = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.26];
}

- (void)tearDown {
  self.slider = nil;
  self.aNonDefaultColor = nil;
  self.defaultBlue = nil;
  self.defaultGray = nil;
  [super tearDown];
}

- (void)testValue {
  // Given
  CGFloat value = [self randomPercent] * self.slider.maximumValue;

  // When
  [self.slider setValue:value animated:YES];

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, value, kEpsilonAccuracy);
}

- (void)testValueAnimated {
  // Given
  CGFloat value = [self randomPercent] * self.slider.maximumValue;

  // When
  [self.slider setValue:value animated:YES];

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, value, kEpsilonAccuracy);
}

- (void)testMaximumDefault {
  // Then
  XCTAssertEqualWithAccuracy(self.slider.maximumValue, 1, kEpsilonAccuracy);
}

- (void)testSetValueToHigherThanMaximum {
  // When
  self.slider.value = self.slider.maximumValue + [self randomNumber];

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.maximumValue, kEpsilonAccuracy);
}

- (void)testSetValueToLowerThanMinimum {
  // When
  self.slider.value = self.slider.minimumValue - [self randomNumber];

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

- (void)testSetMaximumToLowerThanValue {
  // Given
  self.slider.maximumValue = [self randomNumber];
  self.slider.value = self.slider.minimumValue +
                      [self randomPercent] * (self.slider.maximumValue - self.slider.minimumValue);

  // When
  self.slider.maximumValue = self.slider.value - [self randomPercent] * self.slider.value;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.maximumValue, kEpsilonAccuracy);
}

- (void)testSetMinimumToHigherThanValue {
  // Given
  self.slider.maximumValue = [self randomNumber];
  self.slider.value = self.slider.minimumValue +
                      [self randomPercent] * (self.slider.maximumValue - self.slider.minimumValue);

  // When
  self.slider.minimumValue = self.slider.value + [self randomPercent] * self.slider.value;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

- (void)testSetMaximumToLowerThanMinimum {
  // Given
  CGFloat newMax = self.slider.minimumValue - [self randomNumber];

  // When
  self.slider.maximumValue = newMax;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.maximumValue, self.slider.minimumValue, kEpsilonAccuracy,
                             @"Setting the slider's max to lower than the max must equal the min.");
  XCTAssertEqualWithAccuracy(
      newMax, self.slider.minimumValue, kEpsilonAccuracy,
      @"Setting the slider's max must change the min when smaller than the min.");
  XCTAssertEqualWithAccuracy(
      newMax, self.slider.maximumValue, kEpsilonAccuracy,
      @"Setting the slider's max must equal the value gotten even when smaller than the minimum.");
  XCTAssertEqualWithAccuracy(
      newMax, self.slider.value, kEpsilonAccuracy,
      @"Setting the slider's min to lower than the value must change the value also.");
}

- (void)testSetMinimumToLowerThanMaximum {
  // Given
  CGFloat newMin = self.slider.maximumValue + [self randomNumber];

  // When
  self.slider.minimumValue = newMin;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.minimumValue, self.slider.maximumValue, kEpsilonAccuracy,
                             @"Setting the slider's min to higher than the max must equal the "
                             @"max.");
  XCTAssertEqualWithAccuracy(
      newMin, self.slider.minimumValue, kEpsilonAccuracy,
      @"Setting the slider's min must equal the value gotten even when larger than the maximum.");
  XCTAssertEqualWithAccuracy(
      newMin, self.slider.maximumValue, kEpsilonAccuracy,
      @"Setting the slider's min to larger than the max must change the max also.");
  XCTAssertEqualWithAccuracy(
      newMin, self.slider.value, kEpsilonAccuracy,
      @"Setting the slider's min to higher than the value must change the value also.");
}

/**
 When there are only two discrete values allowed, a value in the lower half snaps to the minimum.
 */
- (void)testDiscreteValues2 {
  // Given
  self.slider.maximumValue = 10;
  self.slider.minimumValue = 0;
  self.slider.value = arc4random_uniform((u_int32_t)(self.slider.maximumValue / 2));

  // When
  self.slider.numberOfDiscreteValues = 2;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

/**
 Explicit track tick visibility retains default behavior of @c discrete.
 */
- (void)testDiscreteValues2WithExplicitTickVisibilityRetainsValueSnapping {
  // Given
  self.slider.maximumValue = 10;
  self.slider.minimumValue = 0;
  u_int32_t expectedValue = arc4random_uniform((u_int32_t)(self.slider.maximumValue / 2));
  self.slider.value = expectedValue;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityNever;
  self.slider.numberOfDiscreteValues = 2;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues2SetValue {
  // Given
  self.slider.maximumValue = 10;
  self.slider.minimumValue = 0;
  self.slider.numberOfDiscreteValues = 2;

  // When
  self.slider.value = arc4random_uniform((u_int32_t)(self.slider.maximumValue / 2));

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues3 {
  // Given
  self.slider.maximumValue = 100;
  self.slider.minimumValue = 0;
  self.slider.value = arc4random_uniform((u_int32_t)(self.slider.maximumValue / 6));

  // When
  self.slider.numberOfDiscreteValues = 3;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

/**
 Explicit track tick visibility retains default behavior of @c discrete.
 */
- (void)testDiscreteValues3WithExplicitTickVisibilityRetainsValueSnapping {
  // Given
  self.slider.maximumValue = 100;
  self.slider.minimumValue = 0;
  u_int32_t expectedValue = arc4random_uniform((u_int32_t)(self.slider.maximumValue / 6));
  self.slider.value = expectedValue;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityWhenDragging;
  self.slider.numberOfDiscreteValues = 3;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues3SetValue {
  // Given
  self.slider.maximumValue = 100;
  self.slider.minimumValue = 0;
  self.slider.numberOfDiscreteValues = 3;

  // When
  self.slider.value = arc4random_uniform((u_int32_t)(self.slider.maximumValue / 6));

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, self.slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValuesWithIntegers {
  for (int i = 0; i < kNumberOfRepeats; ++i) {
    // Given
    self.slider = [[MDCSlider alloc] init];
    self.slider.maximumValue = (int)[self randomNumber];
    self.slider.minimumValue = 0;
    self.slider.value = [self randomPercent] * self.slider.maximumValue;
    CGFloat originalValue = self.slider.value;

    // When
    self.slider.numberOfDiscreteValues = (NSUInteger)(self.slider.maximumValue + 1);

    // Then
    XCTAssertEqualWithAccuracy(self.slider.value, originalValue, (CGFloat)0.5 + kEpsilonAccuracy);
    XCTAssertEqualWithAccuracy(self.slider.value, round(originalValue), kEpsilonAccuracy);
  }
}

- (void)testDiscreteValuesWithFloatingPointDelta {
  for (int i = 0; i < kNumberOfRepeats; ++i) {
    // Given
    CGFloat delta = [self randomNumber] + 1;
    NSUInteger numberOfValues = arc4random_uniform(8) + 2;
    CGFloat snapedValue = arc4random_uniform((u_int32_t)numberOfValues) * delta;
    CGFloat originalValue = snapedValue + [self randomPercent] * (delta - kEpsilonAccuracy) -
                            (delta - kEpsilonAccuracy) / 2;

    self.slider = [[MDCSlider alloc] init];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = delta * (numberOfValues - 1);
    self.slider.value = originalValue;

    // When
    self.slider.numberOfDiscreteValues = numberOfValues;

    // Then
    XCTAssertEqualWithAccuracy(self.slider.value, originalValue, delta / 2 + kEpsilonAccuracy);
    XCTAssertEqualWithAccuracy(self.slider.value, snapedValue, kEpsilonAccuracy);
    if ((self.slider.value - kEpsilonAccuracy > snapedValue) ||
        (self.slider.value + kEpsilonAccuracy < snapedValue)) {
      NSLog(@"failed with difference:%f", self.slider.value - snapedValue);
    }
  }
}

#pragma mark - color

- (void)testColorDefault {
  // Then
  XCTAssertEqualObjects(self.slider.color, self.defaultBlue);
}

- (void)testColorIsNullResettable {
  // When
  self.slider.color = self.aNonDefaultColor;
  self.slider.color = nil;

  // Then
  XCTAssertEqualObjects(self.slider.color, self.defaultBlue);
}

#pragma mark - disabledColor

- (void)testDisabledColorDefault {
  // Then
  XCTAssertEqualObjects(self.slider.disabledColor, self.defaultGray);
}

- (void)testDisabledColorIsNullResettable {
  // When
  self.slider.disabledColor = self.aNonDefaultColor;
  self.slider.disabledColor = nil;

  // Then
  XCTAssertEqualObjects(self.slider.disabledColor, self.defaultGray);
}

#pragma mark - trackBackgroundColor

- (void)testTrackBackgroundColorDefault {
  // Then
  XCTAssertEqualObjects(self.slider.trackBackgroundColor, self.defaultGray);
}

- (void)testTrackBackgroundColorIsNullResettable {
  // When
  self.slider.trackBackgroundColor = self.aNonDefaultColor;
  self.slider.trackBackgroundColor = nil;

  // Then
  XCTAssertEqualObjects(self.slider.trackBackgroundColor, self.defaultGray);
}

#pragma mark - thumbColorForState

- (void)testThumbColorForStateDefaults {
  // Given
  UIColor *expectedThumbColor = MDCPalette.bluePalette.tint500;
  UIColor *expectedThumbDisabledColor =
      [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.26];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    if (state == UIControlStateDisabled) {
      XCTAssertEqualObjects([self.slider thumbColorForState:state], expectedThumbDisabledColor,
                            @"(%@) is not equal to (%@) for state (%ld)",
                            [self.slider thumbColorForState:state], expectedThumbDisabledColor,
                            (long)state);
    } else {
      XCTAssertEqualObjects([self.slider thumbColorForState:state], expectedThumbColor,
                            @"(%@) is not equal to (%@) for state (%ld)",
                            [self.slider thumbColorForState:state], expectedThumbColor,
                            (long)state);
    }
  }
}

- (void)testThumbColorForStateFallback {
  // When
  [self.slider setThumbColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.slider setThumbColor:nil forState:UIControlStateDisabled];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider thumbColorForState:state], UIColor.purpleColor,
                          @"(%@) is not equal to (%@) for state (%ld)",
                          [self.slider thumbColorForState:state], UIColor.purpleColor, (long)state);
  }
}

- (void)testThumbColorForStateAppliesToThumbTrack {
  // Given
  self.slider.statefulAPIEnabled = YES;

  // When
  [self.slider setThumbColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.slider setThumbColor:UIColor.redColor forState:UIControlStateHighlighted];
  [self.slider setThumbColor:UIColor.cyanColor forState:UIControlStateSelected];
  [self.slider setThumbColor:UIColor.grayColor forState:UIControlStateDisabled];
  [self.slider setThumbColor:UIColor.blueColor
                    forState:UIControlStateHighlighted | UIControlStateSelected];
  [self.slider setThumbColor:UIColor.blackColor
                    forState:UIControlStateDisabled | UIControlStateSelected];

  // Then
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.thumbDisabledColor,
                        [self.slider thumbColorForState:UIControlStateDisabled]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.thumbEnabledColor,
                           [self.slider thumbColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.thumbDisabledColor,
      [self.slider thumbColorForState:UIControlStateDisabled | UIControlStateSelected]);
  XCTAssertNotEqualObjects(
      self.slider.thumbTrack.thumbEnabledColor,
      [self.slider thumbColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.thumbDisabledColor,
                        [self.slider thumbColorForState:UIControlStateDisabled]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.thumbEnabledColor,
                           [self.slider thumbColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.thumbDisabledColor,
      [self.slider thumbColorForState:UIControlStateDisabled | UIControlStateSelected]);
  XCTAssertNotEqualObjects(
      self.slider.thumbTrack.thumbEnabledColor,
      [self.slider thumbColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.thumbEnabledColor,
                        [self.slider thumbColorForState:UIControlStateNormal]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.thumbDisabledColor,
                           [self.slider thumbColorForState:UIControlStateNormal]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.thumbEnabledColor,
                        [self.slider thumbColorForState:UIControlStateSelected]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.thumbDisabledColor,
                           [self.slider thumbColorForState:UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.thumbEnabledColor,
                        [self.slider thumbColorForState:UIControlStateHighlighted]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.thumbDisabledColor,
                           [self.slider thumbColorForState:UIControlStateHighlighted]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.thumbEnabledColor,
      [self.slider thumbColorForState:UIControlStateHighlighted | UIControlStateSelected]);
  XCTAssertNotEqualObjects(
      self.slider.thumbTrack.thumbDisabledColor,
      [self.slider thumbColorForState:UIControlStateHighlighted | UIControlStateSelected]);
}

- (void)testSettingThumbColorForStateHasNoEffectWhenStatefulAPIDisabled {
  // Given
  self.slider.statefulAPIEnabled = NO;
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = NO;

  // When
  [self.slider setThumbColor:UIColor.cyanColor forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.thumbEnabledColor, self.slider.color);
  XCTAssertNotEqual(self.slider.thumbTrack.thumbEnabledColor,
                    [self.slider thumbColorForState:UIControlStateNormal]);
}

- (void)testSettingThumbColorToNilResultsInClearColorOnThumbTrack {
  // Given
  self.slider.statefulAPIEnabled = YES;

  // When
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self.slider setThumbColor:nil forState:state];
  }

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.thumbEnabledColor, UIColor.clearColor);
}

#pragma mark - trackFillColorForState

- (void)testTrackFillColorForStateDefaults {
  // Given
  UIColor *expectedTrackFillColor = MDCPalette.bluePalette.tint500;

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider trackFillColorForState:state], expectedTrackFillColor,
                          @"(%@) is not equal to (%@) for state (%ld)",
                          [self.slider trackFillColorForState:state], expectedTrackFillColor,
                          (long)state);
  }
}

- (void)testTrackFillColorForStateFallback {
  // When
  [self.slider setTrackFillColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider trackFillColorForState:state], UIColor.purpleColor,
                          @"(%@) is not equal to (%@) for state (%ld)",
                          [self.slider trackFillColorForState:state], UIColor.purpleColor,
                          (long)state);
  }
}

- (void)testTrackFillColorForStateAppliesToThumbTrack {
  // Given
  self.slider.statefulAPIEnabled = YES;

  // When
  [self.slider setTrackFillColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.slider setTrackFillColor:UIColor.redColor forState:UIControlStateHighlighted];
  [self.slider setTrackFillColor:UIColor.cyanColor forState:UIControlStateSelected];
  [self.slider setTrackFillColor:UIColor.grayColor forState:UIControlStateDisabled];
  [self.slider setTrackFillColor:UIColor.orangeColor
                        forState:UIControlStateHighlighted | UIControlStateSelected];
  [self.slider setTrackFillColor:UIColor.blackColor
                        forState:UIControlStateDisabled | UIControlStateSelected];

  // Then
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnColor,
                        [self.slider trackFillColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.trackOnColor,
      [self.slider trackFillColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnColor,
                        [self.slider trackFillColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.trackOnColor,
      [self.slider trackFillColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnColor,
                        [self.slider trackFillColorForState:UIControlStateNormal]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.trackDisabledColor,
                           [self.slider trackFillColorForState:UIControlStateNormal]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnColor,
                        [self.slider trackFillColorForState:UIControlStateSelected]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.trackDisabledColor,
                           [self.slider trackFillColorForState:UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnColor,
                        [self.slider trackFillColorForState:UIControlStateHighlighted]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.trackDisabledColor,
                           [self.slider trackFillColorForState:UIControlStateHighlighted]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.trackOnColor,
      [self.slider trackFillColorForState:UIControlStateHighlighted | UIControlStateSelected]);
  XCTAssertNotEqualObjects(
      self.slider.thumbTrack.trackDisabledColor,
      [self.slider trackFillColorForState:UIControlStateHighlighted | UIControlStateSelected]);
}

- (void)testSettingTrackFillColorForStateHasNoEffectWhenStatefulAPIDisabled {
  // Given
  self.slider.statefulAPIEnabled = NO;
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = NO;

  // When
  [self.slider setTrackFillColor:UIColor.cyanColor forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnColor, self.slider.color);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.trackOnColor,
                           [self.slider trackFillColorForState:UIControlStateNormal]);
}

- (void)testSettingTrackFillColorToNilResultsInClearColorOnThumbTrack {
  // Given
  self.slider.statefulAPIEnabled = YES;

  // When
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self.slider setTrackFillColor:nil forState:state];
  }

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnColor, UIColor.clearColor);
}

#pragma mark - trackBackgroundColorForState

- (void)testTrackBackgroundColorForStateDefaults {
  // Given
  UIColor *expectedDefaultTrackOffColor =
      [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.26];
  UIColor *expectedDisabledTrackOffColor =
      [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.26];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    if (state == UIControlStateDisabled) {
      XCTAssertEqualObjects([self.slider trackBackgroundColorForState:state],
                            expectedDisabledTrackOffColor);
    } else {
      XCTAssertEqualObjects([self.slider trackBackgroundColorForState:state],
                            expectedDefaultTrackOffColor,
                            @"(%@) is not equal to (%@) for state (%ld)",
                            [self.slider trackBackgroundColorForState:state],
                            expectedDefaultTrackOffColor, (long)state);
    }
  }
}

- (void)testTrackBackgroundColorForStateFallback {
  // When
  [self.slider setTrackBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.slider setTrackBackgroundColor:nil forState:UIControlStateDisabled];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider trackBackgroundColorForState:state], UIColor.purpleColor,
                          @"(%@) is not equal to (%@) for state (%ld)",
                          [self.slider trackBackgroundColorForState:state], UIColor.purpleColor,
                          (long)state);
  }
}

- (void)testTrackBackgroundColorForStateAppliesToThumbTrack {
  // Given
  self.slider.statefulAPIEnabled = YES;

  // When
  [self.slider setTrackFillColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.slider setTrackFillColor:UIColor.redColor forState:UIControlStateHighlighted];
  [self.slider setTrackFillColor:UIColor.cyanColor forState:UIControlStateSelected];
  [self.slider setTrackFillColor:UIColor.grayColor forState:UIControlStateDisabled];
  [self.slider setTrackFillColor:UIColor.orangeColor
                        forState:UIControlStateHighlighted | UIControlStateSelected];
  [self.slider setTrackFillColor:UIColor.blackColor
                        forState:UIControlStateDisabled | UIControlStateSelected];

  // Then
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackDisabledColor,
                        [self.slider trackBackgroundColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.trackOffColor,
      [self.slider trackBackgroundColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffColor,
                        [self.slider trackBackgroundColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.trackOffColor,
      [self.slider trackBackgroundColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffColor,
                        [self.slider trackBackgroundColorForState:UIControlStateNormal]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffColor,
                        [self.slider trackBackgroundColorForState:UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffColor,
                        [self.slider trackBackgroundColorForState:UIControlStateHighlighted]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffColor,
                        [self.slider trackBackgroundColorForState:UIControlStateHighlighted |
                                                                  UIControlStateSelected]);
}

- (void)testSettingTrackBackgroundColorForStateHasNoEffectWhenStatefulAPIDisabled {
  // Given
  self.slider.statefulAPIEnabled = NO;
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = NO;

  // When
  [self.slider setTrackBackgroundColor:UIColor.orangeColor forState:UIControlStateDisabled];

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.trackDisabledColor, self.slider.disabledColor);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.trackDisabledColor,
                           [self.slider trackFillColorForState:UIControlStateDisabled]);
  XCTAssertNotEqualObjects(self.slider.thumbTrack.trackOffColor,
                           [self.slider trackFillColorForState:UIControlStateDisabled]);
}

#pragma mark - filledTrackTickColorForState

- (void)testFilledTrackTickColorForStateDefaults {
  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider filledTrackTickColorForState:state], UIColor.blackColor);
  }
}

- (void)testFilledTrackTickColorForStateFallback {
  // When
  [self.slider setFilledTrackTickColor:UIColor.orangeColor forState:UIControlStateNormal];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider filledTrackTickColorForState:state], UIColor.orangeColor,
                          @"(%@) is not equal to (%@) for state (%ld)",
                          [self.slider filledTrackTickColorForState:state], UIColor.orangeColor,
                          (long)state);
  }
}

- (void)testFilledTrackTickColorForStateAppliesToThumbTrack {
  // Given
  self.slider.statefulAPIEnabled = YES;

  // When
  [self.slider setFilledTrackTickColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.slider setFilledTrackTickColor:UIColor.redColor forState:UIControlStateHighlighted];
  [self.slider setFilledTrackTickColor:UIColor.cyanColor forState:UIControlStateSelected];
  [self.slider setFilledTrackTickColor:UIColor.grayColor forState:UIControlStateDisabled];
  [self.slider setFilledTrackTickColor:UIColor.orangeColor
                              forState:UIControlStateHighlighted | UIControlStateSelected];
  [self.slider setFilledTrackTickColor:UIColor.yellowColor
                              forState:UIControlStateDisabled | UIControlStateSelected];

  // Then
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnTickColor,
                        [self.slider filledTrackTickColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.trackOnTickColor,
      [self.slider filledTrackTickColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnTickColor,
                        [self.slider filledTrackTickColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(
      self.slider.thumbTrack.trackOnTickColor,
      [self.slider filledTrackTickColorForState:UIControlStateDisabled | UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnTickColor,
                        [self.slider filledTrackTickColorForState:UIControlStateNormal]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnTickColor,
                        [self.slider filledTrackTickColorForState:UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnTickColor,
                        [self.slider filledTrackTickColorForState:UIControlStateHighlighted]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOnTickColor,
                        [self.slider filledTrackTickColorForState:UIControlStateHighlighted |
                                                                  UIControlStateSelected]);
}

#pragma mark - backgroundTrackTickColorForState

- (void)testBackgroundTrackTickColorForStateDefaults {
  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider backgroundTrackTickColorForState:state], UIColor.blackColor);
  }
}

- (void)testBackgroundTrackTickColorForStateFallback {
  // When
  [self.slider setBackgroundTrackTickColor:UIColor.orangeColor forState:UIControlStateNormal];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.slider backgroundTrackTickColorForState:state], UIColor.orangeColor,
                          @"(%@) is not equal to (%@) for state (%ld)",
                          [self.slider backgroundTrackTickColorForState:state], UIColor.orangeColor,
                          (long)state);
  }
}

- (void)testBackgroundTrackTickColorForStateAppliesToThumbTrack {
  // Given
  self.slider.statefulAPIEnabled = YES;

  // When
  [self.slider setBackgroundTrackTickColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.slider setBackgroundTrackTickColor:UIColor.redColor forState:UIControlStateHighlighted];
  [self.slider setBackgroundTrackTickColor:UIColor.cyanColor forState:UIControlStateSelected];
  [self.slider setBackgroundTrackTickColor:UIColor.grayColor forState:UIControlStateDisabled];
  [self.slider setBackgroundTrackTickColor:UIColor.orangeColor
                                  forState:UIControlStateHighlighted | UIControlStateSelected];
  [self.slider setBackgroundTrackTickColor:UIColor.yellowColor
                                  forState:UIControlStateDisabled | UIControlStateSelected];

  // Then
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateDisabled |
                                                                      UIControlStateSelected]);
  self.slider.enabled = NO;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateDisabled]);
  self.slider.enabled = NO;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateDisabled |
                                                                      UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateNormal]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = NO;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateSelected]);
  self.slider.enabled = YES;
  self.slider.selected = NO;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateHighlighted]);
  self.slider.enabled = YES;
  self.slider.selected = YES;
  self.slider.highlighted = YES;
  XCTAssertEqualObjects(self.slider.thumbTrack.trackOffTickColor,
                        [self.slider backgroundTrackTickColorForState:UIControlStateHighlighted |
                                                                      UIControlStateSelected]);
}

#pragma mark - trackTickVisibility

- (void)testTrackTickVisibilityDefaultForNonDiscreteSlider {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.discrete = NO;

  // Then
  XCTAssertEqual(slider.trackTickVisibility, MDCSliderTrackTickVisibilityWhenDragging);
}

- (void)testTrackTickVisibilityDefaultForDiscreteSlider {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.numberOfDiscreteValues = 2;

  // Then
  XCTAssertEqual(slider.trackTickVisibility, MDCSliderTrackTickVisibilityWhenDragging);
}

#pragma mark - InkColor

- (void)testInkColorDefault {
  // Then
  XCTAssertEqualObjects(self.slider.inkColor, self.slider.thumbTrack.inkColor);
}

- (void)testSetInkColor {
  // When
  self.slider.inkColor = UIColor.orangeColor;

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.inkColor, UIColor.orangeColor);
}

#pragma mark - Thumb

- (void)testThumbRadiusDefault {
  // Then
  XCTAssertEqualWithAccuracy(self.slider.thumbRadius, 6, kEpsilonAccuracy);
}

- (void)testThumbElevationDefault {
  // Then
  XCTAssertEqualWithAccuracy(self.slider.thumbElevation, MDCShadowElevationNone, kEpsilonAccuracy);
}

#pragma mark Numeric value label

- (void)testNumericValueLabelString {
  MDCThumbTrack *track = nil;
  for (UIView *view in self.slider.subviews) {
    if ([view isKindOfClass:[MDCThumbTrack class]]) {
      track = (MDCThumbTrack *)view;
      break;
    }
  }
  XCTAssertNotEqualObjects(track, nil);

  // With
  NSNumberFormatter *testFormatter = [[NSNumberFormatter alloc] init];

  // Then
  XCTAssertEqualObjects(
      [testFormatter numberFromString:[self.slider thumbTrack:track stringForValue:1]], @(1.));
  XCTAssertEqualObjects([testFormatter numberFromString:[self.slider thumbTrack:track
                                                                 stringForValue:(CGFloat)0.57]],
                        @(0.57));
  XCTAssertEqualObjects(
      [testFormatter numberFromString:[self.slider thumbTrack:track
                                               stringForValue:(CGFloat)0.33333333]],
      @(0.333));
}

- (void)testValueLabelTextColorDefalut {
  // Then
  XCTAssertEqualObjects(self.slider.valueLabelTextColor, UIColor.whiteColor);
}

- (void)testSetValueLabelTextColor {
  // When
  self.slider.valueLabelTextColor = UIColor.cyanColor;

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.valueLabelTextColor, UIColor.cyanColor);
}

- (void)testValueLabelTextColorNullResettable {
  // When
  self.slider.valueLabelTextColor = UIColor.cyanColor;
  self.slider.valueLabelTextColor = nil;

  // Then
  XCTAssertEqualObjects(self.slider.valueLabelTextColor, UIColor.whiteColor);
}

- (void)testValueLabelBackgroundColorDefault {
  // Then
  XCTAssertEqualObjects(self.slider.valueLabelBackgroundColor, MDCPalette.bluePalette.tint500);
}

- (void)testSetValueLabelBackgroundColor {
  // When
  self.slider.valueLabelBackgroundColor = UIColor.magentaColor;

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.valueLabelBackgroundColor, UIColor.magentaColor);
}

- (void)testValueLabelBackgroundColorNullResettable {
  // When
  self.slider.valueLabelBackgroundColor = UIColor.magentaColor;
  self.slider.valueLabelBackgroundColor = nil;

  // Then
  XCTAssertEqualObjects(self.slider.valueLabelBackgroundColor, MDCPalette.bluePalette.tint500);
}

#pragma mark Accessibility

// This test is flaky.
/*
 Test Case '-[SliderTests testAccessibilityValue]' started.
 components/Slider/tests/unit/SliderTests.m:1000: error: -[SliderTests testAccessibilityValue] :
 (([self.slider accessibilityValue]) equal to (expected)) failed: ("30%") is not equal to ("29%")
 Test Case '-[SliderTests testAccessibilityValue]' failed (0.002 seconds).
 */
- (void)disabled_testAccessibilityValue {
  // Given
  CGFloat newValue = [self randomPercent];

  // When
  self.slider.value = newValue;

  // Then
  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
  NSString *expected =
      [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(float)self.slider.value]];
  XCTAssertEqualObjects([self.slider accessibilityValue], expected);
}

- (void)testAccessibilityValueWithLargerMax {
  // Given
  self.slider.maximumValue = [self randomNumber];
  CGFloat newValue = [self randomPercent];

  // When
  self.slider.value = newValue;

  // Then
  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
  CGFloat percent = (self.slider.value - self.slider.minimumValue) /
                    (self.slider.maximumValue - self.slider.minimumValue);
  NSString *expected = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(float)percent]];
  XCTAssertEqualObjects([self.slider accessibilityValue], expected);
}

- (void)testAccessibilityIncrementForNonDiscreteSlider {
  // Given
  self.slider.value = [self randomPercent] - (CGFloat)0.1;
  CGFloat expectedValue = self.slider.value + (CGFloat)0.1;

  // When
  [self.slider accessibilityIncrement];

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, expectedValue, kEpsilonAccuracy);
}

- (void)testAccessibilityDecrementForNonDiscreteSlider {
  // Given
  self.slider.value = [self randomPercent] + (CGFloat)0.1;
  CGFloat expectedValue = self.slider.value - (CGFloat)0.1;

  // When
  [self.slider accessibilityDecrement];

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, expectedValue, kEpsilonAccuracy);
}

- (void)testAccessibilityActivateForNonDiscreteSlider {
  // Given
  self.slider.value = 0;

  // When
  [self.slider accessibilityActivate];
  CGFloat newValue = (self.slider.maximumValue - self.slider.minimumValue) / 6;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, newValue, kEpsilonAccuracy);
}

- (void)testAccessibilityIncrementWithLargerMaxForNonDiscreteSlider {
  // Given
  self.slider.maximumValue = [self randomNumber];
  self.slider.value = ([self randomPercent] - (CGFloat)0.1) * self.slider.maximumValue;
  CGFloat expectedValue = self.slider.value + (CGFloat)0.1 * self.slider.maximumValue;

  // When
  [self.slider accessibilityIncrement];

  // Then
  XCTAssertEqualWithAccuracy(self.slider.value, expectedValue, kEpsilonAccuracy);
}

- (void)testAccessibilityTraits {
  // Given
  self.slider.enabled =
      (BOOL)arc4random_uniform(2);  // It does not matter if the slider is enabled or disabled.

  // Then
  XCTAssertTrue(self.slider.accessibilityTraits & UIAccessibilityTraitAdjustable);
}

- (void)testAccessibilityIncrementForDiscreteSlider {
  // Given
  self.slider.discrete = YES;
  for (NSUInteger i = 2; i < 20; ++i) {
    self.slider.numberOfDiscreteValues = i;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.value = self.slider.minimumValue;

    // When
    [self.slider accessibilityIncrement];

    // Then
    CGFloat stepValue = (self.slider.maximumValue - self.slider.minimumValue) /
                        (self.slider.numberOfDiscreteValues - 1);
    CGFloat expectedValue = self.slider.minimumValue + stepValue;
    XCTAssertEqualWithAccuracy(self.slider.value, expectedValue, kEpsilonAccuracy,
                               @"A slider with (%lu) discrete values should have step of '%.3f'.",
                               (unsigned long)self.slider.numberOfDiscreteValues, stepValue);
  }
}

- (void)testAccessibilityDecrementForDiscreteSlider {
  // Given
  self.slider.discrete = YES;
  for (NSUInteger i = 2; i < 20; ++i) {
    self.slider.numberOfDiscreteValues = i;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.value = self.slider.maximumValue;

    // When
    [self.slider accessibilityDecrement];

    // Then
    CGFloat stepValue = (self.slider.maximumValue - self.slider.minimumValue) /
                        (self.slider.numberOfDiscreteValues - 1);
    CGFloat expectedValue = self.slider.maximumValue - stepValue;
    XCTAssertEqualWithAccuracy(self.slider.value, expectedValue, kEpsilonAccuracy,
                               @"A slider with (%lu) discrete values should have step of '%.3f'.",
                               (unsigned long)self.slider.numberOfDiscreteValues, stepValue);
  }
}

/**
 When the number of discrete values results in a step size smaller than the non-discrete value of
 10%, use that value. Otherwise use 10% of the total range.
 */
- (void)testAccessibilityIncrementForNonDiscreteSliderWithDiscreteValuesUsesAdaptiveStepSize {
  // Given
  self.slider.discrete = NO;
  for (NSUInteger i = 2; i < 20; ++i) {
    self.slider.numberOfDiscreteValues = i;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.value = self.slider.minimumValue;

    // When
    [self.slider accessibilityIncrement];

    // Then
    CGFloat sliderRange = self.slider.maximumValue - self.slider.minimumValue;
    CGFloat nonDiscreteStepValue = (CGFloat)(0.1 * sliderRange);
    CGFloat discreteStepValue = sliderRange / (self.slider.numberOfDiscreteValues - 1);
    CGFloat stepValue = MIN(nonDiscreteStepValue, discreteStepValue);
    CGFloat expectedValue = self.slider.minimumValue + stepValue;
    XCTAssertEqualWithAccuracy(self.slider.value, expectedValue, kEpsilonAccuracy,
                               @"A slider with (%lu) discrete values should have step of '%.3f'.",
                               (unsigned long)self.slider.numberOfDiscreteValues, stepValue);
  }
}

/**
 When the number of discrete values results in a step size smaller than the non-discrete value of
 10%, use that value. Otherwise use 10% of the total range.
 */
- (void)testAccessibilityDecrementForNonDiscreteSliderWithDiscreteValuesUsesAdaptiveStepSize {
  // Given
  self.slider.discrete = NO;
  for (NSUInteger i = 2; i < 20; ++i) {
    self.slider.numberOfDiscreteValues = i;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.value = self.slider.maximumValue;

    // When
    [self.slider accessibilityDecrement];

    // Then
    CGFloat sliderRange = self.slider.maximumValue - self.slider.minimumValue;
    CGFloat nonDiscreteStepValue = (CGFloat)(0.1 * sliderRange);
    CGFloat discreteStepValue = sliderRange / (self.slider.numberOfDiscreteValues - 1);
    CGFloat stepValue = MIN(nonDiscreteStepValue, discreteStepValue);
    CGFloat expectedValue = self.slider.maximumValue - stepValue;
    XCTAssertEqualWithAccuracy(self.slider.value, expectedValue, kEpsilonAccuracy,
                               @"A slider with (%lu) discrete values should have step of '%.3f'.",
                               (unsigned long)self.slider.numberOfDiscreteValues, stepValue);
  }
}

- (void)testDefaultHapticsEnabledValue {
  if (@available(iOS 10.0, *)) {
    // Then
    XCTAssertTrue(self.slider.hapticsEnabled);
  } else {
    XCTAssertFalse(self.slider.hapticsEnabled);
  }
}

- (void)testDefaultsSouldEnableHapticsForAllDiscreteValuesValue {
  if (@available(iOS 10.0, *)) {
    for (NSUInteger i = 0; i < 5; ++i) {
      // When
      self.slider.numberOfDiscreteValues = i;

      // Then
      XCTAssertFalse(self.slider.shouldEnableHapticsForAllDiscreteValues);
    }
  }
}

- (void)testSettingShouldEnableHapticsForAllDiscreteValuesValue {
  if (@available(iOS 10.0, *)) {
    for (NSUInteger i = 0; i < 5; ++i) {
      // When
      self.slider.numberOfDiscreteValues = i;
      self.slider.shouldEnableHapticsForAllDiscreteValues = YES;

      // Then
      if (i == 0 || i == 1) {
        XCTAssertFalse(self.slider.shouldEnableHapticsForAllDiscreteValues);
      } else {
        XCTAssertTrue(self.slider.shouldEnableHapticsForAllDiscreteValues);
      }
    }
  }
}

- (void)testEnabledHapticFeedback {
  // Given
  self.slider.minimumValue = 0;
  self.slider.maximumValue = 5;
  self.slider.hapticsEnabled = YES;

  if (@available(iOS 10.0, *)) {
    _mockFeedbackGenerator = [[MockUIImpactFeedbackGenerator alloc] init];
    self.slider.feedbackGenerator = _mockFeedbackGenerator;
    for (NSUInteger i = 0; i < 6; ++i) {
      self.slider.value = i;

      // When
      [self.slider thumbTrackValueChanged:self.slider.thumbTrack];

      // Then
      if (i == 0 || i == 5) {
        XCTAssertTrue(_mockFeedbackGenerator.impactHasOccurred);
      } else {
        XCTAssertFalse(_mockFeedbackGenerator.impactHasOccurred);
      }
      _mockFeedbackGenerator.impactHasOccurred = NO;
    }
  }
}

- (void)testNotEnabledHapticFeedback {
  // Given
  self.slider.minimumValue = 0;
  self.slider.maximumValue = 5;
  self.slider.hapticsEnabled = NO;

  if (@available(iOS 10.0, *)) {
    _mockFeedbackGenerator = [[MockUIImpactFeedbackGenerator alloc] init];
    self.slider.feedbackGenerator = _mockFeedbackGenerator;
    for (NSUInteger i = 0; i < 6; ++i) {
      self.slider.value = i;

      // When
      [self.slider thumbTrackValueChanged:self.slider.thumbTrack];

      // Then
      XCTAssertFalse(_mockFeedbackGenerator.impactHasOccurred);

      _mockFeedbackGenerator.impactHasOccurred = NO;
    }
  }
}

- (void)testEnabledFullHapticNotEnabledHapticFeedback {
  // Given
  self.slider.minimumValue = 0;
  self.slider.maximumValue = 5;
  self.slider.hapticsEnabled = NO;
  self.slider.numberOfDiscreteValues = 2;
  self.slider.shouldEnableHapticsForAllDiscreteValues = YES;

  if (@available(iOS 10.0, *)) {
    _mockFeedbackGenerator = [[MockUIImpactFeedbackGenerator alloc] init];
    self.slider.feedbackGenerator = _mockFeedbackGenerator;
    for (NSUInteger i = 0; i < 6; ++i) {
      self.slider.value = i;

      // When
      [self.slider thumbTrackValueChanged:self.slider.thumbTrack];

      // Then
      XCTAssertFalse(_mockFeedbackGenerator.impactHasOccurred);

      _mockFeedbackGenerator.impactHasOccurred = NO;
    }
  }
}

- (void)testEnabledFullHapticFeedback {
  // Given
  self.slider.minimumValue = 0;
  self.slider.maximumValue = 5;
  self.slider.hapticsEnabled = YES;
  self.slider.numberOfDiscreteValues = 6;
  self.slider.shouldEnableHapticsForAllDiscreteValues = YES;

  if (@available(iOS 10.0, *)) {
    _mockFeedbackGenerator = [[MockUIImpactFeedbackGenerator alloc] init];
    self.slider.feedbackGenerator = _mockFeedbackGenerator;
    for (NSUInteger i = 0; i < 6; ++i) {
      self.slider.thumbTrack.value = i;

      // When
      [self.slider thumbTrackValueChanged:self.slider.thumbTrack];

      // Then
      XCTAssertTrue(_mockFeedbackGenerator.impactHasOccurred);

      _mockFeedbackGenerator.impactHasOccurred = NO;
    }
  }
}

- (void)testHapticFeedbackAcrossAnchor {
  // Given
  self.slider.minimumValue = 0;
  self.slider.maximumValue = 9;
  self.slider.hapticsEnabled = YES;
  self.slider.filledTrackAnchorValue = 4.5;

  if (@available(iOS 10.0, *)) {
    _mockFeedbackGenerator = [[MockUIImpactFeedbackGenerator alloc] init];
    self.slider.feedbackGenerator = _mockFeedbackGenerator;
    for (NSUInteger i = 1; i < 9; i++) {
      self.slider.thumbTrack.value = i;

      // When
      [self.slider thumbTrackValueChanged:self.slider.thumbTrack];

      // Then
      if (i == 5) {
        XCTAssertTrue(_mockFeedbackGenerator.impactHasOccurred);
      } else {
        XCTAssertFalse(_mockFeedbackGenerator.impactHasOccurred);
      }
      _mockFeedbackGenerator.impactHasOccurred = NO;
    }
  }
}

- (void)testHapticFeedbackAtAnchor {
  // Given
  self.slider.minimumValue = 0;
  self.slider.maximumValue = 10;
  self.slider.hapticsEnabled = YES;
  self.slider.filledTrackAnchorValue = 5;

  if (@available(iOS 10.0, *)) {
    _mockFeedbackGenerator = [[MockUIImpactFeedbackGenerator alloc] init];
    self.slider.feedbackGenerator = _mockFeedbackGenerator;
    for (NSUInteger i = 1; i < 10; i++) {
      self.slider.thumbTrack.value = i;

      // When
      [self.slider thumbTrackValueChanged:self.slider.thumbTrack];

      // Then
      if (i == 5) {
        XCTAssertTrue(_mockFeedbackGenerator.impactHasOccurred);
      } else {
        XCTAssertFalse(_mockFeedbackGenerator.impactHasOccurred);
      }
      _mockFeedbackGenerator.impactHasOccurred = NO;
    }
  }
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCSlider *passedSlider = nil;
  self.slider.traitCollectionDidChangeBlock =
      ^(MDCSlider *_Nonnull slider, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedSlider = slider;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.slider traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedSlider, self.slider);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

#pragma mark - MaterialElevation

- (void)testDefaultBaseElevationOverrideIsNegative {
  // Then
  XCTAssertLessThan(self.slider.mdc_overrideBaseElevation, 0);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat expectedBaseElevation = 99;

  // When
  self.slider.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testCurrentElevationMatchesElevationWhenElevationChanges {
  // When
  self.slider.thumbElevation = 77;

  // Then
  XCTAssertEqualWithAccuracy(self.slider.mdc_currentElevation, self.slider.thumbElevation, 0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  self.slider.thumbElevation = 5;
  __block BOOL blockCalled = NO;
  self.slider.mdc_elevationDidChangeBlock =
      ^(id<MDCElevatable> _Nonnull object, CGFloat absoluteElevation) {
        blockCalled = YES;
      };

  // When
  self.slider.thumbElevation = self.slider.thumbElevation + 1;

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  self.slider.thumbElevation = 5;
  __block BOOL blockCalled = NO;
  self.slider.mdc_elevationDidChangeBlock =
      ^(id<MDCElevatable> _Nonnull object, CGFloat absoluteElevation) {
        blockCalled = YES;
      };

  // When
  self.slider.thumbElevation = self.slider.thumbElevation;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testDiscreteValueLabelFontDefaultValue {
  // Then
  XCTAssertEqualObjects(self.slider.discreteValueLabelFont,
                        [[MDCTypography fontLoader] regularFontOfSize:12]);
}

- (void)testDiscreteValueLabelFontSettingToNilValue {
  // Given
  self.slider.discreteValueLabelFont = [UIFont systemFontOfSize:20];

  // When
  self.slider.discreteValueLabelFont = nil;

  // Then
  XCTAssertEqualObjects(self.slider.discreteValueLabelFont,
                        [[MDCTypography fontLoader] regularFontOfSize:12]);
}

#pragma mark Private test helpers

- (CGFloat)randomNumber {
  return arc4random_uniform(1000) / (CGFloat)(arc4random_uniform(9) + 1);
}

- (CGFloat)randomPercent {
  return (CGFloat)(arc4random_uniform(1001)) / 1000;
}

@end
