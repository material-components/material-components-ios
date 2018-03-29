/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialBottomNavigation.h"

@interface MDCBottomNavigationBarTestDelegate : NSObject <MDCBottomNavigationBarDelegate, NSCoding>
@end
@implementation MDCBottomNavigationBarTestDelegate
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  return [super init];
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
  // No-op
}
@end

/**
 A simple class that retains the MDCBottomNavigationBarDelegate during coding.
 */
@interface MDCBottomNavigationBarEncodingTestHarness : NSObject <NSCoding>

@property(nonatomic, strong) id<MDCBottomNavigationBarDelegate> bottomNavDelegate;
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNav;
@end

@implementation MDCBottomNavigationBarEncodingTestHarness

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    // Decode the delegate first so the bottomNav won't nil a weak reference
    if ([aDecoder containsValueForKey:@"navDel"]) {
      _bottomNavDelegate = [aDecoder decodeObjectForKey:@"navDel"];
    } else {
      _bottomNavDelegate = [[MDCBottomNavigationBarTestDelegate alloc] init];
    }
    if ([aDecoder containsValueForKey:@"nav"]) {
      _bottomNav = [aDecoder decodeObjectForKey:@"nav"];
      if (_bottomNav.delegate) {
        _bottomNavDelegate = _bottomNav.delegate;
      }
    } else {
      _bottomNav = [[MDCBottomNavigationBar alloc] init];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.bottomNav forKey:@"nav"];
  [aCoder encodeObject:self.bottomNavDelegate forKey:@"navDel"];
}

@end

@interface BottomNavigationCodingTests : XCTestCase

@end

@implementation BottomNavigationCodingTests

- (void)testTestHarnessEncoding {
  // Given
  MDCBottomNavigationBar *navBar = [[MDCBottomNavigationBar alloc] init];
  MDCBottomNavigationBarTestDelegate *delegate = [[MDCBottomNavigationBarTestDelegate alloc] init];
  MDCBottomNavigationBarEncodingTestHarness *harness =
      [[MDCBottomNavigationBarEncodingTestHarness alloc] init];
  harness.bottomNav = navBar;
  harness.bottomNavDelegate = delegate;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:harness];
  MDCBottomNavigationBarEncodingTestHarness *unarchivedHarness =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertNotNil(unarchivedHarness.bottomNav);
  XCTAssertNotNil(unarchivedHarness.bottomNavDelegate);
}

- (void)testBasicCoding {
  // Given
  MDCBottomNavigationBarTestDelegate *delegate = [[MDCBottomNavigationBarTestDelegate alloc] init];

  MDCBottomNavigationBar *bottomNav = [[MDCBottomNavigationBar alloc] init];
  bottomNav.delegate = delegate;
  bottomNav.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  bottomNav.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  bottomNav.itemTitleFont = [UIFont systemFontOfSize:37];
  bottomNav.selectedItemTintColor = UIColor.cyanColor;
  bottomNav.unselectedItemTintColor = UIColor.magentaColor;
  UITabBarItem *item1 = [[UITabBarItem alloc] init];
  item1.title = @"1";
  UITabBarItem *item2 = [[UITabBarItem alloc] init];
  item2.title = @"2";
  [bottomNav setItems:@[item1, item2]];
  bottomNav.selectedItem = item2;
  
  MDCBottomNavigationBarEncodingTestHarness *harness =
      [[MDCBottomNavigationBarEncodingTestHarness alloc] init];
  harness.bottomNav = bottomNav;
  harness.bottomNavDelegate = delegate;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:harness];
  MDCBottomNavigationBarEncodingTestHarness *unarchivedHarness =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];
  MDCBottomNavigationBar *unarchivedBottomNav = unarchivedHarness.bottomNav;

  // Then
  XCTAssertNotNil(unarchivedBottomNav.delegate);
  XCTAssertEqual(bottomNav.titleVisibility, unarchivedBottomNav.titleVisibility);
  XCTAssertEqual(bottomNav.alignment, unarchivedBottomNav.alignment);
  XCTAssertEqualObjects(bottomNav.itemTitleFont, unarchivedBottomNav.itemTitleFont);
  XCTAssertEqualObjects(bottomNav.selectedItemTintColor, unarchivedBottomNav.selectedItemTintColor);
  XCTAssertEqualObjects(bottomNav.unselectedItemTintColor,
                        unarchivedBottomNav.unselectedItemTintColor);
  XCTAssertEqual(bottomNav.items.count, unarchivedBottomNav.items.count);
  for (NSUInteger i = 0; i < bottomNav.items.count; ++i) {
    XCTAssertEqualObjects(bottomNav.items[i].title, unarchivedBottomNav.items[i].title);
  }
  XCTAssertEqualObjects(bottomNav.selectedItem.title, unarchivedBottomNav.selectedItem.title);
}

@end
