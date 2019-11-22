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

#import "MaterialTextFields.h"

@interface MDCTextFieldAccessibilityTests : XCTestCase

@end

@implementation MDCTextFieldAccessibilityTests

- (void)testUITextFieldAccessibilityLabel {
  // Given
  UITextField *field = [[UITextField alloc] init];

  // When
  field.accessibilityLabel = @"main accessibility label";

  // Then
  XCTAssertEqualObjects(field.accessibilityLabel, @"main accessibility label");
}

- (void)testMDCTextFieldaccessibilityLabel {
  // Given
  MDCTextField *field = [[MDCTextField alloc] init];

  // When
  field.accessibilityLabel = @"main accessibility label";

  // Then
  XCTAssertEqualObjects(field.accessibilityLabel, @"main accessibility label");
}

- (void)testMDCTextFieldAccessibilityLabelUnderlineLabels {
  // Given
  MDCTextField *field = [[MDCTextField alloc] init];

  // When
  field.accessibilityLabel = @"main accessibility label";
  field.leadingUnderlineLabel.accessibilityLabel = @"leading underline";
  field.trailingUnderlineLabel.accessibilityLabel = @"trailing underline";

  // Then
  XCTAssertEqualObjects(field.accessibilityLabel,
                        @"main accessibility label, leading underline, trailing underline");
}

- (void)testMDCTextFieldAccessibilityLabelPlaceholder {
  // Given
  MDCTextField *field = [[MDCTextField alloc] init];

  // When
  field.accessibilityLabel = nil;
  field.placeholderLabel.accessibilityLabel = @"placeholder";
  field.leadingUnderlineLabel.accessibilityLabel = @"leading underline";
  field.trailingUnderlineLabel.accessibilityLabel = @"trailing underline";

  // Then
  XCTAssertEqualObjects(field.accessibilityLabel,
                        @"placeholder, leading underline, trailing underline");
}

- (void)testMDCTextFieldAccessibilityLabelPlaceholderAndLabel {
  // Given
  MDCTextField *field = [[MDCTextField alloc] init];

  // When
  field.accessibilityLabel = @"main accessibility label";
  field.placeholderLabel.accessibilityLabel = @"placeholder";
  field.leadingUnderlineLabel.accessibilityLabel = @"leading underline";
  field.trailingUnderlineLabel.accessibilityLabel = @"trailing underline";

  // Then
  XCTAssertEqualObjects(field.accessibilityLabel,
                        @"main accessibility label, leading underline, trailing underline");
}

@end
