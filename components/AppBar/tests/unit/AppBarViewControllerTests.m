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

@interface AppBarViewControllerTests : XCTestCase

@end

@implementation AppBarViewControllerTests

- (void)testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChanges {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  appBarController.traitCollectionDidChangeBlock =
      ^(MDCFlexibleHeaderViewController *_Nonnull appBarViewController,
        UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
      };

  // When
  [appBarController traitCollectionDidChange:nil];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCFlexibleHeaderViewController *passedAppBarViewController;
  appBarController.traitCollectionDidChangeBlock =
      ^(MDCFlexibleHeaderViewController *_Nonnull appBarViewController,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedAppBarViewController = appBarViewController;
        [expectation fulfill];
      };

  // When
  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  [appBarController traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedAppBarViewController, appBarController);
}

- (void)testHeaderViewElevationSetByShadowIntensityChange {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  UIScrollView *trackingScrollView = [[UIScrollView alloc] init];
  appBarController.headerView.trackingScrollView = trackingScrollView;
  appBarController.headerView.elevation = 0;
  __block BOOL blockCalled = NO;

  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Invoked mdc_elevationDidChangeBlock"];
  appBarController.headerView.mdc_elevationDidChangeBlock =
      ^(MDCFlexibleHeaderView *headerView, CGFloat elevation) {
        blockCalled = YES;
        [expectation fulfill];
      };

  // When
  [appBarController.headerView setVisibleShadowOpacity:1];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertTrue(blockCalled);
}

- (void)testShouldAdjustHeightBasedOnHeaderStackViewSetToYES {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  CGFloat navigationBarHeight =
      [appBarController.navigationBar sizeThatFits:appBarController.headerView.frame.size].height;
  CGFloat bottomBarHeight = 200;
  UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, bottomBarHeight)];
  appBarController.headerStackView.bottomBar = bottomBar;

  // When
  appBarController.shouldAdjustHeightBasedOnHeaderStackView = YES;

  // Then
  CGFloat minHeight = appBarController.headerView.minimumHeight;
  CGFloat maxHeight = appBarController.headerView.maximumHeight;
  XCTAssertEqual(minHeight, maxHeight);
  XCTAssertEqualWithAccuracy(minHeight, bottomBarHeight + navigationBarHeight, 0.01);
}

@end
