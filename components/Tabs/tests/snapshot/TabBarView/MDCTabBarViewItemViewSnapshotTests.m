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

/** Minimum width of an item view for proper layout. */
static const CGFloat kMinimumWidth = 90;

/** Maximum width of an item view for proper layout. */
static const CGFloat kMaximumWidth = 360;

/** Minimum (expected) height of an item view with only a title or image, not both. */
static const CGFloat kMinimumHeightOnlyTitleOrOnlyImage = 48;

/** Minimum (expected) height of an item view with both a title and image. */
static const CGFloat kMinimumHeightTitleAndImage = 72;

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
      [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24) withStyle:MDCSnapshotTestImageStyleFramedX]
          imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
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
  self.itemView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
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

#pragma mark - Title and Image

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

#pragma mark - Title Only

- (void)testShortTitleNoImageSizeToFitLTRLatin {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testShortTitleNoImageSizeToFitRTLArabic {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kShortTitleArabic;
  [self changeToRTL];
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageSizeToFitLTRLatin {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageSizeToFitRTLArabic {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  [self changeToRTL];
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testShortTitleNoImageIntrinsicContentSizeLTRLatin {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testShortTitleNoImageIntrinsicContentSizeRTLArabic {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kShortTitleArabic;
  [self changeToRTL];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageIntrinsicContentSizeLTRLatin {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageIntrinsicContentSizeRTLArabic {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  [self changeToRTL];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageTooSmallSizeLTRLatin {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  self.itemView.bounds = CGRectMake(0, 0, kMinimumWidth, kMinimumHeightOnlyTitleOrOnlyImage);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageTooSmallSizeRTLArabic {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  [self changeToRTL];
  self.itemView.bounds = CGRectMake(0, 0, kMinimumWidth, kMinimumHeightOnlyTitleOrOnlyImage);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageTooLargeSizeLTRLatin {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleLatin;
  self.itemView.bounds =
      CGRectMake(0, 0, kMaximumWidth * (CGFloat)1.5, kMinimumHeightTitleAndImage * (CGFloat)1.5);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testLongTitleNoImageTooLargeSizeRTLArabic {
  // Given
  self.itemView.iconImageView.image = nil;

  // When
  self.itemView.titleLabel.text = kLongTitleArabic;
  [self changeToRTL];
  self.itemView.bounds = CGRectMake(0, 0, kMinimumWidth * (CGFloat)1.5,
                                    kMinimumHeightOnlyTitleOrOnlyImage * (CGFloat)1.5);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

#pragma mark - Image Only

- (void)testNoTitleTypicalImageSizeToFitLTR {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleTypicalImageSizeToFitRTL {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  [self changeToRTL];
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageSizeToFitLTR {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageSizeToFitRTL {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  [self changeToRTL];
  [self.itemView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleTypicalImageIntrinsicContentSizeLTR {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleTypicalImageIntrinsicContentSizeRTL {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  [self changeToRTL];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageIntrinsicContentSizeLTR {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageIntrinsicContentSizeRTL {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  [self changeToRTL];
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;
  self.itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageTooSmallSizeLTR {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  self.itemView.bounds = CGRectMake(0, 0, kMinimumWidth, kMinimumHeightOnlyTitleOrOnlyImage);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageTooSmallSizeRTL {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  [self changeToRTL];
  self.itemView.bounds = CGRectMake(0, 0, kMinimumWidth, kMinimumHeightOnlyTitleOrOnlyImage);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageTooLargeSizeLTR {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  self.itemView.bounds =
      CGRectMake(0, 0, kMaximumWidth * (CGFloat)1.5, kMinimumHeightTitleAndImage * (CGFloat)1.5);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testNoTitleLargeImageTooLargeSizeRTL {
  // Given
  self.itemView.titleLabel.text = nil;

  // When
  self.itemView.iconImageView.image =
      [UIImage mdc_testImageOfSize:CGSizeMake(48, 48) withStyle:MDCSnapshotTestImageStyleFramedX];
  [self changeToRTL];
  self.itemView.bounds = CGRectMake(0, 0, kMinimumWidth * (CGFloat)1.5,
                                    kMinimumHeightOnlyTitleOrOnlyImage * (CGFloat)1.5);

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

#pragma mark - Ripple

- (void)testRippleAppearanceWhenFullyPressed {
  // Given
  self.itemView.titleLabel.textColor = UIColor.yellowColor;
  self.itemView.iconImageView.tintColor = UIColor.magentaColor;
  self.itemView.rippleTouchController.rippleView.rippleColor = UIColor.blueColor;
  [self.itemView sizeToFit];

  // When
  [self.itemView.rippleTouchController.rippleView
      beginRippleTouchDownAtPoint:CGPointMake(CGRectGetMidX(self.itemView.bounds),
                                              CGRectGetMidY(self.itemView.bounds))
                         animated:NO
                       completion:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

#pragma mark - Selection Indicator Support

- (void)testContentFrameForTextOnly {
  // Given
  self.itemView.titleLabel.text = @"1";
  self.itemView.iconImageView.image = nil;
  [self.itemView sizeToFit];
  CGRect contentFrame = self.itemView.contentFrame;

  // When
  UIView *contentFrameOverlayView = [[UIView alloc] init];
  contentFrameOverlayView.translatesAutoresizingMaskIntoConstraints = NO;
  contentFrameOverlayView.backgroundColor =
      [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.25];
  contentFrameOverlayView.bounds =
      CGRectMake(0, 0, CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  contentFrameOverlayView.center =
      CGPointMake(CGRectGetMidX(contentFrame), CGRectGetMidY(contentFrame));
  [self.itemView addSubview:contentFrameOverlayView];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testContentFrameForImageOnly {
  // Given
  self.itemView.titleLabel.text = @"1";
  self.itemView.titleLabel.text = nil;
  [self.itemView sizeToFit];
  CGRect contentFrame = self.itemView.contentFrame;

  // When
  UIView *contentFrameOverlayView = [[UIView alloc] init];
  contentFrameOverlayView.translatesAutoresizingMaskIntoConstraints = NO;
  contentFrameOverlayView.backgroundColor =
      [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.25];
  contentFrameOverlayView.bounds =
      CGRectMake(0, 0, CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  contentFrameOverlayView.center =
      CGPointMake(CGRectGetMidX(contentFrame), CGRectGetMidY(contentFrame));
  [self.itemView addSubview:contentFrameOverlayView];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

- (void)testContentFrameForTextAndImage {
  // Given
  self.itemView.titleLabel.text = @"1";
  [self.itemView sizeToFit];
  CGRect contentFrame = self.itemView.contentFrame;

  // When
  UIView *contentFrameOverlayView = [[UIView alloc] init];
  contentFrameOverlayView.translatesAutoresizingMaskIntoConstraints = NO;
  contentFrameOverlayView.backgroundColor =
      [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.25];
  contentFrameOverlayView.bounds =
      CGRectMake(0, 0, CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  contentFrameOverlayView.center =
      CGPointMake(CGRectGetMidX(contentFrame), CGRectGetMidY(contentFrame));
  [self.itemView addSubview:contentFrameOverlayView];

  // Then
  [self generateSnapshotAndVerifyForView:self.itemView];
}

@end
