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
  if (@available(iOS 10.0, *)) {
    UITraitCollection *traitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:self.contentSizeCategoryOverride];
    return traitCollection;
  }
  return [super traitCollection];
}

@end

/** Snapshot tests for MDCBaseCell. */
@interface MDCSelfSizingStereoCellSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCSelfSizingStereoCell *cell;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

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
  [self snapshotVerifyView:snapshotWindow];
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

- (void)testCellWithDynamicTypeForContentSizeCategoryExtraSmallEnabledForTitleAndDetail {
  if (@available(iOS 10.0, *)) {
    // Given
    self.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

    // When
    self.cell.titleLabel.text = @"Title";
    self.cell.titleLabel.font = self.typographyScheme.subtitle1;
    self.cell.detailLabel.text = @"Detail";
    self.cell.detailLabel.font = self.typographyScheme.button;
    self.cell.mdc_adjustsFontForContentSizeCategory = YES;
    [self.cell setNeedsLayout];

    // Then
    [self generateSnapshotWithContentSizeCategoryAndNotificationPost:UIContentSizeCategoryExtraSmall
                                                    andVerifyForView:self.cell];
  }
}

- (void)testCellWithDynamicTypeForContentSizeCategoryExtraLargeEnabledForTitleAndDetail {
  if (@available(iOS 10.0, *)) {
    // Given
    self.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

    // When
    self.cell.titleLabel.text = @"Title";
    self.cell.titleLabel.font = self.typographyScheme.subtitle1;
    self.cell.detailLabel.text = @"Detail";
    self.cell.detailLabel.font = self.typographyScheme.button;
    self.cell.mdc_adjustsFontForContentSizeCategory = YES;
    [self.cell setNeedsLayout];

    // Then
    [self generateSnapshotWithContentSizeCategoryAndNotificationPost:UIContentSizeCategoryExtraLarge
                                                    andVerifyForView:self.cell];
  }
}

@end
