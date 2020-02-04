// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "../../src/private/MDCBottomNavigationBar+Private.h"
#import "../../src/private/MDCBottomNavigationItemView.h"
#include "MDCAvailability.h"
#import "MaterialBottomNavigation.h"
#import "MaterialPalettes.h"
#import "MaterialShadowElevations.h"

/**
 A testing MDCBottomNavigationBar that allows safeAreaInsets to be set programmatically.
 */
@interface MDCSafeAreaCustomizingBottomNavigationBar : MDCBottomNavigationBar
/** Set this to override the value returned by @c safeAreaInsets. */
@property(nonatomic, assign) UIEdgeInsets test_safeAreaInsets;
@end

@implementation MDCSafeAreaCustomizingBottomNavigationBar

- (UIEdgeInsets)safeAreaInsets {
  return self.test_safeAreaInsets;
}

@end

@interface MDCBottomNavigationBar (Testing)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@end

@interface MDCBottomNavigationItemView (Testing)
@property(nonatomic, strong) UILabel *label;
@end

@interface MDCBottomNavigationBarTests : XCTestCase
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNavBar;
@end

@implementation MDCBottomNavigationBarTests

- (void)setUp {
  self.bottomNavBar = [[MDCBottomNavigationBar alloc] init];
}

- (void)tearDown {
  self.bottomNavBar = nil;
}

- (void)testDefaultValues {
  // When
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];

  // Then
  XCTAssertEqualObjects(bar.backgroundColor, UIColor.whiteColor);
  XCTAssertFalse(bar.isBackgroundBlurEnabled);
  XCTAssertEqual(bar.backgroundBlurEffectStyle, UIBlurEffectStyleExtraLight);
  XCTAssertEqualWithAccuracy(self.bottomNavBar.elevation, MDCShadowElevationBottomNavigationBar,
                             0.001);
  XCTAssertEqualWithAccuracy(self.bottomNavBar.mdc_currentElevation, self.bottomNavBar.elevation,
                             0.001);
  XCTAssertLessThan(self.bottomNavBar.mdc_overrideBaseElevation, 0);
  XCTAssertNil(self.bottomNavBar.mdc_elevationDidChangeBlock);
  XCTAssertEqualObjects(self.bottomNavBar.itemBadgeTextColor, UIColor.whiteColor);
  XCTAssertEqualObjects(self.bottomNavBar.itemBadgeBackgroundColor, MDCPalette.redPalette.tint700);
}

#pragma mark - Fonts

- (void)testItemTitleFontDefault {
  // Then
  XCTAssertNotNil(self.bottomNavBar.itemTitleFont);
}

- (void)testItemTitleFontAppliesToNewItems {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.itemTitleFont = [UIFont systemFontOfSize:31];
  self.bottomNavBar.items = @[ item1, item2 ];

  // Then
  for (MDCBottomNavigationItemView *item in self.bottomNavBar.itemViews) {
    XCTAssertEqualObjects(item.itemTitleFont, self.bottomNavBar.itemTitleFont);
  }
}

- (void)testItemTitleFontAppliesToExistingItems {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  self.bottomNavBar.itemTitleFont = [UIFont systemFontOfSize:31];

  // Then
  for (MDCBottomNavigationItemView *item in self.bottomNavBar.itemViews) {
    XCTAssertEqualObjects(item.itemTitleFont, self.bottomNavBar.itemTitleFont);
  }
}

- (void)testItemReset {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  self.bottomNavBar.items = @[ item1, item2, item3 ];

  // Then
  NSUInteger tabsCount = 3;
  XCTAssertEqual(self.bottomNavBar.itemViews.count, tabsCount);
}

- (void)testFramesAfterReset {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];
  [self.bottomNavBar sizeToFit];
  self.bottomNavBar.frame = CGRectMake(0, 0, 320, 56);

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  self.bottomNavBar.items = @[ item1, item2, item3 ];
  [self.bottomNavBar layoutIfNeeded];

  // Then
  XCTAssertFalse(CGRectEqualToRect(self.bottomNavBar.itemViews[0].frame, CGRectZero));
}

- (void)testSelectedItemAfterReset {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  self.bottomNavBar.items = @[ item1, item2, item3 ];

  // Then
  XCTAssertNil(self.bottomNavBar.selectedItem);
}

- (NSInteger)countOfViewsWithAccessibilityIdentifier:(NSString *)accessibilityIdentifier
                                        fromRootView:(UIView *)view {
  NSInteger sum = [view.accessibilityIdentifier isEqualToString:accessibilityIdentifier] ? 1 : 0;
  for (UIView *subview in view.subviews) {
    sum += [self countOfViewsWithAccessibilityIdentifier:accessibilityIdentifier
                                            fromRootView:subview];
  }
  return sum;
}

- (void)testSettingAccessibilityIdentifierAffectsExactlyOneSubview {
  // Given
  UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Title" image:nil tag:1];
  item.accessibilityIdentifier = @"__i_d__";

  // When
  self.bottomNavBar.items = @[ item ];

  // Then
  XCTAssertEqual([self countOfViewsWithAccessibilityIdentifier:item.accessibilityIdentifier
                                                  fromRootView:self.bottomNavBar],
                 1);
}

- (void)testAccessibilityLabelInitialValue {
  // Given
  NSString *initialLabel = @"initialLabel";
  UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
  tabBarItem.accessibilityLabel = initialLabel;
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];
  // When
  bar.items = @[ tabBarItem ];

  // Then
  XCTAssertEqualObjects(bar.itemViews.firstObject.accessibilityLabel, initialLabel);
}

- (void)testAccessibilityLabelValueChanged {
  // Given
  NSString *oldLabel = @"oldLabel";
  NSString *newLabel = @"newLabel";
  UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
  tabBarItem.accessibilityLabel = oldLabel;
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];
  bar.items = @[ tabBarItem ];

  // When
  tabBarItem.accessibilityLabel = newLabel;

  // Then
  XCTAssertEqualObjects(bar.itemViews.firstObject.accessibilityLabel, newLabel);
}

- (void)testAccessibilityHintInitialValue {
  // Given
  NSString *initialHint = @"initialHint";
  UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
  tabBarItem.accessibilityHint = initialHint;
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];

  // When
  bar.items = @[ tabBarItem ];

  // Then
  MDCBottomNavigationItemView *itemView = bar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  if (@available(iOS 10.0, *)) {
    XCTAssertEqualObjects(itemViewButton.accessibilityHint, initialHint);
  } else {
    // On iOS 9, the bar "fakes" being a tab bar and modifies the hint.
    XCTAssertTrue([itemViewButton.accessibilityHint containsString:initialHint],
                  @"(%@) does not contain (%@)", itemViewButton.accessibilityHint, initialHint);
  }
}

- (void)testAccessibilityHintValueChanged {
  // Given
  NSString *oldHint = @"oldHint";
  NSString *newHint = @"newHint";
  UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
  tabBarItem.accessibilityHint = oldHint;
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];
  bar.items = @[ tabBarItem ];

  // When
  tabBarItem.accessibilityHint = newHint;

  // Then
  MDCBottomNavigationItemView *itemView = bar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  XCTAssertEqualObjects(itemViewButton.accessibilityHint, newHint);
}

- (void)testIsAccessibilityElementInitialValue {
  // Given
  UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
  tabBarItem.isAccessibilityElement = NO;
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];
  // When
  bar.items = @[ tabBarItem ];

  // Then
  XCTAssert(!bar.itemViews.firstObject.isAccessibilityElement);
}

- (void)testIsAccessibilityElementValueChanged {
  // Given
  UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
  tabBarItem.isAccessibilityElement = NO;
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];
  bar.items = @[ tabBarItem ];

  // When
  tabBarItem.isAccessibilityElement = YES;

  // Then
  XCTAssert(bar.itemViews.firstObject.isAccessibilityElement);
}

- (void)testTitleVisibility {
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  self.bottomNavBar.items = @[ item1, item2 ];
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityNever;
  for (MDCBottomNavigationItemView *itemView in self.bottomNavBar.itemViews) {
    XCTAssert(itemView.label.isHidden);
  }
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  for (MDCBottomNavigationItemView *itemView in self.bottomNavBar.itemViews) {
    XCTAssert(!itemView.label.isHidden);
  }
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  self.bottomNavBar.itemViews.firstObject.selected = YES;
  self.bottomNavBar.itemViews.lastObject.selected = NO;
  XCTAssert(!self.bottomNavBar.itemViews.firstObject.label.isHidden);
  XCTAssert(self.bottomNavBar.itemViews.lastObject.label.isHidden);
}

- (void)testDefaultElevation {
  // Then
  XCTAssertEqualWithAccuracy(self.bottomNavBar.elevation, MDCShadowElevationBottomNavigationBar,
                             0.001);
}

- (void)testCustomElevation {
  // Given
  CGFloat customElevation = 20;

  // When
  self.bottomNavBar.elevation = customElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.bottomNavBar.elevation, customElevation, 0.001);
}

- (void)testDefaultShadowColor {
  // Then
  XCTAssertEqualObjects(self.bottomNavBar.shadowColor, UIColor.blackColor);
  XCTAssertTrue(
      CGColorEqualToColor(self.bottomNavBar.layer.shadowColor, UIColor.blackColor.CGColor),
      @"(%@) is not equal to (%@)", self.bottomNavBar.layer.shadowColor,
      UIColor.blackColor.CGColor);
}

- (void)testCustomShadowColor {
  // Given
  UIColor *fakeColor = UIColor.orangeColor;

  // When
  self.bottomNavBar.shadowColor = fakeColor;

  // Then
  XCTAssertEqualObjects(self.bottomNavBar.shadowColor, fakeColor);
  XCTAssertTrue(CGColorEqualToColor(self.bottomNavBar.layer.shadowColor, fakeColor.CGColor),
                @"(%@) is not equal to (%@)", self.bottomNavBar.layer.shadowColor,
                fakeColor.CGColor);
}

- (void)testViewForItemFound {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[ item1, item2 ];

  // Then
  MDCBottomNavigationItemView *viewForItem1 =
      (MDCBottomNavigationItemView *)[self.bottomNavBar viewForItem:item1];
  MDCBottomNavigationItemView *viewForItem2 =
      (MDCBottomNavigationItemView *)[self.bottomNavBar viewForItem:item2];
  XCTAssertNotEqual(viewForItem1, viewForItem2);
  XCTAssertTrue(
      [self.bottomNavBar.itemViews containsObject:viewForItem1],
      @"BottomNavBar.itemViews did not contain the view (%@) returned for UITabBarItem (%@)",
      viewForItem1, item1);
  XCTAssertTrue(
      [self.bottomNavBar.itemViews containsObject:viewForItem2],
      @"BottomNavBar.itemViews did not contain the view (%@) returned for UITabBarItem (%@)",
      viewForItem2, item2);
}

- (void)testViewForItemNotFound {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[ item1, item2 ];

  // Then
  XCTAssert([self.bottomNavBar viewForItem:item3] == nil);
}

- (void)testSizeThatFitsDefaultIncludesSafeArea {
  // Given
  CGRect barFrame = CGRectMake(0, 0, 360, 56);
  MDCSafeAreaCustomizingBottomNavigationBar *bottomNavBar =
      [[MDCSafeAreaCustomizingBottomNavigationBar alloc] initWithFrame:barFrame];
  bottomNavBar.test_safeAreaInsets = UIEdgeInsetsZero;
  CGSize initialSize = [bottomNavBar sizeThatFits:barFrame.size];

  // When
  bottomNavBar.test_safeAreaInsets = UIEdgeInsetsMake(20, 20, 20, 20);

  // Then
  CGSize finalSize = [bottomNavBar sizeThatFits:barFrame.size];
  XCTAssertFalse(CGSizeEqualToSize(finalSize, CGSizeZero),
                 "sizeThatFits: should not return CGSizeZero");
  XCTAssertTrue(CGSizeEqualToSize(finalSize, initialSize), @"(%@) is not equal to (%@)",
                NSStringFromCGSize(finalSize), NSStringFromCGSize(initialSize));
}

- (void)testSizeThatFitsExplicitlyIncludesSafeArea {
  // Given
  CGRect barFrame = CGRectMake(0, 0, 360, 56);
  MDCSafeAreaCustomizingBottomNavigationBar *bottomNavBar =
      [[MDCSafeAreaCustomizingBottomNavigationBar alloc] initWithFrame:barFrame];
  bottomNavBar.test_safeAreaInsets = UIEdgeInsetsZero;
  CGSize initialSize = [bottomNavBar sizeThatFits:barFrame.size];
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(20, 20, 20, 20);
  CGSize expectedSize = CGSizeMake(initialSize.width, initialSize.height + safeAreaInsets.bottom);

  // When
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  bottomNavBar.sizeThatFitsIncludesSafeArea = YES;
#pragma clang diagnostic pop
  bottomNavBar.test_safeAreaInsets = safeAreaInsets;

  // Then
  CGSize finalSize = [bottomNavBar sizeThatFits:barFrame.size];
  XCTAssertFalse(CGSizeEqualToSize(finalSize, CGSizeZero),
                 "sizeThatFits: should not return CGSizeZero");
  if (@available(iOS 11.0, *)) {
    XCTAssertTrue(CGSizeEqualToSize(finalSize, expectedSize), @"(%@) is not equal to (%@)",
                  NSStringFromCGSize(finalSize), NSStringFromCGSize(expectedSize));
  } else {
    XCTAssertTrue(CGSizeEqualToSize(finalSize, initialSize), @"(%@) is not equal to (%@)",
                  NSStringFromCGSize(finalSize), NSStringFromCGSize(initialSize));
  }
}

- (void)testSizeThatFitsExplicitlyExcludesSafeArea {
  // Given
  CGRect barFrame = CGRectMake(0, 0, 360, 56);
  MDCSafeAreaCustomizingBottomNavigationBar *bottomNavBar =
      [[MDCSafeAreaCustomizingBottomNavigationBar alloc] initWithFrame:barFrame];
  bottomNavBar.test_safeAreaInsets = UIEdgeInsetsZero;
  CGSize initialSize = [bottomNavBar sizeThatFits:barFrame.size];

  // When
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  bottomNavBar.sizeThatFitsIncludesSafeArea = NO;
#pragma clang diagnostic pop
  bottomNavBar.test_safeAreaInsets = UIEdgeInsetsMake(20, 20, 20, 20);

  // Then
  CGSize finalSize = [bottomNavBar sizeThatFits:barFrame.size];
  XCTAssertFalse(CGSizeEqualToSize(finalSize, CGSizeZero),
                 "sizeThatFits: should not return CGSizeZero");
  XCTAssertTrue(CGSizeEqualToSize(finalSize, initialSize), @"(%@) is not equal to (%@)",
                NSStringFromCGSize(finalSize), NSStringFromCGSize(initialSize));
}

#pragma mark - Autolayout support

- (void)testIntrinsicContentSizeIgnoresSafeArea {
  // Given
  CGRect barFrame = CGRectMake(0, 0, 360, 56);
  MDCSafeAreaCustomizingBottomNavigationBar *bottomNavBar =
      [[MDCSafeAreaCustomizingBottomNavigationBar alloc] initWithFrame:barFrame];
  bottomNavBar.test_safeAreaInsets = UIEdgeInsetsZero;
  CGSize initialSize = [bottomNavBar intrinsicContentSize];

  // When
  bottomNavBar.test_safeAreaInsets = UIEdgeInsetsMake(20, 20, 20, 20);

  // Then
  CGSize finalSize = [bottomNavBar intrinsicContentSize];
  XCTAssertFalse(CGSizeEqualToSize(finalSize, CGSizeZero),
                 "intrinsicContentSize should not return CGSizeZero");
  XCTAssertTrue(CGSizeEqualToSize(finalSize, initialSize), @"(%@) is not equal to (%@)",
                NSStringFromCGSize(finalSize), NSStringFromCGSize(initialSize));
}

#pragma mark - Property propagation

- (void)testTitlesNumberOfLinesPassedToViewsBeforeItemsAssigned {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  self.bottomNavBar.alignment = MDCBottomNavigationBarAlignmentJustified;

  // When
  self.bottomNavBar.titlesNumberOfLines = 7;
  self.bottomNavBar.items = @[ item1, item2 ];

  // Then
  for (MDCBottomNavigationItemView *itemView in self.bottomNavBar.itemViews) {
    XCTAssertEqual(itemView.titleNumberOfLines, self.bottomNavBar.titlesNumberOfLines);
  }
}

- (void)testTitlesNumberOfLinesPassedToViewsAfterItemsAssigned {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  self.bottomNavBar.alignment = MDCBottomNavigationBarAlignmentJustified;

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  self.bottomNavBar.titlesNumberOfLines = 7;

  // Then
  for (MDCBottomNavigationItemView *itemView in self.bottomNavBar.itemViews) {
    XCTAssertEqual(itemView.titleNumberOfLines, self.bottomNavBar.titlesNumberOfLines);
  }
}

- (void)testItemForPointInsideItemViewReturnsCorrespondingItem {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  self.bottomNavBar.frame = CGRectMake(0, 0, 320, 56);

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  [self.bottomNavBar layoutIfNeeded];
  UIView *view1 = [self.bottomNavBar viewForItem:item1];
  UIView *view2 = [self.bottomNavBar viewForItem:item2];
  UITabBarItem *result1 = [self.bottomNavBar tabBarItemForPoint:view1.center];
  UITabBarItem *result2 = [self.bottomNavBar tabBarItemForPoint:view2.center];

  // Then
  XCTAssertEqualObjects(result1, item1);
  XCTAssertEqualObjects(result2, item2);
}

- (void)testItemForPointOutsideNavigationBarReturnsNil {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  CGFloat navBarHeight = 56;
  self.bottomNavBar.frame = CGRectMake(0, 0, 320, navBarHeight);
  CGPoint testPoint = CGPointMake(0, navBarHeight + 10);

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  [self.bottomNavBar layoutIfNeeded];
  UITabBarItem *result = [self.bottomNavBar tabBarItemForPoint:testPoint];

  // Then
  XCTAssertNil(result);
}

- (void)testItemForPointInsideNavigationBarOutsideItemViewReturnsNil {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  CGFloat navBarHeight = 200;
  self.bottomNavBar.frame = CGRectMake(0, 0, 320, navBarHeight);
  CGPoint testPoint = CGPointMake(0, navBarHeight - 10);

  // When
  self.bottomNavBar.items = @[ item1, item2 ];
  [self.bottomNavBar layoutIfNeeded];
  UITabBarItem *result = [self.bottomNavBar tabBarItemForPoint:testPoint];

  // Then
  XCTAssertNil(result);
}

- (void)testItemForPointInsideNavigationBarNoTabBarItemsReturnsNil {
  // Given
  self.bottomNavBar.frame = CGRectMake(0, 0, 320, 56);

  // When
  [self.bottomNavBar layoutIfNeeded];
  UITabBarItem *result = [self.bottomNavBar tabBarItemForPoint:self.bottomNavBar.center];

  // Then
  XCTAssertNil(result);
}

- (NSInteger)countOfButtonsWithAccessibilityHint:(NSString *)accessibilityHint
                                    fromRootView:(UIView *)view {
  BOOL foundMatchingElement = NO;
  if (@available(iOS 10.0, *)) {
    foundMatchingElement = ([view isKindOfClass:[UIButton class]] &&
                            [view.accessibilityHint isEqualToString:accessibilityHint]);
  } else {
    // Accounts for the "fake" tab bar behavior that modifies the `accessibilityHint` on iOS 9.
    foundMatchingElement = ([view isKindOfClass:[UIButton class]] &&
                            [view.accessibilityHint containsString:accessibilityHint]);
  }
  NSInteger count = foundMatchingElement ? 1 : 0;
  for (UIView *subview in view.subviews) {
    count += [self countOfButtonsWithAccessibilityHint:accessibilityHint fromRootView:subview];
  }
  return count;
}

- (void)testSettingAccessibilityHintPropagatesToOneUIButtonSubview {
  // Given
  UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Title" image:nil tag:9];
  item.accessibilityHint = @"__h_i_n_t__";

  // When
  self.bottomNavBar.items = @[ item ];

  // Then
  XCTAssertEqual([self countOfButtonsWithAccessibilityHint:item.accessibilityHint
                                              fromRootView:self.bottomNavBar],
                 1);
}

#pragma mark - traitCollectionDidChangeBlock

- (void)testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChanges {
  // Given
  __block MDCBottomNavigationBar *passedBottomNavigationBar = nil;
  __block UITraitCollection *passedTraitCollection = nil;
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChangeBlock"];
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  void (^block)(MDCBottomNavigationBar *_Nonnull, UITraitCollection *_Nullable) = ^void(
      MDCBottomNavigationBar *bottomNavigationBar, UITraitCollection *previousTraitCollection) {
    passedBottomNavigationBar = bottomNavigationBar;
    passedTraitCollection = previousTraitCollection;
    [expectation fulfill];
  };
  self.bottomNavBar.traitCollectionDidChangeBlock = block;

  // When
  [self.bottomNavBar traitCollectionDidChange:testTraitCollection];
  [self waitForExpectations:@[ expectation ] timeout:1];

  // Then
  XCTAssertEqual(passedBottomNavigationBar, self.bottomNavBar);
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
}

#pragma mark - MaterialElevation

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Given
  MDCBottomNavigationBar *bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];

  // Then
  XCTAssertLessThan(bottomNavigationBar.mdc_overrideBaseElevation, 0);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat expectedBaseElevation = 99;

  // When
  self.bottomNavBar.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.bottomNavBar.mdc_overrideBaseElevation, expectedBaseElevation,
                             0.001);
}

- (void)testCurrentElevationMatchesElevationWhenElevationChanges {
  // When
  self.bottomNavBar.elevation = MDCShadowElevationQuickEntryResting;

  // Then
  XCTAssertEqualWithAccuracy(self.bottomNavBar.mdc_currentElevation, self.bottomNavBar.elevation,
                             0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  self.bottomNavBar.elevation = 5;
  __block BOOL blockCalled = NO;
  self.bottomNavBar.mdc_elevationDidChangeBlock =
      ^(MDCBottomNavigationBar *object, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  self.bottomNavBar.elevation = self.bottomNavBar.elevation + 1;

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  self.bottomNavBar.elevation = 5;
  __block BOOL blockCalled = NO;
  self.bottomNavBar.mdc_elevationDidChangeBlock =
      ^(MDCBottomNavigationBar *object, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  self.bottomNavBar.elevation = self.bottomNavBar.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

#pragma mark - UILargeContentViewerItem

#if MDC_AVAILABLE_SDK_IOS(13_0)
/** Tests the large content  title when the title should not contain a badge. */
- (void)testLargeContentTitle {
  if (@available(iOS 13.0, *)) {
    // Given.
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Title" image:nil tag:0];
    self.bottomNavBar.items = @[ item ];

    // When.
    NSString *largeContentTitle = self.bottomNavBar.itemViews.firstObject.largeContentTitle;

    // Then.
    XCTAssertEqualObjects(largeContentTitle, item.title);
  }
}

/**
 Tests the large content image is the @c image property when no @c largeContentImage is
 specified.
 */
- (void)testLargeContentImageWithDefaultImage {
  if (@available(iOS 13.0, *)) {
    // Given.
    UIImage *image = [[UIImage alloc] init];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:image tag:0];
    item.largeContentSizeImage = image;
    self.bottomNavBar.items = @[ item ];

    // When.
    UIImage *largeContentImage = self.bottomNavBar.itemViews.firstObject.largeContentImage;

    // Then.
    XCTAssertEqualObjects(largeContentImage, image);
  }
}

/** Tests the large content item's image is the @c largeContentSizeImage . */
- (void)testLargeContentImageWithTabBarLargeContentImage {
  if (@available(iOS 13.0, *)) {
    // Given.
    UIImage *image = [[UIImage alloc] init];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:0];
    item.largeContentSizeImage = image;
    self.bottomNavBar.items = @[ item ];

    // When.
    UIImage *largeContentImage = self.bottomNavBar.itemViews.firstObject.largeContentImage;

    // Then.
    XCTAssertEqualObjects(largeContentImage, image);
  }
}

/** Tests the large content image insets are set. */
- (void)testLargeContentImageInsets {
  if (@available(iOS 13.0, *)) {
    // Given.
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:0];
    item.largeContentSizeImageInsets = insets;
    self.bottomNavBar.items = @[ item ];

    // When.
    UIEdgeInsets largeImageInsets = self.bottomNavBar.itemViews.firstObject.largeContentImageInsets;

    // Then.
    XCTAssertEqual(largeImageInsets.bottom, insets.bottom);
    XCTAssertEqual(largeImageInsets.top, insets.top);
    XCTAssertEqual(largeImageInsets.left, insets.left);
    XCTAssertEqual(largeImageInsets.right, insets.right);
  }
}

/**
 Tests the large content item's image is updated when the tab bar's @c largeContentSizeImage is
 updated.
 */
- (void)testLargeContentImageUpdatedWhenTabBarPropertyUpdates {
  if (@available(iOS 13.0, *)) {
    // Given.
    UIImage *image = [[UIImage alloc] init];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:0];
    self.bottomNavBar.items = @[ item ];

    // When.
    item.largeContentSizeImage = image;
    UIImage *largeContentImage = self.bottomNavBar.itemViews.firstObject.largeContentImage;

    // Then.
    XCTAssertEqualObjects(largeContentImage, image);
  }
}

/**
 Tests the large content inets are update when the tab bar's @c largeContentSizeImageInsets are
 updated.
 */
- (void)testLargeContentInsetUpdatedWhenTabBarPropertyUpdates {
  if (@available(iOS 13.0, *)) {
    // Given.
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:0];
    self.bottomNavBar.items = @[ item ];

    // When.
    item.largeContentSizeImageInsets = insets;
    UIEdgeInsets largeContentInsets =
        self.bottomNavBar.itemViews.firstObject.largeContentImageInsets;

    // Then.
    XCTAssertEqual(largeContentInsets.left, insets.left);
    XCTAssertEqual(largeContentInsets.bottom, insets.bottom);
    XCTAssertEqual(largeContentInsets.right, insets.right);
    XCTAssertEqual(largeContentInsets.top, insets.top);
  }
}

/**
 Tests the last shown large content item is still returned when the interaction touch point is
 still within the bounds of the navigation bar.
 */
- (void)testLargeContentViewerInteractionWhenItemIsSelectedThenDeselectedButStillInNavBarBounds {
  if (@available(iOS 13.0, *)) {
    // Given.
    NSString *title1 = @"Title1";
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:title1 image:nil tag:0];
    self.bottomNavBar.items = @[ item1 ];
    self.bottomNavBar.frame = CGRectMake(0, 0, 350, 125);
    [self.bottomNavBar layoutIfNeeded];
    UILargeContentViewerInteraction *interaction = [[UILargeContentViewerInteraction alloc] init];
    self.continueAfterFailure = NO;

    // When/Then.
    XCTAssertTrue([self.bottomNavBar respondsToSelector:@selector(largeContentViewerInteraction:
                                                                                    itemAtPoint:)]);
    CGPoint itemViewOrigin = self.bottomNavBar.itemViews.firstObject.frame.origin;
    id<UILargeContentViewerItem> largeContentItem =
        [self.bottomNavBar largeContentViewerInteraction:interaction itemAtPoint:itemViewOrigin];
    XCTAssertEqualObjects(largeContentItem.largeContentTitle, title1);

    largeContentItem = [self.bottomNavBar largeContentViewerInteraction:interaction
                                                            itemAtPoint:CGPointZero];
    XCTAssertEqualObjects(largeContentItem.largeContentTitle, title1);
  }
}

/**
 Tests the large content item is nil when the touch point is outside the navigation bar bounds.
 */
- (void)testLargeContentViewerInteractionWhenPointIsOutSideNavBarBounds {
  if (@available(iOS 13.0, *)) {
    // Given.
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Title1" image:nil tag:0];
    self.bottomNavBar.items = @[ item ];
    self.bottomNavBar.frame = CGRectMake(0, 0, 350, 125);
    [self.bottomNavBar layoutIfNeeded];
    UILargeContentViewerInteraction *interaction = [[UILargeContentViewerInteraction alloc] init];
    self.continueAfterFailure = NO;

    // When/Then.
    XCTAssertTrue([self.bottomNavBar respondsToSelector:@selector(largeContentViewerInteraction:
                                                                                    itemAtPoint:)]);
    CGPoint pointOutsideNavBar = CGPointMake(-1, -1);

    id<UILargeContentViewerItem> largeContentItem =
        [self.bottomNavBar largeContentViewerInteraction:interaction
                                             itemAtPoint:pointOutsideNavBar];
    XCTAssertNil(largeContentItem);
  }
}

/** Tests the last shown large item is reset after an interaction ends. */
- (void)testLargeContentViewerInteractionResetsAfterEnding {
  if (@available(iOS 13.0, *)) {
    // Given.
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Title1" image:nil tag:0];
    self.bottomNavBar.items = @[ item ];
    self.bottomNavBar.frame = CGRectMake(0, 0, 350, 125);
    [self.bottomNavBar layoutIfNeeded];
    UILargeContentViewerInteraction *interaction = [[UILargeContentViewerInteraction alloc] init];
    self.continueAfterFailure = NO;

    // When/Then.
    XCTAssertTrue([self.bottomNavBar respondsToSelector:@selector(largeContentViewerInteraction:
                                                                                    itemAtPoint:)]);

    CGPoint pointInsideFirstItem = self.bottomNavBar.itemViews.firstObject.frame.origin;
    id<UILargeContentViewerItem> endItem =
        [self.bottomNavBar largeContentViewerInteraction:interaction
                                             itemAtPoint:pointInsideFirstItem];

    XCTAssertTrue([self.bottomNavBar
        respondsToSelector:@selector(largeContentViewerInteraction:didEndOnItem:atPoint:)]);
    [self.bottomNavBar largeContentViewerInteraction:interaction
                                        didEndOnItem:endItem
                                             atPoint:CGPointZero];

    id<UILargeContentViewerItem> itemAfterReset =
        [self.bottomNavBar largeContentViewerInteraction:interaction itemAtPoint:CGPointZero];
    XCTAssertNil(itemAfterReset);
  }
}
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

@end
