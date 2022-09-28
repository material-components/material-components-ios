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
#import "MaterialActivityIndicator.h"

static CGFloat randomNumber(void) { return arc4random_uniform(128) + 8; }

@interface MDCActivityIndicator (Private)

@property(nonatomic, strong, readonly, nullable) CAShapeLayer *strokeLayer;

@end

@interface ActivityIndicatorTests : XCTestCase
@property(nonatomic, strong, nullable) MDCActivityIndicator *indicator;
@end

@implementation ActivityIndicatorTests

- (void)setUp {
  [super setUp];

  self.indicator = [[MDCActivityIndicator alloc] init];
}

- (void)tearDown {
  self.indicator = nil;

  [super tearDown];
}

- (void)testSetRadiusMin {
  // When
  self.indicator.radius = 2;

  // Then
  XCTAssertGreaterThanOrEqual(self.indicator.radius, 5);
}

- (void)testSetRadius {
  // When
  CGFloat random = randomNumber();
  self.indicator.radius = random;

  // Then
  XCTAssertGreaterThanOrEqual(self.indicator.radius, 8);
  XCTAssertEqual(self.indicator.radius, random);
}

- (void)testDefaultColorCycle {
  // Then
  XCTAssertGreaterThan(self.indicator.cycleColors.count, 0U,
                       @"The default value for |cycleColors| should be a non-empty array.");
}

- (void)testSetCycleColorsEmptyReturnsDefault {
  // When
  self.indicator.cycleColors = @[];

  // Then
  XCTAssertGreaterThan(self.indicator.cycleColors.count, 0U,
                       @"Assigning an empty array for |cycleColors| should result in a default"
                        " value being used instead.");
}

- (void)testSetCycleColorNonEmpty {
  // Given
  NSArray<UIColor *> *cycleColors = @[ [UIColor redColor], [UIColor whiteColor] ];

  // When
  self.indicator.cycleColors = cycleColors;

  // Then
  XCTAssertEqualObjects(self.indicator.cycleColors, cycleColors,
                        @"With a non-empty array, the |cycleColors| property should override the"
                         " default value.");
}

- (void)testSetProgressValue {
  // Make sure that setting progress with or without animation work regardless of whether indicator
  // mode is determinate or indeterminate, and make sure that setting progress value doesn't change
  // the mode.
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self verifySettingProgressOnIndicator:self.indicator animated:NO];
  [self verifySettingProgressOnIndicator:self.indicator animated:YES];
  XCTAssertEqual(self.indicator.indicatorMode, MDCActivityIndicatorModeDeterminate);

  self.indicator.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  [self verifySettingProgressOnIndicator:self.indicator animated:NO];
  [self verifySettingProgressOnIndicator:self.indicator animated:YES];
  XCTAssertEqual(self.indicator.indicatorMode, MDCActivityIndicatorModeIndeterminate);
}

- (void)testSetProgressStrokeNonanimated {
  // Make sure that the stroke layer updates accordingly when we set determinate progress.
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;

  [self.indicator setProgress:(float)0.33 animated:NO];
  XCTAssertEqual(self.indicator.strokeLayer.strokeStart, 0.0);
  XCTAssertEqual(self.indicator.strokeLayer.strokeEnd, (float)0.33);
}

- (void)testSetProgressStrokeAnimated {
  // Make sure that the stroke layer updates accordingly when we set determinate progress.
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.indicator startAnimating];

  [self.indicator setProgress:(float)0.55 animated:YES];
  XCTAssertEqual(self.indicator.strokeLayer.strokeStart, 0.0);
  XCTAssertEqual(self.indicator.strokeLayer.strokeEnd, (float)0.55);
}

- (void)testSetAccessibiltyLabelProperty {
  // Given
  NSString *testString = @"test this label";

  // When
  self.indicator.accessibilityLabel = testString;

  // Then
  XCTAssertEqualObjects(self.indicator.accessibilityLabel, testString);
}

- (void)testStopsAnimatingWhenHidden {
  // Given
  [self.indicator startAnimating];

  // When
  self.indicator.hidden = YES;

  // Then
  XCTAssertFalse(self.indicator.animating);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCActivityIndicator *passedActivityIndicator;
  self.indicator.traitCollectionDidChangeBlock =
      ^(MDCActivityIndicator *_Nonnull indicator,
        UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedActivityIndicator = indicator;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.indicator traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedActivityIndicator, self.indicator);
}

- (void)testTrackEnabledDefaultsToNo {
  // Then
  XCTAssertFalse(self.indicator.trackEnabled);
}

- (void)testTrackEnabledUpdatesWhenSet {
  // When
  self.indicator.trackEnabled = YES;

  // Then
  XCTAssertTrue(self.indicator.trackEnabled);
}

- (void)testDefaultStrokeWidth {
  // Then
  XCTAssertEqualWithAccuracy(self.indicator.strokeWidth, 2.5, 0.001);
}

- (void)testSetStrokeWidthToCustomValue {
  // Given
  CGFloat expectedWidth = 5;

  // When
  self.indicator.strokeWidth = expectedWidth;

  // Then
  XCTAssertEqualWithAccuracy(self.indicator.strokeWidth, expectedWidth, 0.001);
}

- (void)testDefaultAccessibilityTraits {
  // Then
  XCTAssertEqual(self.indicator.accessibilityTraits, UIAccessibilityTraitUpdatesFrequently);
}

- (void)testAccessibilityElementWhenAnimating {
  // When
  self.indicator.animating = YES;

  // Then
  XCTAssertTrue(self.indicator.isAccessibilityElement);
}

- (void)testDefaultIsAccessibilityElement {
  // Then
  XCTAssertFalse(self.indicator.animating);
  XCTAssertFalse(self.indicator.isAccessibilityElement);
}

#pragma mark - Helpers

- (void)verifySettingProgressOnIndicator:(MDCActivityIndicator *)indicator animated:(BOOL)animated {
  [indicator setProgress:-5 animated:animated];
  XCTAssertEqual(indicator.progress, 0);

  [indicator setProgress:(float)0.77 animated:animated];
  XCTAssertEqual(indicator.progress, (float)0.77);

  [indicator setProgress:5 animated:animated];
  XCTAssertEqual(indicator.progress, 1);
}

@end
