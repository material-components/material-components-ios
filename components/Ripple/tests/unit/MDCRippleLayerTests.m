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

#import "MDCRippleLayer.h"

#pragma mark - Fake classes

@interface CapturingMDCRippleLayerSubclass : MDCRippleLayer
@property(nonatomic, strong) NSMutableArray *addedAnimations;

@end

@implementation CapturingMDCRippleLayerSubclass

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
@end

@implementation FakeMDCRippleLayerAnimationDelegate
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
  XCTAssertEqualWithAccuracy(rippleLayer.endAnimationDelay, 0, 0.0001);
  XCTAssertEqualWithAccuracy(rippleLayer.initialRadius, 0, 0.0001);
  XCTAssertEqualWithAccuracy(rippleLayer.finalRadius, 0, 0.0001);
  XCTAssertEqualWithAccuracy(rippleLayer.maxRippleRadius, 0, 0.0001);
  XCTAssertEqualObjects(rippleLayer.rippleColor, [UIColor colorWithWhite:0 alpha:(CGFloat)0.08]);
}

- (void)testInitWithLayer {
  // Given
  FakeMDCRippleLayerAnimationDelegate *delegate = [[FakeMDCRippleLayerAnimationDelegate alloc] init];
  MDCRippleLayer *rippleLayer = [[MDCRippleLayer alloc] init];
  delegate.rippleLayer = rippleLayer;
  rippleLayer.delegate = delegate;
  rippleLayer.endAnimationDelay = 1;
  rippleLayer.initialRadius = 2;
  rippleLayer.finalRadius = 3;
  rippleLayer.maxRippleRadius = 4;
  rippleLayer.rippleColor = UIColor.magentaColor;

  // When
  MDCRippleLayer *copiedLayer = [[MDCRippleLayer alloc] initWithLayer:rippleLayer];

  // Then
  XCTAssertNil(copiedLayer.delegate);
  XCTAssertEqualWithAccuracy(copiedLayer.endAnimationDelay, rippleLayer.endAnimationDelay, 0.0001);
  XCTAssertEqualWithAccuracy(copiedLayer.initialRadius, rippleLayer.initialRadius, 0.0001);
  XCTAssertEqualWithAccuracy(copiedLayer.finalRadius, rippleLayer.finalRadius, 0.0001);
  XCTAssertEqualWithAccuracy(copiedLayer.maxRippleRadius, rippleLayer.maxRippleRadius, 0.0001);
  XCTAssertEqualObjects(copiedLayer.rippleColor, rippleLayer.rippleColor);
  XCTAssertEqual(copiedLayer.sublayers.count, rippleLayer.sublayers.count);
}

- (void)testEndAnimationTimingInTimeScaledLayer {
  // Given
  CapturingMDCRippleLayerSubclass *rippleLayer = [[CapturingMDCRippleLayerSubclass alloc] init];
  rippleLayer.bounds = CGRectMake(0, 0, 10, 10);
  rippleLayer.speed = (CGFloat)0.5;
  rippleLayer.endAnimationDelay = (CGFloat)0.9;

  // When
  [rippleLayer endAnimationAtPoint:CGPointMake(5, 5)];
  NSTimeInterval startTime = CACurrentMediaTime();

  // Then
  XCTAssertEqual(rippleLayer.addedAnimations.count, 1U);
  CAAnimation *animation = rippleLayer.addedAnimations.firstObject;
  if (animation) {
    startTime = [rippleLayer convertTime:(startTime + 0.9) fromLayer:nil];
    XCTAssertEqualWithAccuracy(animation.beginTime, startTime, 0.010);
  }
}

- (void)testChangeAnimationTimingInTimeScaledLayer {
  // Given
  CapturingMDCRippleLayerSubclass *rippleLayer = [[CapturingMDCRippleLayerSubclass alloc] init];
  rippleLayer.bounds = CGRectMake(0, 0, 10, 10);
  rippleLayer.speed = (CGFloat)0.5;

  // When
  [rippleLayer changeAnimationAtPoint:CGPointMake(5, 5)];
  NSTimeInterval startTime = CACurrentMediaTime();

  // Then
  XCTAssertEqual(rippleLayer.addedAnimations.count, 1U);
  CAAnimation *animation = rippleLayer.addedAnimations.firstObject;
  if (animation) {
    startTime = [rippleLayer convertTime:startTime fromLayer:nil];
    XCTAssertEqualWithAccuracy(animation.beginTime, startTime, (CGFloat)0.1);
  }
}

@end
