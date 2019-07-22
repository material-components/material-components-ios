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
 Used for testing @c UIViews that conform to @c MDCElevation and do not respond to @c
 mdc_overrideBaseElevation.
 */
@interface MDCConformingMDCElevationView : UIView <MDCElevation>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevationView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

/**
 Used for testing @c UIViewControllers that conform to @c MDCElevation and do not respond to @c
 mdc_overrideBaseElevation.
 */
@interface MDCConformingMDCElevationViewController : UIViewController <MDCElevation>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevationViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

/**
 Used for testing @c UIViews that conform to @c MDCElevation and do respond to @c
 mdc_overrideBaseElevation.
 */
@interface MDCConformingMDCElevationOverrideView : UIView <MDCElevation>
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevationOverrideView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCConformingMDCElevationOverrideViewSubclass : MDCConformingMDCElevationOverrideView

@end

@implementation MDCConformingMDCElevationOverrideViewSubclass

- (CGFloat)mdc_overrideBaseElevation {
  if (self.superview) {
    if ([self.superview conformsToProtocol:@protocol(MDCElevation)]) {
      UIView<MDCElevation> *superview = (UIView<MDCElevation> *)self.superview;
      return superview.mdc_currentElevation + superview.mdc_baseElevation + self.mdc_currentElevation;
    }
    return self.superview.mdc_baseElevation + self.mdc_currentElevation;
  }
  return 0;
}

@end

/**
 Used for testing @c UIViewControllers that conform to @c MDCElevation and do respond to @c
 mdc_overrideBaseElevation.
 */
@interface MDCConformingMDCElevationOverrideViewController : UIViewController <MDCElevation>
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCConformingMDCElevationOverrideViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

/**
 Tests for the @c MaterialElevationResponding category on @c UIView.
 */
@interface MDCMaterialElevationRespondingTests : XCTestCase
@property(nonatomic, strong, nullable) UIView *view;
@property(nonatomic, strong, nullable) MDCConformingMDCElevationView *elevationView;
@property(nonatomic, strong, nullable) MDCConformingMDCElevationOverrideView *elevationOverrideView;
@property(nonatomic, strong, nullable) UIViewController *viewController;
@property(nonatomic, strong, nullable)
    MDCConformingMDCElevationViewController *elevationViewController;
@property(nonatomic, strong, nullable)
    MDCConformingMDCElevationOverrideViewController *elevationOverrideViewController;
@end

@implementation MDCMaterialElevationRespondingTests

- (void)setUp {
  [super setUp];

  self.view = [[UIView alloc] init];
  self.elevationView = [[MDCConformingMDCElevationView alloc] init];
  self.elevationOverrideView = [[MDCConformingMDCElevationOverrideView alloc] init];
  self.viewController = [[UIViewController alloc] init];
  self.elevationViewController = [[MDCConformingMDCElevationViewController alloc] init];
  self.elevationOverrideViewController =
      [[MDCConformingMDCElevationOverrideViewController alloc] init];
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
  self.elevationOverrideView.elevation = 20;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.elevationOverrideView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
}

// + self.elevationOverrideView
//   + middleView
//     - self.view
- (void)testViewInNonElevationViewInElevationOverrideView {
  // Given
  UIView *middleView = [[UIView alloc] init];
  CGFloat fakeElevation = 3;
  self.elevationOverrideView.elevation = 20;
  self.elevationOverrideView.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.elevationOverrideView addSubview:middleView];
  [middleView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
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
  self.elevationOverrideViewController.elevation = 20;
  self.elevationOverrideViewController.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.elevationOverrideViewController.view addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
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
  self.elevationOverrideViewController.elevation = 20;
  self.elevationOverrideViewController.mdc_overrideBaseElevation = fakeElevation;
  UIView *middleView = [[UIView alloc] init];

  // When
  [self.elevationOverrideViewController.view addSubview:middleView];
  [middleView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevation, 0.001);
}

// + self.elevationView
//   + subclassView
//     - self.view
- (void)testViewInElevationOverrideSubclassView {
  // Given
  CGFloat fakeElevationOne = 3;
  CGFloat fakeElevationTwo = 10;
  MDCConformingMDCElevationOverrideViewSubclass *subclassView =
      [[MDCConformingMDCElevationOverrideViewSubclass alloc] init];
  subclassView.elevation = fakeElevationOne;
  self.elevationView.elevation = fakeElevationTwo;

  // When
  [self.elevationView addSubview:subclassView];
  [subclassView addSubview:self.view];

  // Then
  XCTAssertEqualWithAccuracy(self.view.mdc_baseElevation, fakeElevationOne + fakeElevationTwo,
                             0.001);
}

@end
