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
#import "MaterialActionSheet.h"
#import "ActionSheetTestHelpers.h"
#import "MaterialRipple.h"

@interface MDCActionSheetController (TestingRipple)
@property(nonatomic, strong) UITableView *tableView;
@end

@interface MDCActionSheetItemTableViewCell (TestingRipple)
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
@end

/**
 This class confirms behavior of @c MDCActionSheetController when used with Ripple.
 */
@interface MDCActionSheetControllerRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCActionSheetController *actionSheetController;

@end

@implementation MDCActionSheetControllerRippleTests

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
- (void)testDefaultRipplePropertiesAreCorrect {
  // When
  NSArray *cells = [ActionSheetTestHelpers getCellsFromActionSheet:self.actionSheetController];

  // Then
  XCTAssertEqualObjects(self.actionSheetController.rippleColor, nil);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertNotNil(cell.rippleTouchController);
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor,
                          [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.14]);
    XCTAssertEqual(cell.rippleTouchController.rippleView.rippleStyle, MDCRippleStyleBounded);
    XCTAssertNotNil(cell.rippleTouchController.rippleView.superview);
  }
}

/**
 Test setting ActionSheet's RippleColor API updates the internal RippleTouchController's ripple
 color.
 */
- (void)testSettingRippleColor {
  // When
  self.actionSheetController.rippleColor = UIColor.redColor;
  NSArray *cells = [ActionSheetTestHelpers getCellsFromActionSheet:self.actionSheetController];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.rippleTouchController.rippleView.rippleColor, UIColor.redColor);
  }
}

@end
