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
  [rippleView beginRippleTouchUpAnimated:YES completion:^{
    [expectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchUpDidEnd);
}

//- (void)testAnimationTimingInSpeedScaledLayer {
//  // Given
//  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];
//  rippleLayer.bounds = CGRectMake(0, 0, 10, 10);
//  rippleLayer.speed = (CGFloat)0.5;
//  CGFloat rippleDelay = 0.225;
//
//  // When
//  [rippleLayer startRippleAtPoint:CGPointMake(0, 0) animated:YES completion:nil];
//  [rippleLayer endRippleAnimated:YES completion:nil];
//  NSTimeInterval startTime = CACurrentMediaTime();
//
//  // Then
//  XCTAssertEqual(rippleLayer.addedAnimations.count, 2U);
//  CAAnimation *animation = rippleLayer.addedAnimations.lastObject;
//  if (animation) {
//    startTime = [rippleLayer convertTime:startTime + rippleDelay fromLayer:nil];
//    XCTAssertEqualWithAccuracy(animation.beginTime, startTime, 0.010);
//  }
//}
//
//- (void)testStartRippleAnimationCorrectness {
//  // Given
//  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];
//  CGPoint point = CGPointMake(10, 10);
//
//  // When
//  [rippleLayer startRippleAtPoint:point animated:YES completion:nil];
//
//  // Then
//  CAAnimationGroup *group = (CAAnimationGroup *)rippleLayer.addedAnimations.firstObject;
//  XCTAssertEqual(group.animations.count, 3);
//  NSInteger animationsCount = 0;
//  for (CAAnimation *animation in group.animations) {
//    XCTAssertFalse(animation.removedOnCompletion);
//    if ([animation isKindOfClass:[CABasicAnimation class]]) {
//      CABasicAnimation *basicAnimation = (CABasicAnimation *)animation;
//      if ([basicAnimation.keyPath isEqualToString: @"opacity"]) {
//        animationsCount += 1;
//        XCTAssertEqualObjects(@1, basicAnimation.toValue);
//        XCTAssertEqualObjects(@0, basicAnimation.fromValue);
//        XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
//      } else if ([basicAnimation.keyPath isEqualToString:@"transform.scale"]) {
//        animationsCount += 1;
//        XCTAssertEqualObjects(@1, basicAnimation.toValue);
//        XCTAssertEqualObjects(@0.6, basicAnimation.fromValue);
//      }
//    } else if ([animation isKindOfClass:[CAKeyframeAnimation class]]) {
//      animationsCount += 1;
//      CAKeyframeAnimation *keyFrameAnimation = (CAKeyframeAnimation *)animation;
//      XCTAssertTrue(CGPointEqualToPoint(point, CGPathGetCurrentPoint(keyFrameAnimation.path)));
//    }
//  }
//  XCTAssertEqual(animationsCount, 3);
//}
//
//- (void)testEndRippleAnimationCorrectness {
//  // Given
//  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];
//
//  // When
//  [rippleLayer endRippleAnimated:YES completion:nil];
//
//  // Then
//  XCTAssertTrue([rippleLayer.addedAnimations.firstObject isKindOfClass:[CABasicAnimation class]]);
//  CABasicAnimation *basicAnimation = (CABasicAnimation *)rippleLayer.addedAnimations.firstObject;
//  XCTAssertEqual(rippleLayer.addedAnimations.count, 1);
//  XCTAssertEqualObjects(@"opacity", basicAnimation.keyPath);
//  XCTAssertEqualObjects(@0, basicAnimation.toValue);
//  XCTAssertEqualObjects(@1, basicAnimation.fromValue);
//  XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
//  XCTAssertEqualWithAccuracy(basicAnimation.duration, (CGFloat)0.15, 0.0001);
//}
//
//- (void)testFadeInRippleAnimationCorrectness {
//  // Given
//  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];
//
//  // When
//  [rippleLayer fadeInRippleAnimated:YES completion:nil];
//
//  // Then
//  XCTAssertTrue([rippleLayer.addedAnimations.firstObject isKindOfClass:[CABasicAnimation class]]);
//  CABasicAnimation *basicAnimation = (CABasicAnimation *)rippleLayer.addedAnimations.firstObject;
//  XCTAssertEqual(rippleLayer.addedAnimations.count, 1);
//  XCTAssertEqualObjects(@"opacity", basicAnimation.keyPath);
//  XCTAssertEqualObjects(@1, basicAnimation.toValue);
//  XCTAssertEqualObjects(@0, basicAnimation.fromValue);
//  XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
//  XCTAssertEqualWithAccuracy(basicAnimation.duration, (CGFloat)0.075, 0.0001);
//}
//
//- (void)testFadeOutRippleAnimationCorrectness {
//  // Given
//  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];
//
//  // When
//  [rippleLayer fadeOutRippleAnimated:YES completion:nil];
//
//  // Then
//  XCTAssertTrue([rippleLayer.addedAnimations.firstObject isKindOfClass:[CABasicAnimation class]]);
//  CABasicAnimation *basicAnimation = (CABasicAnimation *)rippleLayer.addedAnimations.firstObject;
//  XCTAssertEqual(rippleLayer.addedAnimations.count, 1);
//  XCTAssertEqualObjects(@"opacity", basicAnimation.keyPath);
//  XCTAssertEqualObjects(@0, basicAnimation.toValue);
//  XCTAssertEqualObjects(@1, basicAnimation.fromValue);
//  XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
//  XCTAssertEqualWithAccuracy(basicAnimation.duration, (CGFloat)0.075, 0.0001);
//}
@end
