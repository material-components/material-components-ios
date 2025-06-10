// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#import "MDCInkView.h"

#pragma mark - Tests

@interface MDCInkViewTests : XCTestCase

@end

@implementation MDCInkViewTests

- (void)testInit {
  // Given
  MDCInkView *inkView = [[MDCInkView alloc] init];

  // Then
  XCTAssertTrue(inkView.usesLegacyInkRipple);
  XCTAssertFalse(inkView.usesCustomInkCenter);
  XCTAssertTrue(CGPointEqualToPoint(inkView.customInkCenter, CGPointZero), @"%@ is not equal to %@",
                NSStringFromCGPoint(inkView.customInkCenter), NSStringFromCGPoint(CGPointZero));
  XCTAssertNil(inkView.animationDelegate);
  XCTAssertEqualObjects(inkView.inkColor, inkView.defaultInkColor);
  XCTAssertEqual(inkView.inkStyle, MDCInkStyleBounded);
  XCTAssertEqualWithAccuracy(inkView.maxRippleRadius, 0.0, 0.0001);
}

- (void)testNewInkUsesMaxRippleRadiusWhenUnbounded {
  // Given
  MDCInkView *inkViewStyleThenRadius = [[MDCInkView alloc] init];
  MDCInkView *inkViewRadiusThenStyle = [[MDCInkView alloc] init];
  inkViewStyleThenRadius.usesLegacyInkRipple = NO;
  inkViewRadiusThenStyle.usesLegacyInkRipple = NO;

  // When
  inkViewStyleThenRadius.inkStyle = MDCInkStyleUnbounded;
  inkViewStyleThenRadius.maxRippleRadius = 12;
  inkViewRadiusThenStyle.maxRippleRadius = 12;
  inkViewRadiusThenStyle.inkStyle = MDCInkStyleUnbounded;

  // Then
  XCTAssertEqualWithAccuracy(inkViewStyleThenRadius.maxRippleRadius, 12, 0.0001);
  XCTAssertEqualWithAccuracy(inkViewRadiusThenStyle.maxRippleRadius, 12, 0.0001);
}

- (void)testLegacyInkUsesMaxRippleRadiusWhenUnbounded {
  // Given
  MDCInkView *inkViewStyleThenRadius = [[MDCInkView alloc] init];
  MDCInkView *inkViewRadiusThenStyle = [[MDCInkView alloc] init];
  inkViewStyleThenRadius.usesLegacyInkRipple = YES;
  inkViewRadiusThenStyle.usesLegacyInkRipple = YES;

  // When
  inkViewStyleThenRadius.inkStyle = MDCInkStyleUnbounded;
  inkViewStyleThenRadius.maxRippleRadius = 12;
  inkViewRadiusThenStyle.maxRippleRadius = 12;
  inkViewRadiusThenStyle.inkStyle = MDCInkStyleUnbounded;

  // Then
  XCTAssertEqualWithAccuracy(inkViewStyleThenRadius.maxRippleRadius, 12, 0.0001);
  XCTAssertEqualWithAccuracy(inkViewRadiusThenStyle.maxRippleRadius, 12, 0.0001);
}

- (void)testNewInkIgnoresMaxRippleRadiusWhenBounded {
  // Given
  MDCInkView *inkViewStyleThenRadius = [[MDCInkView alloc] init];
  MDCInkView *inkViewRadiusThenStyle = [[MDCInkView alloc] init];
  inkViewStyleThenRadius.usesLegacyInkRipple = NO;
  inkViewRadiusThenStyle.usesLegacyInkRipple = NO;

  // When
  inkViewStyleThenRadius.inkStyle = MDCInkStyleBounded;
  inkViewStyleThenRadius.maxRippleRadius = 12;
  inkViewRadiusThenStyle.maxRippleRadius = 12;
  inkViewRadiusThenStyle.inkStyle = MDCInkStyleBounded;

  // Then
  XCTAssertEqualWithAccuracy(inkViewStyleThenRadius.maxRippleRadius, 0, 0.0001);
  XCTAssertEqualWithAccuracy(inkViewRadiusThenStyle.maxRippleRadius, 0, 0.0001);
}

- (void)testLegacyInkUsesMaxRippleRadiusWhenBounded {
  // Given
  MDCInkView *inkViewStyleThenRadius = [[MDCInkView alloc] init];
  MDCInkView *inkViewRadiusThenStyle = [[MDCInkView alloc] init];
  inkViewStyleThenRadius.usesLegacyInkRipple = YES;
  inkViewRadiusThenStyle.usesLegacyInkRipple = YES;

  // When
  inkViewStyleThenRadius.inkStyle = MDCInkStyleBounded;
  inkViewStyleThenRadius.maxRippleRadius = 12;
  inkViewRadiusThenStyle.maxRippleRadius = 12;
  inkViewRadiusThenStyle.inkStyle = MDCInkStyleBounded;

  // Then
  XCTAssertEqualWithAccuracy(inkViewStyleThenRadius.maxRippleRadius, 12, 0.0001);
  XCTAssertEqualWithAccuracy(inkViewRadiusThenStyle.maxRippleRadius, 12, 0.0001);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCInkView *testInkView = [[MDCInkView alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCInkView *passedInkView = nil;
  testInkView.traitCollectionDidChangeBlock =
      ^(MDCInkView *_Nonnull ink, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedInkView = ink;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [testInkView traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedInkView, testInkView);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

- (void)testNullResettableInkColor {
  // Given
  MDCInkView *testInkView = [[MDCInkView alloc] init];
  UIColor *defaultInkColor = testInkView.defaultInkColor;
  testInkView.inkColor = UIColor.redColor;

  // When
  testInkView.inkColor = nil;

  // Then
  XCTAssertEqual(testInkView.inkColor, defaultInkColor);
}

- (void)testInkViewLayerDoesntMaskToBoundsWithInkStyleUnbounded {
  // Given
  MDCInkView *testInkView = [[MDCInkView alloc] init];

  // When
  testInkView.inkStyle = MDCInkStyleUnbounded;
  BOOL masksToBoundsWhenUnbounded = testInkView.layer.masksToBounds;
  testInkView.inkStyle = MDCInkStyleBounded;
  BOOL masksToBoundsWhenBounded = testInkView.layer.masksToBounds;

  // Then
  XCTAssertTrue(masksToBoundsWhenBounded);
  XCTAssertFalse(masksToBoundsWhenUnbounded);
}

@end
