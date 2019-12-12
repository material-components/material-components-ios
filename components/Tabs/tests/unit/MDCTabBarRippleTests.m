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

#import "../../src/private/MDCItemBar.h"
#import "../../src/private/MDCItemBarCell.h"
#import "../../src/private/MDCItemBarStyle.h"
#import "MaterialInk.h"
#import "MaterialRipple.h"
#import "MaterialTabs.h"

@interface MDCTabBar (Testing)
- (void)updateItemBarStyle;
@end

@interface MDCItemBarCell (Testing)
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@end

@interface MDCItemBar (Testing)
@property(nonatomic, strong, nullable) MDCItemBarStyle *style;
@property(nonatomic, strong, nullable) UICollectionView *collectionView;
@end

/**
 This class confirms behavior of @c MDCTabBar when used with Ripple.
 */
@interface MDCTabBarRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCTabBar *tabBar;
@property(nonatomic, strong, nullable) MDCItemBar *itemBar;

@end

@implementation MDCTabBarRippleTests

- (void)setUp {
  [super setUp];

  self.tabBar = [[MDCTabBar alloc] init];
  self.itemBar = [self.tabBar valueForKey:@"_itemBar"];
  CGFloat tabBarHeight = [MDCTabBar defaultHeightForItemAppearance:self.tabBar.itemAppearance];
  self.tabBar.frame = CGRectMake(0, 0, 200, tabBarHeight);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"first" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"second" image:nil tag:0];
  self.tabBar.items = @[ item1, item2 ];
  [self.tabBar setNeedsLayout];
  [self.tabBar layoutIfNeeded];
}

- (void)tearDown {
  self.tabBar = nil;
  self.itemBar = nil;

  [super tearDown];
}

- (NSArray<MDCItemBarCell *> *)getItemBarCells {
  NSMutableArray<MDCItemBarCell *> *arr = [[NSMutableArray alloc] init];
  for (UITabBarItem *item in self.itemBar.items) {
    NSInteger itemIndex = [self.itemBar.items indexOfObject:item];
    if (itemIndex != NSNotFound) {
      NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
      UICollectionViewCell *cell = [self.itemBar.collectionView cellForItemAtIndexPath:indexPath];
      if (cell) {
        NSAssert([cell isKindOfClass:[MDCItemBarCell class]], @"All cells must be MDCItemBarCell");
        MDCItemBarCell *itemCell = (MDCItemBarCell *)cell;
        [arr addObject:itemCell];
      }
    }
  }
  return arr;
}

/**
 Test to confirm behavior of initializing a @c MDCTabBar without any customization.
 */
- (void)testEnabledInkAndDisabledRipplePropertiesAndBehavior {
  // Given
  NSArray<MDCItemBarCell *> *itemBarCells = [self getItemBarCells];

  // Then
  XCTAssertFalse(self.tabBar.enableRippleBehavior);
  XCTAssertFalse(self.itemBar.style.enableRippleBehavior);
  XCTAssertEqualObjects(self.tabBar.rippleColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  XCTAssertEqualObjects(self.tabBar.inkColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  XCTAssertEqualObjects(self.itemBar.style.rippleColor, [UIColor colorWithWhite:1
                                                                          alpha:(CGFloat)0.7]);
  XCTAssertEqualObjects(self.itemBar.style.inkColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  for (MDCItemBarCell *cell in itemBarCells) {
    XCTAssertNotNil(cell.rippleTouchController);
    XCTAssertNotNil(cell.inkTouchController);
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor,
                          [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
    XCTAssertEqual(cell.inkTouchController.defaultInkView.inkStyle, MDCInkStyleBounded);
    XCTAssertEqual(cell.rippleTouchController.rippleView.rippleStyle, MDCRippleStyleBounded);
    XCTAssertNil(cell.rippleTouchController.rippleView.superview);
    XCTAssertNotNil(cell.inkTouchController.defaultInkView.superview);

    CGRect cellBounds = CGRectStandardize(cell.bounds);
    CGRect inkBounds = CGRectStandardize(cell.inkTouchController.defaultInkView.bounds);
    XCTAssertTrue(CGRectEqualToRect(cellBounds, inkBounds), @"%@ is not equal to %@",
                  NSStringFromCGRect(cellBounds), NSStringFromCGRect(inkBounds));
  }
}

/**
 Test to confirm behavior of initializing a @c MDCTabBar with Ripple enabled.
 */
- (void)testEnabledRippleAndDisabledInkPropertiesAndBehaviorWhenEnabledRippleBehavior {
  // Given
  NSArray<MDCItemBarCell *> *itemBarCells = [self getItemBarCells];

  // When
  self.tabBar.enableRippleBehavior = YES;

  // Then
  XCTAssertTrue(self.tabBar.enableRippleBehavior);
  XCTAssertTrue(self.itemBar.style.enableRippleBehavior);
  XCTAssertEqualObjects(self.tabBar.rippleColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  XCTAssertEqualObjects(self.tabBar.inkColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  XCTAssertEqualObjects(self.itemBar.style.rippleColor, [UIColor colorWithWhite:1
                                                                          alpha:(CGFloat)0.7]);
  XCTAssertEqualObjects(self.itemBar.style.inkColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  for (MDCItemBarCell *cell in itemBarCells) {
    XCTAssertNotNil(cell.rippleTouchController);
    XCTAssertNotNil(cell.inkTouchController);
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor,
                          [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
    XCTAssertEqual(cell.inkTouchController.defaultInkView.inkStyle, MDCInkStyleBounded);
    XCTAssertEqual(cell.rippleTouchController.rippleView.rippleStyle, MDCRippleStyleBounded);
    XCTAssertNotNil(cell.rippleTouchController.rippleView.superview);
    XCTAssertNil(cell.inkTouchController.defaultInkView.superview);

    CGRect cellBounds = CGRectStandardize(cell.bounds);
    CGRect rippleBounds = CGRectStandardize(cell.rippleTouchController.rippleView.bounds);
    XCTAssertTrue(CGRectEqualToRect(cellBounds, rippleBounds), @"%@ is not equal to %@",
                  NSStringFromCGRect(cellBounds), NSStringFromCGRect(rippleBounds));
  }
}

/**
 Test to confirm toggling @c enableRippleBehavior removes the @c rippleView as a subview.
 */
- (void)testSetEnableRippleBehaviorToYesThenNoRemovesRippleViewAsSubviewOfCell {
  // Given
  NSArray<MDCItemBarCell *> *itemBarCells = [self getItemBarCells];

  // When
  self.tabBar.enableRippleBehavior = YES;
  self.tabBar.enableRippleBehavior = NO;

  // Then
  for (MDCItemBarCell *cell in itemBarCells) {
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.superview, cell);
    XCTAssertNil(cell.rippleTouchController.rippleView.superview);
  }
}

/**
 Test setting TabBar's RippleColor API updates the internal RippleTouchController's ripple color.
 */
- (void)testSetEnableRIppleBehaviorToYesThenSetRippleColor {
  // Given
  NSArray<MDCItemBarCell *> *itemBarCells = [self getItemBarCells];

  // When
  self.tabBar.enableRippleBehavior = YES;
  self.tabBar.rippleColor = UIColor.redColor;

  // Then
  for (MDCItemBarCell *cell in itemBarCells) {
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor, UIColor.redColor);
  }
}
@end
