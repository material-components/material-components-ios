// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "../../src/private/MDCItemBarCell+Private.h"
#import "../../src/private/MDCItemBarCell.h"
#import "../../src/private/MDCItemBarStyle.h"
#import "MaterialRipple.h"

@interface MDCItemBarCellTests : XCTestCase

@end

@implementation MDCItemBarCellTests

- (void)testTitleNumberOfLines {
  // Given
  MDCItemBarCell *cellWithImageAndText = [[MDCItemBarCell alloc] initWithFrame:CGRectZero];
  MDCItemBarCell *cellWithImageOnly = [[MDCItemBarCell alloc] initWithFrame:CGRectZero];
  MDCItemBarCell *cellWithTextAndMissingImage = [[MDCItemBarCell alloc] initWithFrame:CGRectZero];
  MDCItemBarCell *cellWithTextOnly = [[MDCItemBarCell alloc] initWithFrame:CGRectZero];

  MDCItemBarStyle *style = [[MDCItemBarStyle alloc] init];
  style.textOnlyNumberOfLines = 2;
  style.shouldDisplayImage = YES;
  style.shouldDisplayTitle = YES;

  // When
  cellWithImageAndText.image = [UIImage imageNamed:@"TabBarDemo_ic_info"];
  cellWithImageOnly.image = [UIImage imageNamed:@"TabBarDemo_ic_info"];

  cellWithImageAndText.title = @"A title";
  cellWithTextAndMissingImage.title = @"A title";
  cellWithTextOnly.title = @"A title";

  [cellWithImageAndText applyStyle:style];
  [cellWithImageOnly applyStyle:style];
  [cellWithTextAndMissingImage applyStyle:style];
  style.shouldDisplayImage = NO;
  [cellWithTextOnly applyStyle:style];

  // Then
  XCTAssertEqual(cellWithImageAndText.titleLabel.numberOfLines, 1);
  XCTAssertEqual(cellWithImageOnly.titleLabel.numberOfLines, 1);
  XCTAssertEqual(cellWithTextAndMissingImage.titleLabel.numberOfLines, 1);
  XCTAssertEqual(cellWithTextOnly.titleLabel.numberOfLines, 2);
}

/// Tests that a cell that was initially configured as image-only style, and then changed to
/// image-and-title style, will result in the correct title text.
- (void)testTitleAfterStyleChange {
  MDCItemBarStyle *iconOnlyStyle = [[MDCItemBarStyle alloc] init];
  iconOnlyStyle.shouldDisplayImage = YES;
  iconOnlyStyle.shouldDisplayTitle = NO;

  MDCItemBarStyle *iconAndTextStyle = [[MDCItemBarStyle alloc] init];
  iconAndTextStyle.shouldDisplayImage = YES;
  iconAndTextStyle.shouldDisplayTitle = YES;

  // Create a cell and set the style before settting the image/title. That is the order items will
  // be configured in the app runtime.
  MDCItemBarCell *cell = [[MDCItemBarCell alloc] initWithFrame:CGRectZero];
  [cell applyStyle:iconOnlyStyle];
  cell.image = [UIImage imageNamed:@"TabBarDemo_ic_info"];
  cell.title = @"A title";
  XCTAssertEqual(cell.titleLabel.hidden, YES);

  // Change the style to show image-and-title.
  [cell applyStyle:iconAndTextStyle];
  XCTAssertEqual(cell.titleLabel.hidden, NO);
  XCTAssertEqualObjects(cell.titleLabel.text, @"A TITLE");
}

/// Tests that a cell's badge label doesn't increase in size as the badge value gets to be more than
/// four characters
- (void)testBadgeLabelTextTruncation {
  MDCItemBarStyle *style = [[MDCItemBarStyle alloc] init];
  style.shouldDisplayImage = YES;
  style.shouldDisplayBadge = YES;
  style.shouldDisplayTitle = YES;

  MDCItemBarCell *cell = [[MDCItemBarCell alloc] initWithFrame:CGRectZero];
  [cell applyStyle:style];
  cell.image = [UIImage imageNamed:@"TabBarDemo_ic_info"];
  cell.title = @"A title";
  cell.badgeValue = @"xxxx";
  CGRect frameWithFourDigitBadgeValue = cell.badgeLabel.frame;
  cell.badgeValue = @"xxxxx";
  CGRect frameWithFiveDigitBadgeValue = cell.badgeLabel.frame;
  XCTAssertEqualWithAccuracy(CGRectGetWidth(frameWithFiveDigitBadgeValue),
                             CGRectGetWidth(frameWithFourDigitBadgeValue), 0.001);
}

- (void)testRippleTouchControllerShouldProcessRippleWithScrollViewDefaultsToNo {
  // Given
  MDCItemBarCell *cell = [[MDCItemBarCell alloc] initWithFrame:CGRectZero];

  // Then
  XCTAssertFalse(cell.rippleTouchController.shouldProcessRippleWithScrollViewGestures);
}

@end
