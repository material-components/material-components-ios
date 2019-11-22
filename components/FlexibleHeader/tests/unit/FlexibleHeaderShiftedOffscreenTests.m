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

@interface FlexibleHeaderShiftedOffscreenTests : XCTestCase
@end

@implementation FlexibleHeaderShiftedOffscreenTests

#pragma mark - Programmatic shifting using -shiftHeader(On|Off)ScreenAnimated:

#pragma mark Without a tracking scroll view

- (void)testDefaultIsFalseWithoutTrackingScrollView {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];

  // Then
  XCTAssertFalse(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), 0, 0.001);
}

- (void)testBecomesTrueWhenShiftedOffscreenNotAnimatedWithoutTrackingScrollView {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];

  // When
  [fhvc shiftHeaderOffScreenAnimated:NO];

  // Then
  XCTAssertTrue(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), -fhvc.maximumHeight, 0.001);
}

- (void)testBecomesTrueBeforeAnimationWhenShiftedOffscreenAnimatedWithoutTrackingScrollView {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];

  // When
  [fhvc shiftHeaderOffScreenAnimated:YES];

  // Then
  XCTAssertTrue(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), 0, 0.001);
}

#pragma mark With a tracking scroll view

- (void)testDefaultIsFalseWithTrackingScrollView {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 1000);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.trackingScrollView = scrollView;

  // Then
  XCTAssertFalse(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), 0, 0.001);
}

- (void)testBecomesTrueWhenShiftedOffscreenNotAnimatedWithTrackingScrollView {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 100);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.trackingScrollView = scrollView;

  // When
  [fhvc shiftHeaderOffScreenAnimated:NO];

  // Then
  XCTAssertTrue(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), -fhvc.maximumHeight, 0.001);
}

- (void)testBecomesTrueBeforeAnimationWhenShiftedOffscreenAnimatedWithTrackingScrollView {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 1000);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.trackingScrollView = scrollView;

  // When
  [fhvc shiftHeaderOffScreenAnimated:YES];

  // Then
  XCTAssertTrue(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), 0, 0.001);
}

#pragma mark - Interactive shifting via trackingScrollViewDidScroll

- (void)testDefaultIsFalseWithUndraggedTrackingScrollView {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 100);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
  fhvc.trackingScrollView = scrollView;
  [fhvc trackingScrollViewDidScroll];

  // Then
  XCTAssertFalse(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), 0, 0.001);
}

- (void)testStaysFalseWhenScrolledMuchLessThanTheHeightOfTheHeader {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 100);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
  fhvc.trackingScrollView = scrollView;
  [fhvc trackingScrollViewDidScroll];

  // When
  scrollView.contentOffset = CGPointMake(0, 10);
  [fhvc trackingScrollViewDidScroll];

  // Then
  XCTAssertFalse(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), -scrollView.contentOffset.y, 0.001);
}

- (void)testStaysFalseWhenAlmostScrolledTheFullHeightOfTheHeader {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 100);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
  fhvc.trackingScrollView = scrollView;
  [fhvc trackingScrollViewDidScroll];

  // When
  scrollView.contentOffset = CGPointMake(0, fhvc.maximumHeight - 1);
  [fhvc trackingScrollViewDidScroll];

  // Then
  XCTAssertFalse(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), -scrollView.contentOffset.y, 0.001);
}

- (void)testBecomesTrueWhenScrolledExactlyTheHeightOfTheHeader {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 100);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
  fhvc.trackingScrollView = scrollView;
  [fhvc trackingScrollViewDidScroll];

  // When
  scrollView.contentOffset = CGPointMake(0, fhvc.maximumHeight);
  [fhvc trackingScrollViewDidScroll];

  // Then
  XCTAssertTrue(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), -fhvc.maximumHeight, 0.001);
}

- (void)testBecomesTrueWhenScrolledGreaterThanTheHeightOfTheHeader {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 100);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
  fhvc.trackingScrollView = scrollView;
  [fhvc trackingScrollViewDidScroll];

  // When
  scrollView.contentOffset = CGPointMake(0, 400);
  [fhvc trackingScrollViewDidScroll];

  // Then
  XCTAssertTrue(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), -fhvc.maximumHeight, 0.001);
}

- (void)testBecomesFalseWhenScrolledGreaterThanTheHeightOfTheHeaderAndThenBackToTheContentTop {
  // Given
  MDCFlexibleHeaderView *fhvc = [[MDCFlexibleHeaderView alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 0, 100, 100);
  scrollView.contentSize = CGSizeMake(100, 1000);
  fhvc.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
  fhvc.trackingScrollView = scrollView;
  [fhvc trackingScrollViewDidScroll];

  // When
  scrollView.contentOffset = CGPointMake(0, fhvc.maximumHeight + 100);
  [fhvc trackingScrollViewDidScroll];
  scrollView.contentOffset = CGPointMake(0, 0);
  [fhvc trackingScrollViewDidScroll];

  // Then
  XCTAssertFalse(fhvc.isShiftedOffscreen);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(fhvc.frame), 0, 0.001);
}

@end
