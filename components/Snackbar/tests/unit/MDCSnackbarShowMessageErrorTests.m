// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCSnackbarManager.h"
#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCSnackbarMessageInternal.h"
#pragma clang diagnostic pop

NSString *const kErrorDomain = @"com.google.mdc.snackbar";

@interface MDCFakeSnackbarMessageView : MDCSnackbarMessageView
@end

@implementation MDCFakeSnackbarMessageView
- (CABasicAnimation *_Nullable)animateSnackbarOpacityFrom:(CGFloat)fromOpacity
                                                       to:(CGFloat)toOpacity {
  return nil;
}
- (CABasicAnimation *_Nullable)animateSnackbarScaleFrom:(CGFloat)fromScale
                                                toScale:(CGFloat)toScale {
  return nil;
}
@end

@interface MDCFakeSnackbarMessage : MDCSnackbarMessage
@end

@implementation MDCFakeSnackbarMessage
- (Class)viewClass {
  return [MDCFakeSnackbarMessageView class];
}
@end

/**
 This class confirms behavior of @c Snackbar. It should create NSErrors when misconfigured.
 */
@interface MDCSnackbarErrorTests : XCTestCase
@property(nonatomic, strong) MDCSnackbarManager *manager;
@property(nonatomic, strong) MDCSnackbarMessage *message;
@property(nonatomic, strong) MDCFakeSnackbarMessage *fakeMessage;

@end

@implementation MDCSnackbarErrorTests

- (void)setUp {
  [super setUp];

  self.manager = [[MDCSnackbarManager alloc] init];

  self.message = [[MDCSnackbarMessage alloc] init];
  self.message.text = @"Snackbar Message";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;

  self.fakeMessage = [[MDCFakeSnackbarMessage alloc] init];
  self.fakeMessage.text = @"Fake Snackbar Message";
}

- (void)tearDown {
  [super tearDown];

  [self.manager dismissAndCallCompletionBlocksWithCategory:nil];
  self.fakeMessage = nil;
  self.message = nil;
  self.manager = nil;
}

/**
 Test to confirm no error returned when default snackbar manager is used.
 */
- (void)testNoErrorForSnackbarMessageDefaultManager {
  // Given
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"completed test after dispatch"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });

  // When
  [self.manager showMessage:self.message];

  // Then
  [self waitForExpectationsWithTimeout:1 handler:nil];
  XCTAssertNil(self.message.error);
}

/**
 Test to confirm that the completion handler works as expected when no error is created.
 */
- (void)testSnackbarMessageCompletionHandler {
  // Given
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed handler"];
  self.message.completionHandler = ^(BOOL userInitiated) {
    [expectation fulfill];
  };
  const CGFloat kSnackbarDuration = (CGFloat)0.1;
  self.message.duration = kSnackbarDuration;

  // When
  [self.manager showMessage:self.message];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
}

/**
 Test to confirm that the completion handler with error works as expected when no error is created.
 */
- (void)testSnackbarMessageCompletionHandlerWitheError {
  // Given
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed handler"];
  self.message.completionHandlerWithError = ^(BOOL userInitiated, NSError *_Nullable error) {
    [expectation fulfill];
  };
  const CGFloat kSnackbarDuration = (CGFloat)0.1;
  self.message.duration = kSnackbarDuration;

  // When
  [self.manager showMessage:self.message];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
}

/**
 Test to confirm that the completion handler works as expected when an error is created.
 */
- (void)testSnackbarMessageCompletionHandlerPassesErrorWhenMissconfigured {
  // Given
  __block NSError *completionError;
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed handler"];
  self.fakeMessage.completionHandlerWithError = ^(BOOL userInitiated, NSError *_Nullable error) {
    completionError = error;
    [expectation fulfill];
  };
  const CGFloat kSnackbarDuration = (CGFloat)0.1;
  self.message.duration = kSnackbarDuration;

  // When
  [self.manager showMessage:self.fakeMessage];

  // Then
  [self waitForExpectationsWithTimeout:5 handler:nil];
  XCTAssertNotNil(completionError);
  XCTAssertEqualObjects(completionError.domain, kErrorDomain);
  XCTAssertEqual(completionError.code, -10);
  MDCSnackbarMessage *message = completionError.userInfo[@"message"];
  XCTAssertNil(message.error, @"Message and error retain cycle detected");
}

@end
