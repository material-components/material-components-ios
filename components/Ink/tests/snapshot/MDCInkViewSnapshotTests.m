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

#import "MaterialInk.h"

/** Snapshot tests for MDCInkView. */
@interface MDCInkViewSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCInkView *inkView;

@end

@implementation MDCInkViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.inkView = [[MDCInkView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
  self.inkView.backgroundColor = UIColor.whiteColor;
  self.inkView.inkColor = UIColor.brownColor;
}

- (void)tearDown {
  self.inkView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyView {
  [self.inkView startTouchBeganAtPoint:CGPointMake(CGRectGetMidX(self.inkView.bounds),
                                                   CGRectGetMidY(self.inkView.bounds))
                              animated:NO
                        withCompletion:nil];

  UIView *snapshotView = [self.inkView mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testNewBoundedInk {
  // When
  self.inkView.usesLegacyInkRipple = NO;
  self.inkView.inkStyle = MDCInkStyleBounded;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testNewUnboundedInkBeyondBounds {
  // When
  self.inkView.usesLegacyInkRipple = NO;
  self.inkView.inkStyle = MDCInkStyleBounded;
  self.inkView.maxRippleRadius = CGRectGetWidth(self.inkView.bounds) / 2 + 5;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testNewUnboundedInkWithinBounds {
  // When
  self.inkView.usesLegacyInkRipple = NO;
  self.inkView.inkStyle = MDCInkStyleBounded;
  self.inkView.maxRippleRadius = CGRectGetWidth(self.inkView.bounds) / 3;

  // Then
  [self generateSnapshotAndVerifyView];
}

@end
