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

#import "../../src/private/MDCActionSheetItemTableViewCell.h"
#import "MDCActionSheetTestHelper.h"
#import "MaterialActionSheet.h"
#import "MaterialInk.h"
#import "MaterialRipple.h"

@interface MDCActionSheetController (TestingRipple)
@property(nonatomic, strong) UITableView *tableView;
@end

@interface MDCActionSheetItemTableViewCell (TestingRipple)
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@end

/**
 This class confirms behavior of @c MDCActionSheetController when used with Ripple.
 */
@interface ActionSheetRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCActionSheetController *actionSheetController;

@end

@implementation ActionSheetRippleTests

- (void)setUp {
  [super setUp];

  self.actionSheetController = [[MDCActionSheetController alloc] init];
}

- (void)tearDown {
  self.actionSheetController = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCActionSheetController without any customization.
 */
- (void)testRippleIsDisabledAndInkIsEnabledForAllCellsAndTheirPropertiesAreCorrect {
  // When
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheetController];

  // Then
  XCTAssertFalse(self.actionSheetController.enableRippleBehavior);
  XCTAssertEqualObjects(self.actionSheetController.rippleColor, nil);
  XCTAssertEqualObjects(self.actionSheetController.inkColor, nil);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertFalse(cell.enableRippleBehavior);
    XCTAssertNotNil(cell.rippleTouchController);
    XCTAssertNotNil(cell.inkTouchController);
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [[UIColor alloc] initWithWhite:0 alpha:0.14f]);
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor,
                          [[UIColor alloc] initWithWhite:0 alpha:0.14f]);
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
 Test to confirm behavior of initializing a @c MDCActionSheetController with Ripple enabled.
 */
- (void)
    testRippleIsEnabledAndInkIsDisabledForAllCellsAndTheirPropertiesAreCorrectWhenRippleBehaviorIsEnabled {
  // When
  self.actionSheetController.enableRippleBehavior = YES;
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheetController];

  // Then
  XCTAssertTrue(self.actionSheetController.enableRippleBehavior);
  XCTAssertEqualObjects(self.actionSheetController.rippleColor, nil);
  XCTAssertEqualObjects(self.actionSheetController.inkColor, nil);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertTrue(cell.enableRippleBehavior);
    XCTAssertNotNil(cell.rippleTouchController);
    XCTAssertNotNil(cell.inkTouchController);
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [[UIColor alloc] initWithWhite:0 alpha:0.14f]);
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor,
                          [[UIColor alloc] initWithWhite:0 alpha:0.14f]);
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
  // When
  self.actionSheetController.enableRippleBehavior = YES;
  self.actionSheetController.enableRippleBehavior = NO;
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheetController];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.superview, cell);
    XCTAssertNil(cell.rippleTouchController.rippleView.superview);
  }
}

/**
 Test setting ActionSheet's RippleColor API updates the internal RippleTouchController's ripple
 color.
 */
- (void)testSettingRippleColor {
  // When
  self.actionSheetController.rippleColor = UIColor.redColor;
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheetController];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor, UIColor.redColor);
  }
}
@end
