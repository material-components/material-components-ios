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

#import <XCTest/XCTest.h>

#import <CoreGraphics/CoreGraphics.h>
#import "../../../src/TabBarView/private/MDCTabBarViewItemView.h"
#import "MaterialSnapshot.h"

/** An Arabic-character title that could reasonably fit in a Tabs item. */
static NSString *const kShortTitleArabic = @"ما تنفّس.";

/** A Latin-character title that could reasonably fit in a Tabs item. */
static NSString *const kShortTitleLatin = @"Lorem ipsum";

/** A Latin-character title too long to fit in a Bottom Navigation item. */
static NSString *const kLongTitleLatin =
    @"123456789012345678901234567890123456789012345678901234567890";

/** An Arabic-character title too long to fit in a Bottom Navigation item. */
static NSString *const kLongTitleArabic =
    @"دول السيطرة استطاعوا ٣٠. مليون وفرنسا أوراقهم انه تم, نفس قد والديون العالمية. دون ما تنفّس.";

@interface MDCTabBarViewItemViewSnapshotTests : MDCSnapshotTestCase

/** The view being snapshotted. */
@property(nonatomic, strong) MDCTabBarViewItemView *itemView;

@end

@implementation MDCTabBarViewItemViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.itemView = [[MDCTabBarViewItemView alloc] init];
  self.itemView.titleLabel.text = kShortTitleLatin;
  // Default to white since in actual use the background would be transparent.
  self.itemView.backgroundColor = UIColor.whiteColor;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(24, 24) withStyle:MDCSnapshotTestImageStyleFramedX];
}

- (void)tearDown {
  self.itemView = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTL {
  if (@available(iOS 9.0, *)) {
    self.itemView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }
}

#pragma mark - Tests

- (void)testNoTitleNoImageIntrinsicContentSize {
  // When
  self.itemView.titleLabel.text = nil;
  self.itemView.iconImageView.image = nil;
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testShortTitleRegularImageIntrinsicContentSizeLTRLatin {
  // When
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testShortTitleRegularImageIntrinsicContentSizeRTLArabic {
  // When
  self.itemView.titleLabel.text = kShortTitleArabic;
  [self changeToRTL];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageIntrinsicContentSizeLTRLatin {
  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageIntrinsicContentSizeRTLArabic {
  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  [self changeToRTL];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageTooSmallSizeLTRLatin {
  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  self.itemView.bounds = CGRectMake(0, 0, 36, 36);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageTooSmallSizeRTLArabic {
  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  [self changeToRTL];
  self.itemView.bounds = CGRectMake(0, 0, 36, 40);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageVeryTallSizeLTRLatin {
  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  self.itemView.bounds = CGRectMake(0, 0, 36, 360);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageVeryTallSizeRTLArabic {
  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  [self changeToRTL];
  self.itemView.bounds = CGRectMake(0, 0, 36, 360);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageWidestSizeLTRLatin {
  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  self.itemView.bounds = CGRectMake(0, 0, 1200, 36);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleLargeImageWidestSizeRTLArabic {
  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48)
                         withStyle:MDCSnapshotTestImageStyleRectangles];
  [self changeToRTL];
  self.itemView.bounds = CGRectMake(0, 0, 1200, 36);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

@end
