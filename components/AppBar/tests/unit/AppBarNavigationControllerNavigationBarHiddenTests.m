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

@interface AppBarNavigationControllerNavigationBarHiddenTests : XCTestCase
@end

@implementation AppBarNavigationControllerNavigationBarHiddenTests

- (void)testDefaultIsHidden {
  // Given
  MDCAppBarNavigationController *appBarNavigationController =
      [[MDCAppBarNavigationController alloc] init];

  // Then
  XCTAssertTrue(appBarNavigationController.navigationBarHidden);
}

- (void)testStillHiddenAfterSettingNavigationBarHidden {
  // Given
  MDCAppBarNavigationController *appBarNavigationController =
      [[MDCAppBarNavigationController alloc] init];

  // When
  appBarNavigationController.navigationBarHidden = YES;

  // Then
  XCTAssertTrue(appBarNavigationController.navigationBarHidden);
}

- (void)testStillHiddenAfterSettingNavigationBarHiddenAnimated {
  // Given
  MDCAppBarNavigationController *appBarNavigationController =
  [[MDCAppBarNavigationController alloc] init];

  // When
  [appBarNavigationController setNavigationBarHidden:YES animated:YES];

  // Then
  XCTAssertTrue(appBarNavigationController.navigationBarHidden);
}

@end