// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCRippleView.h"
#import "MDCRippleViewDelegate.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCRippleLayer.h"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

@interface FakeMDCRippleViewAnimationDelegate : NSObject <MDCRippleViewDelegate>
@property(nonatomic, strong) MDCRippleView *rippleView;
@property(nonatomic, assign) BOOL rippleTouchDownDidBegin;
@property(nonatomic, assign) BOOL rippleTouchDownDidEnd;
@property(nonatomic, assign) BOOL rippleTouchUpDidBegin;
@property(nonatomic, assign) BOOL rippleTouchUpDidEnd;

@end

@implementation FakeMDCRippleViewAnimationDelegate
- (void)rippleTouchDownAnimationDidBegin:(nonnull MDCRippleView *)rippleView {
  _rippleTouchDownDidBegin = YES;
}

- (void)rippleTouchDownAnimationDidEnd:(nonnull MDCRippleView *)rippleView {
  _rippleTouchDownDidEnd = YES;
}

- (void)rippleTouchUpAnimationDidBegin:(nonnull MDCRippleView *)rippleView {
  _rippleTouchUpDidBegin = YES;
}

- (void)rippleTouchUpAnimationDidEnd:(nonnull MDCRippleView *)rippleView {
  _rippleTouchUpDidEnd = YES;
}

@end

@interface MDCRippleView (UnitTests)
@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;
@property(nonatomic, strong) CAShapeLayer *maskLayer;
@end

#pragma mark - Tests

@interface MDCRippleViewTests : XCTestCase

@end

@implementation MDCRippleViewTests

- (void)testInit {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];

  // Then
  XCTAssertNil(rippleView.rippleViewDelegate);
  XCTAssertEqualObjects(rippleView.rippleColor, [[UIColor alloc] initWithWhite:0
                                                                         alpha:(CGFloat)0.12]);
  XCTAssertEqual(rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertEqual(rippleView.maximumRadius, 0);
}

- (void)testTouchDownDidBeginDelegate {
  // Given
  FakeMDCRippleViewAnimationDelegate *delegate = [[FakeMDCRippleViewAnimationDelegate alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleViewDelegate = delegate;
  delegate.rippleView = rippleView;

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:YES completion:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchDownDidBegin);
}

- (void)testTouchDownDidEndDelegate {
  // Given
  FakeMDCRippleViewAnimationDelegate *delegate = [[FakeMDCRippleViewAnimationDelegate alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleViewDelegate = delegate;
  delegate.rippleView = rippleView;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0)
                                 animated:YES
                               completion:^{
                                 [expectation fulfill];
                               }];
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchDownDidEnd);
}

- (void)testTouchUpDidBeginDelegate {
  // Given
  FakeMDCRippleViewAnimationDelegate *delegate = [[FakeMDCRippleViewAnimationDelegate alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleViewDelegate = delegate;
  delegate.rippleView = rippleView;

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:NO completion:nil];
  [rippleView beginRippleTouchUpAnimated:YES completion:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchUpDidBegin);
}

- (void)testTouchUpDidEndDelegate {
  // Given
  FakeMDCRippleViewAnimationDelegate *delegate = [[FakeMDCRippleViewAnimationDelegate alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleViewDelegate = delegate;
  delegate.rippleView = rippleView;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:NO completion:nil];
  [rippleView beginRippleTouchUpAnimated:YES
                              completion:^{
                                [expectation fulfill];
                              }];
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchUpDidEnd);
}

- (void)testSettingActiveRippleColor {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:YES completion:nil];
  [rippleView setActiveRippleColor:[UIColor blueColor]];

  // Then
  XCTAssertTrue(
      CGColorEqualToColor([UIColor blueColor].CGColor, rippleView.activeRippleLayer.fillColor));
  XCTAssertNotEqualObjects(rippleView.rippleColor, [UIColor blueColor]);
}

- (void)testSettingRippleColor {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:YES completion:nil];
  [rippleView setRippleColor:[UIColor blueColor]];

  // Then
  XCTAssertFalse(
      CGColorEqualToColor([UIColor blueColor].CGColor, rippleView.activeRippleLayer.fillColor));
  XCTAssertEqualObjects(rippleView.rippleColor, [UIColor blueColor]);
}

- (void)testFrameIsSizeOfSuperViewByDefault {
  // Given
  CGRect fakeFrame = CGRectMake(0, 0, 200, 200);
  UIView *fakeView = [[UIView alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  [fakeView addSubview:rippleView];

  // When
  fakeView.bounds = fakeFrame;

  // Then
  XCTAssertTrue(CGRectEqualToRect(fakeFrame, rippleView.frame), @"%@ not equal to %@",
                NSStringFromCGRect(fakeFrame), NSStringFromCGRect(rippleView.frame));
}

- (void)testFrameRespondsToCustomization {
  // Given
  CGRect fakeViewFrame = CGRectMake(0, 0, 200, 200);
  CGRect fakeRippleFrame = CGRectMake(0, 0, 50, 50);
  UIView *fakeView = [[UIView alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  [fakeView addSubview:rippleView];

  // When
  fakeView.bounds = fakeViewFrame;
  rippleView.frame = fakeRippleFrame;

  // Then
  XCTAssertTrue(CGRectEqualToRect(fakeRippleFrame, rippleView.frame), @"%@ not equal to %@",
                NSStringFromCGRect(fakeRippleFrame), NSStringFromCGRect(rippleView.frame));
}

/** Test that setting the @c maximumRadius on @c MDCRippleView correctly sets the property. */
- (void)testMaximumRadiusGetsSet {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  CGFloat fakeRadius = 10;

  // When
  rippleView.maximumRadius = fakeRadius;

  // Then
  XCTAssertEqual(rippleView.maximumRadius, fakeRadius);
}

/**
 Test that setting the @c maximumRadius on the @c MDCRippleView does not impact how the ripple
 acts when the @c rippleStyle is set to @c MDCRippleStyleBounded.
 */
- (void)testMaximumRadiusDoesNotImpactBoundedRipple {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleStyle = MDCRippleStyleBounded;

  // When
  rippleView.maximumRadius = 10;
  // This must be called to set the @c activeRippleLayer.
  [rippleView beginRippleTouchDownAtPoint:CGPointZero animated:NO completion:nil];

  // Then
  XCTAssertEqual(rippleView.activeRippleLayer.maximumRadius, 0);
}

/**
 Test that setting the @c maximumRadius on the @c MDCRippleView does impact how the ripple acts
 when the @c rippleStyle is set to @c MDCrippleStyleUnbounded.
 */
- (void)testMaximumRippleRadiusImpactsUnboundedRipple {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleStyle = MDCRippleStyleUnbounded;
  CGFloat fakeRippleRadius = 10;

  // When
  rippleView.maximumRadius = fakeRippleRadius;
  // This must be called to set the @c activeRippleLayer.
  [rippleView beginRippleTouchDownAtPoint:CGPointZero animated:NO completion:nil];

  // Then
  XCTAssertEqual(rippleView.activeRippleLayer.maximumRadius, fakeRippleRadius);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCRippleView *testRippleView = [[MDCRippleView alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCRippleView *passedRippleView = nil;
  testRippleView.traitCollectionDidChangeBlock =
      ^(MDCRippleView *_Nonnull ripple, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedRippleView = ripple;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [testRippleView traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedRippleView, testRippleView);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

- (void)testInjectedRippleViewFindsRippleViewInHierarchy {
  // Given
  UIView *parentView = [[UIView alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  [parentView addSubview:rippleView];

  // When
  MDCRippleView *injectedRippleView = [MDCRippleView injectedRippleViewForView:parentView];

  // Then
  XCTAssertEqual(rippleView, injectedRippleView);
}

- (void)testInjectedRippleViewCreatesRippleViewInstance {
  // Given
  UIView *firstLevelView = [[UIView alloc] init];
  UIView *secondLevelView = [[UIView alloc] init];
  [firstLevelView addSubview:secondLevelView];

  // When
  MDCRippleView *injectedRippleView = [MDCRippleView injectedRippleViewForView:firstLevelView];

  // Then
  XCTAssertNotNil(injectedRippleView);
  XCTAssertEqualObjects(injectedRippleView.superview, firstLevelView);
}

@end

NS_ASSUME_NONNULL_END
