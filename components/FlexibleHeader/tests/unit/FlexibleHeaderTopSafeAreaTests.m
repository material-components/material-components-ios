/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import <XCTest/XCTest.h>

#import "MDCFlexibleHeaderTopSafeArea.h"
#import "FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate.h"
#import "FlexibleHeaderTopSafeAreaTestsFakeViewController.h"

@interface FlexibleHeaderTopSafeAreaTests : XCTestCase
@end

@implementation FlexibleHeaderTopSafeAreaTests {
  MDCFlexibleHeaderTopSafeArea *_topSafeArea;
  FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate *_delegate;
}

- (void)setUp {
  [super setUp];

  _topSafeArea = [[MDCFlexibleHeaderTopSafeArea alloc] init];
  _delegate = [[FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate alloc] init];
}

- (void)tearDown {
  _topSafeArea = nil;
  _delegate = nil;

  [super tearDown];
}

#pragma mark - When inferTopSafeAreaInsetFromViewController is disabled

- (void)testDeviceSafeAreaInsetIsDefaultTopSafeAreaInset {
  // Given
  const CGFloat deviceTopSafeAreaInset = 123;
  _delegate.deviceTopSafeAreaInset = deviceTopSafeAreaInset;
  _topSafeArea.topSafeAreaDelegate = _delegate;

  // Then
  XCTAssertNil(_topSafeArea.topSafeAreaSourceViewController);
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, deviceTopSafeAreaInset, 0.0001);
  XCTAssertFalse(_topSafeArea.inferTopSafeAreaInsetFromViewController);
}

- (void)testIgnoresViewControllerTopSafeAreaInset {
  // Given
  const CGFloat deviceTopSafeAreaInset = 123;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  viewController.topSafeAreaInset = 44;
  _delegate.deviceTopSafeAreaInset = deviceTopSafeAreaInset;
  _topSafeArea.topSafeAreaDelegate = _delegate;

  // When
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, deviceTopSafeAreaInset, 0.0001);
}

#pragma mark - Delegate invocations

- (void)testDidChangeInvokesDelegate {
  // Given
  _topSafeArea.topSafeAreaDelegate = _delegate;

  // When
  [_topSafeArea safeAreaInsetsDidChange];

  // Then
  XCTAssertTrue(_delegate.topSafeAreaInsetDidChangeWasCalled);
}

- (void)testSettingViewControllerDoesNotInvokeDelegate {
  // Given
  _topSafeArea.topSafeAreaDelegate = _delegate;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];

  // When
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // Then
  XCTAssertFalse(_delegate.topSafeAreaInsetDidChangeWasCalled);
}

#pragma mark - inferTopSafeAreaInsetFromViewController enabled

- (void)testTopSafeAreaInsetIsZeroWithNilViewController {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 0, 0.0001);
}

- (void)testTopSafeAreaInsetMatchesViewController {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  viewController.topSafeAreaInset = 44;

  // When
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 44, 0.0001);
}

- (void)testTopSafeAreaInsetNotUpdatedWithoutCallToSafeAreaInsetsDidChange {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // When
  viewController.topSafeAreaInset = 44;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 0, 0.0001);
}

- (void)testTopSafeAreaInsetUpdatedAfterCallToSafeAreaInsetsDidChange {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // When
  viewController.topSafeAreaInset = 44;
  [_topSafeArea safeAreaInsetsDidChange];

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 44, 0.0001);
}

// This test simulates a non-notch device hiding its status bar in reaction to the flexible header
// shifting off-screen. In this case the top safe area inset should stay "pinned" to the previous
// known value (of 20).
- (void)testTopSafeAreaInsetDoesNotChangeWhileStatusBarIsShiftedWithNonNotchSafeAreaSize {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;
  _topSafeArea.topSafeAreaDelegate = _delegate;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  viewController.topSafeAreaInset = 20;
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // When
  _delegate.isStatusBarShifted = YES;
  viewController.topSafeAreaInset = 0;
  [_topSafeArea safeAreaInsetsDidChange];

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 20, 0.0001);
}

- (void)testTopSafeAreaInsetDoesChangeWhileStatusBarIsShiftedWithAnyOtherSize {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;
  _topSafeArea.topSafeAreaDelegate = _delegate;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  viewController.topSafeAreaInset = 44;
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // When
  _delegate.isStatusBarShifted = YES;
  viewController.topSafeAreaInset = 0;
  [_topSafeArea safeAreaInsetsDidChange];

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 0, 0.0001);
}

- (void)testTopSafeAreaInsetResetsToZeroWhenViewControllerIsSetToNil {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  viewController.topSafeAreaInset = 44;
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // When
  _topSafeArea.topSafeAreaSourceViewController = nil;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 0, 0.0001);
}

- (void)testTopSafeAreaInsetResetsToViewControllerWhenViewControllerIsNilThenReSet {
  // Given
  _topSafeArea.inferTopSafeAreaInsetFromViewController = YES;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  viewController.topSafeAreaInset = 44;
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // When
  _topSafeArea.topSafeAreaSourceViewController = nil;
  viewController.topSafeAreaInset = 88;
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 88, 0.0001);
}

@end
