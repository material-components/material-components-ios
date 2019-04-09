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
  //  self.recordMode = YES;

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

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testTouchesMoved {
  // Given
  NSSet *touchesSet = [NSSet setWithObject:[[UITouch alloc] init]];

  // When
  [self.button touchesMoved:touchesSet withEvent:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testTouchesEnded {
  // Given
  NSSet *touchesSet = [NSSet setWithObject:[[UITouch alloc] init]];

  // When
  [self.button touchesEnded:touchesSet withEvent:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testTouchesCancelled {
  // Given
  NSSet *touchesSet = [NSSet setWithObject:[[UITouch alloc] init]];

  // When
  [self.button touchesCancelled:touchesSet withEvent:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

@end

