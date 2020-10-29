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
#import "MaterialButtons.h"
#import "MDCAlertController+ButtonForAction.h"
#import "MDCAlertActionManager.h"
#import "MDCAlertControllerView+Private.h"

@interface MDCAlertActionManagerTests : XCTestCase

@property(nonatomic, nullable, strong) MDCAlertActionManager *actionManager;
@property(nonatomic, nullable, strong) MDCAlertAction *action;

@end

@implementation MDCAlertActionManagerTests

- (void)actionButtonPressed:(id)button {
}

- (void)setUp {
  [super setUp];
  self.actionManager = [[MDCAlertActionManager alloc] init];
  self.action = [MDCAlertAction actionWithTitle:@"title"
                                        handler:^(MDCAlertAction *_Nonnull act){
                                        }];
}

- (void)testAddingActionsDoesnotCreaetButtons {
  // When
  [self.actionManager addAction:self.action];

  // Then
  XCTAssertEqual([[self.actionManager actions] count], 1ul);
  XCTAssertEqual([[self.actionManager buttonsInActionOrder] count], 0ul);
}

- (void)testActionManager_ButtonForActionReturnsNoButtonsWhenCalledBeforeThemingOrPresentation {
  // Given
  [self.actionManager addAction:self.action];

  // When
  MDCButton *button = [self.actionManager buttonForAction:self.action];

  // Then
  XCTAssertNil(button);
  XCTAssertEqual([[self.actionManager actions] count], 1ul);
  XCTAssertEqual([[self.actionManager buttonsInActionOrder] count], 0ul);
}

- (void)testActionManager_AddingButtonToActionBeforeAlertIsPresentedReturnsDetachedButtons {
  // Given
  [self.actionManager addAction:self.action];

  // When
  MDCButton *button = [self.actionManager createButtonForAction:self.action
                                                         target:self
                                                       selector:@selector(actionButtonPressed:)];
  MDCButton *button2 = [self.actionManager buttonForAction:self.action];

  // Then
  XCTAssertNotNil(button);
  XCTAssertNil(button.superview);
  XCTAssertEqual([[self.actionManager actions] count], 1ul);
  XCTAssertEqual([[self.actionManager buttonsInActionOrder] count], 1ul);
  XCTAssertEqual(button, button2);
  XCTAssertEqual([self.actionManager actionForButton:button], self.action);
}

- (void)testAlertController_AddingActionsToAlertBeforePresentationCreatesDetachedButtons {
  // Given
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title" message:@"msg"];
  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:@"action2"
                                                    handler:^(MDCAlertAction *_Nonnull act){
                                                    }];

  // When
  [alert addAction:self.action];
  MDCButton *button = [alert buttonForAction:self.action];
  MDCButton *button2 = [alert buttonForAction:action2];

  // Then
  XCTAssertEqual([alert.actions count], 1ul);
  XCTAssertNotNil(button);
  XCTAssertNil(button.superview);
  XCTAssertNil(button2);  // no button if the action hasn't been added first
}

- (void)testAlertController_AlertPresentationAttachesButtonsToViewHierarchy {
  // Given
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title" message:@"msg"];
  [alert addAction:self.action];
  MDCButton *button = [alert buttonForAction:self.action];

  // When (simulating alert presentation)
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)alert.view;

  // Then
  XCTAssertNotNil(button);
  XCTAssertNotNil(button.superview);
  XCTAssertEqual([[alertView.actionManager actions] count], 1ul);
  XCTAssertEqual([[alertView.actionManager buttonsInActionOrder] count], 1ul);
  XCTAssertEqual([alertView.actionManager buttonForAction:self.action], button);
  XCTAssertEqual([alertView.actionManager actionForButton:button], self.action);
}

- (void)testAddingActionsToAlertBeforeAndAfterPresentationAddsAllButtonsToViewHierarchy {
  // Given
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title" message:@"msg"];
  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:@"action2"
                                                    handler:^(MDCAlertAction *_Nonnull act){
                                                    }];
  [alert addAction:self.action];
  MDCButton *button = [alert buttonForAction:self.action];

  // When
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)alert.view;
  [alert addAction:action2];

  // Then
  XCTAssertEqual([alert.actions count], 2ul);
  XCTAssertNotNil(button);
  XCTAssertNotNil(button.superview);
  XCTAssertEqual([[alertView.actionManager buttonsInActionOrder] count], 2ul);
  MDCButton *button2 = [alert buttonForAction:action2];
  XCTAssertNotNil(button2);
  XCTAssertNotNil(button2.superview);
}

/**
 * Verifies that a new action of the same setup of an added action is not considered as included.
 */
- (void)testSecondActionWithSameValuesShouldNotBeIncluded {
  [self.actionManager addAction:self.action];
  MDCAlertAction *clonedAction = [self.action copy];
  XCTAssertFalse([self.actionManager hasAction:clonedAction]);

  // Ensures that the cloned action can be added.
  [self.actionManager addAction:clonedAction];
  XCTAssertTrue([self.actionManager hasAction:clonedAction]);
}

/** Verifes that a button is not created for an action with the same setup that's not yet added. */
- (void)testButtonForActionShouldReturnNilForSameValueButDifferentActionObject {
  [self.actionManager addAction:self.action];
  MDCAlertAction *clonedAction = [self.action copy];
  MDCButton *button = [self.actionManager createButtonForAction:self.action
                                                         target:self
                                                       selector:@selector(actionButtonPressed:)];

  XCTAssertNotNil(button);
  XCTAssertNil([self.actionManager buttonForAction:clonedAction]);
}

/** Verifies that the buttons for two equal actions have different identities. */
- (void)testButtonsShouldBeUniqueWithActionsThatAreEqual {
  MDCAlertAction *clonedAction = [self.action copy];
  [self.actionManager addAction:self.action];
  [self.actionManager addAction:clonedAction];

  MDCButton *button1 = [self.actionManager createButtonForAction:self.action
                                                          target:self
                                                        selector:@selector(actionButtonPressed:)];
  MDCButton *button2 = [self.actionManager createButtonForAction:clonedAction
                                                          target:self
                                                        selector:@selector(actionButtonPressed:)];
  XCTAssertNotEqual(button1, button2);
}

@end
