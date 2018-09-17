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

#import "MDCItemBar.h"

#import <XCTest/XCTest.h>

// Exposing methods for testing
@interface MDCItemBar (Testing)
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

// Mock Delegate which returns NO for `shouldSelectItem:item`
@interface MDCTabBarDelegateShouldSelectNO : NSObject <MDCItemBarDelegate>
@end

@implementation MDCTabBarDelegateShouldSelectNO

- (BOOL)itemBar:(nonnull MDCItemBar *)itemBar shouldSelectItem:(nonnull UITabBarItem *)item {
  return NO;
}

- (void)itemBar:(nonnull MDCItemBar *)itemBar didSelectItem:(nonnull UITabBarItem *)item {
}

@end

// Mock Delegate which returns YES for `shouldSelectItem:item`
@interface MDCTabBarDelegateShouldSelectYES : NSObject <MDCItemBarDelegate>
@end

@implementation MDCTabBarDelegateShouldSelectYES

- (BOOL)itemBar:(nonnull MDCItemBar *)itemBar shouldSelectItem:(nonnull UITabBarItem *)item {
  return YES;
}

- (void)itemBar:(nonnull MDCItemBar *)itemBar didSelectItem:(nonnull UITabBarItem *)item {
}

@end

@interface MDCItemBarTests : XCTestCase

@end

@implementation MDCItemBarTests

- (void)testItemBarCellWhenSelectDelegateNO {
  // Given
  id<MDCItemBarDelegate> delegate = [[MDCTabBarDelegateShouldSelectNO alloc] init];
  MDCItemBar *itemBar = [[MDCItemBar alloc] init];
  itemBar.delegate = delegate;

  UICollectionView *collectionView = [itemBar valueForKey:@"_collectionView"];

  UITabBarItem *_itemA = [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0];

  itemBar.items = @[ _itemA ];

  // When
  UICollectionViewCell *cell = [itemBar collectionView:collectionView
                                cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                           inSection:0]];

  // Then
  XCTAssertNotNil(cell);
  XCTAssertFalse(cell.userInteractionEnabled);
}

- (void)testItemBarCellWhenSelectDelegateYES {
  // Given
  id<MDCItemBarDelegate> delegate = [[MDCTabBarDelegateShouldSelectYES alloc] init];
  MDCItemBar *itemBar = [[MDCItemBar alloc] init];
  itemBar.delegate = delegate;

  UICollectionView *collectionView = [itemBar valueForKey:@"_collectionView"];

  UITabBarItem *_itemA = [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0];

  itemBar.items = @[ _itemA ];

  // When
  UICollectionViewCell *cell = [itemBar collectionView:collectionView
                                cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                           inSection:0]];

  // Then
  XCTAssertNotNil(cell);
  XCTAssertTrue(cell.userInteractionEnabled);
}

@end
