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

#import "MaterialChips.h"
#import "MaterialInk.h"

@interface MDCChipView (PrivateTesting)
- (MDCInkView *)inkView;
@end

@interface ChipsInkColorTests : XCTestCase

@end

@implementation ChipsInkColorTests

- (void)testDefault {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  MDCInkView *inkView = [[MDCInkView alloc] init];

  // Then
  XCTAssertNil([chip inkColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects(inkView.defaultInkColor, chip.inkView.inkColor);
}

- (void)testCustom {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  UIColor *cyan = [UIColor cyanColor];

  // When
  [chip setInkColor:cyan forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(cyan, [chip inkColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects(cyan, chip.inkView.inkColor);
}

- (void)testResetting {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  MDCInkView *inkView = [[MDCInkView alloc] init];
  UIColor *cyan = [UIColor cyanColor];

  // When
  [chip setInkColor:cyan forState:UIControlStateNormal];
  [chip setInkColor:nil forState:UIControlStateNormal];

  // Then
  XCTAssertNil([chip inkColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects(inkView.defaultInkColor, chip.inkView.inkColor);
}

@end
