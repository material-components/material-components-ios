// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialBottomSheet.h"

#import <XCTest/XCTest.h>

#import "MaterialShadowElevations.h"

@interface BottomSheetTests : XCTestCase
@property(nonatomic, strong, nullable) MDCBottomSheetController *bottomSheet;
@end

@implementation BottomSheetTests

- (void)setUp {
  [super setUp];

  self.bottomSheet = [[MDCBottomSheetController alloc]
      initWithContentViewController:[[UIViewController alloc] init]];
}

- (void)tearDown {
  self.bottomSheet = nil;

  [super tearDown];
}

- (void)testBottomSheetDefaults {
  // Then
  XCTAssertFalse(self.bottomSheet.shouldFlashScrollIndicatorsOnAppearance);
  XCTAssertEqualWithAccuracy(self.bottomSheet.elevation, MDCShadowElevationModalBottomSheet, 0.001);
}

- (void)testSetShowScrollIndicatorsResultsInCorrectValue {
  // When
  self.bottomSheet.shouldFlashScrollIndicatorsOnAppearance = YES;

  // Then
  XCTAssertTrue(self.bottomSheet.shouldFlashScrollIndicatorsOnAppearance);
}

- (void)testCustomShadowElevation {
  // Given
  CGFloat fakeElevation = 3;
  [self.bottomSheet loadView];
  MDCShapedView *view = nil;
  if ([self.bottomSheet.view isKindOfClass:[MDCShapedView class]]) {
    view = (MDCShapedView *)self.bottomSheet.view;
  }

  // When
  self.bottomSheet.elevation = fakeElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.bottomSheet.elevation, fakeElevation, 0.001);
  XCTAssertEqualWithAccuracy(view.elevation, fakeElevation, 0.001);
}

- (void)testBottonSheetControllerTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCBottomSheetController *bottomSheet = [[MDCBottomSheetController alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCBottomSheetController *passedBottomSheet;
  bottomSheet.traitCollectionDidChangeBlock =
      ^(MDCBottomSheetController *_Nonnull bottomSheetController,
        UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedBottomSheet = bottomSheetController;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [bottomSheet traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedBottomSheet, bottomSheet);
}

- (void)
    testBottonSheetPresentationControllerTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  UIViewController *stubPresentingViewController = [[UIViewController alloc] init];
  UIViewController *stubPresentedViewController = [[UIViewController alloc] init];
  MDCBottomSheetPresentationController *bottomSheetPresentationController =
      [[MDCBottomSheetPresentationController alloc]
          initWithPresentedViewController:stubPresentedViewController
                 presentingViewController:stubPresentingViewController];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCBottomSheetPresentationController *passedBottomSheetPresentationController;
  bottomSheetPresentationController.traitCollectionDidChangeBlock =
      ^(MDCBottomSheetPresentationController *_Nonnull presentationController,
        UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedBottomSheetPresentationController = presentationController;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [bottomSheetPresentationController traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedBottomSheetPresentationController, bottomSheetPresentationController);
}

@end
