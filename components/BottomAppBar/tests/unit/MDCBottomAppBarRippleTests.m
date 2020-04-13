// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

@interface MDCBottomAppBarView (MDCRippleTesting)

@property(nonatomic, strong) MDCNavigationBar *navBar;

@end

@interface MDCBottomAppBarRippleTests : XCTestCase

@property(nonatomic, nullable, strong) MDCBottomAppBarView *bottomAppBar;

@end

@implementation MDCBottomAppBarRippleTests

- (void)setUp {
  [super setUp];

  self.bottomAppBar = [[MDCBottomAppBarView alloc] init];
}

- (void)tearDown {
  self.bottomAppBar = nil;

  [super tearDown];
}

- (void)testEnableRippleBehaviorDefaultsToNo {
  // Then
  XCTAssertFalse(self.bottomAppBar.enableRippleBehavior);
}

- (void)testSetEnableRippleBehaviorSetsNavBarProperty {
  // When
  self.bottomAppBar.enableRippleBehavior = YES;

  // Then
  XCTAssertTrue(self.bottomAppBar.navBar.enableRippleBehavior);
}

- (void)testSetRippleColorUpdatesNavigationBarProperty {
  // When
  self.bottomAppBar.rippleColor = UIColor.orangeColor;

  // Then
  XCTAssertEqualObjects(self.bottomAppBar.navBar.rippleColor, UIColor.orangeColor);
}

@end
