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

#import "MaterialTabs+FontThemer.h"
#import "MaterialTabs.h"
#import "MaterialThemes.h"

@interface MDCTabBarFontThemerTests : XCTestCase
@end

@implementation MDCTabBarFontThemerTests

- (void)testTabBarFontThemerApplyFontSchemeProperly {
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.button = [UIFont boldSystemFontOfSize:22];
  [MDCTabBarFontThemer applyFontScheme:fontScheme toTabBar:tabBar];
  XCTAssertEqualObjects(tabBar.selectedItemTitleFont, fontScheme.button);
  XCTAssertEqualObjects(tabBar.unselectedItemTitleFont, fontScheme.button);
}

@end
