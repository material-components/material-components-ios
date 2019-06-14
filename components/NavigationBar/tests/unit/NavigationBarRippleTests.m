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

#import "MaterialButtonBar.h"
#import "MaterialInk.h"
#import "MaterialNavigationBar.h"
#import "MaterialRipple.h"

@interface MDCNavigationBar (Testing)
- (MDCButtonBar *)leadingButtonBar;
- (MDCButtonBar *)trailingButtonBar;
@end

/**
 This class confirms behavior of @c MDCNavigationBar when used with Ripple.
 */
@interface NavigationBarRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCNavigationBar *navBar;

@end

@implementation NavigationBarRippleTests

- (void)setUp {
  [super setUp];

  self.navBar = [[MDCNavigationBar alloc] init];
}

- (void)tearDown {
  self.navBar = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCNavigationBar without any customization.
 */
- (void)testRippleIsDisabledForButtonBarAndRippleColorIsNil {
  // Then
  XCTAssertFalse(self.navBar.enableRippleBehavior);
  XCTAssertFalse([self.navBar leadingButtonBar].enableRippleBehavior);
  XCTAssertFalse([self.navBar trailingButtonBar].enableRippleBehavior);
  XCTAssertEqualObjects(self.navBar.rippleColor, nil);
  XCTAssertEqualObjects(self.navBar.inkColor, nil);
  XCTAssertEqualObjects([self.navBar leadingButtonBar].rippleColor, nil);
  XCTAssertEqualObjects([self.navBar leadingButtonBar].inkColor, nil);
}

/**
 Test to confirm behavior of initializing a @c MDCNavigationBar with Ripple enabled.
 */
- (void)testRippleIsEnabledForButtonBarAndRippleColorIsNilWhenRippleBehaviorIsEnabled {
  // When
  self.navBar.enableRippleBehavior = YES;

  // Then
  XCTAssertTrue(self.navBar.enableRippleBehavior);
  XCTAssertTrue([self.navBar leadingButtonBar].enableRippleBehavior);
  XCTAssertTrue([self.navBar trailingButtonBar].enableRippleBehavior);
  XCTAssertEqualObjects(self.navBar.rippleColor, nil);
  XCTAssertEqualObjects(self.navBar.inkColor, nil);
  XCTAssertEqualObjects([self.navBar leadingButtonBar].rippleColor, nil);
  XCTAssertEqualObjects([self.navBar leadingButtonBar].inkColor, nil);
}

- (void)testSettingRippleColorWithRippleEnabled {
  // When
  self.navBar.enableRippleBehavior = YES;
  self.navBar.rippleColor = UIColor.redColor;

  // Then
  XCTAssertTrue(self.navBar.enableRippleBehavior);
  XCTAssertTrue([self.navBar leadingButtonBar].enableRippleBehavior);
  XCTAssertTrue([self.navBar trailingButtonBar].enableRippleBehavior);
  XCTAssertEqualObjects(self.navBar.rippleColor, UIColor.redColor);
  XCTAssertEqualObjects(self.navBar.inkColor, nil);
  XCTAssertEqualObjects([self.navBar leadingButtonBar].rippleColor, UIColor.redColor);
  XCTAssertEqualObjects([self.navBar leadingButtonBar].inkColor, nil);
}

@end
