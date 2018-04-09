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

#import "MaterialButtonBar.h"
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

- (void)testTitleFontProperty {
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  navBar.frame = CGRectMake(0, 0, 300, 25);
  navBar.title = @"this is a Title";
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;
  [navBar layoutIfNeeded];

  XCTAssertNotNil(navBar.titleFont);
  XCTAssertEqual(navBar.titleLabel.font, navBar.titleFont);

  UIFont *testFont = [UIFont boldSystemFontOfSize:24];
  UIFont *resultFont = [UIFont boldSystemFontOfSize:20];
  navBar.titleFont = testFont;
  XCTAssertEqual(navBar.titleLabel.font, resultFont);
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


#pragma mark - Accessibility

- (void)testNavigationBarIsNotAccessibilityElement {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];

  // Then
  XCTAssertFalse(navBar.isAccessibilityElement);
}

- (void)testAccessibilityItemsCountWithNoTitle {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];

  // Then
  const NSInteger elementsCount = 3; // Leading bar, titleLabel, trailing bar
  XCTAssertEqual(elementsCount, navBar.accessibilityElementCount);
}

- (void)testAccessibilityItemsCountWithTitleView {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];

  // When
  navBar.titleView = [[UIView alloc] init];

  // Then
  const NSInteger elementsCount = 3; // Leading bar, titleView, trailing bar
  XCTAssertEqual(elementsCount, navBar.accessibilityElementCount);
}

- (void)testAccessibilityItemAtIndexDefault {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];

  // Then
  XCTAssertTrue([[navBar accessibilityElementAtIndex:0] isKindOfClass:[MDCButtonBar class]]);
  XCTAssertEqual(navBar.titleLabel, [navBar accessibilityElementAtIndex:1]);
  XCTAssertTrue([[navBar accessibilityElementAtIndex:2] isKindOfClass:[MDCButtonBar class]]);
}

- (void)testIndexOfAccessibilityElementDefault {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];

  // Then
  XCTAssertEqual(1, [navBar indexOfAccessibilityElement:navBar.titleLabel]);
  XCTAssertEqual(NSNotFound, [navBar indexOfAccessibilityElement:navBar.leftBarButtonItem]);
}

- (void)testIndexOfAccessibilityElementWithTitleView {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];

  // When
  navBar.titleView = [[UIView alloc] init];

  // Then
  XCTAssertEqual(1, [navBar indexOfAccessibilityElement:navBar.titleView]);
  XCTAssertEqual(NSNotFound, [navBar indexOfAccessibilityElement:navBar.titleLabel]);
}

- (void)testAccessibilityElementsWithNoTitle {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  UIBarButtonItem *leadingItem = [[UIBarButtonItem alloc] init];
  leadingItem.title = @"Leading";
  UIBarButtonItem *trailingItem = [[UIBarButtonItem alloc] init];
  trailingItem.title = @"Trailing";

  // When
  navBar.leadingBarButtonItem = leadingItem;
  navBar.trailingBarButtonItems = @[leadingItem, trailingItem];

  // Then
  NSArray *elements = navBar.accessibilityElements;
  XCTAssertNotNil(elements);
  XCTAssertEqual(3U, elements.count);
  id firstItem = elements[0];
  XCTAssertTrue([firstItem isKindOfClass:[MDCButtonBar class]]);
  if ([firstItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *leadingButtonBar = (MDCButtonBar *)firstItem;
    XCTAssertEqual(1U, leadingButtonBar.subviews.count);
  }
  XCTAssertEqualObjects(navBar.titleLabel, elements[1]);
  id secondItem = elements[2];
  XCTAssertTrue([secondItem isKindOfClass:[MDCButtonBar class]]);
  if ([secondItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *trailingButtonBar = (MDCButtonBar *)secondItem;
    XCTAssertEqual(2U, trailingButtonBar.subviews.count);
  }
}

- (void)testAccessibilityElementsWithTitleView {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  UIBarButtonItem *leadingItem = [[UIBarButtonItem alloc] init];
  leadingItem.title = @"Leading";
  UIBarButtonItem *trailingItem = [[UIBarButtonItem alloc] init];
  trailingItem.title = @"Trailing";

  // When
  navBar.titleView = [[UIView alloc] init];
  navBar.leadingBarButtonItem = leadingItem;
  navBar.trailingBarButtonItems = @[leadingItem, trailingItem];

  // Then
  NSArray *elements = navBar.accessibilityElements;
  XCTAssertNotNil(elements);
  XCTAssertEqual(3U, elements.count);
  id firstItem = elements[0];
  XCTAssertTrue([firstItem isKindOfClass:[MDCButtonBar class]]);
  if ([firstItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *leadingButtonBar = (MDCButtonBar *)firstItem;
    XCTAssertEqual(1U, leadingButtonBar.subviews.count);
  }
  XCTAssertEqualObjects(navBar.titleView, elements[1]);
  id secondItem = elements[2];
  XCTAssertTrue([secondItem isKindOfClass:[MDCButtonBar class]]);
  if ([secondItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *trailingButtonBar = (MDCButtonBar *)secondItem;
    XCTAssertEqual(2U, trailingButtonBar.subviews.count);
  }
}

@end
