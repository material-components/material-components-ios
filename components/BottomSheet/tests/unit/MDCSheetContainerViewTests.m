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

#import "../../src/private/MDCSheetContainerView.h"

#import <XCTest/XCTest.h>

#import "MaterialElevation.h"
#import "../../src/private/MDCDraggableView.h"

@interface MDCSheetContainerView (ElevationTesting)
@property(nonatomic) MDCDraggableView *sheet;
@end

/** Tests for @c MDCSheetContainerView. */
@interface MDCSheetContainerViewTests : XCTestCase
@end

@implementation MDCSheetContainerViewTests

- (void)testDefaultElevation {
  // Given
  MDCSheetContainerView *sheetContainer = [[MDCSheetContainerView alloc] init];

  // Then
  XCTAssertEqualWithAccuracy(sheetContainer.elevation, MDCShadowElevationNone, 0.001);
}

- (void)testCustomElevation {
  // Given
  MDCSheetContainerView *sheetContainer = [[MDCSheetContainerView alloc] init];

  // When
  sheetContainer.elevation = MDCShadowElevationModalBottomSheet;

  // Then
  XCTAssertEqualWithAccuracy(sheetContainer.elevation, MDCShadowElevationModalBottomSheet, 0.001);
  XCTAssertEqualWithAccuracy(sheetContainer.sheet.elevation, MDCShadowElevationModalBottomSheet, 0.001);
}

@end
