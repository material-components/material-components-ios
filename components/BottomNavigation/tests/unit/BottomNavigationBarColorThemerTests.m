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

#import <XCTest/XCTest.h>
#import "MaterialBottomNavigation+ColorThemer.h"
#import "MaterialColorScheme.h"
#import "MaterialBottomNavigation.h"
#import "../../src/private/MDCBottomNavigationItemView.h"

@interface FakeColorScheme : NSObject<MDCColorScheme>
@property(nonatomic, strong) UIColor *primaryColor;
@end
@implementation FakeColorScheme
@end

@interface BottomNavigationBarColorThemerTests : XCTestCase

@end

@interface MDCBottomNavigationBar (Testing)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@end

@implementation BottomNavigationBarColorThemerTests

- (void)testColorScheming {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.primaryColor = [UIColor redColor];
  colorScheme.onPrimaryColor = [UIColor blueColor];
  UITabBarItem *item = [[UITabBarItem alloc] init];
  MDCBottomNavigationBar *bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  [bottomNavigationBar setItems:@[item]];
  bottomNavigationBar.barTintColor = [UIColor greenColor];
  bottomNavigationBar.selectedItemTintColor = [UIColor yellowColor];
  
  // When
  [MDCBottomNavigationBarColorThemer applySemanticColorScheme:colorScheme
                                           toBottomNavigation:bottomNavigationBar];

  // Then
  XCTAssertEqualObjects(bottomNavigationBar.barTintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(bottomNavigationBar.selectedItemTintColor, colorScheme.onPrimaryColor);

  MDCBottomNavigationItemView *firstItemView = [bottomNavigationBar.itemViews firstObject];
  XCTAssertEqualObjects(firstItemView.selectedItemTitleColor, colorScheme.onPrimaryColor);
}

- (void)testColorSchemeWithoutOptionalColorProperties {
  // Given
  FakeColorScheme *colorScheme = [[FakeColorScheme alloc] init];
  colorScheme.primaryColor = UIColor.redColor;
  MDCBottomNavigationBar *bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];

  // When
  [MDCBottomNavigationBarColorThemer applyColorScheme:colorScheme
                                toBottomNavigationBar:bottomNavigationBar];

  // Then
  XCTAssertEqualObjects(bottomNavigationBar.selectedItemTintColor, colorScheme.primaryColor);
}

- (void)testApplyBasicColorScheme {
  // Given
  MDCBasicColorScheme *colorScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:UIColor.blackColor];
  MDCBottomNavigationBar *bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];

  // When
  [MDCBottomNavigationBarColorThemer applyColorScheme:colorScheme
                                toBottomNavigationBar:bottomNavigationBar];

  // Then
  XCTAssertEqualObjects(bottomNavigationBar.selectedItemTintColor, colorScheme.primaryColor);
}

@end
