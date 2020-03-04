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

#import "MaterialChips.h"
#import "MaterialSnapshot.h"

@interface MDCChipFieldSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCChipField *chipField;
@end

@implementation MDCChipFieldSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  CGRect chipFieldFrame = CGRectMake(0, 0, 300, 300);
  self.chipField = [[MDCChipField alloc] initWithFrame:chipFieldFrame];
  self.chipField.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
  self.chipField.textField.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
}

- (void)tearDown {
  self.chipField = nil;

  [super tearDown];
}

- (void)testLayoutEmpty {
  [self snapshotVerifyView:self.chipField];
}

- (void)testTextFieldIsOnTheSameLineAsNarrowChips {
  // When
  [self.chipField addChip:[self chipViewWithTitle:@"ab"]];
  [self.chipField addChip:[self chipViewWithTitle:@"cd"]];
  [self.chipField addChip:[self chipViewWithTitle:@"ef"]];

  // Then
  [self snapshotVerifyView:self.chipField];
}

- (void)testTextFieldIsOnTheLineBelowChipsWhenPlaceholderIsPreset {
  // Given
  self.chipField.textField.placeholder = @"Placeholder Placeholder";

  // When
  [self.chipField addChip:[self chipViewWithTitle:@"ab"]];
  [self.chipField addChip:[self chipViewWithTitle:@"cd"]];
  [self.chipField addChip:[self chipViewWithTitle:@"ef"]];

  // Then
  [self snapshotVerifyView:self.chipField];
}


- (void)testTextFieldIsOnLineBelowWideChips {
  // When
  [self.chipField addChip:[self chipViewWithTitle:@"chipper1234asdf@gmail.com"]];
  [self.chipField addChip:[self chipViewWithTitle:@"chipper4567qwer@gmail.com"]];
  [self.chipField addChip:[self chipViewWithTitle:@"chipper8901zxcv@gmail.com"]];

  // Then
  [self snapshotVerifyView:self.chipField];
}

- (void)testTextFieldWithZeroMinimumWidthIsOnSameLineAsWideChips {
  // Given
  self.chipField.minTextFieldWidth = 0;

  // When
  [self.chipField addChip:[self chipViewWithTitle:@"chipper1234asdf@gmail.com"]];
  [self.chipField addChip:[self chipViewWithTitle:@"chipper4567qwer@gmail.com"]];
  [self.chipField addChip:[self chipViewWithTitle:@"chipper8901zxcv@gmail.com"]];

  // Then
  [self snapshotVerifyView:self.chipField];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  CGSize aSize = [view sizeThatFits:CGSizeMake(300, INFINITY)];
  view.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (MDCChipView *)chipViewWithTitle:(NSString *)title {
  MDCChipView *chipView = [[MDCChipView alloc] init];
  chipView.titleLabel.text = title;
  return chipView;
}

@end
