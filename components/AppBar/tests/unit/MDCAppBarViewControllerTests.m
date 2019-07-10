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

#import "MDCAppBarViewController.h"

@interface MDCAppBarViewControllerTests : XCTestCase

@end

@implementation MDCAppBarViewControllerTests

- (void)testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChanges {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  appBarController.traitCollectionDidChangeBlock =
      ^(UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
      };

  // When
  [appBarController traitCollectionDidChange:nil];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedPreviousTraitCollection {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  appBarController.traitCollectionDidChangeBlock =
      ^(UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        [expectation fulfill];
      };

  // When
  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  [appBarController traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
}

@end
