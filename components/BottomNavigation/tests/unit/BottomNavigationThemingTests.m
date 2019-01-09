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

#import "../../src/private/MDCBottomNavigationItemView.h"
#import "MaterialBottomNavigation+Theming.h"

static const CGFloat kUnselectedOpacity = (CGFloat)0.6;
@interface BottomNavigationThemingTests : XCTestCase
@property(nonatomic, strong, nullable) MDCBottomNavigationBar *bottomNavigationBar;
@property(nonatomic, strong, nullable) id<MDCContainerScheming> containerScheme;
@end

@interface MDCBottomNavigationBar (Testing)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme;
- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme;
@end

@interface MDCBottomNavigationItemView (Testing)
@property(nonatomic, strong) UILabel *label;
@end

@implementation BottomNavigationThemingTests

- (void)setUp {
  [super setUp];

  self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  UITabBarItem *item = [[UITabBarItem alloc] init];
  self.bottomNavigationBar.items = @[ item ];

  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.bottomNavigationBar = nil;

  self.containerScheme = nil;

  [super tearDown];
}

- (void)testBottomNavigationTheming {
  // Given
  id<MDCColorScheming> colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  id<MDCTypographyScheming> typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // When
  [self.bottomNavigationBar applyThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.bottomNavigationBar.barTintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(self.bottomNavigationBar.selectedItemTintColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(self.bottomNavigationBar.unselectedItemTintColor,
                        [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedOpacity]);

  MDCBottomNavigationItemView *firstItemView = [self.bottomNavigationBar.itemViews firstObject];
  XCTAssertEqualObjects(firstItemView.selectedItemTitleColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(firstItemView.unselectedItemTintColor,
                        [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedOpacity]);
  XCTAssertEqual(firstItemView.label.font, typographyScheme.caption);
}

- (void)testBottomNavigationCustomTypographyTheming {
  // Given
  UIFont *fakeFont = [UIFont systemFontOfSize:12];
  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  typographyScheme.caption = fakeFont;

  // When
  [self.bottomNavigationBar applyThemeWithTypographyScheme:typographyScheme];

  // Then
  MDCBottomNavigationItemView *firstItemView = [self.bottomNavigationBar.itemViews firstObject];
  XCTAssertEqual(firstItemView.label.font, fakeFont);
}

- (void)testBottomNavigationCustomColorTheming {
  // Given
  UIColor *fakeOnPrimaryColor = UIColor.blueColor;
  UIColor *fakePrimaryColor = UIColor.greenColor;
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.onPrimaryColor = fakeOnPrimaryColor;
  colorScheme.primaryColor = fakePrimaryColor;

  // When
  [self.bottomNavigationBar applyThemeWithColorScheme:colorScheme];

  // Then
  XCTAssertEqualObjects(self.bottomNavigationBar.barTintColor, fakePrimaryColor);
  XCTAssertEqualObjects(self.bottomNavigationBar.selectedItemTintColor, fakeOnPrimaryColor);
  XCTAssertEqualObjects(self.bottomNavigationBar.unselectedItemTintColor,
                        [fakeOnPrimaryColor colorWithAlphaComponent:kUnselectedOpacity]);

  MDCBottomNavigationItemView *firstItemView = [self.bottomNavigationBar.itemViews firstObject];
  XCTAssertEqualObjects(firstItemView.selectedItemTitleColor, fakeOnPrimaryColor);
  XCTAssertEqualObjects(firstItemView.unselectedItemTintColor,
                        [fakeOnPrimaryColor colorWithAlphaComponent:kUnselectedOpacity]);
}

@end
