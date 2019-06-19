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

#import <CoreGraphics/CoreGraphics.h>
#import "../../src/private/MDCTabBarViewItemView.h"

// Minimum width of an item view.
static const CGFloat kMinWidth = 90;
// Maximum width of an item view.
static const CGFloat kMaxWidth = 360;
// Minimum (expected) height of an item view.
static const CGFloat kMinHeight = 48;

@interface MDCTabBarViewItemViewTests : XCTestCase
@end

@implementation MDCTabBarViewItemViewTests

#pragma mark - -intrinsicContentSize

- (void)testIntrinsicContentSizeForNoTitleNoImageIsMinimumSize {
  // Given
  MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];

  // When
  CGSize intrinsicContentSize = itemView.intrinsicContentSize;

  // Then
  XCTAssertEqualWithAccuracy(intrinsicContentSize.width, kMinWidth, 0.001);
  XCTAssertEqualWithAccuracy(intrinsicContentSize.height, kMinHeight, 0.001);
}

#pragma mark - -sizeThatFits:

- (void)testSizeThatFitsForTooSmallReturnsMinimumSize {
  // Given
  MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];

  // When
  CGSize fitSize = [itemView sizeThatFits:CGSizeZero];

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, kMinWidth, 0.001);
  XCTAssertEqualWithAccuracy(fitSize.height, kMinHeight, 0.001);
}

- (void)testSizeThatFitsForReasonableDimensionsReturnsSameDimensions {
  // Given
  MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
  CGSize requestedSize = CGSizeMake(kMinWidth + (kMaxWidth - kMinWidth) / 2, kMinHeight + 10);

  // When
  CGSize fitSize = [itemView sizeThatFits:requestedSize];

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, requestedSize.width, 0.001);
  XCTAssertEqualWithAccuracy(fitSize.height, requestedSize.height, 0.001);
}

- (void)testSizeThatFitsWithTooLargeWidthReturnsMaxWidth {
  // Given
  MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
  CGSize requestedSize = CGSizeMake(kMaxWidth + 10, kMinHeight + 10);

  // When
  CGSize fitSize = [itemView sizeThatFits:requestedSize];

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, kMaxWidth, 0.001);
  XCTAssertEqualWithAccuracy(fitSize.height, requestedSize.height, 0.001);
}

@end
