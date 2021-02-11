// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
#import "../../src/private/MDCSnackbarManagerInternal.h"
#import "MaterialShadowElevations.h"
#import "MaterialSnackbar.h"

@interface MDCSnackbarManagerInternal (SnackbarManagerTesting)
@property(nonatomic) MDCSnackbarMessageView *currentSnackbar;
@end

@interface MDCSnackbarManager (SnackbarManagerTesting)
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end

@interface SnackbarManagerTests : XCTestCase

@end

@implementation SnackbarManagerTests

- (void)tearDown {
  [MDCSnackbarManager.defaultManager dismissAndCallCompletionBlocksWithCategory:nil];
  [super tearDown];
}

// Disabled due to flakiness in CI.
- (void)disabled_testMessagesResumedWhenTokenIsDeallocated {
  // Given
  MDCSnackbarMessage *suspendedMessage = [MDCSnackbarMessage messageWithText:@"foo1"];
  suspendedMessage.duration = 0.05;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  suspendedMessage.completionHandler = ^(BOOL userInitiated) {
    [expectation fulfill];
  };

  // Encourage the runtime to deallocate the token immediately
  @autoreleasepool {
    id<MDCSnackbarSuspensionToken> token = [MDCSnackbarManager.defaultManager suspendAllMessages];
    [MDCSnackbarManager.defaultManager showMessage:suspendedMessage];

    // When
    token = nil;
  }

  // Then
  [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)testHasMessagesShowingOrQueued {
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"foo1"];
  message.duration = 10;
  [MDCSnackbarManager.defaultManager showMessage:message];

  XCTestExpectation *expectation = [self expectationWithDescription:@"has_shown_message"];

  // We need to dispatch_async in order to assure that the assertion happens after showMessage:
  // actually displays the message.
  dispatch_async(dispatch_get_main_queue(), ^{
    XCTAssertTrue([MDCSnackbarManager.defaultManager hasMessagesShowingOrQueued]);
    [expectation fulfill];
  });

  [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)testInstanceCreatedInBackgroundThread {
  // Given
  XCTestExpectation *expect = [self expectationWithDescription:@""];

  // When
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    MDCSnackbarManager *manager = [[MDCSnackbarManager alloc] init];
    (void)manager;
    [expect fulfill];
  });

  // Then
  [self waitForExpectations:@[ expect ] timeout:3];
}

- (void)testDefaultElevation {
  // Then
  XCTAssertEqual([[MDCSnackbarManager alloc] init].messageElevation, MDCShadowElevationSnackbar);
}

- (void)testCustomElevation {
  // Given
  MDCSnackbarManager *manager = [[MDCSnackbarManager alloc] init];
  CGFloat fakeElevation = 10;

  // When
  manager.messageElevation = fakeElevation;

  // Then
  XCTAssertEqual(manager.messageElevation, fakeElevation);
}

- (void)testAdjustsFontForContentSizeCategoryWhenScaledFontIsUnavailableDefaultValue {
  // Given
  MDCSnackbarManager *manager = [[MDCSnackbarManager alloc] init];

  // Then
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  XCTAssertTrue(manager.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable);
#pragma clang diagnostic pop
}

- (void)testTraitCollectionDidChangeCalledWhenTraitCollectionChanges {
  // Given
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"foo1"];
  message.duration = 10;
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCSnackbarMessageView *passedMessageView;
  MDCSnackbarManager.defaultManager.traitCollectionDidChangeBlockForMessageView =
      ^(MDCSnackbarMessageView *_Nonnull inMessageView,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedMessageView = inMessageView;
        passedTraitCollection = previousTraitCollection;
        [expectation fulfill];
      };

  // When
  [MDCSnackbarManager.defaultManager showMessage:message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];

  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  MDCSnackbarMessageView *messageView =
      MDCSnackbarManager.defaultManager.internalManager.currentSnackbar;
  [messageView traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedMessageView, messageView);
}

- (void)testCurrentElevationMatchesElevationWhenElevationChanges {
  // Given
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"foo1"];
  message.duration = 10;
  MDCSnackbarManager.defaultManager.messageElevation = 4;

  // When
  [MDCSnackbarManager.defaultManager showMessage:message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];

  // Then
  MDCSnackbarMessageView *messageView =
      MDCSnackbarManager.defaultManager.internalManager.currentSnackbar;
  XCTAssertEqualWithAccuracy(messageView.mdc_currentElevation, 4, 0.001);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"foo1"];
  message.duration = 10;
  CGFloat expectedBaseElevation = 99;

  // When
  [MDCSnackbarManager.defaultManager showMessage:message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];
  MDCSnackbarManager.defaultManager.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  MDCSnackbarMessageView *messageView =
      MDCSnackbarManager.defaultManager.internalManager.currentSnackbar;
  XCTAssertEqualWithAccuracy(messageView.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"foo1"];
  message.duration = 10;
  MDCSnackbarManager.defaultManager.shouldApplyStyleChangesToVisibleSnackbars = YES;

  // When
  [MDCSnackbarManager.defaultManager showMessage:message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];
  MDCSnackbarManager.defaultManager.messageElevation = 5;

  __block BOOL blockCalled = NO;
  MDCSnackbarManager.defaultManager.mdc_elevationDidChangeBlockForMessageView =
      ^(id<MDCElevatable> _, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  MDCSnackbarManager.defaultManager.messageElevation =
      MDCSnackbarManager.defaultManager.messageElevation + 1;

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"foo1"];
  message.duration = 10;
  MDCSnackbarManager.defaultManager.shouldApplyStyleChangesToVisibleSnackbars = YES;

  // When
  [MDCSnackbarManager.defaultManager showMessage:message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];
  MDCSnackbarManager.defaultManager.messageElevation = 5;

  __block BOOL blockCalled = NO;
  MDCSnackbarManager.defaultManager.mdc_elevationDidChangeBlockForMessageView =
      ^(id<MDCElevatable> _, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  MDCSnackbarManager.defaultManager.messageElevation =
      MDCSnackbarManager.defaultManager.messageElevation;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Then
  XCTAssertLessThan(MDCSnackbarManager.defaultManager.mdc_overrideBaseElevation, 0);
}

- (void)testDefaultValueForFocusedSnackbarsAccessibilityNotification {
  // Then
  XCTAssertEqual(MDCSnackbarManager.defaultManager.focusAccessibilityNotification,
                 UIAccessibilityLayoutChangedNotification);
}

@end
