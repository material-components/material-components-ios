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

#import "MaterialBottomNavigation+Theming.h"
#import "../../src/private/MDCBottomNavigationItemView.h"

@interface BottomNavigationThemingTests : XCTestCase
@property(nonatomic, strong, nullable) MDCBottomNavigationBar *bottomNavigationBar;
@property(nonatomic, strong, nullable) id<MDCContainerScheming> containerScheme;
@end

@interface MDCBottomNavigationBar (Testing)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@end

@implementation BottomNavigationThemingTests

- (void)setUp {
  [super setUp];

  self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  UITabBarItem *item = [[UITabBarItem alloc] init];
  self.bottomNavigationBar.items = @[item];

  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.bottomNavigationBar = nil;

  self.containerScheme = nil;

  [super tearDown];
}

- (void)testBottomNavigationTheming {
  // Given
  id <MDCColorScheming> colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  id <MDCTypographyScheming> typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // When
  [self.bottomNavigationBar applyThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.bottomNavigationBar.barTintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(self.bottomNavigationBar.selectedItemTintColor, colorScheme.onPrimaryColor);

  MDCBottomNavigationItemView *firstItemView = [self.bottomNavigationBar.itemViews firstObject];
  XCTAssertEqualObjects(firstItemView.selectedItemTitleColor, colorScheme.onPrimaryColor);
  XCTAssertEqual(self.bottomNavigationBar.itemTitleFont, typographyScheme.caption);
}

@end
