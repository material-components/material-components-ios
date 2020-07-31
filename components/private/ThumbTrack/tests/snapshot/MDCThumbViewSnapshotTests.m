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

@interface MDCThumbViewSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCThumbView *thumbView;

@end

@implementation MDCThumbViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.thumbView = [[MDCThumbView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
  self.thumbView.backgroundColor = UIColor.blueColor;
}

- (void)tearDown {
  self.thumbView = nil;

  [super tearDown];
}

- (void)generateSnapshotWithBorderAndVerifyForView:(MDCThumbView *)view {
  // TODO(b/161927075): Refactor when this functionality is available in MaterialSnapshot.
  UIView *thumbViewFrameView = [[UIView alloc] initWithFrame:view.bounds];
  [view addSubview:thumbViewFrameView];
  thumbViewFrameView.layer.borderColor = UIColor.yellowColor.CGColor;
  thumbViewFrameView.layer.borderWidth = 0.5f;

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];

  [thumbViewFrameView removeFromSuperview];
}

#pragma mark - Tests

- (void)testThumbViewFullyRoundedDefaults {
  // When
  self.thumbView.cornerRadius = CGRectGetWidth(self.thumbView.bounds) / 2;

  // Then
  [self generateSnapshotWithBorderAndVerifyForView:self.thumbView];
}

- (void)testThumbViewWhenCenterVisibleAreaIsTrue {
  // When
  self.thumbView.centerVisibleArea = YES;
  self.thumbView.cornerRadius = 10;

  // Then
  [self generateSnapshotWithBorderAndVerifyForView:self.thumbView];
}

@end
