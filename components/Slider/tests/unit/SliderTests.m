/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialPalettes.h"
#import "MaterialThumbTrack.h"
#import "MaterialSlider.h"

static const int kNumberOfRepeats = 20;
static const CGFloat kEpsilonAccuracy = 0.001f;

@interface MDCSlider (TestInterface)

- (NSString *)thumbTrack:(MDCThumbTrack *)thumbTrack stringForValue:(CGFloat)value;

@end

@interface SliderTests : XCTestCase
@property(nonatomic, nonnull) MDCSlider *slider;
@property(nonatomic, nonnull) UIColor *aNonDefaultColor;
@property(nonatomic, nonnull) UIColor *defaultBlue;
@property(nonatomic, nonnull) UIColor *defaultGray;
@end

@implementation SliderTests

- (void)setUp {
  [super setUp];
  self.slider = [[MDCSlider alloc] init];
  self.aNonDefaultColor = [UIColor orangeColor];
  self.defaultBlue = MDCPalette.bluePalette.tint500;
  self.defaultGray = [[UIColor blackColor] colorWithAlphaComponent:0.26f];
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
  XCTAssertEqualWithAccuracy(self.slider.maximumValue, 1.0f, kEpsilonAccuracy);
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
    XCTAssertEqualWithAccuracy(self.slider.value, originalValue, 0.5f + kEpsilonAccuracy);
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

#pragma mark Colors

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

#pragma mark Thumb

- (void)testThumbRadiusDefault {
  // Then
  XCTAssertEqual(self.slider.thumbRadius, 6);
}

- (void)testThumbElevationDefault {
  // Then
  XCTAssertEqual(self.slider.thumbElevation, MDCShadowElevationNone);
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
      [testFormatter numberFromString:[self.slider thumbTrack:track stringForValue:1.f]], @(1.));
  XCTAssertEqualObjects(
      [testFormatter numberFromString:[self.slider thumbTrack:track stringForValue:0.57f]],
      @(0.57));
  XCTAssertEqualObjects(
      [testFormatter numberFromString:[self.slider thumbTrack:track stringForValue:0.33333333f]],
      @(0.333));
}

#pragma mark Accessibility

- (void)testAccessibilityValue {
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

- (void)testAccessibilityIncrement {
  // Given
  self.slider.value = [self randomPercent] - 0.1f;
  CGFloat originalValue = self.slider.value;

  // When
  [self.slider accessibilityIncrement];

  // Then
  XCTAssertEqual(originalValue + 0.1f, self.slider.value);
}

- (void)testAccessibilityDecrement {
  // Given
  self.slider.value = [self randomPercent] + 0.1f;
  CGFloat originalValue = self.slider.value;

  // When
  [self.slider accessibilityDecrement];

  // Then
  XCTAssertEqual(originalValue - 0.1f, self.slider.value);
}

- (void)testAccessibilityIncrementWithLargerMax {
  // Given
  self.slider.maximumValue = [self randomNumber];
  self.slider.value = ([self randomPercent] - 0.1f) * self.slider.maximumValue;
  CGFloat originalValue = self.slider.value;

  // When
  [self.slider accessibilityIncrement];

  // Then
  XCTAssertEqual(originalValue + 0.1f * self.slider.maximumValue, self.slider.value);
}

- (void)testAccessibilityTraits {
  // Given
  self.slider.enabled =
      (BOOL)arc4random_uniform(2);  // It does not matter if the slider is enabled or disabled.

  // Then
  XCTAssertTrue(self.slider.accessibilityTraits & UIAccessibilityTraitAdjustable);
}

#pragma mark Private test helpers

- (CGFloat)randomNumber {
  return arc4random_uniform(1000) / (CGFloat)(arc4random_uniform(9) + 1);
}

- (CGFloat)randomPercent {
  return (CGFloat)(arc4random_uniform(1001)) / 1000;
}

@end
