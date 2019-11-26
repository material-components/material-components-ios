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

#import "../../../src/TabBarView/private/MDCTabBarViewItemView.h"
#import "MDCTabBarItem.h"
#import "MDCTabBarView.h"
#import "MDCTabBarViewCustomViewable.h"
#import "MDCTabBarViewDelegate.h"
#import "MaterialTypography.h"

#import "MaterialAnimationTiming.h"

// Minimum height of the MDCTabBar view.
static const CGFloat kMinHeight = 48;

// Maximum width of a single item in the tab bar.
static const CGFloat kMaxWidthTabBarItem = 360;

/** Returns a generated image of the given size. */
static UIImage *fakeImage(CGSize size) {
  UIGraphicsBeginImageContext(size);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

#pragma mark - Test Doubles

/** A mock class for custom view testing. Records calls to `setSelected:animated:`. */
@interface MDCTabBarViewTestCustomViewMock : UIView <MDCTabBarViewCustomViewable>

/** Whether this view is selected. */
@property(nonatomic, assign, getter=isSelected) BOOL selected;

/** @c YES if this view was marked selected (or unselected) with animation, else @c NO. */
@property(nonatomic, assign) BOOL setSelectedCalledWithAnimation;

@end

@implementation MDCTabBarViewTestCustomViewMock

- (CGSize)intrinsicContentSize {
  return CGSizeMake(1, 1);
}

- (CGSize)sizeThatFits:(CGSize)size {
  return self.intrinsicContentSize;
}

- (CGRect)contentFrame {
  return CGRectZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  self.selected = selected;
  self.setSelectedCalledWithAnimation = animated;
}

@end

/** A fake @c UITapGestureRecognizer subclass that allows the @c view property to be set. */
@interface MDCTabBarViewFakeTapGestureRecognizer : UITapGestureRecognizer

/** The returned value for @c view. */
@property(nonatomic, strong) UIView *settableView;

@end

@implementation MDCTabBarViewFakeTapGestureRecognizer

- (UIView *)view {
  return _settableView ?: [super view];
}

@end

/** Category exposing implementation methods to aid testing. */
@interface MDCTabBarView (UnitTestingExposesPrivateMethods)
- (void)didTapItemView:(UITapGestureRecognizer *)tap;
@end

/** A test fake for responding to all delegate methods of MDCTabBarView. */
@interface MDCTabBarViewTestsFullDelegate : NSObject <MDCTabBarViewDelegate>

/** The item passed by the last invocation of @c tabBarView:didSelectedItem: . */
@property(nonatomic, strong) UITabBarItem *selectedItem;

/** The item passed by the last invocation of @c tabBarView:shouldSelectItem:` . */
@property(nonatomic, strong) UITabBarItem *attemptedSelectedItem;

/** Controls whether this delegate will return @c YES for @c tabBarView:shouldSelectItem: . */
@property(nonatomic, assign) BOOL shouldAllowSelection;

@end

@implementation MDCTabBarViewTestsFullDelegate

- (BOOL)tabBarView:(MDCTabBarView *)tabBarView shouldSelectItem:(UITabBarItem *)item {
  self.attemptedSelectedItem = item;
  return self.shouldAllowSelection;
}

- (void)tabBarView:(MDCTabBarView *)tabBarView didSelectItem:(UITabBarItem *)item {
  self.selectedItem = item;
}

@end

/** A test fake for responding only to @c tabBarView:shouldSelectItem: . */
@interface MDCTabBarViewTestsShouldSelectDelegate : NSObject <MDCTabBarViewDelegate>

/** The item passed by the last invocation of @c tabBarView:shouldSelectItem:` . */
@property(nonatomic, strong) UITabBarItem *attemptedSelectedItem;

/** Controls whether this delegate will return @c YES for @c tabBarView:shouldSelectItem: . */
@property(nonatomic, assign) BOOL shouldAllowSelection;

@end

@implementation MDCTabBarViewTestsShouldSelectDelegate

- (BOOL)tabBarView:(MDCTabBarView *)tabBarView shouldSelectItem:(UITabBarItem *)item {
  self.attemptedSelectedItem = item;
  return self.shouldAllowSelection;
}

@end

/** A test fake for responding only to @c tabBarView:didSelectItem: . */
@interface MDCTabBarViewTestsDidSelectDelegate : NSObject <MDCTabBarViewDelegate>

/** The item passed by the last invocation of @c tabBarView:didSelectedItem: . */
@property(nonatomic, strong) UITabBarItem *selectedItem;

@end

@implementation MDCTabBarViewTestsDidSelectDelegate

- (void)tabBarView:(MDCTabBarView *)tabBarView didSelectItem:(UITabBarItem *)item {
  self.selectedItem = item;
}

@end

#pragma mark - Test Class

/** Unit tests for MDCTabBarView. */
@interface MDCTabBarViewTests : XCTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCTabBarView *tabBarView;

/** A tab bar item. */
@property(nonatomic, strong) UITabBarItem *itemA;

/** A tab bar item. */
@property(nonatomic, strong) UITabBarItem *itemB;

/** A tab bar item. */
@property(nonatomic, strong) UITabBarItem *itemC;

@end

@implementation MDCTabBarViewTests

- (void)setUp {
  [super setUp];

  self.tabBarView = [[MDCTabBarView alloc] init];
  self.itemA = [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0];
  self.itemB = [[UITabBarItem alloc] initWithTitle:@"B" image:nil tag:0];
  self.itemC = [[UITabBarItem alloc] initWithTitle:@"C" image:nil tag:0];
}

- (void)tearDown {
  self.itemA = nil;
  self.itemB = nil;
  self.itemC = nil;
  self.tabBarView = nil;

  [super tearDown];
}

- (void)testDefaultValues {
  // When
  MDCTabBarView *tabBarView = [[MDCTabBarView alloc] init];

  // Then
  XCTAssertNotNil(tabBarView);
  XCTAssertNotNil(tabBarView.items);
  XCTAssertEqualObjects(self.tabBarView.rippleColor, [[UIColor alloc] initWithWhite:0
                                                                              alpha:(CGFloat)0.16]);
  XCTAssertEqualObjects(self.tabBarView.bottomDividerColor, UIColor.clearColor);
  XCTAssertEqualObjects(self.tabBarView.barTintColor, UIColor.whiteColor);

  UIEdgeInsets actualScrollableLayoutPadding =
      [self.tabBarView contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleScrollable];
  UIEdgeInsets expectedScrollableLayoutPadding = UIEdgeInsetsMake(0, 52, 0, 0);
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(actualScrollableLayoutPadding, expectedScrollableLayoutPadding),
      @"(%@) is not equal to (%@)", NSStringFromUIEdgeInsets(actualScrollableLayoutPadding),
      NSStringFromUIEdgeInsets(expectedScrollableLayoutPadding));
  UIEdgeInsets actualFixedLayoutPadding =
      [self.tabBarView contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(actualFixedLayoutPadding, UIEdgeInsetsZero),
                @"(%@) is not equal to (%@)", NSStringFromUIEdgeInsets(actualFixedLayoutPadding),
                NSStringFromUIEdgeInsets(UIEdgeInsetsZero));
  UIEdgeInsets actualFixedClusteredLeadingLayoutPadding =
      [self.tabBarView contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredLeading];
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(actualFixedClusteredLeadingLayoutPadding, UIEdgeInsetsZero),
      @"(%@) is not equal to (%@)",
      NSStringFromUIEdgeInsets(actualFixedClusteredLeadingLayoutPadding),
      NSStringFromUIEdgeInsets(UIEdgeInsetsZero));
  UIEdgeInsets actualFixedClusteredTrailingLayoutPadding =
      [self.tabBarView contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredTrailing];
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(actualFixedClusteredTrailingLayoutPadding, UIEdgeInsetsZero),
      @"(%@) is not equal to (%@)",
      NSStringFromUIEdgeInsets(actualFixedClusteredTrailingLayoutPadding),
      NSStringFromUIEdgeInsets(UIEdgeInsetsZero));
  UIEdgeInsets actualFixedClusteredCenteredLayoutPadding =
      [self.tabBarView contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredCentered];
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(actualFixedClusteredCenteredLayoutPadding, UIEdgeInsetsZero),
      @"(%@) is not equal to (%@)",
      NSStringFromUIEdgeInsets(actualFixedClusteredCenteredLayoutPadding),
      NSStringFromUIEdgeInsets(UIEdgeInsetsZero));
}

/// Tab bars should by default select nil in their items array. The behavior should also be
/// consistent with the UIKit
- (void)testSelectsNilByDefault {
  // Given
  self.tabBarView.items = @[ self.itemA, self.itemB, self.itemC ];

  // Then
  XCTAssertNil(self.tabBarView.selectedItem);
}

/// Tab bars should preserve their selection if possible when changing items.
- (void)testPreservesSelectedItem {
  // Given items {A, B} which selected item A
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemA;
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);

  // When
  self.tabBarView.items = @[ self.itemC, self.itemA ];

  // Then should preserve the selection of A.
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);
}

/// Tab bars should select nil if the old selection is no longer present.
- (void)testSelectsNilWhenSelectedItemMissing {
  // Given items {A, B} which selected item A.
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemA;
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);

  // When
  self.tabBarView.items = @[ self.itemB, self.itemC ];

  // Then set items not including A, which should select nil.
  XCTAssertNil(self.tabBarView.selectedItem);
}

/// Tab bars should safely accept having their items set to the empty array.
- (void)testSafelyHandlesEmptyItems {
  // Given
  self.tabBarView.items = @[];
  XCTAssertNil(self.tabBarView.selectedItem);

  // When
  self.tabBarView.items = @[ self.itemA ];
  self.tabBarView.items = @[];

  // Then
  XCTAssertNil(self.tabBarView.selectedItem);
}

// Tab bar should ignore setting a `selectedItem` to something not in the `items` array.
- (void)testSafelyHandlesNonExistItem {
  // Given
  self.tabBarView.items = @[];
  self.tabBarView.selectedItem = nil;

  // When
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemC;

  // Then
  XCTAssertNil(self.tabBarView.selectedItem);
}

// Setting items to the same set of items should change nothing.
- (void)testItemsUpdateIsIdempotent {
  // Given items {A, B} which selected item A.
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemA;
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);

  // When set same set of items.
  self.tabBarView.items = @[ self.itemA, self.itemB ];

  // Then should make no difference to the selection.
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);
}

#pragma mark - Theming Properties

- (void)testSettingBarTintColorUpdatesBackgroundColor {
  // Given
  self.tabBarView.backgroundColor = nil;

  // When
  self.tabBarView.barTintColor = UIColor.orangeColor;

  // Then
  XCTAssertEqual(self.tabBarView.barTintColor, UIColor.orangeColor);
  XCTAssertEqual(self.tabBarView.backgroundColor, self.tabBarView.barTintColor);
}

- (void)testSettingBackgroundColorUpdatesBarTintColor {
  // Given
  self.tabBarView.barTintColor = nil;

  // When
  self.tabBarView.backgroundColor = UIColor.purpleColor;

  // Then
  XCTAssertEqual(self.tabBarView.backgroundColor, UIColor.purpleColor);
  XCTAssertEqual(self.tabBarView.barTintColor, self.tabBarView.backgroundColor);
}

- (void)testImageTintColorForStateFallsBackToNormalState {
  // Given
  [self.tabBarView setImageTintColor:nil forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:nil forState:UIControlStateSelected];

  // When
  [self.tabBarView setImageTintColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects([self.tabBarView imageTintColorForState:UIControlStateSelected],
                        UIColor.purpleColor);
}

- (void)testImageTintColorForStateReturnsExpectedValue {
  // Given
  [self.tabBarView setImageTintColor:nil forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:nil forState:UIControlStateSelected];

  // When
  [self.tabBarView setImageTintColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:UIColor.orangeColor forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects([self.tabBarView imageTintColorForState:UIControlStateNormal],
                        UIColor.purpleColor);
  XCTAssertEqualObjects([self.tabBarView imageTintColorForState:UIControlStateSelected],
                        UIColor.orangeColor);
}

- (void)testImageTintColorColorForStateSetToNilFallsBackToNormal {
  // Given
  [self.tabBarView setImageTintColor:nil forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:UIColor.cyanColor forState:UIControlStateSelected];

  // When
  [self.tabBarView setImageTintColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:nil forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects([self.tabBarView imageTintColorForState:UIControlStateNormal],
                        UIColor.purpleColor);
  XCTAssertEqualObjects([self.tabBarView imageTintColorForState:UIControlStateSelected],
                        UIColor.purpleColor);
}

- (void)testImageTintColorForStateWithNoValuesReturnsNil {
  // When
  [self.tabBarView setImageTintColor:nil forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:nil forState:UIControlStateSelected];

  // Then
  XCTAssertNil([self.tabBarView imageTintColorForState:UIControlStateNormal]);
  XCTAssertNil([self.tabBarView imageTintColorForState:UIControlStateSelected]);
}

- (void)testTitleColorForStateFallsBackToNormalState {
  // Given
  [self.tabBarView setTitleColor:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:nil forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects([self.tabBarView titleColorForState:UIControlStateSelected],
                        UIColor.purpleColor);
}

- (void)testTitleColorForStateReturnsExpectedValue {
  // Given
  [self.tabBarView setTitleColor:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:nil forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects([self.tabBarView titleColorForState:UIControlStateNormal],
                        UIColor.purpleColor);
  XCTAssertEqualObjects([self.tabBarView titleColorForState:UIControlStateSelected],
                        UIColor.orangeColor);
}

- (void)testTitleColorForStateSetToNilFallsBackToNormal {
  // Given
  [self.tabBarView setTitleColor:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:UIColor.cyanColor forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:nil forState:UIControlStateSelected];

  // Then
  XCTAssertEqualObjects([self.tabBarView titleColorForState:UIControlStateNormal],
                        UIColor.purpleColor);
  XCTAssertEqualObjects([self.tabBarView titleColorForState:UIControlStateSelected],
                        UIColor.purpleColor);
}

- (void)testTitleColorForStateWithNoValuesReturnsNil {
  // When
  [self.tabBarView setTitleColor:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:nil forState:UIControlStateSelected];

  // Then
  XCTAssertNil([self.tabBarView titleColorForState:UIControlStateNormal]);
  XCTAssertNil([self.tabBarView titleColorForState:UIControlStateSelected]);
}

- (void)testTitleFontForStateFallsBackToNormalState {
  // Given
  UIFont *fakeFont = [UIFont systemFontOfSize:25];
  [self.tabBarView setTitleFont:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:nil forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleFont:fakeFont forState:UIControlStateNormal];

  // Then
  [self assertTitleFontForState:UIControlStateSelected equalsFont:fakeFont];
}

- (void)testTitleFontForStateReturnsExpectedValue {
  // Given
  UIFont *fakeNormalFont = [UIFont systemFontOfSize:25];
  UIFont *fakeSelectedFont = [UIFont systemFontOfSize:24];
  [self.tabBarView setTitleFont:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:nil forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleFont:fakeNormalFont forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:fakeSelectedFont forState:UIControlStateSelected];

  // Then
  [self assertTitleFontForState:UIControlStateNormal equalsFont:fakeNormalFont];
  [self assertTitleFontForState:UIControlStateSelected equalsFont:fakeSelectedFont];
}

- (void)testTitleFontForStateSetToNilFallsBackToNormal {
  // Given
  UIFont *fakeNormalFont = [UIFont systemFontOfSize:25];
  UIFont *fakeSelectedFont = [UIFont systemFontOfSize:24];
  [self.tabBarView setTitleFont:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:fakeSelectedFont forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleFont:fakeNormalFont forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:nil forState:UIControlStateSelected];

  // Then
  [self assertTitleFontForState:UIControlStateNormal equalsFont:fakeNormalFont];
  [self assertTitleFontForState:UIControlStateSelected equalsFont:fakeNormalFont];
}

- (void)testTitleFontForStateWithNoValuesReturnsNil {
  // When
  [self.tabBarView setTitleFont:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:nil forState:UIControlStateSelected];

  // Then
  XCTAssertNil([self.tabBarView titleColorForState:UIControlStateNormal]);
  XCTAssertNil([self.tabBarView titleColorForState:UIControlStateSelected]);
}

- (void)assertTitleFontForState:(UIControlState)state equalsFont:(UIFont *)font {
  UIFont *statefulTitleFont = [self.tabBarView titleFontForState:state];
  XCTAssertTrue([statefulTitleFont mdc_isSimplyEqual:font], @"(%@) is not equal to (%@)",
                statefulTitleFont, font);
}

- (void)testContentPaddingAddedToContentSizeForScrollableLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;
  [self.tabBarView setContentPadding:UIEdgeInsetsZero
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalContentSize = self.tabBarView.contentSize;
  CGSize expectedContentSize =
      CGSizeMake(originalContentSize.width + contentPadding.left + contentPadding.right,
                 originalContentSize.height + contentPadding.top + contentPadding.bottom);

  // When
  [self.tabBarView setContentPadding:contentPadding
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualContentSize = self.tabBarView.contentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualContentSize, expectedContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualContentSize),
                NSStringFromCGSize(expectedContentSize));
}

- (void)testContentPaddingAddedToIntrinsicContentSizeForScrollableLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;
  [self.tabBarView setContentPadding:UIEdgeInsetsZero
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  CGSize expectedIntrinsicContentSize =
      CGSizeMake(originalIntrinsicContentSize.width + contentPadding.left + contentPadding.right,
                 originalIntrinsicContentSize.height + contentPadding.top + contentPadding.bottom);

  // When
  [self.tabBarView setContentPadding:contentPadding
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualIntrinsicContentSize, expectedIntrinsicContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualIntrinsicContentSize),
                NSStringFromCGSize(expectedIntrinsicContentSize));
}

- (void)testContentPaddingAddedToContentSizeForScrollableFallbackLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;
  [self.tabBarView setContentPadding:UIEdgeInsetsZero
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  // Too-small bounds forces a "scrollable" layout instead
  self.tabBarView.bounds = CGRectMake(0, 0, 100, 1000);
  self.tabBarView.items = @[ self.itemA, self.itemB, self.itemC ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalContentSize = self.tabBarView.contentSize;
  CGSize expectedContentSize =
      CGSizeMake(originalContentSize.width + contentPadding.left + contentPadding.right,
                 originalContentSize.height + contentPadding.top + contentPadding.bottom);

  // When
  [self.tabBarView setContentPadding:contentPadding
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualContentSize = self.tabBarView.contentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualContentSize, expectedContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualContentSize),
                NSStringFromCGSize(expectedContentSize));
}

- (void)testContentPaddingWontAffectContentSizeForFixedLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalContentSize = self.tabBarView.contentSize;

  // When
  [self.tabBarView setContentPadding:contentPadding forLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualContentSize = self.tabBarView.contentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualContentSize, originalContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualContentSize),
                NSStringFromCGSize(originalContentSize));
}

- (void)testContentPaddingAddedToIntrinsicContentSizeForFixedLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  CGSize expectedIntrinsicContentSize =
      CGSizeMake(originalIntrinsicContentSize.width + contentPadding.left + contentPadding.right,
                 originalIntrinsicContentSize.height + contentPadding.top + contentPadding.bottom);

  // When
  [self.tabBarView setContentPadding:contentPadding forLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualIntrinsicContentSize, expectedIntrinsicContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualIntrinsicContentSize),
                NSStringFromCGSize(expectedIntrinsicContentSize));
}

- (void)testContentPaddingWontAffectContentSizeForFixedClusteredLeadingLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalContentSize = self.tabBarView.contentSize;

  // When
  [self.tabBarView setContentPadding:contentPadding forLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualContentSize = self.tabBarView.contentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualContentSize, originalContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualContentSize),
                NSStringFromCGSize(originalContentSize));
}

- (void)testContentPaddingAddedToIntrinsicContentSizeForFixedClusteredLeadingLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  CGSize expectedIntrinsicContentSize =
      CGSizeMake(originalIntrinsicContentSize.width + contentPadding.left + contentPadding.right,
                 originalIntrinsicContentSize.height + contentPadding.top + contentPadding.bottom);

  // When
  [self.tabBarView setContentPadding:contentPadding
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredLeading];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualIntrinsicContentSize, expectedIntrinsicContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualIntrinsicContentSize),
                NSStringFromCGSize(expectedIntrinsicContentSize));
}

- (void)testContentPaddingWontAffectContentSizeForFixedClusteredTrailingLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalContentSize = self.tabBarView.contentSize;

  // When
  [self.tabBarView setContentPadding:contentPadding forLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualContentSize = self.tabBarView.contentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualContentSize, originalContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualContentSize),
                NSStringFromCGSize(originalContentSize));
}

- (void)testContentPaddingAddedToIntrinsicContentSizeForFixedClusteredTrailingLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  CGSize expectedIntrinsicContentSize =
      CGSizeMake(originalIntrinsicContentSize.width + contentPadding.left + contentPadding.right,
                 originalIntrinsicContentSize.height + contentPadding.top + contentPadding.bottom);

  // When
  [self.tabBarView setContentPadding:contentPadding
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredTrailing];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualIntrinsicContentSize, expectedIntrinsicContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualIntrinsicContentSize),
                NSStringFromCGSize(expectedIntrinsicContentSize));
}

- (void)testContentPaddingWontAffectContentSizeForFixedClusteredCenteredLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalContentSize = self.tabBarView.contentSize;

  // When
  [self.tabBarView setContentPadding:contentPadding forLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualContentSize = self.tabBarView.contentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualContentSize, originalContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualContentSize),
                NSStringFromCGSize(originalContentSize));
}

- (void)testContentPaddingAddedToIntrinsicContentSizeForFixedClusteredCenteredLayout {
  // Given
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;
  UIEdgeInsets contentPadding = UIEdgeInsetsMake(1, 2, 3, 4);
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMaxWidthTabBarItem - contentPadding.left - contentPadding.right, 1000);
  self.tabBarView.items = @[ self.itemA ];
  [self.tabBarView layoutIfNeeded];
  CGSize originalIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  CGSize expectedIntrinsicContentSize =
      CGSizeMake(originalIntrinsicContentSize.width + contentPadding.left + contentPadding.right,
                 originalIntrinsicContentSize.height + contentPadding.top + contentPadding.bottom);

  // When
  [self.tabBarView setContentPadding:contentPadding
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredCentered];
  [self.tabBarView layoutIfNeeded];

  // Then
  CGSize actualIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  XCTAssertTrue(CGSizeEqualToSize(actualIntrinsicContentSize, expectedIntrinsicContentSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(actualIntrinsicContentSize),
                NSStringFromCGSize(expectedIntrinsicContentSize));
}

#pragma mark - Delegate

- (void)testReturnNoForShouldSelectItemPreventsSelection {
  // Given
  MDCTabBarViewTestsFullDelegate *delegate = [[MDCTabBarViewTestsFullDelegate alloc] init];
  self.tabBarView.tabBarDelegate = delegate;
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.bounds = CGRectMake(0, 0, 180, 72);
  [self.tabBarView layoutIfNeeded];
  // Retrieve the view bound to `itemA`.
  UIView *hitView = [self.tabBarView hitTest:CGPointMake(0, 0) withEvent:nil];
  while (hitView && ![hitView isKindOfClass:[MDCTabBarViewItemView class]]) {
    hitView = hitView.superview;
  }
  MDCTabBarViewFakeTapGestureRecognizer *tapRecognizer =
      [[MDCTabBarViewFakeTapGestureRecognizer alloc] init];
  tapRecognizer.settableView = hitView;

  // When
  delegate.shouldAllowSelection = NO;
  [self.tabBarView didTapItemView:tapRecognizer];

  // Then
  XCTAssertEqual(delegate.attemptedSelectedItem, self.itemA);
  XCTAssertNil(delegate.selectedItem);
  XCTAssertNil(self.tabBarView.selectedItem);
}

- (void)testReturnYESForShouldSelectItemAllowsSelection {
  // Given
  MDCTabBarViewTestsFullDelegate *delegate = [[MDCTabBarViewTestsFullDelegate alloc] init];
  self.tabBarView.tabBarDelegate = delegate;
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.bounds = CGRectMake(0, 0, 180, 72);
  [self.tabBarView layoutIfNeeded];
  // Retrieve the view bound to `itemA`.
  UIView *hitView = [self.tabBarView hitTest:CGPointMake(0, 0) withEvent:nil];
  while (hitView && ![hitView isKindOfClass:[MDCTabBarViewItemView class]]) {
    hitView = hitView.superview;
  }
  MDCTabBarViewFakeTapGestureRecognizer *tapRecognizer =
      [[MDCTabBarViewFakeTapGestureRecognizer alloc] init];
  tapRecognizer.settableView = hitView;

  // When
  delegate.shouldAllowSelection = YES;
  [self.tabBarView didTapItemView:tapRecognizer];

  // Then
  XCTAssertEqual(delegate.attemptedSelectedItem, self.itemA);
  XCTAssertEqual(delegate.selectedItem, self.itemA);
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);
}

- (void)testReturnNoForShouldSelectItemWithoutDidSelectImplementationPreventsSelection {
  // Given
  MDCTabBarViewTestsShouldSelectDelegate *delegate =
      [[MDCTabBarViewTestsShouldSelectDelegate alloc] init];
  self.tabBarView.tabBarDelegate = delegate;
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.bounds = CGRectMake(0, 0, 180, 72);
  [self.tabBarView layoutIfNeeded];
  // Retrieve the view bound to `itemA`.
  UIView *hitView = [self.tabBarView hitTest:CGPointMake(0, 0) withEvent:nil];
  while (hitView && ![hitView isKindOfClass:[MDCTabBarViewItemView class]]) {
    hitView = hitView.superview;
  }
  MDCTabBarViewFakeTapGestureRecognizer *tapRecognizer =
      [[MDCTabBarViewFakeTapGestureRecognizer alloc] init];
  tapRecognizer.settableView = hitView;

  // When
  delegate.shouldAllowSelection = NO;
  [self.tabBarView didTapItemView:tapRecognizer];

  // Then
  XCTAssertEqual(delegate.attemptedSelectedItem, self.itemA);
  XCTAssertNil(self.tabBarView.selectedItem);
}

- (void)testReturnYESForShouldSelectItemWithoutDidSelectImplementationAllowsSelection {
  // Given
  MDCTabBarViewTestsShouldSelectDelegate *delegate =
      [[MDCTabBarViewTestsShouldSelectDelegate alloc] init];
  self.tabBarView.tabBarDelegate = delegate;
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.bounds = CGRectMake(0, 0, 180, 72);
  [self.tabBarView layoutIfNeeded];
  // Retrieve the view bound to `itemA`.
  UIView *hitView = [self.tabBarView hitTest:CGPointMake(0, 0) withEvent:nil];
  while (hitView && ![hitView isKindOfClass:[MDCTabBarViewItemView class]]) {
    hitView = hitView.superview;
  }
  MDCTabBarViewFakeTapGestureRecognizer *tapRecognizer =
      [[MDCTabBarViewFakeTapGestureRecognizer alloc] init];
  tapRecognizer.settableView = hitView;

  // When
  delegate.shouldAllowSelection = YES;
  [self.tabBarView didTapItemView:tapRecognizer];

  // Then
  XCTAssertEqual(delegate.attemptedSelectedItem, self.itemA);
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);
}

- (void)testReturnNoForShouldSelectItemWithoutShouldSelectImplementationAllowsSelection {
  // Given
  MDCTabBarViewTestsDidSelectDelegate *delegate =
      [[MDCTabBarViewTestsDidSelectDelegate alloc] init];
  self.tabBarView.tabBarDelegate = delegate;
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.bounds = CGRectMake(0, 0, 180, 72);
  [self.tabBarView layoutIfNeeded];
  // Retrieve the view bound to `itemA`.
  UIView *hitView = [self.tabBarView hitTest:CGPointMake(0, 0) withEvent:nil];
  while (hitView && ![hitView isKindOfClass:[MDCTabBarViewItemView class]]) {
    hitView = hitView.superview;
  }
  MDCTabBarViewFakeTapGestureRecognizer *tapRecognizer =
      [[MDCTabBarViewFakeTapGestureRecognizer alloc] init];
  tapRecognizer.settableView = hitView;

  // When
  [self.tabBarView didTapItemView:tapRecognizer];

  // Then
  XCTAssertEqual(delegate.selectedItem, self.itemA);
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);
}

#pragma mark - UIView

- (void)testIntrinsicContentSizeForNoItemsHasMinimumHeightAndZeroWidth {
  // When
  self.tabBarView.items = @[];

  // Then
  CGSize size = self.tabBarView.intrinsicContentSize;
  XCTAssertEqualWithAccuracy(size.width, 0.0, 0.001);
  XCTAssertEqualWithAccuracy(size.height, kMinHeight, 0.001);
}

- (void)testIntrinsicContentSizeForSingleItemMeetsMinimumExpectations {
  // When
  self.tabBarView.items = @[ self.itemA ];

  // Then
  CGSize size = self.tabBarView.intrinsicContentSize;
  XCTAssertGreaterThan(size.width, 0.0);
  XCTAssertGreaterThanOrEqual(size.height, kMinHeight);
}

- (void)testIntrinsicContentSizeForVeryLargeImageHasGreaterHeightThanTypicalImageSize {
  // Given
  UIImage *typicalImage = fakeImage(CGSizeMake(24, 24));
  UIImage *largeImage = fakeImage(CGSizeMake(48, 48));
  self.itemA.image = typicalImage;
  self.tabBarView.items = @[ self.itemA ];
  CGSize intrinsicContentSizeWithTypicalImage = [self.tabBarView intrinsicContentSize];

  // When
  self.itemA.image = largeImage;

  // Then
  CGSize intrinsicContentSizeWithLargeImage = [self.tabBarView intrinsicContentSize];
  XCTAssertGreaterThan(intrinsicContentSizeWithLargeImage.height,
                       intrinsicContentSizeWithTypicalImage.height);
  XCTAssertGreaterThanOrEqual(intrinsicContentSizeWithLargeImage.width,
                              intrinsicContentSizeWithTypicalImage.width);
}

- (void)testIntrinsicContentSizeDeterminedByJustifiedViewNotScrollableView {
  // Given
  self.tabBarView.items = @[ self.itemA, self.itemB, self.itemC ];

  // When
  self.itemA.title = @".";
  self.itemB.title = @".................................................................."
                      ".................................................................."
                      ".................................................................."
                      ".................................................................."
                      ".................................................................."
                      "..................................................................";
  self.itemC.title = @".";

  // Then
  CGSize intrinsicSizeMinimalSize =
      CGSizeMake(kMaxWidthTabBarItem * self.tabBarView.items.count, kMinHeight);
  CGSize actualIntrinsicContentSize = self.tabBarView.intrinsicContentSize;
  // Verify that it's at least 90% of the naïvely-calculated expected size. Due to truncation or
  // internal details, it may be slightly less (or greater).
  XCTAssertGreaterThanOrEqual(actualIntrinsicContentSize.width,
                              intrinsicSizeMinimalSize.width * 0.9);
  XCTAssertGreaterThanOrEqual(actualIntrinsicContentSize.height, intrinsicSizeMinimalSize.height);
}

- (void)testSizeThatFitsFitsOnlyIncreasesHeightForTooSmallSize {
  // Given
  self.tabBarView.items = @[ self.itemA ];

  // When
  CGSize size = [self.tabBarView sizeThatFits:CGSizeZero];

  // Then
  XCTAssertEqualWithAccuracy(size.width, 0, 0.001);
  XCTAssertEqualWithAccuracy(size.height, kMinHeight, 0.001);
}

- (void)testSizeThatFitsShrinksToFitContentVerticallyButNotHorizontally {
  // Given
  self.tabBarView.items = @[ self.itemA ];
  CGSize intrinsicSize = self.tabBarView.intrinsicContentSize;
  CGSize biggerSize = CGSizeMake(intrinsicSize.width + 10, intrinsicSize.height + 10);

  // When
  CGSize size = [self.tabBarView sizeThatFits:biggerSize];

  // Then
  XCTAssertEqualWithAccuracy(size.width, biggerSize.width, 0.001);
  XCTAssertEqualWithAccuracy(size.height, intrinsicSize.height, 0.001);
}

#pragma mark - Custom Views

- (void)testCustomViewSetSelectedAnimatedCalledForSelectedWithImplicitAnimation {
  // Given
  MDCTabBarViewTestCustomViewMock *mockCustomView = [[MDCTabBarViewTestCustomViewMock alloc] init];
  MDCTabBarItem *customItem = [[MDCTabBarItem alloc] init];
  customItem.mdc_customView = mockCustomView;
  self.tabBarView.items = @[ customItem ];

  // When
  [self.tabBarView setSelectedItem:customItem];

  // Then
  XCTAssertTrue(mockCustomView.selected);
  XCTAssertTrue(mockCustomView.setSelectedCalledWithAnimation);
}

- (void)testCustomViewSetSelectedAnimatedCalledForUnselectedWithImplicitAnimation {
  // Given
  MDCTabBarViewTestCustomViewMock *mockCustomView = [[MDCTabBarViewTestCustomViewMock alloc] init];
  MDCTabBarItem *customItem = [[MDCTabBarItem alloc] init];
  customItem.mdc_customView = mockCustomView;
  self.tabBarView.items = @[ customItem ];
  [self.tabBarView setSelectedItem:customItem];

  // When
  [self.tabBarView setSelectedItem:nil];

  // Then
  XCTAssertFalse(mockCustomView.selected);
  XCTAssertTrue(mockCustomView.setSelectedCalledWithAnimation);
}

- (void)testCustomViewSetSelectedAnimatedCalledForSelectedWithExplicitAnimation {
  // Given
  MDCTabBarViewTestCustomViewMock *mockCustomView = [[MDCTabBarViewTestCustomViewMock alloc] init];
  MDCTabBarItem *customItem = [[MDCTabBarItem alloc] init];
  customItem.mdc_customView = mockCustomView;
  self.tabBarView.items = @[ customItem ];

  // When
  [self.tabBarView setSelectedItem:customItem animated:YES];

  // Then
  XCTAssertTrue(mockCustomView.selected);
  XCTAssertTrue(mockCustomView.setSelectedCalledWithAnimation);
}

- (void)testCustomViewSetSelectedAnimatedCalledForUnselectedWithExplicitAnimation {
  // Given
  MDCTabBarViewTestCustomViewMock *mockCustomView = [[MDCTabBarViewTestCustomViewMock alloc] init];
  MDCTabBarItem *customItem = [[MDCTabBarItem alloc] init];
  customItem.mdc_customView = mockCustomView;
  self.tabBarView.items = @[ customItem ];
  [self.tabBarView setSelectedItem:customItem];

  // When
  [self.tabBarView setSelectedItem:nil animated:YES];

  // Then
  XCTAssertFalse(mockCustomView.selected);
  XCTAssertTrue(mockCustomView.setSelectedCalledWithAnimation);
}

- (void)testCustomViewSetSelectedAnimatedCalledForSelectedWithoutAnimation {
  // Given
  MDCTabBarViewTestCustomViewMock *mockCustomView = [[MDCTabBarViewTestCustomViewMock alloc] init];
  MDCTabBarItem *customItem = [[MDCTabBarItem alloc] init];
  customItem.mdc_customView = mockCustomView;
  self.tabBarView.items = @[ customItem ];

  // When
  [self.tabBarView setSelectedItem:customItem animated:NO];

  // Then
  XCTAssertTrue(mockCustomView.selected);
  XCTAssertFalse(mockCustomView.setSelectedCalledWithAnimation);
}

- (void)testCustomViewSetSelectedAnimatedCalledForUnselectedWithoutAnimation {
  // Given
  MDCTabBarViewTestCustomViewMock *mockCustomView = [[MDCTabBarViewTestCustomViewMock alloc] init];
  MDCTabBarItem *customItem = [[MDCTabBarItem alloc] init];
  customItem.mdc_customView = mockCustomView;
  self.tabBarView.items = @[ customItem ];
  [self.tabBarView setSelectedItem:customItem];

  // When
  [self.tabBarView setSelectedItem:nil animated:NO];

  // Then
  XCTAssertFalse(mockCustomView.selected);
  XCTAssertFalse(mockCustomView.setSelectedCalledWithAnimation);
}

#pragma mark - Key-Value Observing (KVO)

- (void)testSettingTitleNilFromNonNilValue {
  // Given
  self.tabBarView.items = @[ self.itemA ];
  self.itemA.title = @"Not nil";

  // When
  self.itemA.title = nil;

  // Then
  XCTAssertNoThrow([self.tabBarView layoutIfNeeded]);
}

- (void)testSettingImageNilFromNonNilValue {
  // Given
  self.tabBarView.items = @[ self.itemA ];
  self.itemA.image = fakeImage(CGSizeMake(24, 24));

  // When
  self.itemA.image = nil;

  // Then
  XCTAssertNoThrow([self.tabBarView layoutIfNeeded]);
}

- (void)testSettingSelectedImageNilFromNonNilValue {
  // Given
  self.tabBarView.items = @[ self.itemA ];
  self.itemA.selectedImage = fakeImage(CGSizeMake(24, 24));

  // When
  self.itemA.selectedImage = nil;

  // Then
  XCTAssertNoThrow([self.tabBarView layoutIfNeeded]);
}

#pragma mark - UIAccessibility

- (void)testTabBarViewNotAccessibilityElement {
  // Then
  XCTAssertFalse(self.tabBarView.isAccessibilityElement);
}

- (void)testTabBarViewAlwaysBehavesAsTabBarOniOS10 {
  // When
  self.tabBarView.accessibilityTraits = UIAccessibilityTraitLink;

  if (@available(iOS 10.0, *)) {
    // Then
    XCTAssertEqual(self.tabBarView.accessibilityTraits,
                   UIAccessibilityTraitTabBar | UIAccessibilityTraitLink);
  }
}

#pragma mark - Custom APIs

- (void)testAccessibilityElementForItemNotInItemsArrayReturnsNil {
  // Given
  self.tabBarView.items = @[ self.itemA ];

  // When
  UIAccessibilityElement *element = [self.tabBarView accessibilityElementForItem:self.itemB];

  // Then
  XCTAssertNil(element);
}

- (void)testAccessibilityElementForEmptyItemsArrayReturnsNil {
  // Given
  self.tabBarView.items = @[];

  // When
  UIAccessibilityElement *element = [self.tabBarView accessibilityElementForItem:self.itemB];

  // Then
  XCTAssertNil(element);
}

- (void)testAccessibilityElementForItemInItemsArrayReturnsItemViewWithMatchingTitleAndImage {
  // Given
  self.itemB.image = fakeImage(CGSizeMake(24, 24));
  self.tabBarView.items = @[ self.itemA, self.itemB, self.itemC ];

  // When
  UIAccessibilityElement *element = [self.tabBarView accessibilityElementForItem:self.itemB];

  // Then
  XCTAssertTrue([element isKindOfClass:[MDCTabBarViewItemView class]], @"(%@) is not of class (%@)",
                element, NSStringFromClass([MDCTabBarViewItemView class]));
  if ([element isKindOfClass:[MDCTabBarViewItemView class]]) {
    MDCTabBarViewItemView *itemView = (MDCTabBarViewItemView *)element;
    XCTAssertEqualObjects(itemView.titleLabel.text, self.itemB.title);
    XCTAssertEqualObjects(itemView.iconImageView.image, self.itemB.image);
  }
}

- (void)testRectForItemNotFoundReturnsNullRectangle {
  // Given
  self.tabBarView.items = @[];

  // When
  CGRect itemFrame = [self.tabBarView rectForItem:self.itemC inCoordinateSpace:self.tabBarView];

  // Then
  XCTAssertTrue(CGRectIsNull(itemFrame), @"(%@) is not equal to (%@)",
                NSStringFromCGRect(itemFrame), NSStringFromCGRect(CGRectNull));
}

- (void)testRectForItemConvertedToTabBarView {
  // Given
  self.tabBarView.items = @[ self.itemA ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);
  [self.tabBarView layoutIfNeeded];

  // When
  CGRect itemFrame = [self.tabBarView rectForItem:self.itemA inCoordinateSpace:self.tabBarView];

  // Then
  XCTAssertTrue(CGRectEqualToRect(itemFrame, self.tabBarView.bounds), @"(%@) is not equal to (%@)",
                NSStringFromCGRect(itemFrame), NSStringFromCGRect(self.tabBarView.bounds));
}

- (void)testRectForItemConvertedToSuperView {
  // Given
  UIOffset tabBarOffsetWithinSuperview = UIOffsetMake(30, 40);
  self.tabBarView.items = @[ self.itemA ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);
  [self.tabBarView layoutIfNeeded];
  UIView *tabBarSuperview =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                               CGRectGetWidth(self.tabBarView.bounds) +
                                                   tabBarOffsetWithinSuperview.horizontal,
                                               CGRectGetHeight(self.tabBarView.bounds) +
                                                   tabBarOffsetWithinSuperview.vertical)];
  [tabBarSuperview addSubview:self.tabBarView];
  self.tabBarView.center = CGPointMake(
      CGRectGetMidX(tabBarSuperview.bounds) + (tabBarOffsetWithinSuperview.horizontal / 2),
      CGRectGetMidY(tabBarSuperview.bounds) + (tabBarOffsetWithinSuperview.vertical / 2));

  // When
  CGRect itemFrame = [self.tabBarView rectForItem:self.itemA inCoordinateSpace:tabBarSuperview];
  CGRect expectedFrame =
      CGRectMake(tabBarOffsetWithinSuperview.horizontal, tabBarOffsetWithinSuperview.vertical,
                 CGRectGetWidth(self.tabBarView.bounds), CGRectGetHeight(self.tabBarView.bounds));

  // Then
  XCTAssertTrue(CGRectEqualToRect(itemFrame, expectedFrame), @"(%@) is not equal to (%@)",
                NSStringFromCGRect(itemFrame), NSStringFromCGRect(expectedFrame));
}

- (void)testDefaultSelectionChangeAnimationDurationValue {
  // Then
  XCTAssertEqualWithAccuracy(self.tabBarView.selectionChangeAnimationDuration, 0.3, 0.0001);
}

- (void)testDefaultSelectionChangeAnimationTimingFunction {
  // Then
  CAMediaTimingFunction *expectedFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
  float expectedControlPoint1[2];
  float expectedControlPoint2[2];
  float expectedControlPoint3[2];
  float expectedControlPoint4[2];
  [expectedFunction getControlPointAtIndex:0 values:expectedControlPoint1];
  [expectedFunction getControlPointAtIndex:1 values:expectedControlPoint2];
  [expectedFunction getControlPointAtIndex:2 values:expectedControlPoint3];
  [expectedFunction getControlPointAtIndex:3 values:expectedControlPoint4];
  CAMediaTimingFunction *actualFunction = self.tabBarView.selectionChangeAnimationTimingFunction;
  float actualControlPoint1[2];
  float actualControlPoint2[2];
  float actualControlPoint3[2];
  float actualControlPoint4[2];
  [actualFunction getControlPointAtIndex:0 values:actualControlPoint1];
  [actualFunction getControlPointAtIndex:1 values:actualControlPoint2];
  [actualFunction getControlPointAtIndex:2 values:actualControlPoint3];
  [actualFunction getControlPointAtIndex:3 values:actualControlPoint4];
  XCTAssertEqualWithAccuracy(actualControlPoint1[0], expectedControlPoint1[0], 0.0001);
  XCTAssertEqualWithAccuracy(actualControlPoint1[1], expectedControlPoint1[1], 0.0001);
  XCTAssertEqualWithAccuracy(actualControlPoint2[0], expectedControlPoint2[0], 0.0001);
  XCTAssertEqualWithAccuracy(actualControlPoint2[1], expectedControlPoint2[1], 0.0001);
  XCTAssertEqualWithAccuracy(actualControlPoint3[0], expectedControlPoint3[0], 0.0001);
  XCTAssertEqualWithAccuracy(actualControlPoint3[1], expectedControlPoint3[1], 0.0001);
  XCTAssertEqualWithAccuracy(actualControlPoint4[0], expectedControlPoint4[0], 0.0001);
  XCTAssertEqualWithAccuracy(actualControlPoint4[1], expectedControlPoint4[1], 0.0001);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCTabBarView *passedTabBar = nil;
  self.tabBarView.traitCollectionDidChangeBlock =
      ^(MDCTabBarView *_Nonnull tabBar, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedTabBar = tabBar;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.tabBarView traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTabBar, self.tabBarView);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

@end
