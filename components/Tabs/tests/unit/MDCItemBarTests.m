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

#import "MDCItemBar.h"

@interface MDCItemBar (Testing)
- (UITabBarItem *)itemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MDCItemBarTests : XCTestCase
@end

@implementation MDCItemBarTests

- (void)testItemAtIndexPath {
  // Given
  MDCItemBar *itemBar = [[MDCItemBar alloc] init];

  // When
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"first tab" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"second tab" image:nil tag:0];
  itemBar.items = @[ item1, item2 ];
  NSIndexPath *indexPathForFirstItem = [NSIndexPath indexPathForItem:0 inSection:0];
  NSIndexPath *indexPathForSecondItem = [NSIndexPath indexPathForItem:1 inSection:0];
  NSIndexPath *indexPathForThirdItem = [NSIndexPath indexPathForItem:2 inSection:0];

  // Then
  NSAssert([itemBar itemAtIndexPath:indexPathForFirstItem] != nil,
           @"There should be an item for the NSIndexPath with item equal to 0");
  NSAssert([itemBar itemAtIndexPath:indexPathForSecondItem] != nil,
           @"There should be an item for the NSIndexPath with item equal to 1");
  NSAssert([itemBar itemAtIndexPath:indexPathForThirdItem] == nil,
           @"There should NOT be an item for the NSIndexPath with item equal to 2");
}

@end
