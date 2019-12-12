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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "../../src/private/MDCItemBar.h"
#import "../../src/private/MDCItemBarStyle.h"

@interface MDCItemBar (Testing)
- (UITabBarItem *)itemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MDCItemBarTests : XCTestCase

/** The item bar being tested. */
@property(nonatomic, strong) MDCItemBar *itemBar;

@end

@implementation MDCItemBarTests

- (void)setUp {
  [super setUp];

  MDCItemBarStyle *style = [[MDCItemBarStyle alloc] init];
  style.unselectedTitleFont = [UIFont systemFontOfSize:12];
  style.selectedTitleFont = [UIFont systemFontOfSize:12];
  MDCItemBar *itemBar = [[MDCItemBar alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  [itemBar applyStyle:style];
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Item 1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Item 2" image:nil tag:1];
  itemBar.items = @[ item1, item2 ];
  itemBar.selectedItem = item1;
  [itemBar layoutIfNeeded];
  self.itemBar = itemBar;
}

- (void)tearDown {
  self.itemBar = nil;

  [super tearDown];
}

- (void)testItemAtIndexPath {
  // Given
  MDCItemBar *itemBar = [[MDCItemBar alloc] init];
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"first tab" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"second tab" image:nil tag:0];

  // When
  itemBar.items = @[ item1, item2 ];

  // Then
  NSIndexPath *indexPathForFirstItem = [NSIndexPath indexPathForItem:0 inSection:0];
  XCTAssertNotNil([itemBar itemAtIndexPath:indexPathForFirstItem]);
  NSIndexPath *indexPathForSecondItem = [NSIndexPath indexPathForItem:1 inSection:0];
  XCTAssertNotNil([itemBar itemAtIndexPath:indexPathForSecondItem]);
  NSIndexPath *indexPathForThirdItem = [NSIndexPath indexPathForItem:2 inSection:0];
  XCTAssertNil([itemBar itemAtIndexPath:indexPathForThirdItem]);
  NSIndexPath *indexPathWithNonZeroSection = [NSIndexPath indexPathForItem:0 inSection:1];
  XCTAssertNil([itemBar itemAtIndexPath:indexPathWithNonZeroSection]);
  NSIndexPath *indexPathWithItemEqualToNegativeOne = [NSIndexPath indexPathForItem:-1 inSection:0];
  XCTAssertNil([itemBar itemAtIndexPath:indexPathWithItemEqualToNegativeOne]);
}

- (void)testItemBarIsNotAccessibilityElement {
  // Given
  MDCItemBar *itemBar = [[MDCItemBar alloc] init];

  // Then
  XCTAssertFalse(itemBar.isAccessibilityElement);
}

- (void)testItemBarIsAccessibilityTabBarOniOS10Plus {
  if (@available(iOS 10.0, *)) {
    // When
    self.itemBar.accessibilityTraits = UIAccessibilityTraitLink;

    // Then
    XCTAssertEqual(self.itemBar.accessibilityTraits,
                   UIAccessibilityTraitTabBar | UIAccessibilityTraitLink);
  }
}

- (void)testItemBarViewIncludesTabInAccessibilityLabelOniOS9 {
  NSOperatingSystemVersion iOS10Version = {10, 0, 0};
  if (![NSProcessInfo.processInfo isOperatingSystemAtLeastVersion:iOS10Version]) {
    // When
    for (UITabBarItem *item in self.itemBar.items) {
      UIView *view = [self.itemBar accessibilityElementForItem:item];
      XCTAssertTrue([view isKindOfClass:[UIView class]]);
      if ([view isKindOfClass:[UIView class]]) {
        NSString *accessibilityLabel = ((UIView *)view).accessibilityLabel;
        XCTAssertTrue([accessibilityLabel localizedCaseInsensitiveContainsString:@"tab"],
                      @"Item bar items should include the faked 'tab' information on iOS 9.");
      }
    }
  }
}

- (void)testItemBarViewDoesNotIncludesTabInAccessibilityLabelOniOS10Plus {
  if (@available(iOS 10.0, *)) {
    // When
    for (UITabBarItem *item in self.itemBar.items) {
      UIView *view = [self.itemBar accessibilityElementForItem:item];
      XCTAssertTrue([view isKindOfClass:[UIView class]]);
      if ([view isKindOfClass:[UIView class]]) {
        NSString *accessibilityLabel = ((UIView *)view).accessibilityLabel;
        XCTAssertFalse([accessibilityLabel localizedCaseInsensitiveContainsString:@"tab"],
                       @"Item bar items should not include the faked 'tab' information on iOS 9.");
      }
    }
  }
}

@end
