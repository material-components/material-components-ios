/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>
#import "MaterialNavigationBar.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

@interface MDCNavigationBar (Testing)
@property(nonatomic) UILabel *titleLabel;
@end

@interface NavigationBarTests : XCTestCase
@end

@implementation NavigationBarTests

- (void)testSettingTextAlignmentToCenterMustCenterTheTitleLabel {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  navBar.frame = CGRectMake(0, 0, 300, 25);
  navBar.title = @"this is a Title";

  // When
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;
  [navBar layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(navBar.titleLabel.center.x, CGRectGetMidX(navBar.bounds),
                             kEpsilonAccuracy);
}

- (void)testChangingTextOfACenterTextAlignmentMustCenterTheTitleLabel {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  navBar.frame = CGRectMake(0, 0, 300, 25);
  navBar.title = @"this is a Title";
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;

  // When
  navBar.title = @"..";
  [navBar layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(navBar.titleLabel.center.x, CGRectGetMidX(navBar.bounds),
                             kEpsilonAccuracy);
}

- (void)testSettingTextAlignmentToLeftMustLeftAlignTheTitleLabel {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  navBar.frame = CGRectMake(0, 0, 200, 25);
  navBar.title = @"this is a Title";
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;
  [navBar layoutIfNeeded];

  // When
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentLeading;
  [navBar layoutIfNeeded];

  // Then
  XCTAssertLessThan(navBar.titleLabel.center.x, CGRectGetMidX(navBar.bounds));
}

- (void)testDefaultTextAlignment {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];

  // When
  MDCNavigationBarTitleAlignment alignment = navBar.titleAlignment;

  // Then
  XCTAssertEqual(alignment, MDCNavigationBarTitleAlignmentCenter);
}

- (void)testEncoding {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  navBar.title = @"A title";
  navBar.titleView = [[UIView alloc] init];
  navBar.titleView.contentMode = UIViewContentModeTop;
  navBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
  backItem.title = @"Go back!";
  navBar.backItem = backItem;
  navBar.hidesBackButton = YES;
  UIBarButtonItem *item1 = [[UIBarButtonItem alloc] init];
  item1.title = @"Item 1";
  UIBarButtonItem *item2 = [[UIBarButtonItem alloc] init];
  item2.title = @"Item 2";
  navBar.leadingBarButtonItems = @[item1, item2];
  navBar.trailingBarButtonItems = @[item2, item1];
  navBar.leadingItemsSupplementBackButton = YES;
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:navBar];
  MDCNavigationBar *unarchivedBar =
      (MDCNavigationBar *)[NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertEqualObjects(navBar.title, unarchivedBar.title);
  XCTAssertNotNil(unarchivedBar.titleView);
  XCTAssertEqual(navBar.titleView.contentMode, unarchivedBar.titleView.contentMode);
  XCTAssertEqualObjects(navBar.titleTextAttributes, unarchivedBar.titleTextAttributes);
  XCTAssertNotNil(unarchivedBar.backItem);
  XCTAssertEqualObjects(navBar.backItem.title, unarchivedBar.backItem.title);
  XCTAssertEqual(navBar.hidesBackButton, unarchivedBar.hidesBackButton);
  XCTAssertEqual(2U, unarchivedBar.leadingBarButtonItems.count);
  XCTAssertEqual(navBar.leadingBarButtonItems.count, unarchivedBar.leadingBarButtonItems.count);
  for (NSUInteger i = 0; i < navBar.leadingBarButtonItems.count; ++i) {
    XCTAssertEqualObjects(navBar.leadingBarButtonItems[i].title,
                          unarchivedBar.leadingBarButtonItems[i].title);
  }
  XCTAssertEqual(2U, unarchivedBar.trailingBarButtonItems.count);
  XCTAssertEqual(navBar.trailingBarButtonItems.count, unarchivedBar.trailingBarButtonItems.count);
  for (NSUInteger i = 0; i < navBar.trailingBarButtonItems.count; ++i) {
    XCTAssertEqualObjects(navBar.trailingBarButtonItems[i].title,
                          unarchivedBar.trailingBarButtonItems[i].title);
  }
  XCTAssertEqual(navBar.leadingItemsSupplementBackButton,
                unarchivedBar.leadingItemsSupplementBackButton);
  XCTAssertEqual(navBar.titleAlignment, unarchivedBar.titleAlignment);
}

@end
