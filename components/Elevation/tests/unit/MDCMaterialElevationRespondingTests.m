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
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCFakeConformingMDCElevationView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCFakeConformingMDCElevationViewController : UIViewController <MDCElevation>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCFakeConformingMDCElevationViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCFakeConformingMDCElevationOverrideView : UIView <MDCElevation>
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
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
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation MDCFakeConformingMDCElevationViewController

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end

@interface MDCMaterialElevationRespondingTests : XCTestCase
@property(nonatomic, strong, nullable) UIView *fakeView;
@property(nonatomic, strong, nullable) MDCFakeConformingMDCElevationView *fakeElevationView;
@property(nonatomic, strong, nullable) MDCFakeConformingMDCElevationOverrideView *fakeElevationOverrideView;
@property(nonatomic, strong, nullable) UIViewController *fakeViewController;
@property(nonatomic, strong, nullable) UIViewController *fakeElevationViewController;
@property(nonatomic, strong, nullable) UIViewController *fakeElevationOverrideViewController;
@end

@implementation MDCMaterialElevationRespondingTests

- (void)setUp {
  [super setUp];

  self.fakeView = [[UIView alloc] init];
  self.fakeElevationView = [[MDCFakeConformingMDCElevationView alloc] init];
  self.fakeElevationOverrideView = [[MDCFakeConformingMDCElevationOverrideView alloc] init];
  self.fakeViewController = [[UIViewController alloc] init];
  self.fakeElevationViewController = [[MDCFakeConformingMDCElevationViewController alloc] init];
  self.fakeElevationOverrideViewController = [[MDCFakeConformingMDCElevationOverrideViewController alloc] init];
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
  CGFloat fakeElevation = 10;
  self.fakeElevationView.elevation = fakeElevation;

  // When
  [self.fakeElevationView addSubview:self.fakeView];

  // Then
  XCTAssertEqual(self.fakeView.mdc_baseElevation, 10);
}

- (void)testViewInNonElevationViewInElevationView {
  // Given

}

@end
