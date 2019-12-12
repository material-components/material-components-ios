/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "../../src/private/MDCFlexibleHeaderMinMaxHeight.h"
#import "MaterialFlexibleHeader.h"
#import "supplemental/FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate.h"

@interface FlexibleHeaderMinMaxHeightTests : XCTestCase
@end

@implementation FlexibleHeaderMinMaxHeightTests {
  MDCFlexibleHeaderMinMaxHeight *_minMaxHeight;
  MDCFlexibleHeaderTopSafeArea *_topSafeArea;
  FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate *_delegate;
}

- (void)setUp {
  [super setUp];

  _topSafeArea = [[MDCFlexibleHeaderTopSafeArea alloc] init];
  _delegate = [[FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate alloc] init];
  _topSafeArea.topSafeAreaDelegate = _delegate;
}

- (void)tearDown {
  _topSafeArea = nil;
  _delegate = nil;
  _minMaxHeight = nil;

  [super tearDown];
}

#pragma mark - Defaults

- (void)testDefaults {
  // Given
  _delegate.deviceTopSafeAreaInset = 123;

  // When
  _minMaxHeight = [[MDCFlexibleHeaderMinMaxHeight alloc] initWithTopSafeArea:_topSafeArea];
  _minMaxHeight.minMaxHeightIncludesSafeArea = NO;

  // Then
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeight, 56, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeight, 56, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeightWithTopSafeArea,
                             56 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithTopSafeArea,
                             56 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithoutTopSafeArea, 56, 0.0001);
}

#pragma mark - Changes when top safe area inset changes

- (void)testMinMaxHeightWithTopSafeAreaChangesWhenTopSafeAreaChanges {
  // Given
  _delegate.deviceTopSafeAreaInset = 123;
  _minMaxHeight = [[MDCFlexibleHeaderMinMaxHeight alloc] initWithTopSafeArea:_topSafeArea];
  _minMaxHeight.minMaxHeightIncludesSafeArea = NO;

  // When
  _delegate.deviceTopSafeAreaInset = 50;

  // Then
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeight, 56, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeight, 56, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeightWithTopSafeArea,
                             56 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithTopSafeArea,
                             56 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithoutTopSafeArea, 56, 0.0001);
}

#pragma mark - Side effects of min/max setters

- (void)testSettingMaxLessThanMinAdjustsMin {
  // Given
  _delegate.deviceTopSafeAreaInset = 123;
  _minMaxHeight = [[MDCFlexibleHeaderMinMaxHeight alloc] initWithTopSafeArea:_topSafeArea];
  _minMaxHeight.minMaxHeightIncludesSafeArea = NO;

  // When
  _minMaxHeight.minimumHeight = 50;
  _minMaxHeight.maximumHeight = 30;

  // Then
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeight, 30, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeight, 30, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeightWithTopSafeArea,
                             30 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithTopSafeArea,
                             30 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithoutTopSafeArea, 30, 0.0001);
}

- (void)testSettingMinGreaterThanMaxAdjustsMax {
  // Given
  _delegate.deviceTopSafeAreaInset = 123;
  _minMaxHeight = [[MDCFlexibleHeaderMinMaxHeight alloc] initWithTopSafeArea:_topSafeArea];
  _minMaxHeight.minMaxHeightIncludesSafeArea = NO;

  // When
  _minMaxHeight.maximumHeight = 100;
  _minMaxHeight.minimumHeight = 200;

  // Then
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeight, 200, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeight, 200, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.minimumHeightWithTopSafeArea,
                             200 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithTopSafeArea,
                             200 + _delegate.deviceTopSafeAreaInset, 0.0001);
  XCTAssertEqualWithAccuracy(_minMaxHeight.maximumHeightWithoutTopSafeArea, 200, 0.0001);
}

@end
