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

#import "MaterialTextControls+Enums.h"
#import "MaterialTextControls+UnderlinedTextFields.h"

@interface MDCUnderlinedTextFieldTests : XCTestCase
@end

@implementation MDCUnderlinedTextFieldTests

#pragma mark Tests

- (void)testUnderlineColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCUnderlinedTextField *textField = [[MDCUnderlinedTextField alloc] initWithFrame:textFieldFrame];
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

- (void)testNormalUnderlineThickness {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCUnderlinedTextField *textField = [[MDCUnderlinedTextField alloc] initWithFrame:textFieldFrame];

  // When
  textField.normalUnderlineThickness = 4;
  CGFloat normalUnderThicknessWithNormalSetter = textField.normalUnderlineThickness;
  [textField setNormalUnderlineThickness:5 animated:NO];
  CGFloat normalUnderThicknessWithAnimatedSetter = textField.normalUnderlineThickness;

  // Then
  XCTAssertEqual(normalUnderThicknessWithNormalSetter, 4);
  XCTAssertEqual(normalUnderThicknessWithAnimatedSetter, 5);
}

- (void)testEditingUnderlineThickness {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCUnderlinedTextField *textField = [[MDCUnderlinedTextField alloc] initWithFrame:textFieldFrame];

  // When
  textField.editingUnderlineThickness = 2;
  CGFloat editingUnderThicknessWithNormalSetter = textField.editingUnderlineThickness;
  [textField setEditingUnderlineThickness:3 animated:NO];
  CGFloat editingUnderThicknessWithAnimatedSetter = textField.editingUnderlineThickness;

  // Then
  XCTAssertEqual(editingUnderThicknessWithNormalSetter, 2);
  XCTAssertEqual(editingUnderThicknessWithAnimatedSetter, 3);
}

@end
