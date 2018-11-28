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

#import "MDCItemBar.h"
#import "MDCTabBar.h"

@interface MDCTabBarLayoutTests : XCTestCase

@end

@implementation MDCTabBarLayoutTests

- (void)testRTL {
  // Create a tabbar with some dummy items and a dummy frame.
  MDCTabBar *tabBar = [[MDCTabBar alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"first" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"second" image:nil tag:0];
  tabBar.items = @[item1, item2];
  [tabBar setNeedsLayout];
  [tabBar layoutIfNeeded];

  // Extract the collection view cells and layout corresponding to the two tab bar items.
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
  UICollectionViewFlowLayout *flowLayout =
      (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
  NSArray<UICollectionViewCell *> *visibleCells = collectionView.visibleCells;
  XCTAssertEqual(visibleCells.count, 2ul);
  // NOTE: The cells are in reverse order, so the first tab bar item is at the lastObject index.
  UICollectionViewCell *firstItemCell = visibleCells.lastObject;
  UICollectionViewCell *secondItemCell = visibleCells.firstObject;

  // Assert the initial state.
  UISemanticContentAttribute oldAttribute = tabBar.mdf_semanticContentAttribute;
  XCTAssertEqual(oldAttribute, UISemanticContentAttributeUnspecified);
  CGFloat leftInset = flowLayout.sectionInset.left;
  XCTAssertEqualWithAccuracy(firstItemCell.frame.origin.x, leftInset, FLT_EPSILON);
  XCTAssertEqualWithAccuracy(secondItemCell.frame.origin.x,
                             leftInset + firstItemCell.frame.size.width,
                             FLT_EPSILON);

  // Adjust the attribute and force a re-layout.
  tabBar.mdf_semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  [tabBar setNeedsLayout];
  [tabBar layoutIfNeeded];

  // Grab the new cells after the re-layout.
  visibleCells = collectionView.visibleCells;
  XCTAssertEqual(visibleCells.count, 2ul);
  // NOTE: The cells are in reverse order, so the first tab bar item is at the lastObject index.
  firstItemCell = visibleCells.lastObject;
  secondItemCell = visibleCells.firstObject;

  // Verify the attribute and frames were changed correctly.
  XCTAssertEqual(tabBar.mdf_semanticContentAttribute, UISemanticContentAttributeForceRightToLeft);
  CGFloat totalWidth = tabBar.frame.size.width;
  CGFloat expectedFirstItemOriginX = totalWidth - leftInset - firstItemCell.frame.size.width;
  XCTAssertEqualWithAccuracy(firstItemCell.frame.origin.x, expectedFirstItemOriginX, FLT_EPSILON);
  CGFloat expectedSecondItemOriginX = expectedFirstItemOriginX - secondItemCell.frame.size.width;
  XCTAssertEqualWithAccuracy(secondItemCell.frame.origin.x, expectedSecondItemOriginX, FLT_EPSILON);

  // Reset the semantic content attribute.
  tabBar.mdf_semanticContentAttribute = oldAttribute;
}

@end

