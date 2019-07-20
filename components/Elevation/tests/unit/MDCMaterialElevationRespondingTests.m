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

@interface MDCFakeConformingMDCElevationView : UIView <MDCElevation>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCFakeConformingMDCElevationView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCFakeConformingMDCElevationViewController : UIViewController <MDCElevation>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCFakeConformingMDCElevationViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCFakeConformingMDCElevationOverrideView : UIView <MDCElevation>
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCFakeConformingMDCElevationOverrideView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCFakeConformingMDCElevationOverrideViewController : UIViewController <MDCElevation>
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCFakeConformingMDCElevationOverrideViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCMaterialElevationRespondingTests : XCTestCase
@property(nonatomic, strong, nullable) UIView *fakeView;
@property(nonatomic, strong, nullable) MDCFakeConformingMDCElevationView *fakeElevationView;
@property(nonatomic, strong, nullable)
    MDCFakeConformingMDCElevationOverrideView *fakeElevationOverrideView;
@property(nonatomic, strong, nullable) UIViewController *fakeViewController;
@property(nonatomic, strong, nullable)
    MDCFakeConformingMDCElevationViewController *fakeElevationViewController;
@property(nonatomic, strong, nullable)
    MDCFakeConformingMDCElevationOverrideViewController *fakeElevationOverrideViewController;
@end

@implementation MDCMaterialElevationRespondingTests

- (void)setUp {
  [super setUp];

  self.fakeView = [[UIView alloc] init];
  self.fakeElevationView = [[MDCFakeConformingMDCElevationView alloc] init];
  self.fakeElevationOverrideView = [[MDCFakeConformingMDCElevationOverrideView alloc] init];
  self.fakeViewController = [[UIViewController alloc] init];
  self.fakeElevationViewController = [[MDCFakeConformingMDCElevationViewController alloc] init];
  self.fakeElevationOverrideViewController =
      [[MDCFakeConformingMDCElevationOverrideViewController alloc] init];
}

- (void)tearDown {
  self.fakeElevationOverrideViewController = nil;
  self.fakeElevationViewController = nil;
  self.fakeViewController = nil;
  self.fakeElevationOverrideView = nil;
  self.fakeElevationView = nil;
  self.fakeView = nil;

  [super tearDown];
}

- (void)testViewInElevationView {
  // Given
  CGFloat fakeElevation = 3;
  self.fakeElevationView.elevation = fakeElevation;

  // When
  [self.fakeElevationView addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, fakeElevation);
}

- (void)testViewInNonElevationViewInElevationView {
  // Given
  UIView *middleView = [[UIView alloc] init];
  CGFloat fakeElevation = 3;
  self.fakeElevationView.elevation = fakeElevation;

  // When
  [self.fakeElevationView addSubview:middleView];
  [middleView addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, fakeElevation);
}

- (void)testViewInElevationOverrideView {
  // Given
  CGFloat fakeElevation = 3;
  self.fakeElevationOverrideView.elevation = 20;
  self.fakeElevationOverrideView.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.fakeElevationOverrideView addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, fakeElevation);
}

- (void)testViewInNonElevationViewInElevationOverrideView {
  // Given
  UIView *middleView = [[UIView alloc] init];
  CGFloat fakeElevation = 3;
  self.fakeElevationOverrideView.elevation = 20;
  self.fakeElevationOverrideView.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.fakeElevationOverrideView addSubview:middleView];
  [middleView addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, fakeElevation);
}

- (void)testViewInElevationViewInElevationOverrideView {
  // Given
  CGFloat fakeElevation = 3;
  CGFloat fakeElevationOverride = 4;
  self.fakeElevationView.elevation = fakeElevation;
  self.fakeElevationOverrideView.mdc_overrideBaseElevation = fakeElevationOverride;

  // When
  [self.fakeElevationOverrideView addSubview:self.fakeElevationView];
  [self.fakeElevationView addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, fakeElevation + fakeElevationOverride);
}

- (void)testViewInElevationViewController {
  // Given
  CGFloat fakeElevation = 3;
  self.fakeElevationViewController.elevation = fakeElevation;

  // When
  [self.fakeElevationViewController.view addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, fakeElevation);
}

- (void)testViewInElevationOverrideViewController {
  // Given
  CGFloat fakeElevation = 3;
  self.fakeElevationOverrideViewController.elevation = 20;
  self.fakeElevationOverrideViewController.mdc_overrideBaseElevation = fakeElevation;

  // When
  [self.fakeElevationViewController.view addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, fakeElevation);
}

@end
