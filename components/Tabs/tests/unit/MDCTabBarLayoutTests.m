// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <MDFInternationalization/MDFInternationalization.h>
#import <XCTest/XCTest.h>

#import "../../src/private/MDCItemBar.h"
#import "MDCTabBar.h"

// Returns the underlying collection view from a given tabBar. If one cannot be extracted, returns
// nil.
static UICollectionView *ExtractCollectionViewFromTabBar(MDCTabBar *tabBar) {
  MDCItemBar *itemBar = nil;
  for (UIView *subview in tabBar.subviews) {
    if ([subview isKindOfClass:[MDCItemBar class]]) {
      itemBar = (MDCItemBar *)subview;
    }
  }
  UICollectionView *collectionView = nil;
  for (UIView *subview in itemBar.subviews) {
    if ([subview isKindOfClass:[UICollectionView class]]) {
      collectionView = (UICollectionView *)subview;
    }
  }
  return collectionView;
}

// Returns the visible items of the given collectionView in sorted order.
static NSArray<UICollectionViewCell *> *SortedCellsFromCollectionView(
    UICollectionView *collectionView) {
  NSArray<NSIndexPath *> *indexPathsForVisibleItems = collectionView.indexPathsForVisibleItems;
  NSArray<NSIndexPath *> *sortedIndexPaths =
      [indexPathsForVisibleItems sortedArrayUsingSelector:@selector(compare:)];
  NSMutableArray *sortedCells = [NSMutableArray array];
  for (NSIndexPath *indexPath in sortedIndexPaths) {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
      [sortedCells addObject:cell];
    }
  }
  return sortedCells;
}

@interface MDCTabBarLayoutTests : XCTestCase

@end

@implementation MDCTabBarLayoutTests {
  MDCTabBar *_tabBar;
}

- (void)setUp {
  [super setUp];

  // Create a tabbar with some dummy items and a dummy frame.
  _tabBar = [[MDCTabBar alloc] initWithFrame:CGRectZero];
  CGFloat tabBarHeight = [MDCTabBar defaultHeightForItemAppearance:_tabBar.itemAppearance];
  _tabBar.frame = CGRectMake(0, 0, 200, tabBarHeight);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"first" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"second" image:nil tag:0];
  _tabBar.items = @[ item1, item2 ];
  [_tabBar setNeedsLayout];
  [_tabBar layoutIfNeeded];
}

- (void)tearDown {
  // Explictly nil out ivars so that they are properly deallocated between tests. Otherwise XCTest
  // will keep them alive until all test cases are complete.
  _tabBar = nil;
  [super tearDown];
}

// Tests the default layout behavior of of the tab bar's collection view.
- (void)testLeftToRightLayout {
  // Given
  UICollectionView *collectionView = ExtractCollectionViewFromTabBar(_tabBar);
  NSArray<UICollectionViewCell *> *sortedVisibleItems =
      SortedCellsFromCollectionView(collectionView);
  XCTAssertEqual(sortedVisibleItems.count, 2ul);
  if (sortedVisibleItems.count != 2ul) {
    // Return early if something went catastrophically wrong with UICollectionView.
    return;
  }
  UICollectionViewCell *firstItemCell = sortedVisibleItems.firstObject;
  UICollectionViewCell *secondItemCell = sortedVisibleItems.lastObject;
  UICollectionViewFlowLayout *flowLayout =
      (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;

  // When
  _tabBar.mdf_semanticContentAttribute = UISemanticContentAttributeUnspecified;

  // Then
  CGFloat leftInset = flowLayout.sectionInset.left;
  XCTAssertEqualWithAccuracy(CGRectGetMinX(firstItemCell.frame), leftInset, (CGFloat)0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(secondItemCell.frame),
                             leftInset + CGRectGetWidth(firstItemCell.frame), (CGFloat)0.001);
}

// Tests that setting UISemanticContentAttributeForceRightToLeft causes the tab bar's collection
// view to lay out the cells in RTL (right-to-left) manner.
- (void)testRightToLeftLayout {
  // Given
  UICollectionView *collectionView = ExtractCollectionViewFromTabBar(_tabBar);
  UICollectionViewFlowLayout *flowLayout =
      (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;

  // When
  _tabBar.mdf_semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  [_tabBar setNeedsLayout];
  [_tabBar layoutIfNeeded];

  // Then
  XCTAssertEqual(_tabBar.mdf_semanticContentAttribute, UISemanticContentAttributeForceRightToLeft);
  XCTAssertEqual(_tabBar.effectiveUserInterfaceLayoutDirection,
                 UIUserInterfaceLayoutDirectionRightToLeft);
  NSArray<UICollectionViewCell *> *sortedVisibleItems =
      SortedCellsFromCollectionView(collectionView);
  XCTAssertEqual(sortedVisibleItems.count, 2ul);
  if (sortedVisibleItems.count != 2ul) {
    // Return early if something went catastrophically wrong with UICollectionView.
    return;
  }
  UICollectionViewCell *firstItemCell = sortedVisibleItems.firstObject;
  UICollectionViewCell *secondItemCell = sortedVisibleItems.lastObject;
  CGFloat totalWidth = CGRectGetWidth(_tabBar.frame);
  CGFloat leftInset = flowLayout.sectionInset.left;
  CGFloat expectedFirstItemOriginX = totalWidth - leftInset - CGRectGetWidth(firstItemCell.frame);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(firstItemCell.frame), expectedFirstItemOriginX,
                             (CGFloat)0.001);
  CGFloat expectedSecondItemOriginX =
      expectedFirstItemOriginX - CGRectGetWidth(secondItemCell.frame);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(secondItemCell.frame), expectedSecondItemOriginX,
                             (CGFloat)0.001);
}

@end
