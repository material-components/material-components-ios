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

#import "MaterialElevation.h"

#import <XCTest/XCTest.h>

/**
 Used for testing @c UIViews that conform to @c MDCElevatable and do not conform to @c
 MDCElevatableOverride.
 */
@interface MDCConformingMDCElevatableView : UIView <MDCElevatable>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)
    (MDCConformingMDCElevatableView *view, CGFloat elevation);
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevatableView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

/**
 Used for testing @c UIViewControllers that conform to @c MDCElevatable and do not conform to @c
 MDCElevatableOverride.
 */
@interface MDCConformingMDCElevatableViewController : UIViewController <MDCElevatable>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)
    (MDCConformingMDCElevatableViewController *viewController, CGFloat elevation);
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevatableViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

/**
 Used for testing @c UIViews that conform to @c MDCElevatable and does conform to @c
 MDCElevatableOverride.
 */
@interface MDCConformingMDCElevatableOverrideView : UIView <MDCElevatable, MDCElevationOverriding>
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)
    (MDCConformingMDCElevatableOverrideView *view, CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevatableOverrideView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCConformingMDCElevatableOverrideViewSubclass : MDCConformingMDCElevatableOverrideView

@end

@implementation MDCConformingMDCElevatableOverrideViewSubclass

- (CGFloat)mdc_overrideBaseElevation {
  return -1;
}

@end

/**
 Used for testing @c UIViewControllers that conform to @c MDCElevatable and does conform to @c
 MDCElevatableOverride.
 */
@interface MDCConformingMDCElevatableOverrideViewController
    : UIViewController <MDCElevatable, MDCElevationOverriding>
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)
    (MDCConformingMDCElevatableOverrideViewController *viewController, CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevatableOverrideViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

/**
 Tests for the @c MaterialElevationResponding category on @c UIView.
 */
@interface MDCMaterialElevationRespondingTests : XCTestCase
@property(nonatomic, strong, nullable) UIView *view;
@property(nonatomic, strong, nullable) MDCConformingMDCElevatableView *elevationView;
@property(nonatomic, strong, nullable)
    MDCConformingMDCElevatableOverrideView *elevationOverrideView;
@property(nonatomic, strong, nullable) UIViewController *viewController;
@property(nonatomic, strong, nullable)
    MDCConformingMDCElevatableViewController *elevationViewController;
@property(nonatomic, strong, nullable)
    MDCConformingMDCElevatableOverrideViewController *elevationOverrideViewController;
@end

@implementation MDCMaterialElevationRespondingTests

- (void)setUp {
  [super setUp];

  self.view = [[UIView alloc] init];
  self.elevationView = [[MDCConformingMDCElevatableView alloc] init];
  self.elevationOverrideView = [[MDCConformingMDCElevatableOverrideView alloc] init];
  self.viewController = [[UIViewController alloc] init];
  self.elevationViewController = [[MDCConformingMDCElevatableViewController alloc] init];
  self.elevationOverrideViewController =
      [[MDCConformingMDCElevatableOverrideViewController alloc] init];
}

- (void)tearDown {
  self.elevationOverrideViewController = nil;
  self.elevationViewController = nil;
  self.viewController = nil;
  self.elevationOverrideView = nil;
  self.elevationView = nil;
  self.view = nil;

  [super tearDown];
}

// + self.elevationView
//   - self.view
- (void)testViewInElevationView {
  // Given
  CGFloat fakeElevation = 3;
  self.elevationView.elevation = fakeElevation;

  // When
  [self.elevationView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
}

// + self.elevationView
//   + middleView
//     - self.view
- (void)testViewInNonElevationViewInElevationView {
  // Given
  UIView *middleView = [[UIView alloc] init];
  CGFloat fakeElevation = 3;
  self.elevationView.elevation = fakeElevation;

  // When
  [self.elevationView addSubview:middleView];
  [middleView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
}

// + self.elevationOverrideView
//   - self.view
- (void)testViewInElevationOverrideView {
  // Given
  CGFloat fakeElevation = 3;
  CGFloat fakeCurrentElevation = 20;
  self.elevationOverrideView.elevation = fakeCurrentElevation;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.elevationOverrideView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation + fakeCurrentElevation,
                             0.001);
}

// + self.elevationOverrideView
//   + middleView
//     - self.view
- (void)testViewInNonElevationViewInElevationOverrideView {
  // Given
  UIView *middleView = [[UIView alloc] init];
  CGFloat fakeElevation = 3;
  CGFloat fakeCurrentElevation = 20;
  self.elevationOverrideView.elevation = fakeCurrentElevation;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.elevationOverrideView addSubview:middleView];
  [middleView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation + fakeCurrentElevation,
                             0.001);
}

// + self.elevationOverrideView
//   + self.elevationView
//     - self.view
- (void)testViewInElevationViewInElevationOverrideView {
  // Given
  CGFloat fakeElevation = 3;
  CGFloat fakeElevationOverride = 4;
  self.elevationView.elevation = fakeElevation;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeElevationOverride;

  // When
  [self.elevationOverrideView addSubview:self.elevationView];
  [self.elevationView addSubview:self.view];

  // Then
  XCTAssertEqual(self.view.mdc_baseElevation, fakeElevation + fakeElevationOverride);
}

// + self.elevationViewController
//   - self.view
- (void)testViewInElevationViewController {
  // Given
  CGFloat fakeElevation = 3;
  self.elevationViewController.elevation = fakeElevation;

  // When
  [self.elevationViewController.view addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
}

// + self.elevationOverrideViewController
//   - self.view
- (void)testViewInElevationOverrideViewController {
  // Given
  CGFloat fakeElevation = 3;
  CGFloat fakeCurrentElevation = 20;
  self.elevationOverrideViewController.elevation = fakeCurrentElevation;
  self.elevationOverrideViewController.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.elevationOverrideViewController.view addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation + fakeCurrentElevation,
                             0.001);
}

// + self.elevationViewController
//   + middleView
//     - self.view
- (void)testViewInUIViewInElevationViewController {
  // Given
  CGFloat fakeElevation = 3;
  self.elevationViewController.elevation = fakeElevation;
  UIView *middleView = [[UIView alloc] init];

  // When
  [self.elevationViewController.view addSubview:middleView];
  [middleView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
}

// + self.elevationOverrideViewController
//   + self.middleView
//     - self.view
- (void)testViewInUIViewInElevationOverrideViewController {
  // Given
  CGFloat fakeElevation = 3;
  CGFloat fakeCurrentElevation = 20;
  self.elevationOverrideViewController.elevation = fakeCurrentElevation;
  self.elevationOverrideViewController.mdc_overrideBaseElevation = fakeElevation;
  UIView *middleView = [[UIView alloc] init];

  // When
  [self.elevationOverrideViewController.view addSubview:middleView];
  [middleView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation + fakeCurrentElevation,
                             0.001);
}

// + self.elevationView
//   + subclassView
//     - self.view
- (void)testViewInElevationOverrideSubclassView {
  // Given
  CGFloat fakeElevationOne = 3;
  CGFloat fakeElevationTwo = 10;
  MDCConformingMDCElevatableOverrideViewSubclass *subclassView =
      [[MDCConformingMDCElevatableOverrideViewSubclass alloc] init];
  subclassView.elevation = fakeElevationOne;
  self.elevationView.elevation = fakeElevationTwo;

  // When
  [self.elevationView addSubview:subclassView];
  [subclassView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevationOne + fakeElevationTwo,
                             0.001);
}

// + self.overrideElevationView
//   + self.view
//     + self.elevationView
- (void)testElevationViewInUIViewInOverrideView {
  // Given
  CGFloat fakeElevation = 3;
  CGFloat fakeOverrideElevation = 7;
  self.elevationOverrideView.elevation = fakeElevation;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeOverrideElevation;

  // When
  [self.elevationOverrideView addSubview:self.view];
  [self.view addSubview:self.elevationView];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationView.mdc_baseElevation,
                             fakeElevation + fakeOverrideElevation, 0.001);
}

// + self.elevationView
//   + self.view
//     + self.elevationOverrideView
- (void)testElevationOverrideViewInUIViewInElevationView {
  // Given
  CGFloat fakeElevation = 100;
  CGFloat fakeOverideElevation = 3;
  self.elevationView.elevation = fakeElevation;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeOverideElevation;

  // When
  [self.elevationView addSubview:self.view];
  [self.view addSubview:self.elevationOverrideView];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationOverrideView.mdc_baseElevation, fakeOverideElevation,
                             0.001);
}

// + self.view
//   + self.elevationView
- (void)testElevationViewInUIView {
  // Given
  CGFloat fakeElevation = 3;
  self.elevationView.elevation = fakeElevation;

  // When
  [self.view addSubview:self.elevationView];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationView.mdc_baseElevation, 0, 0.001);
}

// + self.view
//   - self.elevationOverrideView
- (void)testElevationOverrideViewInUIView {
  // Given
  CGFloat fakeElevation = 3;
  CGFloat fakeElevationOverride = 7;
  self.elevationOverrideView.elevation = fakeElevation;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeElevationOverride;

  // When
  [self.view addSubview:self.elevationOverrideView];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationOverrideView.mdc_baseElevation, fakeElevationOverride,
                             0.001);
}

// + self.elevationOverrideViewController
//   + self.view
//     - self.elevationView
- (void)testElevatableViewInUIViewInElevatableOverrideViewController {
  // Given
  CGFloat fakeViewControllerElevation = 3;
  CGFloat fakeViewControllerOverride = 5;
  self.elevationOverrideViewController.mdc_overrideBaseElevation = fakeViewControllerOverride;
  self.elevationOverrideViewController.elevation = fakeViewControllerElevation;

  // When
  [self.elevationOverrideViewController.view addSubview:self.view];
  [self.view addSubview:self.elevationView];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationView.mdc_baseElevation,
                             fakeViewControllerElevation + fakeViewControllerOverride, 0.001);
}

// + self.elevationViewController
//   + self.view
//     - self.elevationOverrideViewController
- (void)testElevationOverrideViewControllerInUIViewInElevationView {
  // Given
  CGFloat fakeViewControllerElevation = 3;
  CGFloat fakeViewControllerOverride = 5;
  self.elevationOverrideViewController.mdc_overrideBaseElevation = fakeViewControllerOverride;
  self.elevationOverrideViewController.elevation = fakeViewControllerElevation;
  CGFloat fakeSecondViewControllerElevation = 10;
  self.elevationViewController.elevation = fakeSecondViewControllerElevation;

  // When
  [self.elevationViewController.view addSubview:self.view];
  [self.view addSubview:self.elevationOverrideViewController.view];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationOverrideViewController.view.mdc_baseElevation,
                             fakeViewControllerOverride, 0.001);
}

// + self.view
//   - self.elevationViewController
- (void)testElevationViewControllerInUIView {
  // Given
  self.elevationViewController.elevation = 100;

  // When
  [self.view addSubview:self.elevationViewController.view];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationViewController.view.mdc_baseElevation, 0, 0.001);
}

// + self.view
//   - self.elevationOverrideViewController
- (void)testElevationOverrideViewControllerInUIView {
  // Given
  CGFloat fakeElevationOverride = 20;
  CGFloat fakeElevation = 3;
  self.elevationOverrideViewController.elevation = fakeElevation;
  self.elevationOverrideViewController.mdc_overrideBaseElevation = fakeElevationOverride;

  // When
  [self.view addSubview:self.elevationOverrideViewController.view];

  // Then
  XCTAssertEqualWithAccuracy(self.elevationOverrideViewController.view.mdc_baseElevation,
                             fakeElevationOverride, 0.001);
}

@end
