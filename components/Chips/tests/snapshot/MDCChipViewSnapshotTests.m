// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"
#import "MaterialSnapshot.h"

@interface MDCChipViewSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCChipView *chip;

@end

@implementation MDCChipViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
    self.recordMode = YES;

  self.chip = [[MDCChipView alloc] init];
  self.chip.titleLabel.text = @"A Chip";
}

- (void)tearDown {
  self.chip = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  CGSize aSize = [view sizeThatFits:CGSizeMake(300, INFINITY)];
  view.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testDefaultChip {
  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

@end
