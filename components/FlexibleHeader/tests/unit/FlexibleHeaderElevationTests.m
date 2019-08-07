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

@interface FlexibleHeaderElevationTests : XCTestCase
@end

@implementation FlexibleHeaderElevationTests {
  MDCFlexibleHeaderView *_flexibleHeaderView;
}

- (void)setUp {
  [super setUp];

  _flexibleHeaderView = [[MDCFlexibleHeaderView alloc] init];
}

- (void)tearDown {
  _flexibleHeaderView = nil;

  [super tearDown];
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  const CGFloat finalElevation = 6;
  _flexibleHeaderView.elevation = finalElevation - 1;
  __block CGFloat newElevation = -1;
  _flexibleHeaderView.mdc_elevationDidChangeBlock =
      ^(MDCFlexibleHeaderView *blockHeaderView, CGFloat elevation) {
        newElevation = elevation;
      };

  // When
  _flexibleHeaderView.elevation = _flexibleHeaderView.elevation + 1;

  // Then
  XCTAssertEqualWithAccuracy(newElevation, finalElevation, 0.001);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  _flexibleHeaderView.elevation = 5;
  __block BOOL blockCalled = NO;
  _flexibleHeaderView.mdc_elevationDidChangeBlock =
      ^(MDCFlexibleHeaderView *blockHeaderView, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  _flexibleHeaderView.elevation = _flexibleHeaderView.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Then
  XCTAssertLessThan(_flexibleHeaderView.mdc_overrideBaseElevation, 0);
}

@end
