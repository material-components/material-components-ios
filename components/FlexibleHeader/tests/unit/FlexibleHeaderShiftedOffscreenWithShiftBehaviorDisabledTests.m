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

#import "MaterialFlexibleHeader.h"

// Validates the behavior of isShiftedOffscreen and flexible header shifting when shiftBehavior
// is MDCFlexibleHeaderShiftBehaviorDisabled.
@interface FlexibleHeaderShiftedOffscreenWithShiftBehaviorDisabledTests : XCTestCase
@property(nonatomic, strong) MDCFlexibleHeaderView *fhvc;
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation FlexibleHeaderShiftedOffscreenWithShiftBehaviorDisabledTests

- (void)setUp {
  [super setUp];

  self.fhvc = [[MDCFlexibleHeaderView alloc] init];
  self.fhvc.shiftBehavior = MDCFlexibleHeaderShiftBehaviorDisabled;
  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.frame = CGRectMake(0, 0, 100, 100);
  self.scrollView.contentSize = CGSizeMake(100, 1000);
  self.fhvc.trackingScrollView = self.scrollView;
  [self.fhvc trackingScrollViewDidScroll];
}

- (void)tearDown {
  self.fhvc = nil;
  self.scrollView = nil;

  [super tearDown];
}

- (void)testDefaultIsNotShifted {
  // Then
  XCTAssertFalse(self.fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.fhvc.frame), 0, 0.001);
}

- (void)testCanBeShiftedOffScreen {
  // When
  [self.fhvc shiftHeaderOffScreenAnimated:NO];

  // Then
  XCTAssertTrue(self.fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.fhvc.frame), -self.fhvc.maximumHeight, 0.001);
}

- (void)testStaysShiftedOffScreenWhenScrolledUpByHeaderHeight {
  // Given
  [self.fhvc shiftHeaderOffScreenAnimated:NO];

  // When
  self.scrollView.contentOffset = CGPointMake(0, self.fhvc.maximumHeight);
  [self.fhvc trackingScrollViewDidScroll];

  // Then
  XCTAssertTrue(self.fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.fhvc.frame), -self.fhvc.maximumHeight, 0.001);
}

- (void)testShiftsBackOnScreenWhenDragged {
  // Given
  [self.fhvc shiftHeaderOffScreenAnimated:NO];

  // When
  // Scroll up to match shifted amount.
  self.scrollView.contentOffset = CGPointMake(0, self.fhvc.maximumHeight);
  [self.fhvc trackingScrollViewDidScroll];
  // Scroll down to pull header back on-screen.
  self.scrollView.contentOffset = CGPointMake(0, 0);
  [self.fhvc trackingScrollViewDidScroll];

  // Then
  // TODO(https://github.com/material-components/material-components-ios/issues/9022): This should
  // be false.
  XCTAssertTrue(self.fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.fhvc.frame), 0, 0.001);
}

- (void)testDoesNotShiftBackOffScreenWhenDragged {
  // Given
  [self.fhvc shiftHeaderOffScreenAnimated:NO];

  // When
  // Scroll up to match shifted amount.
  self.scrollView.contentOffset = CGPointMake(0, self.fhvc.maximumHeight);
  [self.fhvc trackingScrollViewDidScroll];
  // Scroll down to pull header back on-screen.
  self.scrollView.contentOffset = CGPointMake(0, 0);
  [self.fhvc trackingScrollViewDidScroll];
  // Scroll up to attempt to shift the header again.
  self.scrollView.contentOffset = CGPointMake(0, self.fhvc.maximumHeight);
  [self.fhvc trackingScrollViewDidScroll];

  // Then
  // TODO(https://github.com/material-components/material-components-ios/issues/9022): This should
  // be false.
  XCTAssertTrue(self.fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(self.fhvc.frame), 0, 0.001);
}

@end
