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

#import "MaterialShadowElevations.h"

#import <XCTest/XCTest.h>

/** Test class for testing @c UIViews that conform to @c MDCElevation */
@interface FakeMDCShadowElevationRespondingView : UIView <MDCElevation>
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation FakeMDCShadowElevationRespondingView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

- (void)setElevation:(CGFloat)elevation {
  _elevation = elevation;
  [self mdc_elevationDidChange];
}

@end

/** Test class for testing @c UIViewControllers that conform to @c MDCElevation */
@interface FakeMDCShadowElevationRespondingViewController : UIViewController <MDCElevation>
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation FakeMDCShadowElevationRespondingViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MaterialElevationRespondingTests : XCTestCase

@end

@implementation MaterialElevationRespondingTests

- (void)testViewElevationDidChangeCallsBlock {
  // Given
  FakeMDCShadowElevationRespondingView *view = [[FakeMDCShadowElevationRespondingView alloc] init];
  XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"elevationDidChange"];
  view.mdc_elevationDidChangeBlock = ^(CGFloat elevation) {
    [expectation fulfill];
  };

  // When
  view.elevation = 10;

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
}

@end
