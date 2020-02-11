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

#import <UIKit/UIKit.h>

#import "MaterialButtonBar.h"

static NSString *const kLeadingTitleLatin = @"Lead";
static NSString *const kMiddleTitleLatin = @"Mid";
static NSString *const kTrailingTitleLatin = @"Trail";

static NSString *const kLeadingTitleArabic = @"أما.";
static NSString *const kMiddleTitleArabic = @"بالرّد.";
static NSString *const kTrailingTitleArabic = @"كل.";

@interface MDCButtonBarSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) UIBarButtonItem *leadingTitleItem;
@property(nonatomic, strong) UIBarButtonItem *middleTitleItem;
@property(nonatomic, strong) UIBarButtonItem *trailingTitleItem;
@property(nonatomic, strong) UIBarButtonItem *image16PointSquareItem;
@property(nonatomic, strong) UIBarButtonItem *image24PointSquareItem;
@property(nonatomic, strong) UIBarButtonItem *image32PointSquareItem;
@property(nonatomic, strong) MDCButtonBar *buttonBar;
@end

@implementation MDCButtonBarSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.buttonBar = [[MDCButtonBar alloc] init];
  self.buttonBar.backgroundColor = UIColor.blackColor;
  self.leadingTitleItem = [[UIBarButtonItem alloc] initWithTitle:kLeadingTitleLatin
                                                           style:UIBarButtonItemStylePlain
                                                          target:nil
                                                          action:NULL];
  self.middleTitleItem = [[UIBarButtonItem alloc] initWithTitle:kMiddleTitleLatin
                                                          style:UIBarButtonItemStylePlain
                                                         target:nil
                                                         action:NULL];
  self.trailingTitleItem = [[UIBarButtonItem alloc] initWithTitle:kTrailingTitleLatin
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:NULL];
  self.buttonBar.items = @[ self.leadingTitleItem, self.middleTitleItem, self.trailingTitleItem ];

  UIImage *icon16 = [[UIImage mdc_testImageOfSize:CGSizeMake(16, 16)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image16PointSquareItem = [[UIBarButtonItem alloc] initWithImage:icon16
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:NULL];
  UIImage *icon24 = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image24PointSquareItem = [[UIBarButtonItem alloc] initWithImage:icon24
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:NULL];
  UIImage *icon32 = [[UIImage mdc_testImageOfSize:CGSizeMake(32, 32)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image32PointSquareItem = [[UIBarButtonItem alloc] initWithImage:icon32
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:NULL];
}

- (void)tearDown {
  self.leadingTitleItem = nil;
  self.middleTitleItem = nil;
  self.trailingTitleItem = nil;
  self.image16PointSquareItem = nil;
  self.image24PointSquareItem = nil;
  self.image32PointSquareItem = nil;
  self.buttonBar = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTLAndArabic {
  self.leadingTitleItem.title = kLeadingTitleArabic;
  self.middleTitleItem.title = kMiddleTitleArabic;
  self.trailingTitleItem.title = kTrailingTitleArabic;

  [self changeViewToRTL:self.buttonBar];
}

- (void)changeItemsToImages {
  self.buttonBar.items =
      @[ self.image16PointSquareItem, self.image24PointSquareItem, self.image32PointSquareItem ];
}

#pragma mark - Tests (Bounds)

- (void)testTitlesSizeToFitLTR {
  // When
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testImagesSizeToFitLTR {
  // Given
  [self changeItemsToImages];

  // When
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTitlesSizeToFitRTL {
  // When
  [self changeToRTLAndArabic];
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testImagesSizeToFitRTL {
  // Given
  [self changeItemsToImages];

  // When
  [self changeToRTLAndArabic];
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTitlesSizeTooWideLTR {
  // When
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testImagesSizeTooWideLTR {
  // Given
  [self changeItemsToImages];

  // When
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTitlesSizeTooWideRTL {
  // When
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testImagesSizeTooWideRTL {
  // Given
  [self changeItemsToImages];

  // When
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTitlesSizeTooTallLTR {
  // When
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height * 2);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testImagesSizeTooTallLTR {
  // Given
  [self changeItemsToImages];

  // When
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height * 2);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTitlesSizeTooTallRTL {
  // When
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height * 2);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testImagesSizeTooTallRTL {
  // Given
  [self changeItemsToImages];

  // When
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height * 2);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

#pragma mark - Tests (Properties)

- (void)testOriginalCaseTitles {
  // When
  self.buttonBar.uppercasesButtonTitles = NO;
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testButtonTitleBaselineQuarterHeight {
  // When
  [self.buttonBar sizeToFit];
  self.buttonBar.buttonTitleBaseline = CGRectGetHeight(self.buttonBar.bounds) / 4;

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testButtonTitleBaselineHalfHeight {
  // When
  [self.buttonBar sizeToFit];
  self.buttonBar.buttonTitleBaseline = CGRectGetHeight(self.buttonBar.bounds) / 2;

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionLeadingWithTitlesLTR {
  // When
  self.buttonBar.layoutPosition = MDCButtonBarLayoutPositionLeading;
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionLeadingWithImagesLTR {
  // Given
  [self changeItemsToImages];

  // When
  self.buttonBar.layoutPosition = MDCButtonBarLayoutPositionLeading;
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionLeadingWithTitlesRTL {
  // When
  self.buttonBar.layoutPosition = MDCButtonBarLayoutPositionLeading;
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionLeadingWithImagesRTL {
  // Given
  [self changeItemsToImages];

  // When
  self.buttonBar.layoutPosition = MDCButtonBarLayoutPositionLeading;
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionTrailingWithTitlesLTR {
  // When
  self.buttonBar.layoutPosition = MDCFloatingButtonImageLocationTrailing;
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionTrailingWithImagesLTR {
  // Given
  [self changeItemsToImages];

  // When
  self.buttonBar.layoutPosition = MDCFloatingButtonImageLocationTrailing;
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionTrailingWithTitlesRTL {
  // When
  self.buttonBar.layoutPosition = MDCFloatingButtonImageLocationTrailing;
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testLayoutPositionTrailingWithImagesRTL {
  // Given
  [self changeItemsToImages];

  // When
  self.buttonBar.layoutPosition = MDCFloatingButtonImageLocationTrailing;
  [self changeToRTLAndArabic];
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTintColorOnBarButtonItem {
  // Given
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // When
  self.leadingTitleItem.tintColor = [UIColor redColor];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTintColorOnButtonBar {
  // Given
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // When
  self.buttonBar.tintColor = [UIColor redColor];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testTitleColorForState {
  // Given
  CGSize fitSize = [self.buttonBar sizeThatFits:CGSizeZero];
  self.buttonBar.bounds = CGRectMake(0, 0, fitSize.width * 2, fitSize.height);

  // When
  [self.buttonBar setButtonsTitleColor:[UIColor redColor] forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

@end
