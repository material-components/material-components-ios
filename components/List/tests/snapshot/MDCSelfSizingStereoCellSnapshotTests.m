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

#import "MaterialList.h"

/** Snapshot tests for MDCBaseCell. */
@interface MDCSelfSizingStereoCellSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCSelfSizingStereoCell *cell;

@end

@implementation MDCSelfSizingStereoCellSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  self.cell = [[MDCSelfSizingStereoCell alloc] initWithFrame:CGRectMake(0, 0, 240, 60)];
}

- (void)tearDown {
  self.cell = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testDefaultCell {
  // Then
  [self generateSnapshotAndVerifyForView:self.cell];
}

- (void)testCellWithTitleAndDetail {
  // When
  self.cell.titleLabel.text = @"Title";
  self.cell.detailLabel.text = @"Detail";

  // Then
  [self generateSnapshotAndVerifyForView:self.cell];
}

- (void)testCellWithTitleAndDetailAndImage {
  // When
  self.cell.titleLabel.text = @"Title";
  self.cell.detailLabel.text = @"Detail";
  self.cell.leadingImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                         withStyle:MDCSnapshotTestImageStyleCheckerboard];
  self.cell.trailingImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                         withStyle:MDCSnapshotTestImageStyleRectangles];

  // Then
  [self generateSnapshotAndVerifyForView:self.cell];
}

@end
