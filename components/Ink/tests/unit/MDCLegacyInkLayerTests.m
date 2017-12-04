/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MaterialInk.h"
#import "MDCLegacyInkLayer+Testing.h"

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
}

@end

@interface MDCFakeBackgroundRipple : MDCLegacyInkLayerBackgroundRipple

@property(nonatomic, assign) BOOL exitAnimationParameter;

@end

@implementation MDCFakeBackgroundRipple

- (void)exit:(BOOL)animated {
  self.exitAnimationParameter = animated;
}

@end

#pragma mark - XCTestCase

@interface MDCLegacyInkLayerTests : XCTestCase <MDCLegacyInkLayerRippleDelegate>
@property(nonatomic, strong) XCTestExpectation *expectation;
@property(nonatomic, strong) MDCLegacyInkLayer *inkLayer;
@end

@implementation MDCLegacyInkLayerTests

#pragma mark - <MDCLegacyInkLayerDelegate>

- (void)animationDidStop:(CAAnimation *)anim
              shapeLayer:(CAShapeLayer *)shapeLayer
                finished:(BOOL)finished {
  [self.inkLayer animationDidStop:anim shapeLayer:shapeLayer finished:finished];
  [self.expectation fulfill];
}

#pragma mark - Unit Tests

- (void)tearDown {
  self.expectation = nil;
  self.inkLayer = nil;
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

- (void)testForegroundRippleExitWithoutAnimation {
  // Given
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];
  MDCLegacyInkLayerForegroundRipple *foregroundRipple =
      [[MDCLegacyInkLayerForegroundRipple alloc] init];
  foregroundRipple.animationDelegate = self;
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 0U,
                 @"There should be no foreground ripples at the start of the test.");
  [self.inkLayer.foregroundRipples addObject:foregroundRipple];
  self.expectation = [self expectationWithDescription:@"Background ripple completion"];

  // When
  [self.inkLayer resetAllInk:NO];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
  XCTAssertEqual(self.inkLayer.foregroundRipples.count, 0U,
                 @"After exiting the only foreround ripple, the array should be empty.");
}

- (void)testBackgroundRippleExitWithoutAnimation {
  // Given
  self.inkLayer = [[MDCLegacyInkLayer alloc] init];
  MDCLegacyInkLayerBackgroundRipple *backgroundRipple =
      [[MDCLegacyInkLayerBackgroundRipple alloc] init];
  backgroundRipple.animationDelegate = self;
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 0U,
                 @"There should be no background ripples at the start of the test.");
  [self.inkLayer.backgroundRipples addObject:backgroundRipple];
  self.expectation = [self expectationWithDescription:@"Background ripple completion"];

  // When
  [self.inkLayer resetAllInk:NO];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
  XCTAssertEqual(self.inkLayer.backgroundRipples.count, 0U,
                 @"After exiting the only foreround ripple, the array should be empty.");
}

@end
