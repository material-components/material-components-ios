// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MaterialSnapshot.h"
#import "MaterialThumbTrack.h"

@interface MDCThumbTrackSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCThumbTrack *thumbTrack;

@end

@implementation MDCThumbTrackSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.thumbTrack = [[MDCThumbTrack alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
  self.thumbTrack.thumbRadius = 10;
  self.thumbTrack.trackHeight = 3;
  self.thumbTrack.trackOnColor = UIColor.blueColor;
  self.thumbTrack.trackOffColor = UIColor.redColor;
  self.thumbTrack.value = 0;
  self.thumbTrack.minimumValue = -10;
  self.thumbTrack.maximumValue = 10;
  self.thumbTrack.backgroundColor = UIColor.whiteColor;
  self.thumbTrack.thumbEnabledColor = UIColor.blackColor;
}

- (void)tearDown {
  self.thumbTrack = nil;

  [super tearDown];
}

- (void)generateSnapshotWithBorderAndVerifyForView:(MDCThumbTrack *)view {
  // TODO(b/161927075): Refactor when this functionality is available in MaterialSnapshot.
  UIView *thumbTrackFrameView = [[UIView alloc] initWithFrame:view.bounds];
  [view addSubview:thumbTrackFrameView];
  thumbTrackFrameView.layer.borderColor = UIColor.yellowColor.CGColor;
  thumbTrackFrameView.layer.borderWidth = 0.5f;

  UIView *thumbViewFrameView = [[UIView alloc] initWithFrame:view.thumbView.bounds];
  [view.thumbView addSubview:thumbViewFrameView];
  thumbViewFrameView.layer.borderColor = UIColor.yellowColor.CGColor;
  thumbViewFrameView.layer.borderWidth = 0.5f;

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];

  [thumbViewFrameView removeFromSuperview];
  [thumbTrackFrameView removeFromSuperview];
}

#pragma mark - Tests

- (void)testThumbTrackAtMidpoint {
  // When
  self.thumbTrack.value = self.thumbTrack.minimumValue +
                          (self.thumbTrack.maximumValue - self.thumbTrack.minimumValue) / 2;

  // Then
  [self generateSnapshotWithBorderAndVerifyForView:self.thumbTrack];
}

- (void)testThumbTrackAtMinimum {
  // When
  self.thumbTrack.value = self.thumbTrack.minimumValue;

  // Then
  [self generateSnapshotWithBorderAndVerifyForView:self.thumbTrack];
}

- (void)testThumbTrackAtMaximum {
  // When
  self.thumbTrack.value = self.thumbTrack.maximumValue;

  // Then
  [self generateSnapshotWithBorderAndVerifyForView:self.thumbTrack];
}

@end
