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

#import "MaterialNavigationDrawer.h"

#import "../../src/private/MDCBottomDrawerContainerViewController.h"
#import "MDCNavigationDrawerFakes.h"

@interface MDCBottomDrawerContainerViewController (MDCBottomDrawerHeaderTesting)
- (void)updateViewWithContentOffset:(CGPoint)contentOffset;
@end

@interface MDCBottomDrawerPresentationController (MDCBottomDrawerHeaderTesting)
@property(nonatomic) MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController;
@end

@interface MDCNavigationDrawerTest : XCTestCase
@property(nonatomic, strong) MDCBottomDrawerViewController *navigationDrawer;
@end

@implementation MDCNavigationDrawerTest

- (void)setUp {
  [super setUp];

  MDCNavigationDrawerFakeTableViewController *fakeTableViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.navigationDrawer = [[MDCBottomDrawerViewController alloc] init];
  self.navigationDrawer.headerViewController = fakeHeader;
  self.navigationDrawer.contentViewController = fakeTableViewController;
  self.navigationDrawer.trackingScrollView = fakeTableViewController.tableView;
}

- (void)tearDown {
  self.navigationDrawer = nil;

  [super tearDown];
}

- (void)testScrimColor {
  // Given
  UIColor *customColor = UIColor.blueColor;

  // When
  self.navigationDrawer.scrimColor = customColor;

  // Then
  if ([self.navigationDrawer.presentationController
          isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *presentationController =
        (MDCBottomDrawerPresentationController *)self.navigationDrawer.presentationController;
    XCTAssertEqualObjects(presentationController.scrimColor, customColor);
  } else {
    XCTFail(@"Navigation Drawer isn't using MDCBottomDrawerPresentationController as it's "
            @"presentationController");
  }
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCBottomDrawerViewController *passedBottomDrawer = nil;
  self.navigationDrawer.traitCollectionDidChangeBlock =
      ^(MDCBottomDrawerViewController *_Nonnull navigationDrawer,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedBottomDrawer = navigationDrawer;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.navigationDrawer traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedBottomDrawer, self.navigationDrawer);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Then
  XCTAssertLessThan(self.navigationDrawer.mdc_overrideBaseElevation, 0);
}

- (void)testCurrentElevationMatchesElevationWhenElevationChanges {
  // When
  self.navigationDrawer.elevation = 4;

  // Then
  XCTAssertEqualWithAccuracy(self.navigationDrawer.mdc_currentElevation,
                             self.navigationDrawer.elevation, 0.001);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat expectedBaseElevation = 99;

  // When
  self.navigationDrawer.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.navigationDrawer.mdc_overrideBaseElevation, expectedBaseElevation,
                             0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  self.navigationDrawer.elevation = 5;
  __block BOOL blockCalled = NO;
  self.navigationDrawer.mdc_elevationDidChangeBlock =
      ^(MDCBottomDrawerViewController *object, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  self.navigationDrawer.elevation = self.navigationDrawer.elevation + 1;

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  self.navigationDrawer.elevation = 5;
  __block BOOL blockCalled = NO;
  self.navigationDrawer.mdc_elevationDidChangeBlock =
      ^(MDCBottomDrawerViewController *object, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  self.navigationDrawer.elevation = self.navigationDrawer.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testSettingShouldAlwaysExpandHeader {
  // When
  self.navigationDrawer.shouldAlwaysExpandHeader = YES;

  // Then
  XCTAssertTrue(self.navigationDrawer.shouldAlwaysExpandHeader);
  if ([self.navigationDrawer.presentationController
          isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *presentationController =
        (MDCBottomDrawerPresentationController *)self.navigationDrawer.presentationController;
    XCTAssertTrue(presentationController.shouldAlwaysExpandHeader);
  } else {
    XCTFail(@"The presentation controller should be class of kind "
            @"MDCBottomDrawerPresentationController but is %@",
            self.navigationDrawer.presentationController.class);
  }
}

- (void)testShouldIncludeSafeAreaInContentHeight {
  // When
  self.navigationDrawer.shouldIncludeSafeAreaInContentHeight = YES;

  // Then
  XCTAssertTrue(self.navigationDrawer.shouldIncludeSafeAreaInContentHeight);
  if ([self.navigationDrawer.presentationController
          isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *presentationController =
        (MDCBottomDrawerPresentationController *)self.navigationDrawer.presentationController;
    XCTAssertTrue(presentationController.shouldIncludeSafeAreaInContentHeight);
  } else {
    XCTFail(@"The presentation controller should be class of kind "
            @"MDCBottomDrawerPresentationController but is %@",
            self.navigationDrawer.presentationController.class);
  }
}

- (void)testShouldIncludeSafeAreaInInitialDrawerHeight {
  // When
  self.navigationDrawer.shouldIncludeSafeAreaInInitialDrawerHeight = YES;

  // Then
  XCTAssertTrue(self.navigationDrawer.shouldIncludeSafeAreaInInitialDrawerHeight);
  if ([self.navigationDrawer.presentationController
          isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *presentationController =
        (MDCBottomDrawerPresentationController *)self.navigationDrawer.presentationController;
    XCTAssertTrue(presentationController.shouldIncludeSafeAreaInInitialDrawerHeight);
  } else {
    XCTFail(@"The presentation controller should be class of kind "
            @"MDCBottomDrawerPresentationController but is %@",
            self.navigationDrawer.presentationController.class);
  }
}

- (void)testShouldUseStickyStatusBar {
  // When
  self.navigationDrawer.shouldUseStickyStatusBar = YES;

  // Then
  XCTAssertTrue(self.navigationDrawer.shouldUseStickyStatusBar);
  if ([self.navigationDrawer.presentationController
          isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *presentationController =
        (MDCBottomDrawerPresentationController *)self.navigationDrawer.presentationController;
    XCTAssertTrue(presentationController.shouldUseStickyStatusBar);
  } else {
    XCTFail(@"The presentation controller should be class of kind "
            @"MDCBottomDrawerPresentationController but is %@",
            self.navigationDrawer.presentationController.class);
  }
}

- (void)testHeaderHeightWhenShouldAlwaysExpandEnabledAndScrollOccured {
  // Given
  self.navigationDrawer.shouldAlwaysExpandHeader = YES;
  self.navigationDrawer.headerViewController.preferredContentSize = CGSizeMake(100, 200);
  self.navigationDrawer.contentViewController.preferredContentSize = CGSizeMake(100, 200);
  [self.navigationDrawer.presentationController presentationTransitionWillBegin];
  CGFloat originalHeaderHeight =
      CGRectGetHeight(self.navigationDrawer.headerViewController.view.frame);

  // When
  if ([self.navigationDrawer.presentationController
          isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *presentationController =
        (MDCBottomDrawerPresentationController *)self.navigationDrawer.presentationController;
    [presentationController.bottomDrawerContainerViewController
        updateViewWithContentOffset:CGPointMake(0, 400)];
  } else {
    XCTFail(@"The presentation controller should be class of kind "
            @"MDCBottomDrawerPresentationController but is %@",
            self.navigationDrawer.presentationController.class);
  }

  // Then
  CGFloat newHeaderHeight = CGRectGetHeight(self.navigationDrawer.headerViewController.view.frame);
  XCTAssertGreaterThanOrEqual(newHeaderHeight, originalHeaderHeight);
}

- (void)testMaximumDrawerHeightBeingSetUpdatesTheUnderlyingPresentationControllerAndViewController {
  // Given
  self.navigationDrawer.headerViewController.preferredContentSize = CGSizeMake(100, 200);
  self.navigationDrawer.contentViewController.preferredContentSize = CGSizeMake(100, 200);
  [self.navigationDrawer.presentationController presentationTransitionWillBegin];

  // When
  self.navigationDrawer.maximumDrawerHeight = 300;

  // Then
  XCTAssertEqual(self.navigationDrawer.maximumDrawerHeight, 300);
  if ([self.navigationDrawer.presentationController
          isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *presentationController =
        (MDCBottomDrawerPresentationController *)self.navigationDrawer.presentationController;
    XCTAssertEqual(presentationController.maximumDrawerHeight, 300);
    XCTAssertEqual(presentationController.bottomDrawerContainerViewController.maximumDrawerHeight,
                   300);
  } else {
    XCTFail(@"The presentation controller should be class of kind "
            @"MDCBottomDrawerPresentationController but is %@",
            self.navigationDrawer.presentationController.class);
  }
}

- (void)testDefaultShouldDismissOnAccessibilityPerformEscape {
  // Default
  XCTAssertTrue([self.navigationDrawer accessibilityPerformEscape]);
}

- (void)testSettingShouldDismissOnAccessibilityPerformEscape {
  // When
  self.navigationDrawer.shouldDismissOnAccessibilityPerformEscape = NO;

  // Then
  XCTAssertFalse([self.navigationDrawer accessibilityPerformEscape]);
}

@end
