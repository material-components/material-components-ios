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

#import "MDCButton.h"
#import "MDCAlertController.h"
#import "MDCAlertControllerView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCAlertActionManager.h"
#import "MDCAlertControllerView+Private.h"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Subclasses for testing

@interface MDCAlertController (Testing)
@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;
@end

#pragma mark - Tests

@interface MDCAlertControllerRippleTests : XCTestCase
@property(nonatomic, nullable) MDCAlertController *alert;
@end

@implementation MDCAlertControllerRippleTests

- (void)setUp {
  [super setUp];

  self.alert = [MDCAlertController alertControllerWithTitle:@"title" message:@"message"];
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];
}

- (void)tearDown {
  self.alert = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCAlerController without any customization.
 */
- (void)testRippleIsDisabledForButtons {
  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertFalse(self.alert.enableRippleBehavior);
  XCTAssertFalse(view.enableRippleBehavior);
  NSArray<MDCButton *> *buttons = (NSArray<MDCButton *> *)view.actionManager.buttonsInActionOrder;
  for (MDCButton *button in buttons) {
    XCTAssertFalse(button.enableRippleBehavior);
  }
}

/**
 Test to confirm behavior of initializing a @c MDCAlerController with Ripple enabled.
 */
- (void)testRippleIsEnabledForButtonsWhenRippleBehaviorIsEnabled {
  // When
  self.alert.enableRippleBehavior = YES;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertTrue(self.alert.enableRippleBehavior);
  XCTAssertTrue(view.enableRippleBehavior);
  NSArray<MDCButton *> *buttons = (NSArray<MDCButton *> *)view.actionManager.buttonsInActionOrder;
  for (MDCButton *button in buttons) {
    XCTAssertTrue(button.enableRippleBehavior);
  }
}

@end

NS_ASSUME_NONNULL_END
