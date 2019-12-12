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

#import <XCTest/XCTest.h>
#import "MaterialChips.h"

@interface ChipAccessibilityTests : XCTestCase

@end

@implementation ChipAccessibilityTests {
  MDCChipView *chip;
}

- (void)setUp {
  [super setUp];
  chip = [[MDCChipView alloc] init];
}

- (void)tearDown {
  chip = nil;
  [super tearDown];
}

- (void)testAccessibilityLabel {
  NSString *chipLabel = @"Test1";
  [chip.titleLabel setText:chipLabel];
  XCTAssertTrue(chip.isAccessibilityElement, @"Chip view should be the accessibility element");
  XCTAssertEqual(chip.accessibilityLabel, chipLabel, @"Chip accessibility label should be: [%@]",
                 chipLabel);
}

- (void)testAccessibleEnabledState {
  chip.enabled = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled,
                    UIAccessibilityTraitNotEnabled, @"Chip accessibility should be enabled");

  chip.selected = YES;
  chip.highlighted = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled,
                    UIAccessibilityTraitNotEnabled,
                    @"Chip accessibility should be enabled when selected & highlighted");
}

- (void)testAccessibleDisabledState {
  chip.enabled = NO;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled,
                 UIAccessibilityTraitNotEnabled, @"Chip accessibility should be disabled");

  chip.selected = YES;
  chip.highlighted = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled,
                 UIAccessibilityTraitNotEnabled,
                 @"Chip accessibility should be disabled when selected & highlighted");
}

- (void)testAccessibleSelectedState {
  chip.selected = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected,
                 UIAccessibilityTraitSelected, @"Chip accessibility should be selected");

  chip.enabled = YES;
  chip.highlighted = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected,
                 UIAccessibilityTraitSelected,
                 @"Chip accessibility should be selected when enabled & highlighted");

  chip.enabled = NO;
  chip.highlighted = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected,
                 UIAccessibilityTraitSelected,
                 @"Chip accessibility should be selected when disabled & highlighted");
}

- (void)testAccessibleDeselectedState {
  chip.selected = NO;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected,
                    UIAccessibilityTraitSelected, @"Chip accessibility should be de-selected");

  chip.enabled = YES;
  chip.highlighted = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected,
                    UIAccessibilityTraitSelected,
                    @"Chip accessibility should be de-selected when enabled & highlighted");

  chip.enabled = NO;
  chip.highlighted = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected,
                    UIAccessibilityTraitSelected,
                    @"Chip accessibility should be de-selected when disabled & highlighted");
}

- (void)testAccessibilityLabel_default {
  // When
  chip.titleLabel.text = @"Title";

  // Then
  XCTAssertEqualObjects(chip.accessibilityLabel, @"Title");
}

- (void)testAccessibilityLabel_setTitleLabelAccessibilityLabel {
  // When
  chip.titleLabel.text = @"Title";
  chip.titleLabel.accessibilityLabel = @"Accessibility Title";

  // Then
  XCTAssertEqualObjects(chip.accessibilityLabel, @"Accessibility Title");
}

- (void)testAccessibilityLabel_setAccessibilityLabel {
  // When
  chip.titleLabel.text = @"Title";
  chip.titleLabel.accessibilityLabel = @"Label accessibility title";
  chip.accessibilityLabel = @"Accessibility Title";

  // Then
  XCTAssertEqualObjects(chip.accessibilityLabel, @"Accessibility Title");
}

@end
