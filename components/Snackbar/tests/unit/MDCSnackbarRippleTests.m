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

#import "MaterialSnackbar.h"

#import "../../src/private/MDCSnackbarManagerInternal.h"

@interface MDCSnackbarManagerInternal (RippleTesting)
@property(nonatomic) MDCSnackbarMessageView *currentSnackbar;
@end

@interface MDCSnackbarManager (RippleTesting)
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end

/**
 This class confirms behavior of @c MDCSnackbar when used with Ripple.
 */
@interface MDCSnackbarRippleTests : XCTestCase
@property(nonatomic, strong) MDCSnackbarManager *manager;
@property(nonatomic, strong) MDCSnackbarMessage *message;
@end

@implementation MDCSnackbarRippleTests

- (void)setUp {
  [super setUp];

  self.manager = [[MDCSnackbarManager alloc] init];
  self.message = [[MDCSnackbarMessage alloc] init];
  self.message.text = @"Snackbar Message";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;
}

- (void)tearDown {
  [super tearDown];

  self.message = nil;
  self.manager = nil;
}

/**
 Test to confirm behavior of initializing a @c MDCSnackbar without any customization.
 */
- (void)testRippleDisabledForSnackbarButtons {
  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });

  // Then
  [self waitForExpectationsWithTimeout:1 handler:nil];
  NSMutableArray<MDCButton *> *actionButtons =
      self.manager.internalManager.currentSnackbar.actionButtons;
  for (MDCButton *button in actionButtons) {
    XCTAssertFalse(button.enableRippleBehavior);
    XCTAssertEqual(button.inkStyle, MDCInkStyleBounded);
  }
}

/**
 Test to confirm behavior of initializing a @c MDCSnackbar with Ripple enabled.
 */
- (void)testRippleEnabledForSnackbarButtonsWhenEnabledRippleBehavior {
  // When
  self.message.enableRippleBehavior = YES;
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });

  // Then
  [self waitForExpectationsWithTimeout:1 handler:nil];
  NSMutableArray<MDCButton *> *actionButtons =
      self.manager.internalManager.currentSnackbar.actionButtons;
  for (MDCButton *button in actionButtons) {
    XCTAssertTrue(button.enableRippleBehavior);
    XCTAssertEqual(button.inkStyle, MDCInkStyleBounded);
  }
}

@end
