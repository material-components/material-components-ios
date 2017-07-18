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

@import XCTest;
#import "MDCInkLayer+Testing.h"

#pragma mark - Property exposure

@interface MDCInkLayer (UnitTests)

@property(nonatomic, strong) NSMutableArray<MDCInkLayerForegroundRipple *> *foregroundRipples;
@property(nonatomic, strong) NSMutableArray<MDCInkLayerBackgroundRipple *> *backgroundRipples;

@end

#pragma mark - Subclasses for testing

@interface MDCFakeForegroundRipple : MDCInkLayerForegroundRipple

@property(nonatomic, assign) BOOL exitAnimationParameter;

@end

@implementation MDCFakeForegroundRipple

- (void)exit:(BOOL)animated {
  self.exitAnimationParameter = animated;
}

@end

@interface MDCFakeBackgroundRipple : MDCInkLayerBackgroundRipple

@property(nonatomic, assign) BOOL exitAnimationParameter;

@end

@implementation MDCFakeBackgroundRipple

- (void)exit:(BOOL)animated {
  self.exitAnimationParameter = animated;
}

@end

#pragma mark - Tests

@interface MDCInkLayerTests : XCTestCase
@end

@implementation MDCInkLayerTests

- (void)testResetRipplesWithoutAnimation {
  // Given
  MDCInkLayer *inkLayer = [[MDCInkLayer alloc] init];
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
  MDCInkLayer *inkLayer = [[MDCInkLayer alloc] init];
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

@end
