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

#import <XCTest/XCTest.h>

#import "MDCChipField.h"
#import "MDCChipFieldDelegate.h"
#import "MDCChipView.h"
#import "MaterialTextFields.h"

/**
 A class to record messages from MDCChipField.
 */
@interface MDCChipFieldDelegateFake : NSObject <MDCChipFieldDelegate>
/** The chip field (if any) passed as an argument to chipFieldHeightDidChange: */
@property(nonatomic) MDCChipField *heightChangedChipField;
@end

@implementation MDCChipFieldDelegateFake

- (void)chipFieldHeightDidChange:(MDCChipField *)chipField {
  self.heightChangedChipField = chipField;
}

@end

/**
 Tests to ensure communication between @c MDCChipField and its delegate happens as expected.
 */
@interface MDCChipFieldDelegateTests : XCTestCase
/** The MDCChipField being tested. */
@property(nonatomic) MDCChipField *chipField;
/** The MDCChipField delegate used to record calls from chipField. */
@property(nonatomic) MDCChipFieldDelegateFake *delegate;
@end

@implementation MDCChipFieldDelegateTests

- (void)setUp {
  [super setUp];

  self.chipField = [[MDCChipField alloc] init];
  self.chipField.textField.placeholder = @"Placeholder";
  [self.chipField sizeToFit];
  self.delegate = [[MDCChipFieldDelegateFake alloc] init];
  self.chipField.delegate = self.delegate;
}

/**
 Ensures the @c MDCChipField's delegate is notified of a height change triggered by text input.
 */
- (void)testHeightChangedCalledOnTextAddition {
  // Given
  [self.chipField addChip:[self chipViewWithTitle:@"Chip"]];
  // Adding a chip calls chipFieldHeightDidChange, so we need to reset heightChangedChipField to nil
  self.delegate.heightChangedChipField = nil;
  [self.chipField layoutIfNeeded];

  // When
  self.chipField.textField.text = @"This is a very very long chip field string";

  // Then
  XCTAssertNotNil(self.delegate.heightChangedChipField);
  XCTAssertEqualObjects(self.delegate.heightChangedChipField, self.chipField);
}

/**
 Ensures the @c MDCChipField's delegate is notified of a height change triggered by chip addition.
 */
- (void)testHeightChangedCalledOnChipAddition {
  // When
  [self.chipField addChip:[self chipViewWithTitle:@"Chip"]];
  [self.chipField layoutIfNeeded];

  // Then
  XCTAssertNotNil(self.delegate.heightChangedChipField);
  XCTAssertEqualObjects(self.delegate.heightChangedChipField, self.chipField);
}

/**
 Ensures the @c MDCChipField's delegate is notified of a height change triggered by chip removal.
 */
- (void)testHeightChangedCalledOnChipRemoval {
  // Given
  // Because the chip field does not change height when its only chip is removed, we need to test
  // the removal of a second chip.
  [self.chipField addChip:[self chipViewWithTitle:@"title 1"]];
  [self.chipField addChip:[self chipViewWithTitle:@"title 2"]];
  // Adding a chip calls chipFieldHeightDidChange, so we need to reset heightChangedChipField to nil
  self.delegate.heightChangedChipField = nil;

  // When
  [self.chipField removeChip:self.chipField.chips.firstObject];
  [self.chipField layoutIfNeeded];

  // Then
  XCTAssertNotNil(self.delegate.heightChangedChipField);
  XCTAssertEqualObjects(self.delegate.heightChangedChipField, self.chipField);
}

#pragma mark - Helpers

- (MDCChipView *)chipViewWithTitle:(NSString *)title {
  MDCChipView *chipView = [[MDCChipView alloc] init];
  chipView.titleLabel.text = title;
  [chipView sizeToFit];
  return chipView;
}

@end
