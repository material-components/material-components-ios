//
//  ChipAccessibilityTests.m
//  MaterialComponentsUnitTests
//
//  Created by Galia Kaufman on 6/18/18.
//

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
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAccessibilityLabel {
  NSString *chipLabel = @"Test1";
  [chip.titleLabel setText:chipLabel];
  XCTAssertTrue(chip.isAccessibilityElement, @"Chip view should be the accessibility element");
  XCTAssertEqual(chip.accessibilityLabel, chipLabel, @"Chip accessibility label should be: [%@]", chipLabel);
}

- (void)testAccessibleEnabledState {
  chip.enabled = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled, UIAccessibilityTraitNotEnabled, @"Chip accessibility should be enabled");

  chip.selected = YES;
  chip.highlighted = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled, UIAccessibilityTraitNotEnabled, @"Chip accessibility should be enabled when selected & highlighted");
}

- (void)testAccessibleDisabledState {
  chip.enabled = NO;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled, UIAccessibilityTraitNotEnabled, @"Chip accessibility should be disabled");

  chip.selected = YES;
  chip.highlighted = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitNotEnabled, UIAccessibilityTraitNotEnabled, @"Chip accessibility should be disabled when selected & highlighted");
}

- (void)testAccessibleSelectedState {
  chip.selected = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected, UIAccessibilityTraitSelected, @"Chip accessibility should be selected");

  chip.enabled = YES;
  chip.highlighted = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected, UIAccessibilityTraitSelected, @"Chip accessibility should be selected when enabled & highlighted");

  chip.enabled = NO;
  chip.highlighted = YES;
  XCTAssertEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected, UIAccessibilityTraitSelected, @"Chip accessibility should be selected when disabled & highlighted");
}

- (void)testAccessibleDeselectedState {
  chip.selected = NO;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected, UIAccessibilityTraitSelected, @"Chip accessibility should be de-selected");

  chip.enabled = YES;
  chip.highlighted = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected, UIAccessibilityTraitSelected, @"Chip accessibility should be de-selected when enabled & highlighted");

  chip.enabled = NO;
  chip.highlighted = YES;
  XCTAssertNotEqual(chip.accessibilityTraits & UIAccessibilityTraitSelected, UIAccessibilityTraitSelected, @"Chip accessibility should be de-selected when disabled & highlighted");
}

@end
