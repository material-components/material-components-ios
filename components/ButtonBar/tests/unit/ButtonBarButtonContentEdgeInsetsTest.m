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

#import "MDCButtonBarButton.h"

#import <XCTest/XCTest.h>

/**
 Tests verifying that MDCButtonBarButton correctly sets its inkViewOffset based on its
 contentEdgeInsets
 */
@interface ButtonBarButtonContentEdgeInsetsTests : XCTestCase
@end

@implementation ButtonBarButtonContentEdgeInsetsTests

- (void)testSettingSymmetricalContentEdgeInsetsResultsInAZeroInkViewOffset {
  // Given
  MDCButtonBarButton *button = [[MDCButtonBarButton alloc] init];

  // When
  button.contentEdgeInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);

  // Then
  CGSize expectedSize = CGSizeZero;
  CGSize actualSize = button.inkViewOffset;
  XCTAssertTrue(CGSizeEqualToSize(actualSize, expectedSize),
                @"button.inkViewOffset should equal %@ (got %@)", NSStringFromCGSize(expectedSize),
                NSStringFromCGSize(actualSize));
}

// When assigned asymmetric contentEdgeInsets, the button should set its inkViewOffset to center
// it within those insets.
- (void)testSettingAsymmetricalContentEdgeInsetsResultsInANonZeroInkViewOffset {
  // Given
  MDCButtonBarButton *button = [[MDCButtonBarButton alloc] init];

  // When
  button.contentEdgeInsets = UIEdgeInsetsMake(10.f, 10.f, 0.f, 4.f);

  // Then
  CGFloat expectedWidth = (button.contentEdgeInsets.left - button.contentEdgeInsets.right) / 2.f;
  CGFloat expectedHeight = (button.contentEdgeInsets.top - button.contentEdgeInsets.bottom) / 2.f;
  CGSize expectedSize = CGSizeMake(expectedWidth, expectedHeight);
  CGSize actualSize = button.inkViewOffset;
  XCTAssertTrue(CGSizeEqualToSize(actualSize, expectedSize),
                @"button.inkViewOffset should equal %@ (got %@)", NSStringFromCGSize(expectedSize),
                NSStringFromCGSize(actualSize));
}

@end
