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

#import <XCTest/XCTest.h>

#import "MDCRippleLayer.h"

#pragma mark - Fake classes

@interface CapturingAnimationsMDCRippleLayer : MDCRippleLayer
@property(nonatomic, strong) NSMutableArray *addedAnimations;
@end

@implementation CapturingAnimationsMDCRippleLayer

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {
  if (!self.addedAnimations) {
    self.addedAnimations = [NSMutableArray array];
  }
  [self.addedAnimations addObject:anim];
  [super addAnimation:anim forKey:key];
}

@end

@interface FakeMDCRippleLayerAnimationDelegate : NSObject <MDCRippleLayerDelegate>
@property(nonatomic, strong) MDCRippleLayer *rippleLayer;
@property(nonatomic, assign) BOOL rippleTouchDownDidBegin;
@property(nonatomic, assign) BOOL rippleTouchDownDidEnd;
@property(nonatomic, assign) BOOL rippleTouchUpDidBegin;
@property(nonatomic, assign) BOOL rippleTouchUpDidEnd;

@end

@implementation FakeMDCRippleLayerAnimationDelegate
- (void)rippleLayerTouchDownAnimationDidBegin:(nonnull MDCRippleLayer *)rippleLayer {
  _rippleTouchDownDidBegin = YES;
}

- (void)rippleLayerTouchDownAnimationDidEnd:(nonnull MDCRippleLayer *)rippleLayer {
  _rippleTouchDownDidEnd = YES;
}

- (void)rippleLayerTouchUpAnimationDidBegin:(nonnull MDCRippleLayer *)rippleLayer {
  _rippleTouchUpDidBegin = YES;
}

- (void)rippleLayerTouchUpAnimationDidEnd:(nonnull MDCRippleLayer *)rippleLayer {
  _rippleTouchUpDidEnd = YES;
}

@end

#pragma mark - Tests

@interface MDCRippleLayerTests : XCTestCase

@end

@implementation MDCRippleLayerTests

- (void)testInit {
  // Given
  MDCRippleLayer *rippleLayer = [[MDCRippleLayer alloc] init];

  // Then
  XCTAssertNil(rippleLayer.delegate);
  XCTAssertFalse(rippleLayer.isStartAnimationActive);
  XCTAssertEqualWithAccuracy(rippleLayer.rippleTouchDownStartTime, 0, 0.0001);
}

- (void)testLayerTouchDownDidBeginDelegate {
  // Given
  FakeMDCRippleLayerAnimationDelegate *delegate = [[FakeMDCRippleLayerAnimationDelegate alloc] init];
  MDCRippleLayer *rippleLayer = [[MDCRippleLayer alloc] init];
  rippleLayer.rippleLayerDelegate = delegate;
  delegate.rippleLayer = rippleLayer;

  // When
  [rippleLayer startRippleAtPoint:CGPointMake(0, 0) animated:YES completion:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchDownDidBegin);
}

- (void)testLayerTouchDownDidEndDelegate {
  // Given
  FakeMDCRippleLayerAnimationDelegate *delegate = [[FakeMDCRippleLayerAnimationDelegate alloc] init];
  MDCRippleLayer *rippleLayer = [[MDCRippleLayer alloc] init];
  rippleLayer.rippleLayerDelegate = delegate;
  delegate.rippleLayer = rippleLayer;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];

  // When
  [rippleLayer startRippleAtPoint:CGPointMake(0, 0) animated:YES completion:^{
    [expectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchDownDidEnd);
}

- (void)testLayerTouchUpDidBeginDelegate {
  // Given
  FakeMDCRippleLayerAnimationDelegate *delegate = [[FakeMDCRippleLayerAnimationDelegate alloc] init];
  MDCRippleLayer *rippleLayer = [[MDCRippleLayer alloc] init];
  rippleLayer.rippleLayerDelegate = delegate;
  delegate.rippleLayer = rippleLayer;

  // When
  [rippleLayer endRippleAnimated:YES completion:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchUpDidBegin);
}

- (void)testLayerTouchUpDidEndDelegate {
  // Given
  FakeMDCRippleLayerAnimationDelegate *delegate = [[FakeMDCRippleLayerAnimationDelegate alloc] init];
  MDCRippleLayer *rippleLayer = [[MDCRippleLayer alloc] init];
  rippleLayer.rippleLayerDelegate = delegate;
  delegate.rippleLayer = rippleLayer;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];

  // When
  [rippleLayer endRippleAnimated:YES completion:^{
    [expectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(delegate.rippleTouchUpDidEnd);
}

- (void)testAnimationTimingInSpeedScaledLayer {
  // Given
  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];
  rippleLayer.bounds = CGRectMake(0, 0, 10, 10);
  rippleLayer.speed = (CGFloat)0.5;
  CGFloat rippleDelay = 0.225;

  // When
  [rippleLayer startRippleAtPoint:CGPointMake(0, 0) animated:YES completion:nil];
  [rippleLayer endRippleAnimated:YES completion:nil];
  NSTimeInterval startTime = CACurrentMediaTime();

  // Then
  XCTAssertEqual(rippleLayer.addedAnimations.count, 2U);
  CAAnimation *animation = rippleLayer.addedAnimations.lastObject;
  if (animation) {
    startTime = [rippleLayer convertTime:startTime + rippleDelay fromLayer:nil];
    XCTAssertEqualWithAccuracy(animation.beginTime, startTime, 0.010);
  }
}

- (void)testStartRippleAnimationCorrectness {
  // Given
  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];
  CGPoint point = CGPointMake(10, 10);

  // When
  [rippleLayer startRippleAtPoint:point animated:YES completion:nil];
  
  // Then
  CAAnimationGroup *group = (CAAnimationGroup *)rippleLayer.addedAnimations.firstObject;
  XCTAssertEqual(group.animations.count, 3);
  NSInteger animationsCount = 0;
  for (CAAnimation *animation in group.animations) {
    XCTAssertFalse(animation.removedOnCompletion);
    if ([animation isKindOfClass:[CABasicAnimation class]]) {
      CABasicAnimation *basicAnimation = (CABasicAnimation *)animation;
      if ([basicAnimation.keyPath isEqualToString: @"opacity"]) {
        animationsCount += 1;
        XCTAssertEqualObjects(@1, basicAnimation.toValue);
        XCTAssertEqualObjects(@0, basicAnimation.fromValue);
        XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
      } else if ([basicAnimation.keyPath isEqualToString:@"transform.scale"]) {
        animationsCount += 1;
        XCTAssertEqualObjects(@1, basicAnimation.toValue);
        XCTAssertEqualObjects(@0.6, basicAnimation.fromValue);
      }
    } else if ([animation isKindOfClass:[CAKeyframeAnimation class]]) {
      animationsCount += 1;
      CAKeyframeAnimation *keyFrameAnimation = (CAKeyframeAnimation *)animation;
      XCTAssertTrue(CGPointEqualToPoint(point, CGPathGetCurrentPoint(keyFrameAnimation.path)));
    }
  }
  XCTAssertEqual(animationsCount, 3);
}

- (void)testEndRippleAnimationCorrectness {
  // Given
  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];

  // When
  [rippleLayer endRippleAnimated:YES completion:nil];

  // Then
  XCTAssertTrue([rippleLayer.addedAnimations.firstObject isKindOfClass:[CABasicAnimation class]]);
  CABasicAnimation *basicAnimation = (CABasicAnimation *)rippleLayer.addedAnimations.firstObject;
  XCTAssertEqual(rippleLayer.addedAnimations.count, 1);
  XCTAssertEqualObjects(@"opacity", basicAnimation.keyPath);
  XCTAssertEqualObjects(@0, basicAnimation.toValue);
  XCTAssertEqualObjects(@1, basicAnimation.fromValue);
  XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
  XCTAssertEqualWithAccuracy(basicAnimation.duration, (CGFloat)0.15, 0.0001);
}

- (void)testFadeInRippleAnimationCorrectness {
  // Given
  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];

  // When
  [rippleLayer fadeInRippleAnimated:YES completion:nil];

  // Then
  XCTAssertTrue([rippleLayer.addedAnimations.firstObject isKindOfClass:[CABasicAnimation class]]);
  CABasicAnimation *basicAnimation = (CABasicAnimation *)rippleLayer.addedAnimations.firstObject;
  XCTAssertEqual(rippleLayer.addedAnimations.count, 1);
  XCTAssertEqualObjects(@"opacity", basicAnimation.keyPath);
  XCTAssertEqualObjects(@1, basicAnimation.toValue);
  XCTAssertEqualObjects(@0, basicAnimation.fromValue);
  XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
  XCTAssertEqualWithAccuracy(basicAnimation.duration, (CGFloat)0.075, 0.0001);
}

- (void)testFadeOutRippleAnimationCorrectness {
  // Given
  CapturingAnimationsMDCRippleLayer *rippleLayer = [[CapturingAnimationsMDCRippleLayer alloc] init];

  // When
  [rippleLayer fadeOutRippleAnimated:YES completion:nil];

  // Then
  XCTAssertTrue([rippleLayer.addedAnimations.firstObject isKindOfClass:[CABasicAnimation class]]);
  CABasicAnimation *basicAnimation = (CABasicAnimation *)rippleLayer.addedAnimations.firstObject;
  XCTAssertEqual(rippleLayer.addedAnimations.count, 1);
  XCTAssertEqualObjects(@"opacity", basicAnimation.keyPath);
  XCTAssertEqualObjects(@0, basicAnimation.toValue);
  XCTAssertEqualObjects(@1, basicAnimation.fromValue);
  XCTAssertEqualObjects([CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], basicAnimation.timingFunction);
  XCTAssertEqualWithAccuracy(basicAnimation.duration, (CGFloat)0.075, 0.0001);
}
@end
