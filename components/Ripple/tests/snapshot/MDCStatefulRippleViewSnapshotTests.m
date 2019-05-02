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

#import "MaterialRipple.h"
#import "MaterialSnapshot.h"

/** Snapshot tests for MDCStatefulRippleView. */
@interface MDCStatefulRippleViewSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCStatefulRippleView *rippleView;
@property(nonatomic, strong) UIView *view;

@end

@implementation MDCStatefulRippleViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //   self.recordMode = YES;

  self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  self.view.backgroundColor = UIColor.whiteColor;
  self.rippleView = [[MDCStatefulRippleView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  [self.view addSubview:self.rippleView];
}

- (void)tearDown {
  self.view = nil;
  self.rippleView = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testDefaultRippleView {
  // Given
  [self.rippleView beginRippleTouchDownAtPoint:CGPointZero animated:NO completion:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

- (void)testSelectedRippleView {
  // Given
  self.rippleView.allowsSelection = YES;
  self.rippleView.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

- (void)testHighlightedRippleView {
  // Given
  self.rippleView.rippleHighlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

- (void)testDraggedRippleView {
  // Given
  self.rippleView.dragged = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

- (void)testRippleHighlightedIsNotDissolvedWhenSetToYES {
  // Given
  self.rippleView.layer.speed = 10000;
  [self.rippleView setRippleColor:UIColor.orangeColor forState:MDCRippleStateHighlighted];
  self.rippleView.rippleHighlighted = YES;
  [self.rippleView setValue:@YES forKey:@"_tapWentInsideOfBounds"];
  [self.rippleView setValue:@YES forKey:@"_tapWentOutsideOfBounds"];
  self.rippleView.rippleHighlighted = NO;
  [self.rippleView setValue:@NO forKey:@"_tapWentOutsideOfBounds"];
  self.rippleView.rippleHighlighted = YES;
  [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

@end
