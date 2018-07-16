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
#import "MaterialActivityIndicator.h"

static CGFloat randomNumber() {
  return arc4random_uniform(64) + 8;
}

@interface MDCActivityIndicator (Private)

@property(nonatomic, strong, readonly, nullable) CAShapeLayer *strokeLayer;

@end

@interface ActivityIndicatorTests : XCTestCase

@end

@implementation ActivityIndicatorTests

- (void)testSetRadiusMin {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // When
  indicator.radius = 2.0f;

  // Then
  XCTAssertGreaterThanOrEqual(indicator.radius, 5.0f);
  XCTAssertLessThanOrEqual(indicator.radius, 72.0f);
}

- (void)testSetRadiusMax {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // When
  indicator.radius = 80.0f;

  // Then
  XCTAssertGreaterThanOrEqual(indicator.radius, 8.0f);
  XCTAssertLessThanOrEqual(indicator.radius, 72.0f);
}

- (void)testSetRadius {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // When
  CGFloat random = randomNumber();
  indicator.radius = random;

  // Then
  XCTAssertGreaterThanOrEqual(indicator.radius, 8.0f);
  XCTAssertLessThanOrEqual(indicator.radius, 72.0f);
  XCTAssertEqual(indicator.radius, random);
}

- (void)testDefaultColorCycle {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // Then
  XCTAssertGreaterThan(indicator.cycleColors.count, 0U,
                       @"The default value for |cycleColors| should be a non-empty array.");
}

- (void)testSetCycleColorsEmptyReturnsDefault {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // When
  indicator.cycleColors = @[];

  // Then
  XCTAssertGreaterThan(indicator.cycleColors.count, 0U,
                       @"Assigning an empty array for |cycleColors| should result in a default"
                        " value being used instead.");
}

- (void)testSetCycleColorNonEmpty {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];
  NSArray <UIColor *> *cycleColors = @[[UIColor redColor], [UIColor whiteColor]];

  // When
  indicator.cycleColors = cycleColors;

  // Then
  XCTAssertEqualObjects(indicator.cycleColors, cycleColors,
                        @"With a non-empty array, the |cycleColors| property should override the"
                        " default value.");
}

- (void)testSetProgressValue {
  // Make sure that setting progress with or without animation work regardless of whether indicator
  // mode is determinate or indeterminate, and make sure that setting progress value doesn't change
  // the mode.
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self verifySettingProgressOnIndicator:indicator animated:NO];
  [self verifySettingProgressOnIndicator:indicator animated:YES];
  XCTAssertEqual(indicator.indicatorMode, MDCActivityIndicatorModeDeterminate);

  indicator.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  [self verifySettingProgressOnIndicator:indicator animated:NO];
  [self verifySettingProgressOnIndicator:indicator animated:YES];
  XCTAssertEqual(indicator.indicatorMode, MDCActivityIndicatorModeIndeterminate);
}

- (void)testSetProgressStrokeNonanimated {
  // Make sure that the stroke layer updates accordingly when we set determinate progress.
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];
  indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;

  [indicator setProgress:0.33f animated:NO];
  XCTAssertEqual(indicator.strokeLayer.strokeStart, 0.0);
  XCTAssertEqual(indicator.strokeLayer.strokeEnd, 0.33f);
}

- (void)testSetProgressStrokeAnimated {
  // Make sure that the stroke layer updates accordingly when we set determinate progress.
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];
  indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [indicator startAnimating];

  [indicator setProgress:0.55f animated:YES];
  XCTAssertEqual(indicator.strokeLayer.strokeStart, 0.0);
  XCTAssertEqual(indicator.strokeLayer.strokeEnd, 0.55f);
}

- (void)testSetAccessibiltyLabelProperty {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];
  NSString *testString = @"test this label";

  // When
  indicator.accessibilityLabel = testString;

  // Then
  XCTAssertEqualObjects(indicator.accessibilityLabel, testString);
}

#pragma mark - Helpers

- (void)verifySettingProgressOnIndicator:(MDCActivityIndicator *)indicator animated:(BOOL)animated {
  [indicator setProgress:-5.0f animated:animated];
  XCTAssertEqual(indicator.progress, 0.0f);

  [indicator setProgress:0.77f animated:animated];
  XCTAssertEqual(indicator.progress, 0.77f);

  [indicator setProgress:5.0f animated:animated];
  XCTAssertEqual(indicator.progress, 1.0f);
}

@end
