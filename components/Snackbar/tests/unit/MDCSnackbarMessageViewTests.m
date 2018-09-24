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

#import "MaterialSnackbar.h"
#import "supplemental/MDCFakeMDCSnackbarManagerDelegate.h"

#import "../../src/private/MDCSnackbarManagerInternal.h"
#import "../../src/private/MDCSnackbarOverlayView.h"

@interface MDCSnackbarManagerInternal (Testing)
@property(nonatomic) MDCSnackbarOverlayView *overlayView;
@property(nonatomic) BOOL isVoiceOverRunningOverride;
@end
@interface MDCSnackbarManager (Testing)
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end
@interface MDCSnackbarMessageView (Testing)
@property(nonatomic, strong) UILabel *label;
@end

@interface MDCSnackbarMessageViewTests : XCTestCase
@property(nonatomic, strong) MDCSnackbarManager *manager;
@property(nonatomic, strong) FakeMDCSnackbarManagerDelegate *delegate;
@property(nonatomic, strong) MDCSnackbarMessage *message;
@end

@implementation MDCSnackbarMessageViewTests

- (void)setUp {
  [super setUp];

  self.manager = [[MDCSnackbarManager alloc] init];
  self.delegate = [[FakeMDCSnackbarManagerDelegate alloc] init];
  self.manager.delegate = self.delegate;
  self.message = [MDCSnackbarMessage messageWithText:@"message text"];
}

- (void)testDefaultColors {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];

  // Then
  XCTAssertEqualObjects(messageView.snackbarMessageViewBackgroundColor,
                        [UIColor colorWithRed:(float)(0x32 / 255.0)
                                        green:(float)(0x32 / 255.0)
                                         blue:(float)(0x32 / 255.0)
                                        alpha:1]);
  XCTAssertEqualObjects(messageView.snackbarMessageViewShadowColor, UIColor.blackColor);
  XCTAssertEqualObjects(messageView.messageTextColor, UIColor.whiteColor);
}

- (void)testAccessibilityLabelDefaultIsNil {
  // When
  [self.manager showMessage:self.message];

  // Then
  XCTAssertNil(self.delegate.presentedView.label.accessibilityLabel);
}

- (void)testAccessibilityLabelSetFromSnackbarMessageProperty {
  // When
  self.message.accessibilityLabel = @"not message text";
  [self.manager showMessage:self.message];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

  // Then
  XCTAssertEqualObjects(self.delegate.presentedView.label.accessibilityLabel,
                        self.message.accessibilityLabel);
}

- (void)testAccessibilityHintDefaultIsNotNil {
  // When
  [self.manager showMessage:self.message];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

  // Then
  XCTAssertNotNil(self.delegate.presentedView.label.accessibilityHint);
}

- (void)testAccessibilityHintSetFromSnackbarMessageProperty {
  // When
  self.message.accessibilityHint = @"a hint";
  [self.manager showMessage:self.message];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

  // Then
  XCTAssertEqualObjects(self.delegate.presentedView.label.accessibilityHint,
                        self.message.accessibilityHint);
}

- (void)testSnackbarSetAccessibiltyViewIsModalForActionSnacbars {
  // Given
  self.manager.internalManager.isVoiceOverRunningOverride = YES;
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;
  self.manager.shouldEnableAccessibilityViewIsModal = YES;

  // When
  [self.manager showMessage:self.message];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

  // Then
  XCTAssertTrue(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testSnackbarAccessibiltyViewIsModalShouldBeNoWithNoActions {
  // Given
  self.manager.shouldEnableAccessibilityViewIsModal = YES;

  // When
  [self.manager showMessage:self.message];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

  // Then
  XCTAssertFalse(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testSnackbarSetAccessibiltyViewIsModalShouldBeNoForActionSnacbarsWhenManagerIsNo {
  // Given
  self.manager.internalManager.isVoiceOverRunningOverride = YES;
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;
  self.manager.shouldEnableAccessibilityViewIsModal = NO;

  // When
  [self.manager showMessage:self.message];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

  // Then
  XCTAssertFalse(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testSnackbarAccessibiltyViewIsModalShouldBeNoByDefault {
  // Given
  self.manager.shouldEnableAccessibilityViewIsModal = NO;

  // When
  [self.manager showMessage:self.message];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

  // Then
  XCTAssertFalse(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

@end
