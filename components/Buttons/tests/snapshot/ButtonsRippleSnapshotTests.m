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

#import "MaterialSnapshot.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialButtons.h"

/** Snapshot tests for @c MDCButton when @c enableRippleBehavior is @c YES. */
@interface ButtonsRippleSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCButton *button;
@end

@implementation ButtonsRippleSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
    self.recordMode = YES;

  self.button = [[MDCButton alloc] init];
  self.button.enableRippleBehavior = YES;
  UIImage *testImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.button setImage:testImage forState:UIControlStateNormal];
  [self.button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
  self.button.backgroundColor = UIColor.whiteColor;
  [self.button sizeToFit];
  self.button.layer.speed = 10000;
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view sizeToFit];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testNormalState {
  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testHighlightedState {
  // When
  self.button.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testSelectedState {
  // When
  self.button.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testDisabledState {
  // When
  self.button.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testHighlightedSelectedState {
  // When
  self.button.highlighted = YES;
  self.button.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testTouchesBegan {
  // Given
  NSSet *touchesSet = [NSSet setWithObject:[[UITouch alloc] init]];

  // When
  [self.button touchesBegan:touchesSet withEvent:nil];
  [self drainMainRunLoop];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testTouchesMoved {
  // Given
  NSSet *touchesSet = [NSSet setWithObject:[[UITouch alloc] init]];

  // When
  [self.button touchesMoved:touchesSet withEvent:nil];
  [self drainMainRunLoop];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testTouchesEnded {
  // Given
  NSSet *touchesSet = [NSSet setWithObject:[[UITouch alloc] init]];

  // When
  [self.button touchesEnded:touchesSet withEvent:nil];
  [self drainMainRunLoop];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testTouchesCancelled {
  // Given
  NSSet *touchesSet = [NSSet setWithObject:[[UITouch alloc] init]];

  // When
  [self.button touchesCancelled:touchesSet withEvent:nil];
  [self drainMainRunLoop];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Inserts a semaphore block into the main run loop and then waits for that sempahore to be executed.
 This enables other queued actions on the main loop to issue within unit tests.  For example, it can
 allow animation blocks to execute, but does not necessarily wait for them to complete.

 Note: Although an imperfect solution, it unblocks snapshot testing for now and reduces flakiness.
 */
- (void)drainMainRunLoop {
  XCTestExpectation *expectation = [self expectationWithDescription:@"draining the main run loop"];

  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });

  [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end

