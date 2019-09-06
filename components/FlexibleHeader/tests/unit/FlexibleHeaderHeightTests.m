// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#import "MaterialFlexibleHeader.h"

#import "supplemental/FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate.h"

@interface MDCFlexibleHeaderView (UnitTestingPrivateAPIs)
@property(nonatomic, strong) MDCFlexibleHeaderTopSafeArea *topSafeArea;
@end

@interface FlexibleHeaderHeightTests : XCTestCase
@end

@implementation FlexibleHeaderHeightTests {
  MDCFlexibleHeaderView *_flexibleHeaderView;
  FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate *_delegate;
}

- (void)setUp {
  [super setUp];

  _flexibleHeaderView = [[MDCFlexibleHeaderView alloc] init];
  _flexibleHeaderView.minMaxHeightIncludesSafeArea = NO;

  // Fake the top safe area behavior so that we can control the top safe area inset.
  _delegate = [[FlexibleHeaderTopSafeAreaTestsFakeTopSafeAreaDelegate alloc] init];
  _delegate.forwardingDelegate = _flexibleHeaderView.topSafeArea.topSafeAreaDelegate;
  _delegate.deviceTopSafeAreaInset = 123;
  _flexibleHeaderView.topSafeArea.topSafeAreaDelegate = _delegate;

  [_delegate flexibleHeaderSafeAreaTopSafeAreaInsetDidChange:_flexibleHeaderView.topSafeArea];
}

- (void)tearDown {
  _flexibleHeaderView = nil;
  _delegate = nil;

  [super tearDown];
}

- (void)testDefaults {
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.minimumHeight, 56, 0.0001f);
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.maximumHeight, 56, 0.0001f);
}

- (void)testSettingMaxGreaterThanMinDoesNotAdjustMin {
  // When
  _flexibleHeaderView.minimumHeight = 50;
  _flexibleHeaderView.maximumHeight = 80;

  // Then
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.minimumHeight, 50, 0.0001f);
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.maximumHeight, 80, 0.0001f);
}

- (void)testSettingMaxLessThanMinAdjustsMin {
  // When
  _flexibleHeaderView.minimumHeight = 50;
  _flexibleHeaderView.maximumHeight = 30;

  // Then
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.minimumHeight, 30, 0.0001f);
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.maximumHeight, 30, 0.0001f);
}

- (void)testSettingMinGreaterThanMaxAdjustsMax {
  // When
  _flexibleHeaderView.maximumHeight = 100;
  _flexibleHeaderView.minimumHeight = 200;

  // Then
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.minimumHeight, 200, 0.0001f);
  XCTAssertEqualWithAccuracy(_flexibleHeaderView.maximumHeight, 200, 0.0001f);
}

@end
