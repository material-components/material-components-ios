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

#import "MaterialThumbTrack.h"
#import "MaterialSlider.h"

static const int kNumberOfRepeats = 20;
static const CGFloat kEpsilonAccuracy = 0.001f;

// Blue 500 from https://material.io/guidelines/style/color.html#color-color-palette .
static const uint32_t MDCBlueColor = 0x2196F3;

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *MDCColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

@interface MDCSlider (TestInterface)

- (NSString *)thumbTrack:(MDCThumbTrack *)thumbTrack stringForValue:(CGFloat)value;

@end

@interface SliderTests : XCTestCase

@end

@implementation SliderTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in
  // the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in
  // the class.
  [super tearDown];
}

- (void)testValue {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  CGFloat value = [self randomPercent] * slider.maximumValue;

  // When
  [slider setValue:value animated:YES];

  // Then
  XCTAssertEqualWithAccuracy(slider.value, value, kEpsilonAccuracy);
}

- (void)testValueAnimated {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  CGFloat value = [self randomPercent] * slider.maximumValue;

  // When
  [slider setValue:value animated:YES];

  // Then
  XCTAssertEqualWithAccuracy(slider.value, value, kEpsilonAccuracy);
}

- (void)testMaximumDefault {
  // When
  MDCSlider *slider = [[MDCSlider alloc] init];

  // Then
  XCTAssertEqualWithAccuracy(slider.maximumValue, 1.0f, kEpsilonAccuracy);
}

- (void)testSetValueToHigherThanMaximum {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.value = slider.maximumValue + [self randomNumber];

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.maximumValue, kEpsilonAccuracy);
}

- (void)testSetValueToLowerThanMinimum {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.value = slider.minimumValue - [self randomNumber];

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testSetMaximumToLowerThanValue {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = [self randomNumber];
  slider.value =
      slider.minimumValue + [self randomPercent] * (slider.maximumValue - slider.minimumValue);

  // When
  slider.maximumValue = slider.value - [self randomPercent] * slider.value;

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.maximumValue, kEpsilonAccuracy);
}

- (void)testSetMinimumToHigherThanValue {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = [self randomNumber];
  slider.value =
      slider.minimumValue + [self randomPercent] * (slider.maximumValue - slider.minimumValue);

  // When
  slider.minimumValue = slider.value + [self randomPercent] * slider.value;

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testSetMaximumToLowerThanMinimum {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  CGFloat newMax = slider.minimumValue - [self randomNumber];

  // When
  slider.maximumValue = newMax;

  // Then
  XCTAssertEqualWithAccuracy(slider.maximumValue, slider.minimumValue, kEpsilonAccuracy,
                             @"setting the slider's max to lower than the max must equal the min");
  XCTAssertEqualWithAccuracy(
      newMax, slider.minimumValue, kEpsilonAccuracy,
      @"setting the slider's max must change the min when smaller than the min");
  XCTAssertEqualWithAccuracy(
      newMax, slider.maximumValue, kEpsilonAccuracy,
      @"setting the slider's max must equal the value gotten even when smaller than the minimum");
  XCTAssertEqualWithAccuracy(
      newMax, slider.value, kEpsilonAccuracy,
      @"setting the slider's min to lower than the value must change the value also");
}

- (void)testSetMinimumToLowerThanMaximum {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  CGFloat newMin = slider.maximumValue + [self randomNumber];

  // When
  slider.minimumValue = newMin;

  // Then
  XCTAssertEqualWithAccuracy(slider.minimumValue, slider.maximumValue, kEpsilonAccuracy,
                             @"setting the slider's min to higher than the max must equal the max");
  XCTAssertEqualWithAccuracy(
      newMin, slider.minimumValue, kEpsilonAccuracy,
      @"setting the slider's min must equal the value gotten even when larger than the maximum");
  XCTAssertEqualWithAccuracy(
      newMin, slider.maximumValue, kEpsilonAccuracy,
      @"setting the slider's min to larger than the max must change the max also");
  XCTAssertEqualWithAccuracy(
      newMin, slider.value, kEpsilonAccuracy,
      @"setting the slider's min to higher than the value must change the value also");
}

- (void)testDiscreteValues2 {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = 10;
  slider.minimumValue = 0;
  slider.value = arc4random_uniform((u_int32_t)(slider.maximumValue / 2));

  // When
  slider.numberOfDiscreteValues = 2;

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues2SetValue {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = 10;
  slider.minimumValue = 0;
  slider.numberOfDiscreteValues = 2;

  // When
  slider.value = arc4random_uniform((u_int32_t)(slider.maximumValue / 2));

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues3 {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = 100;
  slider.minimumValue = 0;
  slider.value = arc4random_uniform((u_int32_t)(slider.maximumValue / 6));

  // When
  slider.numberOfDiscreteValues = 3;

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues3SetValue {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = 100;
  slider.minimumValue = 0;
  slider.numberOfDiscreteValues = 3;

  // When
  slider.value = arc4random_uniform((u_int32_t)(slider.maximumValue / 6));

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValuesWithIntegers {
  for (int i = 0; i < kNumberOfRepeats; ++i) {
    // Given
    MDCSlider *slider = [[MDCSlider alloc] init];
    slider.maximumValue = (int)[self randomNumber];
    slider.minimumValue = 0;
    slider.value = [self randomPercent] * slider.maximumValue;
    CGFloat originalValue = slider.value;

    // When
    slider.numberOfDiscreteValues = (NSUInteger)(slider.maximumValue + 1);

    // Then
    XCTAssertEqualWithAccuracy(slider.value, originalValue, 0.5f + kEpsilonAccuracy);
    XCTAssertEqualWithAccuracy(slider.value, round(originalValue), kEpsilonAccuracy);
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

    MDCSlider *slider = [[MDCSlider alloc] init];
    slider.minimumValue = 0;
    slider.maximumValue = delta * (numberOfValues - 1);
    slider.value = originalValue;

    // When
    slider.numberOfDiscreteValues = numberOfValues;

    // Then
    XCTAssertEqualWithAccuracy(slider.value, originalValue, delta / 2 + kEpsilonAccuracy);
    XCTAssertEqualWithAccuracy(slider.value, snapedValue, kEpsilonAccuracy);
    if ((slider.value - kEpsilonAccuracy > snapedValue) ||
        (slider.value + kEpsilonAccuracy < snapedValue)) {
      NSLog(@"failed with difference:%f", slider.value - snapedValue);
    }
  }
}

#pragma mark colors

- (void)testThumbColor {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  UIColor *actualColor = slider.color;

  // Then
  UIColor *expectedColor = [self blueColor];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testThumbColorNullRestable {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.color = nil;

  // Then
  UIColor *actualColor = slider.color;
  UIColor *expectedColor = [self blueColor];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testTrackColor {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  UIColor *actualColor = slider.trackBackgroundColor;

  // Then
  UIColor *expectedColor = [[UIColor blackColor] colorWithAlphaComponent:0.26f];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testTrackColorNullRestable {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.trackBackgroundColor = nil;

  // Then
  UIColor *actualColor = slider.trackBackgroundColor;
  UIColor *expectedColor = [[UIColor blackColor] colorWithAlphaComponent:0.26f];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

#pragma mark numeric value label

- (void)testNumericValueLabelString {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  MDCThumbTrack *track = nil;
  for (UIView *view in slider.subviews) {
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
      [testFormatter numberFromString:[slider thumbTrack:track stringForValue:1.f]], @(1.));
  XCTAssertEqualObjects(
      [testFormatter numberFromString:[slider thumbTrack:track stringForValue:0.57f]], @(0.57));
  XCTAssertEqualObjects(
      [testFormatter numberFromString:[slider thumbTrack:track stringForValue:0.33333333f]],
      @(0.333));
}

#pragma mark accessibility

- (void)testAccessibilityValue {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  CGFloat newValue = [self randomPercent];

  // When
  slider.value = newValue;

  // Then
  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
  NSString *expected =
      [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(float)slider.value]];
  XCTAssertEqualObjects([slider accessibilityValue], expected);
}

- (void)testAccessibilityValueWithLargerMax {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = [self randomNumber];
  CGFloat newValue = [self randomPercent];

  // When
  slider.value = newValue;

  // Then
  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
  CGFloat percent =
      (slider.value - slider.minimumValue) / (slider.maximumValue - slider.minimumValue);
  NSString *expected = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(float)percent]];
  XCTAssertEqualObjects([slider accessibilityValue], expected);
}

- (void)testAccessibilityIncrement {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.value = [self randomPercent] - 0.1f;
  CGFloat originalValue = slider.value;

  // When
  [slider accessibilityIncrement];

  // Then
  XCTAssertEqual(originalValue + 0.1f, slider.value);
}

- (void)testAccessibilityDecrement {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.value = [self randomPercent] + 0.1f;
  CGFloat originalValue = slider.value;

  // When
  [slider accessibilityDecrement];

  // Then
  XCTAssertEqual(originalValue - 0.1f, slider.value);
}

- (void)testAccessibilityIncrementWithLargerMax {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = [self randomNumber];
  slider.value = ([self randomPercent] - 0.1f) * slider.maximumValue;
  CGFloat originalValue = slider.value;

  // When
  [slider accessibilityIncrement];

  // Then
  XCTAssertEqual(originalValue + 0.1f * slider.maximumValue, slider.value);
}

- (void)testAccessibilityTraits {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.enabled =
      arc4random_uniform(2);  // It does not matter if the slider is enabled or disabled.

  // Then
  XCTAssertTrue(slider.accessibilityTraits & UIAccessibilityTraitAdjustable);
}

#pragma mark private test helpers

- (UIColor *)blueColor {
  return MDCColorFromRGB(MDCBlueColor);
}

- (CGFloat)randomNumber {
  return arc4random_uniform(1000) / (CGFloat)(arc4random_uniform(9) + 1);
}

- (CGFloat)randomPercent {
  return (CGFloat)(arc4random_uniform(1001)) / 1000;
}

@end
