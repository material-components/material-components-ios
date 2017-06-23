/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

@import XCTest;
#import "MaterialSnackBar.h"

@interface SnackbarManagerTests : XCTestCase

@end

@implementation SnackbarManagerTests

- (void)testMessagesResumedWhenTokenIsDeallocated {
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

@end
