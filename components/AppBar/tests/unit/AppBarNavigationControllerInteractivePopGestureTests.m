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

#import "MaterialAppBar.h"

@interface AppBarNavigationControllerInteractivePopGestureTests : XCTestCase
@property(nonatomic, strong) MDCAppBarNavigationController *appBarNavigationController;
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@end

@implementation AppBarNavigationControllerInteractivePopGestureTests

- (void)setUp {
  [super setUp];

  self.appBarNavigationController = [[MDCAppBarNavigationController alloc] init];
}

- (void)tearDown {
  self.appBarNavigationController = nil;

  [super tearDown];
}

- (void)testIsNilByDefault {
  // Then
  XCTAssertNil(self.appBarNavigationController.interactivePopGestureRecognizer.delegate);
}

- (void)testIsSelfAfterViewDidLoad {
  // When
  [self.appBarNavigationController loadViewIfNeeded];

  // Then
  XCTAssertEqualObjects(self.appBarNavigationController.interactivePopGestureRecognizer.delegate,
                        self.appBarNavigationController);
}

@end
