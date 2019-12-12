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

#import "../../../src/TabBarView/private/MDCTabBarViewItemView.h"
#import "MDCTabBarItem.h"
#import "MDCTabBarView.h"
#import "MDCTabBarViewCustomViewable.h"

/** The typical size of an image in a Tab bar. */
static const CGSize kTypicalImageSize = (CGSize){24, 24};

/** The expected height of titles-only or icons-only Tabs. */
static const CGFloat kExpectedHeightTitlesOrIconsOnly = 48;

/** The expected height of Tabs with titles and icons. */
static const CGFloat kExpectedHeightTitlesAndIcons = 72;

/** The leading inset for scrollable tabs. */
static const CGFloat kLeadingInsetForScrollableTabs = 52;

/** The minimum width of a tab bar item. */
static const CGFloat kMinItemWidth = 90;

/** The maximum width of a tab bar item. */
static const CGFloat kMaxItemWidth = 360;

static inline void SizeViewToIntrinsicContentSize(UIView *view) {
  CGSize intrinsicContentSize = view.intrinsicContentSize;
  view.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);
}

/** A custom view to place in an MDCTabBarView. */
@interface MDCTabBarViewSnapshotTestsCustomView : UIView <MDCTabBarViewCustomViewable>
/** A switch shown in the view. */
@property(nonatomic, strong) UISwitch *aSwitch;
@end

@implementation MDCTabBarViewSnapshotTestsCustomView

- (CGRect)contentFrame {
  return CGRectStandardize(self.aSwitch.frame);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  // No-op since this is an example.
}

- (UISwitch *)aSwitch {
  if (!_aSwitch) {
    _aSwitch = [[UISwitch alloc] init];
    [self addSubview:_aSwitch];
  }
  return _aSwitch;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.aSwitch.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (CGSize)intrinsicContentSize {
  return self.aSwitch.intrinsicContentSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [self.aSwitch sizeThatFits:size];
}

@end

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

/** Exposing some internal properties to aid in testing. */
@interface MDCTabBarView (SnapshotTesting)
@property(nonnull, nonatomic, copy) NSArray<UIView *> *itemViews;
@end

/** A test class that allows setting safe area insets. */
@interface MDCTabBarViewSnapshotTestsSuperview : UIView
/** Allows overriding the safe area insets. */
@property(nonatomic, assign) UIEdgeInsets customSafeAreaInsets;
@end

@implementation MDCTabBarViewSnapshotTestsSuperview

- (void)setCustomSafeAreaInsets:(UIEdgeInsets)customSafeAreaInsets {
  _customSafeAreaInsets = customSafeAreaInsets;
  if (@available(iOS 11.0, *)) {
    [self safeAreaInsetsDidChange];
  }
}

- (UIEdgeInsets)safeAreaInsets {
  return _customSafeAreaInsets;
}

@end

@interface MDCTabBarViewSnapshotTests : MDCSnapshotTestCase

/** The view being snapshotted. */
@property(nonatomic, strong) MDCTabBarView *tabBarView;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon1;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon2;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon3;

/** A tab bar item with a title and image. */
@property(nonatomic, strong) UITabBarItem *item1;

/** A tab bar item with a title and image. */
@property(nonatomic, strong) UITabBarItem *item2;

/** A tab bar item with a title and image. */
@property(nonatomic, strong) UITabBarItem *item3;

@end

@implementation MDCTabBarViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.tabBarView = [[MDCTabBarView alloc] init];
  self.tabBarView.barTintColor = UIColor.whiteColor;
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesOrIconsOnly);

  self.typicalIcon1 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleFramedX]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.typicalIcon2 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleDiagonalLines]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.typicalIcon3 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleEllipses]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  self.item1 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Latin
                                             image:self.typicalIcon1
                                               tag:0];
  self.item2 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Latin
                                             image:self.typicalIcon2
                                               tag:1];
  self.item3 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Latin
                                             image:self.typicalIcon3
                                               tag:2];
}

- (void)tearDown {
  self.item1 = nil;
  self.item2 = nil;
  self.item3 = nil;
  self.typicalIcon1 = nil;
  self.typicalIcon2 = nil;
  self.typicalIcon3 = nil;
  self.tabBarView = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)activateRippleInView:(MDCTabBarView *)tabBarView forItem:(UITabBarItem *)item {
  NSUInteger indexOfItem = [tabBarView.items indexOfObject:item];
  if (indexOfItem == NSNotFound || indexOfItem >= tabBarView.itemViews.count) {
    NSAssert(NO, @"(%@) has no associated item view.", item);
    return;
  }
  UIView *itemView = tabBarView.itemViews[indexOfItem];
  if (![itemView isKindOfClass:[MDCTabBarViewItemView class]]) {
    return;
  }
  MDCTabBarViewItemView *mdcItemView = (MDCTabBarViewItemView *)itemView;
  [mdcItemView.rippleTouchController.rippleView
      beginRippleTouchDownAtPoint:CGPointMake(CGRectGetMidX(mdcItemView.bounds),
                                              CGRectGetMidY(mdcItemView.bounds))
                         animated:NO
                       completion:nil];
}

- (void)changeToLatinStringsWithLongTitles:(BOOL)useLongTitles {
  if (useLongTitles) {
    self.item1.title = kItemTitleLong1Latin;
    self.item2.title = kItemTitleLong2Latin;
    self.item3.title = kItemTitleLong3Latin;
  } else {
    self.item1.title = kItemTitleShort1Latin;
    self.item2.title = kItemTitleShort2Latin;
    self.item3.title = kItemTitleShort3Latin;
  }
}

- (void)changeToArabicStringsWithLongTitles:(BOOL)useLongTitles {
  if (useLongTitles) {
    self.item1.title = kItemTitleLong1Arabic;
    self.item2.title = kItemTitleLong2Arabic;
    self.item3.title = kItemTitleLong3Arabic;
  } else {
    self.item1.title = kItemTitleShort1Arabic;
    self.item2.title = kItemTitleShort2Arabic;
    self.item3.title = kItemTitleShort3Arabic;
  }
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  // Needed so that the stack view can be constrained correctly and then allow any "scrolling" to
  // take place for the selected item to be visible.
  [view layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - UITabBarItem properties

- (void)testItemsWithOnlyTitlesLTRLatin {
  // Given
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyTitlesRTLArabic {
  // Given
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;

  // When
  [self changeToArabicStringsWithLongTitles:NO];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyImagesLTR {
  // Given
  self.item1.title = nil;
  self.item2.title = nil;
  self.item3.title = nil;

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyImagesRTL {
  // Given
  self.item1.title = nil;
  self.item2.title = nil;
  self.item3.title = nil;

  // When
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithTitlesAndImagesLTRLatin {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithTitlesAndImagesRTLArabic {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);

  // When
  [self changeToArabicStringsWithLongTitles:NO];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithMixedTitlesAndImagesLTRLatin {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  self.item1.image = nil;
  self.item2.title = nil;

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithMixedTitlesAndImagesRTLArabic {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.image = nil;
  self.item2.title = nil;

  // When
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Selection

- (void)testChangingSelectedItemUsesSelectedImage {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  self.item1.image = self.typicalIcon1;
  self.item1.selectedImage = self.typicalIcon2;
  self.item2.image = self.typicalIcon1;
  self.item3.image = self.typicalIcon1;
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  [self.tabBarView setSelectedItem:self.item2 animated:NO];

  // When
  [self.tabBarView setSelectedItem:self.item1 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testRemovingSelectedItemUpdatesStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:1];
  self.tabBarView.items = @[ item1, item2 ];
  SizeViewToIntrinsicContentSize(self.tabBarView);
  [self.tabBarView setSelectedItem:item1 animated:NO];
  [self.tabBarView setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:UIColor.blackColor forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
  [self.tabBarView setImageTintColor:UIColor.whiteColor forState:UIControlStateSelected];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:24] forState:UIControlStateSelected];

  // When
  [self.tabBarView setSelectedItem:nil animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSelectedItemInitiallyVisibleLTRLatin {
  // Given
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMinItemWidth * (CGFloat)1.5, kExpectedHeightTitlesOrIconsOnly);
  [self changeToLatinStringsWithLongTitles:YES];
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;
  self.item3.title = kItemTitleShort3Latin;
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];

  // When
  [self.tabBarView setSelectedItem:self.item3 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSelectedItemInitiallyVisibleRTLArabic {
  // Given
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMinItemWidth * (CGFloat)1.5, kExpectedHeightTitlesOrIconsOnly);
  [self changeToArabicStringsWithLongTitles:YES];
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;
  self.item3.title = kItemTitleShort3Arabic;
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];

  // When
  [self changeViewToRTL:self.tabBarView];
  [self.tabBarView setSelectedItem:self.item3 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Key-Value Observing (KVO)

- (void)testChangingTitleAfterAddingToBar {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item2.title = @"2";

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingImageOfUnselectedItemAfterAddingToBar {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item1.image = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

/**
 This order of operations has no effect because UITabBarItem assigns a copy the value set for
 @c image to @c selectedImage if it is currently @c nil. Since MDCTabBarView can only retrieve
 images from the public API of UITabBarItem, there is a value for @c selectedImage. As a result,
 changing the value of @c image will not update @c selectedImage.
 */
- (void)testChangingImageOfSelectedItemAfterAddingToBarDoesNothing {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item2.image = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingSelectedImageOfUnselectedItemAfterAddingToBarDoesNothing {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item1.selectedImage = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingSelectedImageOfSelectedItemAfterAddingToBarUpdatesView {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item2.selectedImage = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Layout Sizes
- (void)testSettingBoundsTooNarrowWithItemsLessThanMinimumWidthResultsInScrollableLayoutLTRLatin {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:8];

  // When
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSettingBoundsTooNarrowWithItemsLessThanMinimumWidthResultsInScrollableLayoutRTLArabic {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Arabic image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Arabic image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:8];

  // When
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSettingBoundsToIntrinsicContentSizeResultsInJustifiedLayoutLTRLatin {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:8];

  // When
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSettingBoundsToIntrinsicContentSizeResultsInJustifiedLayoutRTLArabic {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Arabic image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Arabic image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:8];

  // When
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsLargerThanBoundsChangesToScrollableLayout {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMinItemWidth * (self.tabBarView.items.count - (CGFloat)0.5),
                 kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testVeryLongItemLimitsItemWidthToItemMaximumWhenBoundsTooNarrow {
  // Given
  NSString *longString = @"This is a super long tab bar string. And it should be longer than 360 "
                         @"and wrap to multiple lines.";
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:longString image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  self.tabBarView.bounds = CGRectMake(0, 0, kMaxItemWidth * self.tabBarView.items.count / 2,
                                      kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testVeryLongItemLimitsItemWidthToItemMaximumWhenBoundsAreIntrinsicContentSize {
  // Given
  NSString *longString = @"This is a super long tab bar string. And it should be longer than 360 "
                         @"and wrap to multiple lines.";
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:longString image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testLayoutBehaviorWhenBoundsExceedsMaximumWidthForNumberOfItems {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];

  // When
  self.tabBarView.items = @[ item1, item2 ];
  self.tabBarView.bounds = CGRectMake(0, 0, kMaxItemWidth * (self.tabBarView.items.count + 1),
                                      kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testLayoutBehaviorWhenBoundsExceedsIntrinsicContentSizeAndRemainsLessThanMaximum {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];

  // When
  self.tabBarView.items = @[ item1, item2 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds = CGRectMake(
      0, 0, MIN(kMaxItemWidth * self.tabBarView.items.count, intrinsicContentSize.width * 2),
      intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Safe Area/Inset Support

- (void)testSafeAreaTopAndLeftInsetsForJustifiedLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(16, 44, 0, 0);
  superview.customSafeAreaInsets = safeAreaInsets;
  CGSize fitSize = self.tabBarView.intrinsicContentSize;
  fitSize = CGSizeMake(fitSize.width + safeAreaInsets.left, fitSize.height + safeAreaInsets.top);
  self.tabBarView.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaRightAndBottomInsetsForJustifiedLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(0, 0, 16, 44);
  superview.customSafeAreaInsets = safeAreaInsets;
  CGSize fitSize = self.tabBarView.intrinsicContentSize;
  fitSize =
      CGSizeMake(fitSize.width + safeAreaInsets.right, fitSize.height + safeAreaInsets.bottom);
  self.tabBarView.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaTopAndLeftInsetsForFixedClusteredCenteredLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(16, 44, 0, 0);
  superview.customSafeAreaInsets = safeAreaInsets;
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxItemWidth * self.tabBarView.items.count + 1 + safeAreaInsets.left,
                 kExpectedHeightTitlesOrIconsOnly + safeAreaInsets.top);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaRightAndBottomInsetsForFixedClusteredCenteredLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(0, 0, 16, 44);
  superview.customSafeAreaInsets = safeAreaInsets;
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxItemWidth * self.tabBarView.items.count + 1 + safeAreaInsets.right,
                 kExpectedHeightTitlesOrIconsOnly + safeAreaInsets.bottom);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaTopAndLeftInsetsForScrollableLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(16, 44, 0, 0);
  self.tabBarView.bounds = CGRectMake(0, 0, kMinItemWidth * 2.5, kExpectedHeightTitlesOrIconsOnly);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaRightAndBottomInsetsForScrollableLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item4 animated:NO];

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(0, 0, 16, 44);
  self.tabBarView.bounds = CGRectMake(0, 0, kMinItemWidth * 2.5, kExpectedHeightTitlesOrIconsOnly);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testCustomInsetsToNegateInternalLeadingInset {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item1 animated:NO];
  self.tabBarView.bounds = CGRectMake(0, 0, 120, 48);

  // When
  self.tabBarView.contentInset = UIEdgeInsetsMake(0, -52, 0, 0);
  [self.tabBarView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testCustomInsetsTopAndRightRepositionsJustifiedViews {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item1 animated:NO];

  // When
  UIEdgeInsets contentInset = UIEdgeInsetsMake(15, 0, 0, 45);
  self.tabBarView.contentInset = contentInset;
  CGSize fitSize = self.tabBarView.intrinsicContentSize;
  fitSize = CGSizeMake(fitSize.width + contentInset.right, fitSize.height + contentInset.top);
  self.tabBarView.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testCustomInsetsBottomAndLeftRepositionsJustifiedViews {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item1 animated:NO];

  // When
  UIEdgeInsets contentInset = UIEdgeInsetsMake(0, 45, 15, 0);
  self.tabBarView.contentInset = contentInset;
  CGSize fitSize = self.tabBarView.intrinsicContentSize;
  fitSize = CGSizeMake(fitSize.width + contentInset.left, fitSize.height + contentInset.bottom);
  self.tabBarView.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testCustomInsetsTopAndRightRepositionsFixedClusteredCenteredViews {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item1 animated:NO];

  // When
  UIEdgeInsets contentInset = UIEdgeInsetsMake(15, 0, 0, 45);
  self.tabBarView.contentInset = contentInset;
  self.tabBarView.bounds = CGRectMake(0, 0, kMaxItemWidth * self.tabBarView.items.count + 1,
                                      kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testCustomInsetsBottomAndLeftRepositionsFixedClusteredCenteredViews {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item1 animated:NO];

  // When
  UIEdgeInsets contentInset = UIEdgeInsetsMake(0, 45, 15, 0);
  self.tabBarView.contentInset = contentInset;
  self.tabBarView.bounds = CGRectMake(0, 0, kMaxItemWidth * self.tabBarView.items.count + 1,
                                      kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testCustomInsetsTopAndRightRepositionsScrollableViews {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item4 animated:NO];
  self.tabBarView.bounds = CGRectMake(0, 0, 120, kExpectedHeightTitlesOrIconsOnly);

  // When
  self.tabBarView.contentInset = UIEdgeInsetsMake(15, 0, 0, 15);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testCustomInsetsBottomAndLeftRepositionsScrollableViews {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item1 animated:NO];
  self.tabBarView.bounds = CGRectMake(0, 0, 120, kExpectedHeightTitlesOrIconsOnly);

  // When
  self.tabBarView.contentInset = UIEdgeInsetsMake(0, 15, 15, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSafeAreaAndContentInsetCombineTopAndLeftForJustifiedLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(10, 5, 0, 0);
  UIEdgeInsets contentInset = UIEdgeInsetsMake(5, 10, 0, 0);
  superview.customSafeAreaInsets = safeAreaInsets;
  self.tabBarView.contentInset = contentInset;
  CGSize fitSize = self.tabBarView.intrinsicContentSize;
  fitSize = CGSizeMake(fitSize.width + safeAreaInsets.left + contentInset.left,
                       fitSize.height + safeAreaInsets.top + contentInset.top);
  self.tabBarView.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaAndContentInsetCombineBottomAndRightForJustifiedLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(0, 0, 10, 5);
  UIEdgeInsets contentInset = UIEdgeInsetsMake(0, 0, 5, 10);
  superview.customSafeAreaInsets = safeAreaInsets;
  self.tabBarView.contentInset = contentInset;
  CGSize fitSize = self.tabBarView.intrinsicContentSize;
  fitSize = CGSizeMake(fitSize.width + safeAreaInsets.right + contentInset.right,
                       fitSize.height + safeAreaInsets.bottom + contentInset.bottom);
  self.tabBarView.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

#pragma mark - MDCTabBarView Properties

- (void)testSetTitleColorForExplicitItemStates {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleColor:UIColor.brownColor forState:UIControlStateSelected];
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleColorForNormalStateAppliesToSelectedItem {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  ;

  // When
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleColorExplicitlyToNilRendersSomeDefault {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleColor:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:nil forState:UIControlStateSelected];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetImageTintColorForExplicitItemStates {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setImageTintColor:UIColor.brownColor forState:UIControlStateSelected];
  [self.tabBarView setImageTintColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetImageTintColorForNormalStateAppliesToSelectedItem {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setImageTintColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetImageTintColorExplicitlyToNilUsesTintColor {
  // Given
  self.tabBarView.tintColor = UIColor.orangeColor;
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setImageTintColor:nil forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:nil forState:UIControlStateSelected];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleFontForExplicitItemStates {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:24] forState:UIControlStateSelected];
  SizeViewToIntrinsicContentSize(self.tabBarView);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleFontForNormalStateAppliesToSelectedItem {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  SizeViewToIntrinsicContentSize(self.tabBarView);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleFontExplicitlyToNilUsesDefaultFont {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:24] forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleFont:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:nil forState:UIControlStateSelected];
  SizeViewToIntrinsicContentSize(self.tabBarView);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingSelectionUpdatesItemStyle {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:UIColor.redColor forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:UIColor.brownColor forState:UIControlStateSelected];
  [self.tabBarView setImageTintColor:UIColor.blueColor forState:UIControlStateSelected];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:24] forState:UIControlStateSelected];

  // When
  [self.tabBarView setSelectedItem:item3 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testBarTintColor {
  // When
  self.tabBarView.barTintColor = UIColor.purpleColor;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testRippleColor {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  SizeViewToIntrinsicContentSize(self.tabBarView);

  // When
  self.tabBarView.rippleColor = [UIColor.orangeColor colorWithAlphaComponent:(CGFloat)0.25];
  [self activateRippleInView:self.tabBarView forItem:item1];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testCustomSelectionIndicatorStrokeColor {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  SizeViewToIntrinsicContentSize(self.tabBarView);

  // When
  self.tabBarView.selectionIndicatorStrokeColor = UIColor.purpleColor;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSelectionIndicatorStrokeColorResetsToDefault {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  SizeViewToIntrinsicContentSize(self.tabBarView);
  self.tabBarView.selectionIndicatorStrokeColor = UIColor.purpleColor;

  // When
  self.tabBarView.selectionIndicatorStrokeColor = nil;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testBottomDividerColor {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  SizeViewToIntrinsicContentSize(self.tabBarView);
  self.tabBarView.bottomDividerColor = UIColor.purpleColor;

  // When
  self.tabBarView.selectionIndicatorStrokeColor = nil;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Custom View support

- (void)testCustomView {
  // Given
  MDCTabBarViewSnapshotTestsCustomView *customView =
      [[MDCTabBarViewSnapshotTestsCustomView alloc] init];
  MDCTabBarItem *customViewItem = [[MDCTabBarItem alloc] initWithTitle:@"Title" image:nil tag:0];
  customViewItem.mdc_customView = customView;
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];

  // When
  self.tabBarView.items = @[ item1, customViewItem, item3 ];
  SizeViewToIntrinsicContentSize(self.tabBarView);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - rectForItem:inCoordinateSpace:

- (void)testRectForItemInCoordinateSpaceWithinBounds {
  // Given
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);
  UIView *itemRectOverlayView = [[UIView alloc] init];
  itemRectOverlayView.backgroundColor =
      [UIColor.magentaColor colorWithAlphaComponent:(CGFloat)0.25];
  [self.tabBarView addSubview:itemRectOverlayView];
  [self.tabBarView layoutIfNeeded];

  // When
  CGRect item2FrameRect = [self.tabBarView rectForItem:self.item2
                                     inCoordinateSpace:self.tabBarView];
  itemRectOverlayView.frame = item2FrameRect;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testRectForItemInCoordinateSpaceWhenPartiallyOutsideBarBounds {
  // Given
  self.tabBarView.items = @[ self.item1, self.item2 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds = CGRectMake(0, 0, kMinItemWidth * 1.2 + kLeadingInsetForScrollableTabs,
                                      intrinsicContentSize.height);
  UIView *itemRectOverlayView = [[UIView alloc] init];
  itemRectOverlayView.backgroundColor =
      [UIColor.magentaColor colorWithAlphaComponent:(CGFloat)0.25];
  [self.tabBarView addSubview:itemRectOverlayView];
  [self.tabBarView layoutIfNeeded];

  // When
  CGRect item2FrameRect = [self.tabBarView rectForItem:self.item2
                                     inCoordinateSpace:self.tabBarView];
  itemRectOverlayView.frame = item2FrameRect;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testRectForItemInCoordinateSpaceWithSafeAreaInsets {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(16, 44, 0, 0);
  CGSize fitSize = self.tabBarView.intrinsicContentSize;
  fitSize = CGSizeMake(fitSize.width + safeAreaInsets.left, fitSize.height + safeAreaInsets.top);
  self.tabBarView.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height);

  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  superview.customSafeAreaInsets = safeAreaInsets;
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  UIView *itemRectOverlayView = [[UIView alloc] init];
  itemRectOverlayView.backgroundColor =
      [UIColor.magentaColor colorWithAlphaComponent:(CGFloat)0.25];
  [superview addSubview:itemRectOverlayView];
  [superview layoutIfNeeded];

  // When
  CGRect item2FrameRect = [self.tabBarView rectForItem:item2 inCoordinateSpace:superview];
  itemRectOverlayView.frame = item2FrameRect;

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

@end
