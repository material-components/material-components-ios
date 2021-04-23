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

#import "MaterialTextControls+Enums.h"
#import "MaterialTextControls+FilledTextFields.h"

@interface MDCFilledTextFieldTests : XCTestCase
@end

@implementation MDCFilledTextFieldTests

#pragma mark Tests

- (void)testFilledBackgroundColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCFilledTextField *textField = [[MDCFilledTextField alloc] initWithFrame:textFieldFrame];
  UIColor *filledBackgroundColorNormal = [UIColor blueColor];
  UIColor *filledBackgroundColorEditing = [UIColor greenColor];
  UIColor *filledBackgroundColorDisabled = [UIColor purpleColor];

  // When
  [textField setFilledBackgroundColor:filledBackgroundColorNormal
                             forState:MDCTextControlStateNormal];
  [textField setFilledBackgroundColor:filledBackgroundColorEditing
                             forState:MDCTextControlStateEditing];
  [textField setFilledBackgroundColor:filledBackgroundColorDisabled
                             forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(filledBackgroundColorNormal,
                        [textField filledBackgroundColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(filledBackgroundColorEditing,
                        [textField filledBackgroundColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(filledBackgroundColorDisabled,
                        [textField filledBackgroundColorForState:MDCTextControlStateDisabled]);
}

- (void)testUnderlineColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCFilledTextField *textField = [[MDCFilledTextField alloc] initWithFrame:textFieldFrame];
  UIColor *underlineColorNormal = [UIColor blueColor];
  UIColor *underlineColorEditing = [UIColor greenColor];
  UIColor *underlineColorDisabled = [UIColor purpleColor];

  // When
  [textField setUnderlineColor:underlineColorNormal forState:MDCTextControlStateNormal];
  [textField setUnderlineColor:underlineColorEditing forState:MDCTextControlStateEditing];
  [textField setUnderlineColor:underlineColorDisabled forState:MDCTextControlStateDisabled];
  // Then
  XCTAssertEqualObjects(underlineColorNormal,
                        [textField underlineColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(underlineColorEditing,
                        [textField underlineColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(underlineColorDisabled,
                        [textField underlineColorForState:MDCTextControlStateDisabled]);
}

@end
