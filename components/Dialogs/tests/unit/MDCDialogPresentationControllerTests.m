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

#import "MaterialDialogs.h"

@interface MDCDialogPresentationControllerTests : XCTestCase

@end

@implementation MDCDialogPresentationControllerTests

- (void)testTraitCollectionDidChangeCalledWithCorrectParameters {
  // Given
  UIViewController *presentedViewController = [[UIViewController alloc] init];
  UIViewController *presentingViewController = [[UIViewController alloc] init];
  MDCDialogPresentationController *presentationController = [[MDCDialogPresentationController alloc]
      initWithPresentedViewController:presentedViewController
             presentingViewController:presentingViewController];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];

  __block UITraitCollection *passedTraitCollection;
  __block MDCDialogPresentationController *passedPresentationController;
  presentationController.traitCollectionDidChangeBlock =
      ^(MDCDialogPresentationController *_Nonnull presentationControllerInBlock,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedPresentationController = presentationControllerInBlock;
        [expectation fulfill];
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [presentationController traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedPresentationController, presentationController);
}

@end
