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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCShadowElevations.h"
#import "MDCSnackbarManager.h"
#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"
#import "MDCSnackbarManagerInternal.h"
#import "MDCFakeMDCSnackbarManagerDelegate.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

@interface MDCSnackbarManagerInternal (MDCSnackbarManagerTesting)
@property(nonatomic) MDCSnackbarMessageView *currentSnackbar;
@end

@interface MDCSnackbarManager (MDCSnackbarManagerTesting)
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end

static NSString *const kTestFakeSnackbarCategory = @"Test Snackbar Category";
static NSString *const kTestFakeSnackbarMessageText = @"Test Snackbar Message";
static const CGFloat kTestFakeSnackbarMessageDuration = 10.0;
static const CGFloat kTestFakeSnackbarMessageTimeoutDuration = 3.0;

@interface MDCSnackbarManagerTests : XCTestCase
@property(nonatomic, strong, nullable) MDCSnackbarManager *managerUnderTest;
@property(nonatomic, strong, nullable) FakeMDCSnackbarManagerDelegate *delegate;
@property(nonatomic, strong, nullable) MDCSnackbarMessage *message;
@end

@implementation MDCSnackbarManagerTests

- (void)setUp {
  [super setUp];

  self.managerUnderTest = [[MDCSnackbarManager alloc] init];
  self.delegate = [[FakeMDCSnackbarManagerDelegate alloc] init];
  self.managerUnderTest.delegate = self.delegate;
  self.message = [MDCSnackbarMessage messageWithText:kTestFakeSnackbarMessageText];
  self.message.duration = kTestFakeSnackbarMessageDuration;
}

- (void)tearDown {
  [self.managerUnderTest dismissAndCallCompletionBlocksWithCategory:nil];
  self.message = nil;
  self.managerUnderTest.delegate = nil;
  self.delegate = nil;
  self.managerUnderTest = nil;

  [super tearDown];
}

/** Tests that `hasMessagesShowingOrQueued` returns true after calling `showMessage`. */
- (void)testHasMessagesShowingOrQueued {
  [self.managerUnderTest showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"has_shown_message"];

  dispatch_async(dispatch_get_main_queue(), ^{
    XCTAssertTrue([self.managerUnderTest hasMessagesShowingOrQueued]);
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:kTestFakeSnackbarMessageTimeoutDuration handler:nil];
}

- (void)testInstanceCreatedInBackgroundThread {
  XCTestExpectation *expect = [self expectationWithDescription:@""];

  dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    MDCSnackbarManager *manager = [[MDCSnackbarManager alloc] init];
    (void)manager;
    [expect fulfill];
  });

  [self waitForExpectations:@[ expect ] timeout:kTestFakeSnackbarMessageTimeoutDuration];
}

/**
 * Tests that the default message elevation for a newly-initialized snackbar manager matches the
 * expected default value.
 */
- (void)testDefaultElevation {
  XCTAssertEqual([[MDCSnackbarManager alloc] init].messageElevation, MDCShadowElevationSnackbar);
}

/** Tests that MDCSnackBarManager's elevation setter works as expected. */
- (void)testCustomElevation {
  MDCSnackbarManager *manager = [[MDCSnackbarManager alloc] init];
  CGFloat fakeElevation = 10;

  manager.messageElevation = fakeElevation;

  XCTAssertEqual(manager.messageElevation, fakeElevation);
}

/**
 * Tests that the trait collection passed into `traitCollectionDidChange` is updated when the
 * the trait collection for a snackbar message view changes.
 */
- (void)testTraitCollectionDidChangeCalledWhenTraitCollectionChanges {
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCSnackbarMessageView *passedMessageView;
  self.managerUnderTest.traitCollectionDidChangeBlockForMessageView =
      ^(MDCSnackbarMessageView *_Nonnull inMessageView,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedMessageView = inMessageView;
        passedTraitCollection = previousTraitCollection;
        [expectation fulfill];
      };

  [self.managerUnderTest showMessage:self.message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];
  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  MDCSnackbarMessageView *messageView = self.managerUnderTest.internalManager.currentSnackbar;
  [messageView traitCollectionDidChange:testCollection];

  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedMessageView, messageView);
}

/**
 * Tests that the custom message elevation value set on a snackbar manager is used by its message
 * view.
 */
- (void)testCurrentElevationMatchesElevationWhenElevationChanges {
  self.managerUnderTest.messageElevation = 4;

  [self.managerUnderTest showMessage:self.message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];

  MDCSnackbarMessageView *messageView = self.managerUnderTest.internalManager.currentSnackbar;
  XCTAssertEqualWithAccuracy(messageView.mdc_currentElevation, 4, 0.001);
}

/**
 * Tests that overriding the base elevation for a snackbar manager configures its message view with
 * the new value.
 */
- (void)testSettingOverrideBaseElevationReturnsSetValue {
  CGFloat expectedBaseElevation = 99;

  [self.managerUnderTest showMessage:self.message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];
  self.managerUnderTest.mdc_overrideBaseElevation = expectedBaseElevation;

  MDCSnackbarMessageView *messageView = self.managerUnderTest.internalManager.currentSnackbar;
  XCTAssertEqualWithAccuracy(messageView.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

/**
 * Tests that the elevationDidChange block is called when the snackbar manager's elevation property
 * is modified.
 */
- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  self.managerUnderTest.shouldApplyStyleChangesToVisibleSnackbars = YES;
  __block BOOL blockCalled = NO;

  [self.managerUnderTest showMessage:self.message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];
  self.managerUnderTest.messageElevation = 5;
  self.managerUnderTest.mdc_elevationDidChangeBlockForMessageView =
      ^(id<MDCElevatable> _, CGFloat elevation) {
        blockCalled = YES;
      };
  self.managerUnderTest.messageElevation = self.managerUnderTest.messageElevation + 1;

  XCTAssertTrue(blockCalled);
}

/**
 * Tests that the elevationDidChange block is not called when the snackbar manager's elevation
 * property is not modified.
 */
- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  self.managerUnderTest.shouldApplyStyleChangesToVisibleSnackbars = YES;
  __block BOOL blockCalled = NO;

  [self.managerUnderTest showMessage:self.message];
  XCTestExpectation *mainQueueExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [mainQueueExpectation fulfill];
  });
  [self waitForExpectations:@[ mainQueueExpectation ] timeout:1];
  self.managerUnderTest.messageElevation = 5;
  self.managerUnderTest.mdc_elevationDidChangeBlockForMessageView =
      ^(id<MDCElevatable> _, CGFloat elevation) {
        blockCalled = YES;
      };
  self.managerUnderTest.messageElevation = self.managerUnderTest.messageElevation;

  XCTAssertFalse(blockCalled);
}

/**
 * Tests that the SnackbarManager returns true for `hasMessagesShowingOrQueued` after
 * `showMessage` is called while the manager is not in a suspended state.
 */
- (void)testShowMessage {
  __block BOOL result = NO;
  XCTestExpectation *expectation = [self expectationWithDescription:@"Snackbar state"];

  [self.managerUnderTest showMessage:self.message];
  dispatch_async(dispatch_get_main_queue(), ^{
    result = [self.managerUnderTest hasMessagesShowingOrQueued];
    [expectation fulfill];
  });

  [self waitForExpectations:@[ expectation ] timeout:kTestFakeSnackbarMessageTimeoutDuration];
  XCTAssertTrue(result);
}

/**
 * Tests that a message with a category is dismissed and its completion handler is called after
 * calling `dismissAndCallCompletionBlocksWithCategory`.
 */
- (void)testSuspendAndResumeMessage {
  self.message.category = kTestFakeSnackbarCategory;
  XCTestExpectation *completionHandlerExpectation =
      [self expectationWithDescription:@"Completion Handler called"];
  self.message.completionHandler = ^(BOOL userInitiated) {
    [completionHandlerExpectation fulfill];
  };

  [self.managerUnderTest showMessage:self.message];
  [self.managerUnderTest dismissAndCallCompletionBlocksWithCategory:kTestFakeSnackbarCategory];
  [self waitForExpectations:@[ completionHandlerExpectation ]
                    timeout:kTestFakeSnackbarMessageTimeoutDuration];

  XCTAssertFalse([self.managerUnderTest hasMessagesShowingOrQueued]);
}

@end

NS_ASSUME_NONNULL_END
