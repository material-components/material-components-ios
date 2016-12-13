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

- (void)
    testSettingTextAlignmentToCenterWithTrailingBarButtonItemsMustNotCoverTheTrailingBarButtonItems {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  navBar.frame = CGRectMake(0, 0, 300, 25);
  navBar.title = @"a Title";
  UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"long button name"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:nil];

  navBar.trailingBarButtonItems = @[ button ];

  // When
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;
  [navBar layoutIfNeeded];

  // Then
  XCTAssertLessThan(navBar.titleLabel.center.x, CGRectGetMidX(navBar.bounds));
}

- (void)
    testSettingTextAlignmentToCenterWithLeadingBarButtonItemsMustNotCoverTheLeadingBarButtonItems {
  // Given
  MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
  navBar.frame = CGRectMake(0, 0, 300, 25);
  navBar.title = @"a Title";
  UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"long button name"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:nil];

  navBar.leadingBarButtonItems = @[ button ];

  // When
  navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;
  [navBar layoutIfNeeded];

  // Then
  XCTAssertGreaterThan(navBar.titleLabel.center.x, CGRectGetMidX(navBar.bounds));
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
  XCTAssertEqual(alignment, MDCNavigationBarTitleAlignmentLeading);
}

@end
