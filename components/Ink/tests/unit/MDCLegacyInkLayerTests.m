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
#import "../../src/private/MDCLegacyInkLayer+Private.h"
#import "MDCLegacyInkLayer.h"
#import "MDCLegacyInkLayerRippleDelegate.h"

#pragma mark - Property exposure

@interface MDCLegacyInkLayer (UnitTests)

@property(nonatomic, strong) NSMutableArray<MDCLegacyInkLayerForegroundRipple *> *foregroundRipples;
@property(nonatomic, strong) NSMutableArray<MDCLegacyInkLayerBackgroundRipple *> *backgroundRipples;

@end

@interface MDCLegacyInkLayerRipple (UnitTests)

@property(nonatomic, weak) id<MDCLegacyInkLayerRippleDelegate> animationDelegate;

@end

#pragma mark - Subclasses for testing

@interface MDCFakeForegroundRipple : MDCLegacyInkLayerForegroundRipple

@property(nonatomic, assign) BOOL exitAnimationParameter;

@end

@implementation MDCFakeForegroundRipple

- (void)exit:(BOOL)animated {
  self.exitAnimationParameter = animated;
  [super exit:animated];
}

@end

@interface MDCFakeBackgroundRipple : MDCLegacyInkLayerBackgroundRipple

@property(nonatomic, assign) BOOL exitAnimationParameter;

@end

@implementation MDCFakeBackgroundRipple

- (void)exit:(BOOL)animated {
  self.exitAnimationParameter = animated;
  [super exit:animated];
}

@end

#pragma mark - XCTestCase

@interface MDCLegacyInkLayerTests : XCTestCase <MDCLegacyInkLayerRippleDelegate>
@property(nonatomic, strong) XCTestExpectation *animationDidStartExpectation;
@property(nonatomic, strong) XCTestExpectation *animationDidStopExpectation;

@property(nonatomic, assign) NSInteger legacyInkLayerAnimationDidStartCount;
@property(nonatomic, strong) XCTestExpectation *legacyInkLayerAnimationDidStartExpectation;
@property(nonatomic, assign) NSInteger legacyInkLayerAnimationDidEndCount;
@property(nonatomic, strong) XCTestExpectation *legacyInkLayerAnimationDidEndExpectation;

@property(nonatomic, strong) MDCLegacyInkLayer *inkLayer;
@end

@implementation MDCLegacyInkLayerTests

#pragma mark - <MDCLegacyInkLayerDelegate>

- (void)animationDidStart:(MDCLegacyInkLayerRipple *)shapeLayer {
  [self.inkLayer animationDidStart:shapeLayer];
  [self.animationDidStartExpectation fulfill];
}

- (void)animationDidStop:(CAAnimation *)anim
              shapeLayer:(CAShapeLayer *)shapeLayer
                finished:(BOOL)finished {
  [self.inkLayer animationDidStop:anim shapeLayer:shapeLayer finished:finished];
  [self.animationDidStopExpectation fulfill];
}

- (void)legacyInkLayerAnimationDidStart:(MDCLegacyInkLayer *)inkLayer {
  self.legacyInkLayerAnimationDidStartCount += 1;
  [self.legacyInkLayerAnimationDidStartExpectation fulfill];
}

- (void)legacyInkLayerAnimationDidEnd:(MDCLegacyInkLayer *)inkLayer {
  self.legacyInkLayerAnimationDidEndCount += 1;
  [self.legacyInkLayerAnimationDidEndExpectation fulfill];
}

#pragma mark - Unit Tests

- (void)tearDown {
  self.animationDidStartExpectation = nil;
  self.animationDidStopExpectation = nil;
  self.legacyInkLayerAnimationDidStartExpectation = nil;
  self.legacyInkLayerAnimationDidEndExpectation = nil;
  self.inkLayer = nil;
}

- (void)testInit {
  // Given
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];

  // Then
  XCTAssertTrue(self.inkLayer.isBounded);
  XCTAssertFalse(self.inkLayer.isAnimating);
  XCTAssertFalse(self.inkLayer.useCustomInkCenter);
  XCTAssertTrue(CGPointEqualToPoint(self.inkLayer.customInkCenter, CGPointZero),
                @"%@ is not equal to %@", NSStringFromCGPoint(self.inkLayer.customInkCenter),
                NSStringFromCGPoint(CGPointZero));
  XCTAssertFalse(self.inkLayer.userLinearExpansion);
  XCTAssertEqualWithAccuracy(self.inkLayer.evaporateDuration, 0, 0.0001);
  XCTAssertEqualWithAccuracy(self.inkLayer.spreadDuration, 0, 0.0001);
  XCTAssertEqualWithAccuracy(self.inkLayer.maxRippleRadius, 0, 0.0001);
  XCTAssertNotNil(self.inkLayer.inkColor);
}

- (void)testResetRipplesWithoutAnimation {
  // Given
  MDCLegacyInkLayer *inkLayer = [[MDCLegacyInkLayer alloc] init];
  MDCFakeForegroundRipple *fakeForegroundRipple = [[MDCFakeForegroundRipple alloc] init];
  MDCFakeBackgroundRipple *fakeBackgroundRipple = [[MDCFakeBackgroundRipple alloc] init];

  // When
  [inkLayer.foregroundRipples addObject:fakeForegroundRipple];
  [inkLayer.backgroundRipples addObject:fakeBackgroundRipple];
  [inkLayer resetAllInk:NO];

  // Then
  XCTAssertFalse(fakeForegroundRipple.exitAnimationParameter,
                 @"When calling without animation, the ripple should receive a 'NO' argument");
  XCTAssertFalse(fakeBackgroundRipple.exitAnimationParameter,
                 @"When calling without animation, the ripple should receive a 'NO' argument");
}

- (void)testResetRipplesWithAnimation {
  // Given
  MDCLegacyInkLayer *inkLayer = [[MDCLegacyInkLayer alloc] init];
  MDCFakeForegroundRipple *fakeForegroundRipple = [[MDCFakeForegroundRipple alloc] init];
  MDCFakeBackgroundRipple *fakeBackgroundRipple = [[MDCFakeBackgroundRipple alloc] init];

  // When
  [inkLayer.foregroundRipples addObject:fakeForegroundRipple];
  [inkLayer.backgroundRipples addObject:fakeBackgroundRipple];
  [inkLayer resetAllInk:YES];

  // Then
  XCTAssertTrue(fakeForegroundRipple.exitAnimationParameter,
                @"When calling without animation, the ripple should receive a 'NO' argument");
  XCTAssertTrue(fakeBackgroundRipple.exitAnimationParameter,
                @"When calling without animation, the ripple should receive a 'NO' argument");
}

- (void)testForegroundRippleWillEnterWithAnimation {
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];
  self.inkLayer.animationDelegate = self;

  MDCLegacyInkLayerForegroundRipple *foregroundRipple =
      [[MDCLegacyInkLayerForegroundRipple alloc] init];
  foregroundRipple.animationDelegate = self;
  XCTAssertEqual(self.inkLayer.foregroundRipples.count, 0U,
                 @"There should be no foreground ripples at the start of the test.");
  [self.inkLayer.foregroundRipples addObject:foregroundRipple];
  self.animationDidStartExpectation =
      [self expectationWithDescription:@"Foreground ripple start animation"];

  // When
  [self.inkLayer enterAllInks];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];

  XCTAssertTrue(self.inkLayer.isAnimating,
                @"When calling without animation, the ripple should receive a 'NO' argument");
  XCTAssertEqual(self.inkLayer.foregroundRipples.count, 1U,
                 @"There should be no foreground ripples at the start of the test.");
}

- (void)testBackgroundRippleWillEnterWithAnimation {
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];

  MDCLegacyInkLayerBackgroundRipple *backgroundRipple =
      [[MDCLegacyInkLayerBackgroundRipple alloc] init];
  backgroundRipple.animationDelegate = self;
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 0U,
                 @"There should be no background ripples at the start of the test.");
  [self.inkLayer.backgroundRipples addObject:backgroundRipple];
  self.animationDidStartExpectation =
      [self expectationWithDescription:@"Background ripple start animation"];

  // When
  [self.inkLayer enterAllInks];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];

  XCTAssertTrue(self.inkLayer.isAnimating,
                @"When calling without animation, the ripple should receive a 'NO' argument");
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 1U,
                 @"There should be no foreground ripples at the start of the test.");
}

- (void)testForegroundRippleDidExitWithoutAnimation {
  // Given
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];
  MDCLegacyInkLayerForegroundRipple *foregroundRipple =
      [[MDCLegacyInkLayerForegroundRipple alloc] init];
  foregroundRipple.animationDelegate = self;
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 0U,
                 @"There should be no foreground ripples at the start of the test.");
  [self.inkLayer.foregroundRipples addObject:foregroundRipple];
  self.animationDidStopExpectation =
      [self expectationWithDescription:@"Background ripple completion"];

  // When
  [self.inkLayer resetAllInk:NO];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
  XCTAssertEqual(self.inkLayer.foregroundRipples.count, 0U,
                 @"After exiting the only foreround ripple, the array should be empty.");
}

- (void)testBackgroundRippleDidExitWithoutAnimation {
  // Given
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];
  MDCLegacyInkLayerBackgroundRipple *backgroundRipple =
      [[MDCLegacyInkLayerBackgroundRipple alloc] init];
  backgroundRipple.animationDelegate = self;
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 0U,
                 @"There should be no background ripples at the start of the test.");
  [self.inkLayer.backgroundRipples addObject:backgroundRipple];
  self.animationDidStopExpectation =
      [self expectationWithDescription:@"Background ripple completion"];

  // When
  [self.inkLayer resetAllInk:NO];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 0U,
                 @"After exiting the only background ripple, the array should be empty.");
}

- (void)testLegacyInkLayerAnimationCallbacksCalled {
  // Given
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];
  self.inkLayer.animationDelegate = self;
  MDCFakeForegroundRipple *fakeForegroundRipple = [[MDCFakeForegroundRipple alloc] init];
  fakeForegroundRipple.animationDelegate = self;
  MDCFakeBackgroundRipple *fakeBackgroundRipple = [[MDCFakeBackgroundRipple alloc] init];
  fakeBackgroundRipple.animationDelegate = self;

  [self.inkLayer.foregroundRipples addObject:fakeForegroundRipple];
  [self.inkLayer.backgroundRipples addObject:fakeBackgroundRipple];

  // When
  self.legacyInkLayerAnimationDidStartExpectation =
      [self expectationWithDescription:@"Legacy Ink Layer animation did start"];
  [self.inkLayer enterAllInks];
  [self waitForExpectationsWithTimeout:5 handler:nil];

  XCTAssertTrue(self.inkLayer.isAnimating,
                @"After legacy ink animation did end callback there should be no animation.");
  XCTAssertEqual(self.legacyInkLayerAnimationDidStartCount, 1U,
                 @"The legacy ink animation did start callback should only be called once");

  // When
  self.legacyInkLayerAnimationDidEndExpectation =
      [self expectationWithDescription:@"Legacy Ink Layer animation did end"];
  [self.inkLayer resetAllInk:NO];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
  XCTAssertFalse(self.inkLayer.isAnimating,
                 @"After legacy ink animation did end callback there should be no animation.");
  XCTAssertEqual(
      self.inkLayer.foregroundRipples.count, 0U,
      @"After legacy ink animation did end callback, the foreground ripples array should empty.");
  XCTAssertEqual(
      self.inkLayer.backgroundRipples.count, 0U,
      @"After legacy ink animation did end callback, the background ripples array should empty.");
  XCTAssertEqual(self.legacyInkLayerAnimationDidEndCount, 1U,
                 @"The legacy ink animation did end callback should only be called once");
}

@end
