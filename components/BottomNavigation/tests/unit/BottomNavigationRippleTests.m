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
#import "MaterialBottomNavigation.h"
#import "MaterialInk.h"
#import "MaterialRipple.h"

@interface MDCBottomNavigationBar (Testing)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@property(nonatomic, strong) NSMutableArray *inkControllers;
- (BOOL)inkTouchController:(MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location;
- (BOOL)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
    shouldProcessRippleTouchesAtTouchLocation:(CGPoint)location;
@end

/**
 This class confirms behavior of @c MDCBottomNavigationBar when used with Ripple.
 */
@interface BottomNavigationRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCBottomNavigationBar *bottomNavigationBar;

@end

@implementation BottomNavigationRippleTests

- (void)setUp {
  [super setUp];

  self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  self.bottomNavigationBar.items = @[ item1, item2 ];
}

- (void)tearDown {
  self.bottomNavigationBar = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCBottomNavigationBar without any customization.
 */
- (void)testEnabledInkAndDisabledRippleColorsAndSuperviewsAndBounds {
  // Then
  XCTAssertFalse(self.bottomNavigationBar.enableRippleBehavior);
  for (MDCBottomNavigationItemView *itemView in self.bottomNavigationBar.itemViews) {
    XCTAssertEqualObjects(itemView.rippleTouchController.rippleView.rippleColor,
                          [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.15]);
    XCTAssertEqualObjects(itemView.inkView.inkColor,
                          [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.15]);
    XCTAssertEqual(itemView.rippleTouchController.rippleView.rippleStyle, MDCRippleStyleUnbounded);
    XCTAssertNotNil(itemView.rippleTouchController.rippleView.superview);
    XCTAssertNotNil(itemView.inkView.superview);
    CGRect itemViewBounds = CGRectStandardize(itemView.bounds);
    CGRect inkBounds = CGRectStandardize(itemView.inkView.bounds);
    XCTAssertTrue(CGRectEqualToRect(itemViewBounds, inkBounds), @"%@ is not equal to %@",
                  NSStringFromCGRect(itemViewBounds), NSStringFromCGRect(inkBounds));
  }
}

/**
 Test to confirm behavior of initializing a @c MDCBottomNavigationBar with Ripple enabled.
 */
- (void)testEnabledRippleAndDisabledInkColorsAndSuperviewsAndBoundsWithRippleBehaviorEnabled {
  // When
  self.bottomNavigationBar.enableRippleBehavior = YES;

  // Then
  XCTAssertTrue(self.bottomNavigationBar.enableRippleBehavior);
  for (MDCBottomNavigationItemView *itemView in self.bottomNavigationBar.itemViews) {
    XCTAssertEqualObjects(itemView.rippleTouchController.rippleView.rippleColor,
                          [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.15]);
    XCTAssertEqualObjects(itemView.inkView.inkColor,
                          [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.15]);
    XCTAssertEqual(itemView.rippleTouchController.rippleView.rippleStyle, MDCRippleStyleUnbounded);
    XCTAssertNotNil(itemView.rippleTouchController.rippleView.superview);
    XCTAssertNotNil(itemView.inkView.superview);
    CGRect itemViewBounds = CGRectStandardize(itemView.bounds);
    CGRect rippleBounds = CGRectStandardize(itemView.rippleTouchController.rippleView.bounds);
    XCTAssertTrue(CGRectEqualToRect(itemViewBounds, rippleBounds), @"%@ is not equal to %@",
                  NSStringFromCGRect(itemViewBounds), NSStringFromCGRect(rippleBounds));
  }
}

/**
 Test to confirm toggling @c enableRippleBehavior triggers ripple on touch and not ink.
 */
- (void)testSetEnableRippleBehaviorToYesThenInvokeItemToCheckRippleIsInvoked {
  // When
  self.bottomNavigationBar.enableRippleBehavior = YES;

  // Then
  for (MDCBottomNavigationItemView *itemView in self.bottomNavigationBar.itemViews) {
    XCTAssertTrue([self.bottomNavigationBar rippleTouchController:itemView.rippleTouchController
                        shouldProcessRippleTouchesAtTouchLocation:CGPointZero]);
  }
  for (MDCInkTouchController *controller in self.bottomNavigationBar.inkControllers) {
    XCTAssertFalse([self.bottomNavigationBar inkTouchController:controller
                         shouldProcessInkTouchesAtTouchLocation:CGPointZero]);
  }
}

/**
 Test to confirm that default behavior triggers ink on touch and not ripple.
 */
- (void)testTouchingItemToCheckInkIsInvokedAndNotRipple {
  // Then
  for (MDCBottomNavigationItemView *itemView in self.bottomNavigationBar.itemViews) {
    XCTAssertFalse([self.bottomNavigationBar rippleTouchController:itemView.rippleTouchController
                         shouldProcessRippleTouchesAtTouchLocation:CGPointZero]);
  }
  for (MDCInkTouchController *controller in self.bottomNavigationBar.inkControllers) {
    XCTAssertTrue([self.bottomNavigationBar inkTouchController:controller
                        shouldProcessInkTouchesAtTouchLocation:CGPointZero]);
  }
}

/**
 Test setting BottomNavigation's selectedItemTintColor API updates the internal
 RippleTouchController's ripple color.
 */
- (void)testSetEnableRippleBehaviorToYesThenSetSelectedItemTintColorToSetRippleColor {
  // When
  self.bottomNavigationBar.enableRippleBehavior = YES;
  [self.bottomNavigationBar setSelectedItemTintColor:UIColor.redColor];

  // Then
  for (MDCBottomNavigationItemView *itemView in self.bottomNavigationBar.itemViews) {
    XCTAssertEqualObjects(itemView.rippleTouchController.rippleView.rippleColor,
                          [UIColor.redColor colorWithAlphaComponent:(CGFloat)0.15]);
    XCTAssertEqualObjects(itemView.inkView.inkColor,
                          [UIColor.redColor colorWithAlphaComponent:(CGFloat)0.15]);
  }
}
@end
