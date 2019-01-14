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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MDCTextFieldSnapshotTestCase.h"
#import "SnapshotFakeMDCTextField.h"

@implementation MDCTextFieldSnapshotTestCase

- (void)setUp {
  [super setUp];

  self.textField = [[SnapshotFakeMDCTextField alloc] init];
}

- (void)removeAllSubviewsFromSuperviews:(UIView *)view {
  NSArray *subviews = [view.subviews copy];
  for (UIView *subview in subviews) {
    [self removeAllSubviewsFromSuperviews:subview];
  }
  [view removeFromSuperview];
}

- (void)tearDown {
  // This is required to invalidate any pending UITextField caret blink timers.
  // Calling `removeFromSuperview` on `self.textField` is insufficient.
  // See https://github.com/material-components/material-components-ios/issues/6181
  [self removeAllSubviewsFromSuperviews:self.textField];
  self.textField = nil;

  [super tearDown];
}

#pragma mark - Private methods

/**
 Inserts a semaphore block into the main run loop and then waits for that sempahore to be executed.
 This enables other queued actions on the main loop to issue within unit tests.  For example, it can
 allow animation blocks to execute, but does not necessarily wait for them to complete.

 Note: Although an imperfect solution, it unblocks snapshot testing for now and reduces flakiness.
 */
- (void)drainMainRunLoop {
  XCTestExpectation *expectation = [self expectationWithDescription:@"draining the main run loop"];

  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });

  [self waitForExpectationsWithTimeout:1 handler:nil];
}

#pragma mark - Helpers

- (void)triggerTextFieldLayout {
  CGSize aSize = [self.textField sizeThatFits:CGSizeMake(300, INFINITY)];
  self.textField.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [self.textField layoutIfNeeded];

  // Allow animation blocks to issue through the main run loop. This may not be sufficient for all
  // animations, but it appears to correct and deflake the rendering of long placeholder text.
  [self drainMainRunLoop];
}

- (void)generateSnapshotAndVerify {
  [self triggerTextFieldLayout];
  UIView *snapshotView = [self.textField mdc_addToBackgroundView];

  // Perform the actual verification.
  [self snapshotVerifyView:snapshotView];
}

@end
