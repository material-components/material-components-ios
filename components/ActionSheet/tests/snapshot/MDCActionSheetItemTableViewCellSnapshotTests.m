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

#import "MDCActionSheetAction.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCActionSheetItemTableViewCell.h"
#import "MDCSnapshotTestCase.h"
#import "UIImage+MDCSnapshot.h"
#import "UIView+MDCSnapshot.h"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

/** Snapshot tests for @c MDCActionSheetItemTableViewCell. */
@interface MDCActionSheetItemTableViewCellSnapshotTests : MDCSnapshotTestCase

/** The cell that we take a snapshot of. */
@property(nonatomic, strong, nullable) MDCActionSheetItemTableViewCell *cell;

/** A @c MDCActionSheetAction used to create the cell we will test. */
@property(nonatomic, strong, nullable) MDCActionSheetAction *action;

@end

@implementation MDCActionSheetItemTableViewCellSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.cell = [[MDCActionSheetItemTableViewCell alloc] init];
  self.action =
      [MDCActionSheetAction actionWithTitle:@"Action 1"
                                      image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
                                    handler:nil];
}

- (void)tearDown {
  self.action = nil;
  self.cell = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForCell {
  [self layoutCell];
  UIView *snapshotView = [self.cell mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)layoutCell {
  self.cell.backgroundColor = UIColor.whiteColor;
  self.cell.frame = CGRectMake(0, 0, 500, 75);
  [self.cell setNeedsLayout];
  [self.cell layoutIfNeeded];
}

- (void)testCellWithTitleAndImage {
  // When
  self.cell.action = self.action;

  // Then
  [self generateSnapshotAndVerifyForCell];
}

- (void)testCellWithTitleAndImageAndDivider {
  // When
  self.cell.action = self.action;
  self.cell.showsDivider = YES;
  self.cell.dividerColor = UIColor.greenColor;

  // Then
  [self generateSnapshotAndVerifyForCell];
}

- (void)testCellWithTitleImageAndDividerAndPositiveContentEdgeInsets {
  // When
  self.cell.action = self.action;
  self.cell.showsDivider = YES;
  self.cell.dividerColor = UIColor.greenColor;
  self.cell.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 16);

  // Then
  [self generateSnapshotAndVerifyForCell];
}

- (void)testCellWithTitleImageAndDividerAndNegativeContentEdgeInsets {
  // When
  self.cell.action = self.action;
  self.cell.showsDivider = YES;
  self.cell.dividerColor = UIColor.greenColor;
  self.cell.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, -16);

  // Then
  [self generateSnapshotAndVerifyForCell];
}

- (void)testCellWithTitleImageAndDividerUnbalancedContentEdgeInsets {
  // When
  self.cell.action = self.action;
  self.cell.showsDivider = YES;
  self.cell.dividerColor = UIColor.greenColor;
  self.cell.contentEdgeInsets = UIEdgeInsetsMake(-4, -8, -12, -16);

  // Then
  [self generateSnapshotAndVerifyForCell];
}

- (void)testCellWithTitleImageAndDividerClearColor {
  // When
  self.cell.action = self.action;
  self.cell.showsDivider = YES;

  // Then
  [self generateSnapshotAndVerifyForCell];
}

@end

NS_ASSUME_NONNULL_END
