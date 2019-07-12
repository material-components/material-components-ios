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
#import "MaterialSnackbar.h"

#import "../../src/private/MDCSnackbarManagerInternal.h"

@interface MDCSnackbarManagerInternal (Testing)
@property(nonatomic) MDCSnackbarMessageView *currentSnackbar;
@end

@interface MDCSnackbarManager (Testing)
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end

@interface SnackbarManagerTests : XCTestCase
@end

@implementation SnackbarManagerTests

- (void)tearDown {
  [MDCSnackbarManager dismissAndCallCompletionBlocksWithCategory:nil];
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
    id<MDCSnackbarSuspensionToken> token = [MDCSnackbarManager suspendAllMessages];
    [MDCSnackbarManager showMessage:suspendedMessage];

    // When
    token = nil;
  }

  // Then
  [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)testHasMessagesShowingOrQueued {
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"foo1"];
  message.duration = 10;
  [MDCSnackbarManager showMessage:message];

  XCTestExpectation *expectation = [self expectationWithDescription:@"has_shown_message"];

  // We need to dispatch_async in order to assure that the assertion happens after showMessage:
  // actually displays the message.
  dispatch_async(dispatch_get_main_queue(), ^{
    XCTAssertTrue([MDCSnackbarManager hasMessagesShowingOrQueued]);
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

- (void)testTraitCollectionDidChangeCalledWhenCurrentSnackbarTraitCollectionChanges {
  // Given
  MDCSnackbarManager *manager = [[MDCSnackbarManager alloc] init];
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"test"];

  XCTestExpectation *traitCollectionExpectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCSnackbarMessageView *passedMessageView;
  manager.traitCollectionDidChangeBlock =
      ^(MDCSnackbarMessageView *_Nonnull messageView,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedMessageView = messageView;
        passedTraitCollection = previousTraitCollection;
        [traitCollectionExpectation fulfill];
      };

  // When
  [manager showMessage:message];
  XCTestExpectation *showExpectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [showExpectation fulfill];
  });
  [self waitForExpectations:@[ showExpectation ] timeout:1];

  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  [manager.internalManager.currentSnackbar traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ traitCollectionExpectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedMessageView, manager.internalManager.currentSnackbar);
}

@end
