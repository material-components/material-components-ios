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

#import "../../src/private/MDCFlexibleHeaderTopSafeArea.h"
#import "MaterialFlexibleHeader.h"

@interface FlexibleHeaderTopSafeAreaTests : XCTestCase
@end

@interface FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate
    : NSObject <MDCFlexibleHeaderSafeAreaDelegate>
@property(nonatomic) BOOL isStatusBarShifted;
@property(nonatomic) BOOL topSafeAreaInsetDidChangeWasCalled;
@end

@interface FlexibleHeaderTopSafeAreaTestsFakeViewController : UIViewController
@property(nonatomic) CGFloat topSafeAreaInset;
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

#pragma mark - inferTopSafeAreaInsetFromViewController disabled

- (void)testDefaultConfiguration {
  // Then
  XCTAssertNil(_topSafeArea.topSafeAreaSourceViewController);
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 20, 0.0001);
  XCTAssertFalse(_topSafeArea.inferTopSafeAreaInsetFromViewController);
  XCTAssertNil(_topSafeArea.delegate);
}

- (void)testDidChangeInvokesDelegate {
  // Given
  _topSafeArea.delegate = _delegate;

  // When
  [_topSafeArea safeAreaInsetsDidChange];

  // Then
  XCTAssertTrue(_delegate.topSafeAreaInsetDidChangeWasCalled);
}

- (void)testSettingViewControllerDoesNotInvokeDelegate {
  // Given
  _topSafeArea.delegate = _delegate;
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];

  // When
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // Then
  XCTAssertFalse(_delegate.topSafeAreaInsetDidChangeWasCalled);
}

- (void)testIgnoresViewControllerTopSafeAreaInset {
  // Given
  FlexibleHeaderTopSafeAreaTestsFakeViewController *viewController =
      [[FlexibleHeaderTopSafeAreaTestsFakeViewController alloc] init];
  viewController.topSafeAreaInset = 44;

  // When
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 20, 0.0001);
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
  _topSafeArea.delegate = _delegate;
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
  _topSafeArea.delegate = _delegate;
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
  _topSafeArea.topSafeAreaSourceViewController = viewController;

  // Then
  XCTAssertEqualWithAccuracy(_topSafeArea.topSafeAreaInset, 44, 0.0001);
}

@end

#pragma mark - Fake implementations

@implementation FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate

#pragma mark MDCFlexibleHeaderTopSafeAreaDelegate

- (BOOL)flexibleHeaderSafeAreaIsStatusBarShifted:(MDCFlexibleHeaderTopSafeArea *)safeAreas {
  return self.isStatusBarShifted;
}

- (void)flexibleHeaderSafeAreaTopSafeAreaInsetDidChange:(MDCFlexibleHeaderTopSafeArea *)safeAreas {
  self.topSafeAreaInsetDidChangeWasCalled = YES;
}

@end

@interface FlexibleHeaderTopSafeAreaTestsFakeView : UIView
@property(nonatomic) CGFloat topSafeAreaInset;
@end

@interface FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide : NSObject <UILayoutSupport>
@property(nonatomic) CGFloat topSafeAreaInset;
@end

@interface FlexibleHeaderTopSafeAreaTestsFakeViewController ()
@property(nonatomic, strong) FlexibleHeaderTopSafeAreaTestsFakeView *view;
@end

@implementation FlexibleHeaderTopSafeAreaTestsFakeViewController {
  FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide *_topLayoutGuide;
}

@dynamic view;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _topLayoutGuide = [[FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide alloc] init];
  }
  return self;
}

- (void)loadView {
  [super loadView];

  self.view = [[FlexibleHeaderTopSafeAreaTestsFakeView alloc] initWithFrame:self.view.bounds];
}

- (id<UILayoutSupport>)topLayoutGuide {
  return _topLayoutGuide;
}

- (FlexibleHeaderTopSafeAreaTestsFakeView *)view {
  return (FlexibleHeaderTopSafeAreaTestsFakeView *)[super view];
}

- (void)setTopSafeAreaInset:(CGFloat)topSafeAreaInset {
  self.view.topSafeAreaInset = topSafeAreaInset;
  _topLayoutGuide.topSafeAreaInset = topSafeAreaInset;
}

- (CGFloat)topSafeAreaInset {
  return self.view.topSafeAreaInset;
}

@end

@implementation FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide

@synthesize bottomAnchor;
@synthesize heightAnchor;
@synthesize length;
@synthesize topAnchor;

- (CGFloat)length {
  return self.topSafeAreaInset;
}

@end

@implementation FlexibleHeaderTopSafeAreaTestsFakeView

- (UIEdgeInsets)safeAreaInsets {
  UIEdgeInsets safeAreaInsets = [super safeAreaInsets];
  safeAreaInsets.top = self.topSafeAreaInset;
  return safeAreaInsets;
}

@end
