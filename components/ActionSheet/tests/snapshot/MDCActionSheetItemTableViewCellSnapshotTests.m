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

#import "MaterialSnapshot.h"

#import "MaterialActionSheet.h"
#import "../../src/private/MDCActionSheetItemTableViewCell.h"

/** Snapshot tests for @c MDCActionSheetItemTableViewCell. */
@interface MDCActionSheetItemTableViewCellSnapshotTests : MDCSnapshotTestCase

/** The cell that we take a snapshot of. */
@property(nonatomic, strong, nullable) MDCActionSheetItemTableViewCell *cell;

@end

@implementation MDCActionSheetItemTableViewCellSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
    self.recordMode = YES;

  self.cell = [[MDCActionSheetItemTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 500, 48)];
}

- (void)tearDown {
  self.cell = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)testCellWithTitleAndAction {
  // When
  self.cell.action = [MDCActionSheetAction actionWithTitle:@"Action 1" image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)] handler:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.cell];
}

@end
