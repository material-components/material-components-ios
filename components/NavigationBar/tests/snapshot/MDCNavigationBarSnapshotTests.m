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

#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialNavigationBar.h"

static NSString *const kItemTitleShort1Latin = @"Quando";
static NSString *const kItemTitleShort2Latin = @"No";
static NSString *const kItemTitleShort3Latin = @"Facer";

static NSString *const kItemTitleLong1Latin =
    @"Quando volumus maluisset cum ei, ad zril quodsi cum.";
static NSString *const kItemTitleLong2Latin = @"No quis modo nam, sea ea dicit tollit.";
static NSString *const kItemTitleLong3Latin =
    @"Facer maluisset torquatos ad has, ad vix audiam assueverit mediocritatem.";

static NSString *const kItemTitleShort1Arabic = @"عل";
static NSString *const kItemTitleShort2Arabic = @"قد";
static NSString *const kItemTitleShort3Arabic = @"وتم";

static NSString *const kItemTitleLong1Arabic =
    @"عل أخذ استطاعوا الانجليزية. قد وحتّى بزمام التبرعات مكن.";
static NSString *const kItemTitleLong2Arabic =
    @"وتم عل والقرى إتفاقية, عن هذا وباءت الغالي وفرنسا.";
static NSString *const kItemTitleLong3Arabic = @"تحت أي قدما وإقامة. ودول بشرية اليابانية لان ما.";

/** Snapshot tests for MDCNavigationBar */
@interface MDCNavigationBarSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCNavigationBar *navBar;

@property(nonatomic, strong) UIImage *image24;
@property(nonatomic, strong) UIImage *image48;
@property(nonatomic, strong) UIView *titleView;
@property(nonatomic, strong) UIBarButtonItem *itemWithTitle1;
@property(nonatomic, strong) UIBarButtonItem *itemWithTitle2;
@property(nonatomic, strong) UIBarButtonItem *itemWithImage24;
@property(nonatomic, strong) UIBarButtonItem *itemWithImage48;

@end

@implementation MDCNavigationBarSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 360, 56)];
  self.image24 = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image48 = [[UIImage mdc_testImageOfSize:CGSizeMake(48, 48)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.itemWithTitle1 = [[UIBarButtonItem alloc] initWithTitle:kItemTitleShort1Latin
                                                         style:UIBarButtonItemStylePlain
                                                        target:nil
                                                        action:NULL];
  self.itemWithTitle2 = [[UIBarButtonItem alloc] initWithTitle:kItemTitleShort2Latin
                                                         style:UIBarButtonItemStylePlain
                                                        target:nil
                                                        action:NULL];
  self.itemWithImage24 = [[UIBarButtonItem alloc] initWithImage:self.image24
                                                          style:UIBarButtonItemStylePlain
                                                         target:nil
                                                         action:NULL];
  self.itemWithImage48 = [[UIBarButtonItem alloc] initWithImage:self.image48
                                                          style:UIBarButtonItemStylePlain
                                                         target:nil
                                                         action:NULL];

  UIImage *backImage = [MDCIcons imageFor_ic_arrow_back];
  backImage = [backImage imageFlippedForRightToLeftLayoutDirection];
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage
                                                               style:UIBarButtonItemStylePlain
                                                              target:nil
                                                              action:NULL];
  self.navBar.backItem = backItem;

  self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
  self.titleView.backgroundColor = UIColor.cyanColor;
}

- (void)tearDown {
  self.navBar = nil;
  self.itemWithImage48 = nil;
  self.itemWithImage24 = nil;
  self.itemWithTitle2 = nil;
  self.itemWithTitle1 = nil;
  [self.titleView removeFromSuperview];
  self.titleView = nil;

  [super tearDown];
}

- (void)setStringsToArabicShort {
  self.itemWithTitle1.title = kItemTitleShort1Arabic;
  self.itemWithTitle2.title = kItemTitleShort2Arabic;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testNavbarWithBackButtonAndShortTitleLTRLatin {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Latin;

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButtonAndShortTitleRTLArabic {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Arabic;
  [self changeViewToRTL:self.navBar];
  [self setStringsToArabicShort];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButtonAndLongTitleLTRLatin {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleLong1Latin;

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButtonAndLongTitleRTLArabic {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.navBar];
  [self setStringsToArabicShort];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButtonAndTitleViewLTR {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.titleView = self.titleView;

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButtonAndTitleViewRTL {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.titleView = self.titleView;
  [self changeViewToRTL:self.navBar];
  [self setStringsToArabicShort];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2LeadingItemsAndShortTitleLTRLatin {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Latin;
  self.navBar.leadingBarButtonItems = @[ self.itemWithTitle1, self.itemWithTitle2 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2LeadingItemsAndShortTitleRTLArabic {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Arabic;
  self.navBar.leadingBarButtonItems = @[ self.itemWithTitle1, self.itemWithTitle2 ];
  [self changeViewToRTL:self.navBar];
  [self setStringsToArabicShort];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2TrailingItemsAndShortTitleLTRLatin {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Latin;
  self.navBar.trailingBarButtonItems = @[ self.itemWithImage24, self.itemWithImage48 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2TrailingItemsAndShortTitleRTLArabic {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Arabic;
  self.navBar.trailingBarButtonItems = @[ self.itemWithImage24, self.itemWithImage48 ];
  [self changeViewToRTL:self.navBar];
  [self setStringsToArabicShort];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2Leading2TrailingItemsAndShortTitleLTRLatin {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Latin;
  self.navBar.leadingBarButtonItems = @[ self.itemWithTitle1, self.itemWithTitle2 ];
  self.navBar.trailingBarButtonItems = @[ self.itemWithImage24, self.itemWithImage48 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2Leading2TrailingItemsAndShortTitleRTLArabic {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.title = kItemTitleShort3Arabic;
  self.navBar.leadingBarButtonItems = @[ self.itemWithTitle1, self.itemWithTitle2 ];
  self.navBar.trailingBarButtonItems = @[ self.itemWithImage24, self.itemWithImage48 ];
  [self changeViewToRTL:self.navBar];
  [self setStringsToArabicShort];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2Leading2TrailingItemsSupplementBackAndShortTitleLTRLatin {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.leadingItemsSupplementBackButton = YES;
  self.navBar.title = kItemTitleShort3Latin;
  self.navBar.leadingBarButtonItems = @[ self.itemWithTitle1, self.itemWithTitle2 ];
  self.navBar.trailingBarButtonItems = @[ self.itemWithImage24, self.itemWithImage48 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithBackButton2Leading2TrailingItemsSupplementBackAndShortTitleRTLArabic {
  // When
  self.navBar.hidesBackButton = NO;
  self.navBar.leadingItemsSupplementBackButton = YES;
  self.navBar.title = kItemTitleShort3Arabic;
  self.navBar.leadingBarButtonItems = @[ self.itemWithTitle1, self.itemWithTitle2 ];
  self.navBar.trailingBarButtonItems = @[ self.itemWithImage24, self.itemWithImage48 ];
  [self changeViewToRTL:self.navBar];
  [self setStringsToArabicShort];

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithTitleViewBehaviorCenter {
  // When
  self.navBar.titleViewLayoutBehavior = MDCNavigationBarTitleViewLayoutBehaviorCenter;
  // Using a label as custom view to have a view that has an intrinsic content size.
  UILabel *customTitleLabel = [[UILabel alloc] init];
  customTitleLabel.text = kItemTitleShort1Latin;
  // Tint the background to see the label's full frame on the screenshot.
  customTitleLabel.backgroundColor = UIColor.cyanColor;
  self.navBar.titleView = customTitleLabel;

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

- (void)testNavbarWithTitleViewBehaviorCenterFit {
  // When
  self.navBar.titleViewLayoutBehavior = MDCNavigationBarTitleViewLayoutBehaviorCenterFit;
  // Using a label as custom view to have a view that has an intrinsic content size.
  UILabel *customTitleLabel = [[UILabel alloc] init];
  customTitleLabel.text = kItemTitleShort1Latin;
  // Tint the background to see the label's full frame on the screenshot.
  customTitleLabel.backgroundColor = UIColor.cyanColor;
  self.navBar.titleView = customTitleLabel;

  // Then
  [self generateSnapshotAndVerifyForView:self.navBar];
}

@end
