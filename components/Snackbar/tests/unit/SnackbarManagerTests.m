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
#import <MaterialComponents/MaterialSnackbar.h>

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

@end
