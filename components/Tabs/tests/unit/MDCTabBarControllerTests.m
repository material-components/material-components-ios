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

#import "MaterialTabs.h"

@interface MDCTabBarViewControllerTests : XCTestCase

@end

@implementation MDCTabBarViewControllerTests

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCTabBarViewController *testTabBarController = [[MDCTabBarViewController alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCTabBarViewController *passedTabBarController = nil;
  testTabBarController.traitCollectionDidChangeBlock =
      ^(MDCTabBarViewController *_Nonnull tabBarViewController,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedTabBarController = tabBarViewController;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [testTabBarController traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTabBarController, testTabBarController);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

@end
