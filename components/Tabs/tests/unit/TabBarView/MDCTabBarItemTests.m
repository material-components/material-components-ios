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

#import "MaterialTabs+TabBarView.h"

@interface MDCTabBarItemTestCustomViewTestFake : UIView <MDCTabBarViewCustomViewable>
@end

@implementation MDCTabBarItemTestCustomViewTestFake

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  // No-op
}

- (CGRect)contentFrame {
  return CGRectZero;
}

@end

@interface MDCTabBarItemTests : XCTestCase
@end

@implementation MDCTabBarItemTests

- (void)testGetterSetterForCustomView {
  // Given
  MDCTabBarItemTestCustomViewTestFake *customView =
      [[MDCTabBarItemTestCustomViewTestFake alloc] init];
  MDCTabBarItem *barItem = [[MDCTabBarItem alloc] init];

  // When
  barItem.mdc_customView = customView;

  // Then
  XCTAssertEqual(barItem.mdc_customView, customView);
}

@end
