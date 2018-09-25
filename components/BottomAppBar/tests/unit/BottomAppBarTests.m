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

#import "MaterialBottomAppBar.h"

#import <XCTest/XCTest.h>

#import "MaterialNavigationBar.h"

@interface MDCBottomAppBarView (Testing)
@property(nonatomic, strong) MDCNavigationBar *navBar;
@end

@interface BottomAppBarTests : XCTestCase
@property(nonatomic, strong) MDCBottomAppBarView *bottomAppBar;
@end

@implementation BottomAppBarTests

- (void)setUp {
  [super setUp];
  self.bottomAppBar = [[MDCBottomAppBarView alloc] init];
}

#pragma mark - Color

- (void)testLeadingBarItemTintColorDefault {
  // Then
  XCTAssertEqualObjects(self.bottomAppBar.leadingBarItemsTintColor, UIColor.blackColor);
}

- (void)testLeadingBarItemTintColorAppliesToNavigationBar {
  // When
  self.bottomAppBar.leadingBarItemsTintColor = UIColor.cyanColor;

  // Then
  XCTAssertEqualObjects(self.bottomAppBar.navBar.leadingBarItemsTintColor, UIColor.cyanColor);
}

- (void)testTrailingBarItemTintColorDefault {
  // Then
  XCTAssertEqualObjects(self.bottomAppBar.trailingBarItemsTintColor, UIColor.blackColor);
}

- (void)testTrailingBarItemTintColorAppliesToNavigationBar {
  // When
  self.bottomAppBar.trailingBarItemsTintColor = UIColor.purpleColor;

  // Then
  XCTAssertEqualObjects(self.bottomAppBar.navBar.trailingBarItemsTintColor, UIColor.purpleColor);
}

#pragma mark - Floating Button

- (void)testCustomizedFloatingButtonVerticalHeight {
  CGFloat veriticalOffset = 5.0f;
  self.bottomAppBar.floatingButtonVerticalOffset = veriticalOffset;
  [self.bottomAppBar layoutSubviews];
  CGPoint floatingButtonPosition = self.bottomAppBar.floatingButton.center;
  CGPoint navigationBarPosition = self.bottomAppBar.navBar.frame.origin;
  XCTAssertEqualWithAccuracy(floatingButtonPosition.y + veriticalOffset, navigationBarPosition.y,
                             0.001f);
}

@end
