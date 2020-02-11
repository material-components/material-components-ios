// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFlexibleHeaderHairline.h"

@interface FlexibleHeaderHairlineTests : XCTestCase
@property(nonatomic, strong) MDCFlexibleHeaderHairline *hairline;
@property(nonatomic, strong) UIView *containerView;
@end

@implementation FlexibleHeaderHairlineTests

- (void)setUp {
  [super setUp];

  self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
  self.hairline = [[MDCFlexibleHeaderHairline alloc] initWithContainerView:self.containerView];
}

- (void)tearDown {
  self.hairline = nil;
  self.containerView = nil;

  [super tearDown];
}

- (void)testDefaults {
  XCTAssertTrue(self.hairline.hidden);
  XCTAssertEqualObjects(self.hairline.color, [UIColor blackColor]);
  XCTAssertEqual(self.hairline.containerView, self.containerView);
  XCTAssertEqual(self.hairline.containerView.subviews.count, 0);
}

#pragma mark - Visibility

- (void)testAddsHairlineViewToContainerViewWhenMadeVisible {
  // When
  self.hairline.hidden = NO;

  // Then
  CGFloat expectedHairlineHeight = 1;
  XCTAssertEqual(self.containerView.subviews.count, 1);
  UIView *hairlineView = self.containerView.subviews[0];
  XCTAssertFalse(hairlineView.hidden);
  XCTAssertEqualObjects(self.hairline.color, [UIColor blackColor]);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(hairlineView.frame),
                             CGRectGetWidth(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(hairlineView.frame), expectedHairlineHeight, 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(hairlineView.frame),
                             CGRectGetMinX(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(hairlineView.frame),
                             CGRectGetMaxY(self.containerView.bounds) - expectedHairlineHeight,
                             0.001);
}

- (void)testAddsOnlyOneHairlineViewToContainerViewWhenMadeVisibleTwice {
  // When
  self.hairline.hidden = NO;
  self.hairline.hidden = NO;

  // Then
  CGFloat expectedHairlineHeight = 1;
  XCTAssertEqual(self.containerView.subviews.count, 1);
  UIView *hairlineView = self.containerView.subviews[0];
  XCTAssertFalse(hairlineView.hidden);
  XCTAssertEqualObjects(self.hairline.color, [UIColor blackColor]);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(hairlineView.frame),
                             CGRectGetWidth(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(hairlineView.frame), expectedHairlineHeight, 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(hairlineView.frame),
                             CGRectGetMinX(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(hairlineView.frame),
                             CGRectGetMaxY(self.containerView.bounds) - expectedHairlineHeight,
                             0.001);
}

- (void)testAddsOnlyOneHairlineViewToContainerViewWhenVisibilityIsToggledTwice {
  // When
  self.hairline.hidden = NO;
  self.hairline.hidden = YES;
  self.hairline.hidden = NO;

  // Then
  CGFloat expectedHairlineHeight = 1;
  XCTAssertEqual(self.containerView.subviews.count, 1);
  UIView *hairlineView = self.containerView.subviews[0];
  XCTAssertFalse(hairlineView.hidden);
  XCTAssertEqualObjects(self.hairline.color, [UIColor blackColor]);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(hairlineView.frame),
                             CGRectGetWidth(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(hairlineView.frame), expectedHairlineHeight, 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(hairlineView.frame),
                             CGRectGetMinX(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(hairlineView.frame),
                             CGRectGetMaxY(self.containerView.bounds) - expectedHairlineHeight,
                             0.001);
}

- (void)testContainerViewStillHasHairlineViewWhenHairlineIsHidden {
  // Given
  self.hairline.hidden = NO;

  // When
  self.hairline.hidden = YES;

  // Then
  CGFloat expectedHairlineHeight = 1;
  XCTAssertEqual(self.containerView.subviews.count, 1);
  UIView *hairlineView = self.containerView.subviews[0];
  XCTAssertTrue(hairlineView.hidden);
  XCTAssertEqualObjects(self.hairline.color, [UIColor blackColor]);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(hairlineView.frame),
                             CGRectGetWidth(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(hairlineView.frame), expectedHairlineHeight, 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(hairlineView.frame),
                             CGRectGetMinX(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(hairlineView.frame),
                             CGRectGetMaxY(self.containerView.bounds) - expectedHairlineHeight,
                             0.001);
}

#pragma mark - Visibility

- (void)testContainerBoundsChangeResultsInFrameChangeOfHairlineView {
  // Given
  self.hairline.hidden = NO;

  // When
  self.containerView.frame = CGRectMake(0, 0, 10, 20);

  // Then
  CGFloat expectedHairlineHeight = 1;
  XCTAssertEqual(self.containerView.subviews.count, 1);
  UIView *hairlineView = self.containerView.subviews[0];
  XCTAssertFalse(hairlineView.hidden);
  XCTAssertEqualObjects(self.hairline.color, [UIColor blackColor]);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(hairlineView.frame),
                             CGRectGetWidth(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(hairlineView.frame), expectedHairlineHeight, 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(hairlineView.frame),
                             CGRectGetMinX(self.containerView.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(hairlineView.frame),
                             CGRectGetMaxY(self.containerView.bounds) - expectedHairlineHeight,
                             0.001);
}

@end
