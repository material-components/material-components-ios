/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>

#import "MDCItemBarCell.h"
#import "MDCItemBarCell+Private.h"
#import "MDCItemBarStyle.h"

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
  [cellWithImageAndText setImage:[UIImage imageNamed:@"TabBarDemo_ic_info"]];
  [cellWithImageOnly setImage:[UIImage imageNamed:@"TabBarDemo_ic_info"]];

  [cellWithImageAndText setTitle:@"A title"];
  [cellWithTextAndMissingImage setTitle:@"A title"];
  [cellWithTextOnly setTitle:@"A title"];

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

@end
