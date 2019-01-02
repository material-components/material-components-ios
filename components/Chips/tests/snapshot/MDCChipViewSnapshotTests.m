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

@property(nonatomic, strong) MDCContainerScheme *scheme;
@property(nonatomic, strong) MDCChipView *chip;

@end

@implementation MDCChipViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.chip = [[MDCChipView alloc] init];
  self.chip.titleLabel.text = @"A Chip";
  self.scheme = [[MDCContainerScheme alloc] init];
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

- (UIImage *)leadingImage {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCChipViewSnapshotTests class]];
  UIImage *image = [UIImage imageNamed:@"ic_mask"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  return image;
}

- (UIButton *)deleteButton {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCChipViewSnapshotTests class]];
  UIImage *image = [UIImage imageNamed:@"ic_cancel"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
  button.tintColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.7];
  [button setImage:image forState:UIControlStateNormal];

  return button;
}

#pragma mark - Tests

- (void)testDefaultChip {
  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChip {
  // When
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChip {
  // When
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

#pragma mark - With Leading Image

- (void)testDefaultChipWithImage {
  // When
  self.chip.imageView.image = [self leadingImage];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithImage {
  // When
  self.chip.imageView.image = [self leadingImage];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithImage {
  // When
  self.chip.imageView.image = [self leadingImage];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

#pragma mark - With Accessory View

- (void)testDefaultChipWithAccessoryView {
  // When
  self.chip.accessoryView = [self deleteButton];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithAccessoryView {
  // When
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithAccessoryView {
  // When
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

#pragma mark - With Leading Image and Accessory View

- (void)testDefaultChipWithImageAndAccessoryView {
  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithImageAndAccessoryView {
  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithImageAndAccessoryView {
  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

@end
