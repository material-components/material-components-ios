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
#import "MaterialBottomNavigation+TypographyThemer.h"
#import "MaterialBottomNavigation.h"

@interface BottomNavigationTypographyThemerTests : XCTestCase

@end

@implementation BottomNavigationTypographyThemerTests

- (void)testTypogrpahyThemer {
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  MDCBottomNavigationBar *bottomBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectZero];
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  bottomBar.itemTitleFont = [UIFont systemFontOfSize:31];
  bottomBar.items = @[item1, item2];

  [MDCBottomNavigationBarTypographyThemer applyTypographyScheme:typographyScheme
                                          toBottomNavigationBar:bottomBar];

  XCTAssertEqual(bottomBar.itemTitleFont, typographyScheme.caption);
}

@end
