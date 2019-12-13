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

#import "MaterialChips.h"

/**
 An MDCChipView subclass that allows the user to override the @c traitCollection property.
 */
@interface MDCChipViewLayoutCustomTraitCollectionFake : MDCChipView
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCChipViewLayoutCustomTraitCollectionFake
- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

/** Snapshot tests exercising the layout APIs for MDCChipView. */
@interface MDCChipViewLayoutSnapshotTests : MDCSnapshotTestCase

/** The chip being tested. */
@property(nonatomic, strong) MDCChipViewLayoutCustomTraitCollectionFake *chipView;
@end

@implementation MDCChipViewLayoutSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.chipView = [[MDCChipViewLayoutCustomTraitCollectionFake alloc] init];
  self.chipView.titleLabel.text = @"Chip";
  self.chipView.imageView.image = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)];
  UIImageView *accessoryView = [[UIImageView alloc] init];
  accessoryView.image = [UIImage mdc_testImageOfSize:CGSizeMake(18, 18)
                                           withStyle:MDCSnapshotTestImageStyleFramedX];
  self.chipView.accessoryView = accessoryView;

  self.chipView.titleLabel.layer.borderColor = UIColor.blueColor.CGColor;
  self.chipView.titleLabel.layer.borderWidth = 1;
  self.chipView.imageView.layer.borderColor = UIColor.orangeColor.CGColor;
  self.chipView.imageView.layer.borderWidth = 1;
  self.chipView.selectedImageView.layer.borderColor = UIColor.brownColor.CGColor;
  self.chipView.selectedImageView.layer.borderWidth = 1;
  self.chipView.accessoryView.layer.borderColor = UIColor.greenColor.CGColor;
  self.chipView.accessoryView.layer.borderWidth = 1;

  self.chipView.contentPadding = UIEdgeInsetsZero;
  self.chipView.titlePadding = UIEdgeInsetsZero;
  self.chipView.imagePadding = UIEdgeInsetsZero;
  self.chipView.accessoryPadding = UIEdgeInsetsZero;
}

- (void)tearDown {
  self.chipView = nil;
  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  CGSize aSize = [view sizeThatFits:CGSizeMake(300, INFINITY)];
  view.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testChipWithAllZeroPadding {
  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)changeToRTL:(MDCChipViewLayoutCustomTraitCollectionFake *)chip {
  if (@available(iOS 10.0, *)) {
    chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }
}

#pragma mark - ContentPadding

- (void)testChipContentPaddingAllPositiveValuesLTR {
  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingAllPositiveValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingAllNegativeValuesLTR {
  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingAllNegativeValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingShiftToLeadingEdgeLTR {
  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingShiftToLeadingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingShiftToTrailingEdgeLTR {
  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingShiftToTrailingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingShiftDown {
  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(20, 0, -20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipContentPaddingShiftUp {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.contentPadding = UIEdgeInsetsMake(-20, 0, 20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

#pragma mark - ImagePadding

- (void)testChipImagePaddingWithoutImagesLTR {
  // When
  self.chipView.imageView.image = nil;
  self.chipView.selectedImageView.image = nil;
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingAllPositiveValuesLTR {
  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingAllPositiveValuesForOnlySelectedImageLTR {
  // Given
  self.chipView.imageView.image = nil;
  self.chipView.selectedImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                         withStyle:MDCSnapshotTestImageStyleDiagonalLines];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testSelectedChipImagePaddingAllPositiveValuesForOnlySelectedImageLTR {
  // Given
  self.chipView.imageView.image = nil;
  self.chipView.selectedImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                         withStyle:MDCSnapshotTestImageStyleDiagonalLines];
  self.chipView.selected = YES;

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingAllPositiveValuesForLargeSelectedImageLTR {
  // Given
  self.chipView.selectedImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(32, 32)
                         withStyle:MDCSnapshotTestImageStyleDiagonalLines];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testSelectedChipImagePaddingAllPositiveValuesForLargeSelectedImageLTR {
  // Given
  self.chipView.selectedImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(32, 32)
                         withStyle:MDCSnapshotTestImageStyleDiagonalLines];
  self.chipView.selected = YES;

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingAllPositiveValuesForSmallSelectedImageLTR {
  // Given
  self.chipView.selectedImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(8, 8)
                         withStyle:MDCSnapshotTestImageStyleDiagonalLines];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testSelectedChipImagePaddingAllPositiveValuesForSmallSelectedImageLTR {
  // Given
  self.chipView.selectedImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(8, 8)
                         withStyle:MDCSnapshotTestImageStyleDiagonalLines];
  self.chipView.selected = YES;

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingAllPositiveValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingAllNegativeValuesLTR {
  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingAllNegativeValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingShiftToLeadingEdgeLTR {
  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingShiftToLeadingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingShiftToTrailingEdgeLTR {
  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingShiftToTrailingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingShiftDown {
  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(20, 0, -20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testUnselectedChipImagePaddingShiftUp {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.imagePadding = UIEdgeInsetsMake(-20, 0, 20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

#pragma mark - TitlePadding

- (void)testChipTitlePaddingAllPositiveValuesLTR {
  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingAllPositiveValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingAllNegativeValuesLTR {
  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingAllNegativeValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingShiftToLeadingEdgeLTR {
  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingShiftToLeadingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingShiftToTrailingEdgeLTR {
  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingShiftToTrailingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingShiftDown {
  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(20, 0, -20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipTitlePaddingShiftUp {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.titlePadding = UIEdgeInsetsMake(-20, 0, 20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

#pragma mark - AccessoryPadding

- (void)testChipAccessoryPaddingAllPositiveValuesLTR {
  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingAllPositiveValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(10, 20, 30, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingAllNegativeValuesLTR {
  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingAllNegativeValuesRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(-2, -4, -6, -8);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingShiftToLeadingEdgeLTR {
  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingShiftToLeadingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(0, -20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingShiftToTrailingEdgeLTR {
  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingShiftToTrailingEdgeRTL {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingShiftDown {
  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(20, 0, -20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

- (void)testChipAccessoryPaddingShiftUp {
  // Given
  [self changeToRTL:self.chipView];

  // When
  self.chipView.accessoryPadding = UIEdgeInsetsMake(-20, 0, 20, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chipView];
}

@end
