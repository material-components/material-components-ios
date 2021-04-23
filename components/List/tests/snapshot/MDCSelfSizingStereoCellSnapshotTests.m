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
#import "MaterialTypographyScheme.h"

static NSString *const kSelfSizingStereoCellIdentifier = @"kSelfSizingStereoCellIdentifier";

@interface MDCSelfSizingStereoCellSnapshotTestsContentSizeCategoryOverrideWindow : UIWindow

/** Used to override the value of @c preferredContentSizeCategory. */
@property(nonatomic, copy) UIContentSizeCategory contentSizeCategoryOverride;

@end

@implementation MDCSelfSizingStereoCellSnapshotTestsContentSizeCategoryOverrideWindow

- (instancetype)init {
  self = [super init];
  if (self) {
    self.contentSizeCategoryOverride = UIContentSizeCategoryLarge;
  }
  return self;
}

- (UITraitCollection *)traitCollection {
  UITraitCollection *traitCollection = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:self.contentSizeCategoryOverride];
  return traitCollection;
}

@end

/** Snapshot tests for MDCBaseCell. */
@interface MDCSelfSizingStereoCellSnapshotTests : MDCSnapshotTestCase <UICollectionViewDataSource>

/** The view being tested. */
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property(nonatomic, strong) NSArray *arrayOfCells;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation MDCSelfSizingStereoCellSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionViewLayout.estimatedItemSize = CGSizeMake(240, 75);
  self.collectionViewLayout.minimumInteritemSpacing = 1;
  self.collectionViewLayout.minimumLineSpacing = 0;
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240, 100)
                                           collectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = UIColor.grayColor;
  [self.collectionView registerClass:[MDCSelfSizingStereoCell class]
          forCellWithReuseIdentifier:kSelfSizingStereoCellIdentifier];
  self.collectionView.dataSource = self;
}

- (void)tearDown {
  [self.collectionView removeFromSuperview];
  self.collectionView = nil;
  self.collectionViewLayout = nil;
  self.typographyScheme = nil;

  [super tearDown];
}

- (UIWindow *)generateWindowWithView:(UIView *)view
                 contentSizeCategory:(UIContentSizeCategory)sizeCategory
                              insets:(UIEdgeInsets)insets {
  MDCSelfSizingStereoCellSnapshotTestsContentSizeCategoryOverrideWindow *backgroundWindow =
      [[MDCSelfSizingStereoCellSnapshotTestsContentSizeCategoryOverrideWindow alloc]
          initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds) + insets.left + insets.right,
                                   CGRectGetHeight(view.bounds) + insets.top + insets.bottom)];
  backgroundWindow.contentSizeCategoryOverride = sizeCategory;
  backgroundWindow.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.8 alpha:1];
  [backgroundWindow addSubview:view];
  backgroundWindow.hidden = NO;

  CGRect frame = view.frame;
  frame.origin = CGPointMake(insets.left, insets.top);
  view.frame = frame;

  return backgroundWindow;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

// TODO(https://github.com/material-components/material-components-ios/issues/7487):
// The size of the cell view sent for snapshot is not correct because Autolayout needs
// to be used as an environment.
- (void)generateSnapshotWithContentSizeCategoryAndNotificationPost:
            (UIContentSizeCategory)sizeCategory
                                                  andVerifyForView:(UIView *)view {
  UIWindow *snapshotWindow = [self generateWindowWithView:view
                                      contentSizeCategory:sizeCategory
                                                   insets:UIEdgeInsetsMake(10, 10, 10, 10)];
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];
  [self.collectionView reloadData];
  [self snapshotVerifyView:snapshotWindow];
}

#pragma mark - Tests

- (void)testCellWithTitleAndDetail {
  // When
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  cell.titleLabel.text = @"Title";
  cell.detailLabel.text = @"Detail";
  self.arrayOfCells = @[ cell ];

  // Then
  [self generateSnapshotAndVerifyForView:self.collectionView];
}

- (void)testCellWithTitleAndDetailAndImage {
  // When
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  cell.titleLabel.text = @"Title";
  cell.detailLabel.text = @"Detail";
  cell.leadingImageView.image = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                   withStyle:MDCSnapshotTestImageStyleCheckerboard];
  cell.trailingImageView.image = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                    withStyle:MDCSnapshotTestImageStyleRectangles];
  self.arrayOfCells = @[ cell ];

  // Then
  [self generateSnapshotAndVerifyForView:self.collectionView];
}

- (void)testCellWithTitleAndDetailAndVerticallyCenteredImage {
  // When
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  cell.titleLabel.text = @"This is a title label. This is a title label. This is a title label. "
                         @"This is a title label. This is a title label.";
  cell.detailLabel.text = @"This is a detail label. This is a detail label. This is a detail "
                          @"label. This is a detail label. This is a detail label.";
  cell.leadingImageView.image = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                   withStyle:MDCSnapshotTestImageStyleCheckerboard];
  cell.trailingImageView.image = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                    withStyle:MDCSnapshotTestImageStyleRectangles];
  cell.leadingImageViewVerticalPosition = MDCSelfSizingStereoCellImageViewVerticalPositionCenter;
  cell.trailingImageViewVerticalPosition = MDCSelfSizingStereoCellImageViewVerticalPositionCenter;
  self.arrayOfCells = @[ cell ];

  CGSize cellSize = [cell systemLayoutSizeFittingSize:CGSizeMake(170, CGFLOAT_MAX)];
  self.collectionView.frame = CGRectMake(0, 0, cellSize.width, cellSize.height);
  self.collectionViewLayout.estimatedItemSize = cellSize;

  // Then
  [self generateSnapshotAndVerifyForView:self.collectionView];
}

- (void)testCellWithDynamicTypeForContentSizeCategoryExtraSmallEnabledForTitleAndDetail {
  // Given
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  self.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // When
  cell.titleLabel.text = @"Title";
  cell.titleLabel.font = self.typographyScheme.subtitle1;
  cell.detailLabel.text = @"Detail";
  cell.detailLabel.font = self.typographyScheme.button;
  cell.mdc_adjustsFontForContentSizeCategory = YES;
  self.arrayOfCells = @[ cell ];

  // Then
  [self generateSnapshotWithContentSizeCategoryAndNotificationPost:UIContentSizeCategoryExtraSmall
                                                  andVerifyForView:self.collectionView];
}

- (void)testCellWithDynamicTypeForContentSizeCategoryExtraLargeEnabledForTitleAndDetail {
  // Given
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  self.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // When
  cell.titleLabel.text = @"Title";
  cell.titleLabel.font = self.typographyScheme.subtitle1;
  cell.detailLabel.text = @"Detail";
  cell.detailLabel.font = self.typographyScheme.button;
  cell.mdc_adjustsFontForContentSizeCategory = YES;
  self.arrayOfCells = @[ cell ];

  // Then
  [self generateSnapshotWithContentSizeCategoryAndNotificationPost:UIContentSizeCategoryExtraLarge
                                                  andVerifyForView:self.collectionView];
}

- (void)testPreferredFontForAXXLContentSizeCategory {
  if (@available(iOS 11.0, *)) {
    // Given
    MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
    cell.titleLabel.text = @"Title";
    cell.detailLabel.text = @"Detail";
    self.arrayOfCells = @[ cell ];

    // When
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    UIFont *font = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:12]];
    cell.titleLabel.font = font;
    cell.detailLabel.font = font;
    cell.titleLabel.adjustsFontForContentSizeCategory = YES;
    cell.detailLabel.adjustsFontForContentSizeCategory = YES;
    self.collectionView.frame = CGRectMake(0, 0, 240, 150);
    self.collectionViewLayout.estimatedItemSize = CGSizeMake(240, 150);

    // Then
    [self generateSnapshotWithContentSizeCategoryAndNotificationPost:
              UIContentSizeCategoryExtraExtraLarge
                                                    andVerifyForView:self.collectionView];
  }
}

- (void)testPreferredFontForAXSContentSizeCategory {
  if (@available(iOS 11.0, *)) {
    // Given
    MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
    cell.titleLabel.text = @"Title";
    cell.detailLabel.text = @"Detail";
    self.arrayOfCells = @[ cell ];

    // When
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    UIFont *font = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:12]];
    cell.titleLabel.font = font;
    cell.detailLabel.font = font;
    cell.titleLabel.adjustsFontForContentSizeCategory = YES;
    cell.detailLabel.adjustsFontForContentSizeCategory = YES;
    self.collectionView.frame = CGRectMake(0, 0, 240, 150);
    self.collectionViewLayout.estimatedItemSize = CGSizeMake(240, 150);

    // Then
    [self generateSnapshotWithContentSizeCategoryAndNotificationPost:UIContentSizeCategoryExtraSmall
                                                    andVerifyForView:self.collectionView];
  }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.arrayOfCells.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCSelfSizingStereoCell *dequeuedCell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kSelfSizingStereoCellIdentifier
                                                forIndexPath:indexPath];
  // Temporarily add dequeuedCell as a subview of collectionView
  // to inherit traitCollection. The dequeuedCell will be removed
  // from parent at the end of this method.
  [self.collectionView addSubview:dequeuedCell];
  MDCSelfSizingStereoCell *cell = self.arrayOfCells[indexPath.item];

  // Change backgroundColor to distinguish cell from the collection view.
  dequeuedCell.backgroundColor = UIColor.whiteColor;
  dequeuedCell.titleLabel.text = cell.titleLabel.text;
  dequeuedCell.titleLabel.font = cell.titleLabel.font;
  dequeuedCell.titleLabel.adjustsFontForContentSizeCategory =
      cell.titleLabel.adjustsFontForContentSizeCategory;
  dequeuedCell.detailLabel.text = cell.detailLabel.text;
  dequeuedCell.detailLabel.font = cell.detailLabel.font;
  dequeuedCell.detailLabel.adjustsFontForContentSizeCategory =
      cell.detailLabel.adjustsFontForContentSizeCategory;
  dequeuedCell.leadingImageView.image = cell.leadingImageView.image;
  dequeuedCell.trailingImageView.image = cell.trailingImageView.image;
  dequeuedCell.mdc_adjustsFontForContentSizeCategory = cell.mdc_adjustsFontForContentSizeCategory;
  dequeuedCell.leadingImageViewVerticalPosition = cell.leadingImageViewVerticalPosition;
  dequeuedCell.trailingImageViewVerticalPosition = cell.trailingImageViewVerticalPosition;
  [dequeuedCell removeFromSuperview];
  return dequeuedCell;
}

@end
