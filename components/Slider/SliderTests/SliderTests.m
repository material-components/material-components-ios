/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MaterialSlider.h"

static const NSUInteger kNumberOfRepeats = 20;
static const CGFloat kEpsilonAccuracy = 0.0001f;

@interface PageControlTests : XCTestCase

@end

@implementation PageControlTests

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
  // Given

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
  slider.value = slider.minimumValue + [self randomPercent] * (slider.maximumValue - slider.minimumValue);

  // When
  slider.maximumValue = slider.value - [self randomPercent] * slider.value;

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.maximumValue, kEpsilonAccuracy);
}

- (void)testSetMinimumToHigherThanValue {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = [self randomNumber];
  slider.value = slider.minimumValue + [self randomPercent] * (slider.maximumValue - slider.minimumValue);

  // When
  slider.minimumValue = slider.value + [self randomPercent] * slider.value;

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testSetMaximumToLowerThanMinimum {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.maximumValue = slider.minimumValue - [self randomNumber];

  // Then
  XCTAssertEqualWithAccuracy(slider.maximumValue, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testSetMinimumToLowerThanMaximum {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.minimumValue = slider.maximumValue + [self randomNumber];

  // Then
  XCTAssertEqualWithAccuracy(slider.minimumValue, slider.maximumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues2 {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = 10;
  slider.minimumValue = 0;
  slider.value = arc4random_uniform(slider.maximumValue / 2);

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
  slider.value = arc4random_uniform(slider.maximumValue / 2);

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValues3 {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];
  slider.maximumValue = 100;
  slider.minimumValue = 0;
  slider.value = arc4random_uniform(slider.maximumValue / 6);

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
  slider.value = arc4random_uniform(slider.maximumValue / 6);

  // Then
  XCTAssertEqualWithAccuracy(slider.value, slider.minimumValue, kEpsilonAccuracy);
}

- (void)testDiscreteValuesWithIntegers {
  for (int ii = 0; ii < kNumberOfRepeats; ++ii) {
    // Given
    MDCSlider *slider = [[MDCSlider alloc] init];
    slider.maximumValue = (int)[self randomNumber];
    slider.minimumValue = 0;
    slider.value = [self randomPercent] * slider.maximumValue;
    CGFloat originalValue = slider.value;

    // When
    slider.numberOfDiscreteValues = slider.maximumValue + 1;

    // Then
    XCTAssertEqualWithAccuracy(slider.value, originalValue, 0.5f + kEpsilonAccuracy);
    XCTAssertEqualWithAccuracy(slider.value, round(originalValue), kEpsilonAccuracy);
  }
}

- (void)testDiscreteValuesWithFloatingPointDelta {
  for (int ii = 0; ii < kNumberOfRepeats; ++ii) {
    // Given
    CGFloat delta = [self randomNumber] + 1;
    NSUInteger numberOfValues = arc4random_uniform(8) + 2;
    CGFloat snapedValue = arc4random_uniform((int)numberOfValues) * delta;
    CGFloat originalValue = snapedValue + [self randomPercent] * (delta - kEpsilonAccuracy) - (delta - kEpsilonAccuracy) / 2;

    MDCSlider *slider = [[MDCSlider alloc] init];
    slider.minimumValue = 0;
    slider.maximumValue = delta * (numberOfValues - 1);
    slider.value = originalValue;

    // When
    slider.numberOfDiscreteValues = numberOfValues;

    // Then
    XCTAssertEqualWithAccuracy(slider.value, originalValue, delta / 2 + kEpsilonAccuracy);
    XCTAssertEqualWithAccuracy(slider.value, snapedValue, kEpsilonAccuracy);
    if ((slider.value - kEpsilonAccuracy > snapedValue) || (slider.value + kEpsilonAccuracy < snapedValue)) {
      NSLog(@"failed with difference:%f", slider.value - snapedValue);
    }
  }
}

#pragma mark colors

- (void)testThumbColor {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  UIColor *actualColor = slider.thumbColor;

  // Then
  UIColor *expectedColor = [self blueColor];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testThumbColorNullRestable {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.thumbColor = nil;

  // Then
  UIColor *actualColor = slider.thumbColor;
  UIColor *expectedColor = [self blueColor];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testTrackColor {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  UIColor *actualColor = slider.trackColor;

  // Then
  UIColor *expectedColor = [[UIColor blackColor] colorWithAlphaComponent:0.26f];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testTrackColorNullRestable {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.trackColor = nil;

  // Then
  UIColor *actualColor = slider.trackColor;
  UIColor *expectedColor = [self blueColor];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testInkColor {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  UIColor *actualColor = slider.inkColor;

  // Then
  UIColor *expectedColor = [[self blueColor] colorWithAlphaComponent:0.5f];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

- (void)testInkColorNullRestable {
  // Given
  MDCSlider *slider = [[MDCSlider alloc] init];

  // When
  slider.inkColor = nil;

  // Then
  UIColor *actualColor = slider.inkColor;
  UIColor *expectedColor = [[self blueColor] colorWithAlphaComponent:0.5f];
  XCTAssertEqualObjects(actualColor, expectedColor);
}

#pragma mark private test helpers

- (UIColor *)blueColor {
  return [UIColor blueColor];
}

- (CGFloat)randomNumber {
  return arc4random_uniform(1000) / (CGFloat)(arc4random_uniform(9) + 1);
}

- (CGFloat)randomPercent {
  return 1 / (CGFloat)(arc4random_uniform(999) + 1);
}

@end
