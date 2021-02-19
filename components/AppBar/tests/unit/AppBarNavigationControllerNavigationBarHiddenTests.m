// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialAppBar.h"
#import "MaterialFlexibleHeader.h"

@interface AppBarNavigationControllerNavigationBarHiddenTests : XCTestCase
@property(nonatomic, strong) MDCAppBarNavigationController *appBarNavigationController;
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@end

@implementation AppBarNavigationControllerNavigationBarHiddenTests

- (void)setUp {
  [super setUp];

  self.appBarNavigationController = [[MDCAppBarNavigationController alloc] init];
  self.appBarNavigationController.shouldSetNavigationBarHiddenHideAppBar = NO;
  [self.appBarNavigationController pushViewController:[[UIViewController alloc] init] animated:NO];
  self.appBarViewController = [self.appBarNavigationController
      appBarViewControllerForViewController:self.appBarNavigationController.visibleViewController];
}

- (void)tearDown {
  self.appBarNavigationController = nil;

  [super tearDown];
}

- (void)testDefaultIsHidden {
  // Then
  XCTAssertTrue(self.appBarNavigationController.navigationBarHidden);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.appBarViewController.headerView.frame), 0, 0.001);
}

- (void)testStillHiddenAfterSettingNavigationBarHidden {
  // When
  self.appBarNavigationController.navigationBarHidden = YES;

  // Then
  XCTAssertTrue(self.appBarNavigationController.navigationBarHidden);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.appBarViewController.headerView.frame), 0, 0.001);
}

- (void)testStillHiddenAfterSettingNavigationBarHiddenAnimated {
  // When
  [self.appBarNavigationController setNavigationBarHidden:YES animated:YES];

  // Then
  XCTAssertTrue(self.appBarNavigationController.navigationBarHidden);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.appBarViewController.headerView.frame), 0, 0.001);
}

// Note: it is not possible to write tests for `navigationBarHidden = NO;` because this throws an
// assertion.

@end
