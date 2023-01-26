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
#import "MDCFakeMDCSnackbarManagerDelegate.h"

@interface MDCSnackbarManagerInstanceTests : XCTestCase

@property(nonatomic, strong) UIColor *messageTextColor;
@property(nonatomic, strong) UIColor *snackbarMessageViewShadowColor;
@property(nonatomic, strong) UIColor *snackbarMessageViewBackgroundColor;
@property(nonatomic, strong) NSMutableDictionary *titleColorForState;

@end

@implementation MDCSnackbarManagerInstanceTests

// The fact that MDCSnackbarManager.defaultInstance is a singleton means it's incredibly hard to
// test correctly. The -setUp and -tearDown methods below attempt to save/restore the
// defaultManager's tested state as well as possible. If either these tests or any of the "default"
// styling tests begin to flake/fail, it's probably best to remove these methods as well as
// -testClassPropertiesAssignToDefaultInstance .

- (void)setUp {
  [super setUp];

  self.messageTextColor = MDCSnackbarManager.defaultManager.messageTextColor;
  self.snackbarMessageViewShadowColor =
      MDCSnackbarManager.defaultManager.snackbarMessageViewShadowColor;
  self.snackbarMessageViewBackgroundColor =
      MDCSnackbarManager.defaultManager.snackbarMessageViewBackgroundColor;
  self.titleColorForState = [@{} mutableCopy];
  NSUInteger maxState = UIControlStateNormal | UIControlStateDisabled | UIControlStateSelected |
                        UIControlStateHighlighted;
  for (NSUInteger state = 0; state < maxState; ++state) {
    self.titleColorForState[@(state)] =
        [MDCSnackbarManager.defaultManager buttonTitleColorForState:state];
  }
}

- (void)tearDown {
  // Restore the Snackbar Manager's state
  MDCSnackbarManager.defaultManager.messageTextColor = self.messageTextColor;
  MDCSnackbarManager.defaultManager.snackbarMessageViewShadowColor =
      self.snackbarMessageViewShadowColor;
  MDCSnackbarManager.defaultManager.snackbarMessageViewBackgroundColor =
      self.snackbarMessageViewBackgroundColor;
  for (NSNumber *state in self.titleColorForState.allKeys) {
    if (self.titleColorForState[state] != nil) {
      [MDCSnackbarManager.defaultManager setButtonTitleColor:self.titleColorForState[state]
                                                    forState:state.unsignedIntegerValue];
    }
  }

  // Clean-up the test case
  [self.titleColorForState removeAllObjects];
  self.messageTextColor = nil;
  self.snackbarMessageViewShadowColor = nil;
  self.snackbarMessageViewBackgroundColor = nil;

  [super tearDown];
}

- (void)testTwoInitializationsProvideTwoObjects {
  // When
  MDCSnackbarManager *manager1 = [[MDCSnackbarManager alloc] init];
  MDCSnackbarManager *manager2 = [[MDCSnackbarManager alloc] init];

  // Then
  XCTAssertNotEqual(manager1, manager2);
}

- (void)testDefaultInstanceIsTheSame {
  // Given
  MDCSnackbarManager *manager = MDCSnackbarManager.defaultManager;

  // Then
  XCTAssertEqual(MDCSnackbarManager.defaultManager, manager);
}

- (void)testClassPropertiesAssignToDefaultInstance {
  // Given
  MDCSnackbarManager *manager = MDCSnackbarManager.defaultManager;
  FakeMDCSnackbarManagerDelegate *delegate = [[FakeMDCSnackbarManagerDelegate alloc] init];

  // When
  MDCSnackbarManager.defaultManager.horizontalAlignment = MDCSnackbarHorizontalAlignmentLeading;
  MDCSnackbarManager.defaultManager.buttonFont = [UIFont systemFontOfSize:72];
  MDCSnackbarManager.defaultManager.delegate = delegate;
  MDCSnackbarManager.defaultManager.messageFont = [UIFont systemFontOfSize:66];
  MDCSnackbarManager.defaultManager.messageTextColor = UIColor.orangeColor;
  MDCSnackbarManager.defaultManager.shouldApplyStyleChangesToVisibleSnackbars = YES;
  MDCSnackbarManager.defaultManager.snackbarMessageViewBackgroundColor = UIColor.brownColor;
  MDCSnackbarManager.defaultManager.snackbarMessageViewShadowColor = UIColor.purpleColor;
  [MDCSnackbarManager.defaultManager setButtonTitleColor:UIColor.greenColor
                                                forState:UIControlStateDisabled];

  // Then
  XCTAssertEqual(manager.horizontalAlignment,
                 MDCSnackbarManager.defaultManager.horizontalAlignment);
  XCTAssertEqualObjects(manager.buttonFont, MDCSnackbarManager.defaultManager.buttonFont);
  XCTAssertEqual(manager.delegate, MDCSnackbarManager.defaultManager.delegate);
  XCTAssertEqualObjects(manager.messageFont, MDCSnackbarManager.defaultManager.messageFont);
  XCTAssertEqual(manager.messageTextColor, MDCSnackbarManager.defaultManager.messageTextColor);
  XCTAssertEqual(manager.shouldApplyStyleChangesToVisibleSnackbars,
                 MDCSnackbarManager.defaultManager.shouldApplyStyleChangesToVisibleSnackbars);
  XCTAssertEqual(manager.snackbarMessageViewBackgroundColor,
                 MDCSnackbarManager.defaultManager.snackbarMessageViewBackgroundColor);
  XCTAssertEqual(manager.snackbarMessageViewShadowColor,
                 MDCSnackbarManager.defaultManager.snackbarMessageViewShadowColor);
  XCTAssertEqual(
      [manager buttonTitleColorForState:UIControlStateDisabled],
      [MDCSnackbarManager.defaultManager buttonTitleColorForState:UIControlStateDisabled]);
}

- (void)testInstancesDoNotSharePropertyStorage {
  // Given
  MDCSnackbarManager *manager1 = [[MDCSnackbarManager alloc] init];
  MDCSnackbarManager *manager2 = [[MDCSnackbarManager alloc] init];
  FakeMDCSnackbarManagerDelegate *delegate1 = [[FakeMDCSnackbarManagerDelegate alloc] init];
  FakeMDCSnackbarManagerDelegate *delegate2 = [[FakeMDCSnackbarManagerDelegate alloc] init];

  // When
  manager1.horizontalAlignment = MDCSnackbarHorizontalAlignmentLeading;
  manager2.horizontalAlignment = MDCSnackbarHorizontalAlignmentCenter;
  manager1.buttonFont = [UIFont systemFontOfSize:72];
  manager2.buttonFont = [UIFont systemFontOfSize:41];
  manager1.delegate = delegate1;
  manager2.delegate = delegate2;
  manager1.messageFont = [UIFont systemFontOfSize:66];
  manager2.messageFont = [UIFont systemFontOfSize:33];
  manager1.messageTextColor = UIColor.orangeColor;
  manager2.messageTextColor = UIColor.blueColor;
  manager1.shouldApplyStyleChangesToVisibleSnackbars = YES;
  manager2.shouldApplyStyleChangesToVisibleSnackbars = NO;
  manager1.snackbarMessageViewBackgroundColor = UIColor.brownColor;
  manager2.snackbarMessageViewBackgroundColor = UIColor.yellowColor;
  manager1.snackbarMessageViewShadowColor = UIColor.purpleColor;
  manager2.snackbarMessageViewShadowColor = UIColor.cyanColor;
  [manager1 setButtonTitleColor:UIColor.greenColor forState:UIControlStateDisabled];
  [manager2 setButtonTitleColor:UIColor.magentaColor forState:UIControlStateDisabled];

  // Then
  XCTAssertNotEqual(manager1.horizontalAlignment, manager2.horizontalAlignment);
  XCTAssertNotEqual(manager1.buttonFont, manager2.buttonFont);
  XCTAssertNotEqual(manager1.delegate, manager2.delegate);
  XCTAssertNotEqual(manager1.messageFont, manager2.messageFont);
  XCTAssertNotEqual(manager1.messageTextColor, manager2.messageTextColor);
  XCTAssertNotEqual(manager1.shouldApplyStyleChangesToVisibleSnackbars,
                    manager2.shouldApplyStyleChangesToVisibleSnackbars);
  XCTAssertNotEqual(manager1.snackbarMessageViewBackgroundColor,
                    manager2.snackbarMessageViewBackgroundColor);
  XCTAssertNotEqual(manager1.snackbarMessageViewShadowColor,
                    manager2.snackbarMessageViewShadowColor);
  XCTAssertNotEqual([manager1 buttonTitleColorForState:UIControlStateDisabled],
                    [manager2 buttonTitleColorForState:UIControlStateDisabled]);
}

@end
