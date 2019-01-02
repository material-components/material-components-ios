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

#import <XCTest/XCTest.h>

#import "MaterialRipple.h"
#import "MDCRippleLayer.h"

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
  XCTAssertEqualObjects(rippleView.rippleColor, [[UIColor alloc] initWithWhite:0 alpha:0.16]);
  XCTAssertEqual(rippleView.rippleStyle, MDCRippleStyleBounded);
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

- (void)testLayerTouchDownDidEndDelegate {
  // Given
  FakeMDCRippleViewAnimationDelegate *delegate = [[FakeMDCRippleViewAnimationDelegate alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleViewDelegate = delegate;
  delegate.rippleView = rippleView;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:YES completion:^{
    [expectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchDownDidEnd);
}

- (void)testLayerTouchUpDidBeginDelegate {
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

- (void)testLayerTouchUpDidEndDelegate {
  // Given
  FakeMDCRippleViewAnimationDelegate *delegate = [[FakeMDCRippleViewAnimationDelegate alloc] init];
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.rippleViewDelegate = delegate;
  delegate.rippleView = rippleView;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:NO completion:nil];
  [rippleView beginRippleTouchUpAnimated:YES completion:^{
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
  XCTAssertTrue(CGColorEqualToColor([UIColor blueColor].CGColor,
                                    rippleView.activeRippleLayer.fillColor));
  XCTAssertNotEqualObjects(rippleView.rippleColor, [UIColor blueColor]);
}

- (void)testSettingRippleColor {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];

  // When
  [rippleView beginRippleTouchDownAtPoint:CGPointMake(0, 0) animated:YES completion:nil];
  [rippleView setRippleColor:[UIColor blueColor]];

  // Then
  XCTAssertFalse(CGColorEqualToColor([UIColor blueColor].CGColor,
                                    rippleView.activeRippleLayer.fillColor));
  XCTAssertEqualObjects(rippleView.rippleColor, [UIColor blueColor]);
}

@end
