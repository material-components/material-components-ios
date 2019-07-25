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

#import "../../src/private/MDCDraggableView.h"

#import <XCTest/XCTest.h>

#import "MaterialElevation.h"

/** Tests for @c MDCDraggableView. */
@interface MDCDraggableViewTests : XCTestCase
@end

@implementation MDCDraggableViewTests

- (void)testDefaultElevation {
  // Given
  MDCDraggableView *draggableView = [[MDCDraggableView alloc] init];

  // Then
  XCTAssertEqualWithAccuracy(draggableView.elevation, MDCShadowElevationNone, 0.001);
}

- (void)testCustomElevation {
  // Given
  MDCDraggableView *draggableView = [[MDCDraggableView alloc] init];

  // When
  draggableView.elevation = MDCShadowElevationModalBottomSheet;

  // Then
  XCTAssertEqualWithAccuracy(draggableView.elevation, MDCShadowElevationModalBottomSheet, 0.001);
}

@end
