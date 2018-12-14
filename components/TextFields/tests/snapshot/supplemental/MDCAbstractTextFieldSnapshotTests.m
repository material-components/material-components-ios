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

#import "MDCAbstractTextFieldSnapshotTests.h"
#import "MDCTextFieldSnapshotTestsStrings.h"

@implementation MDCAbstractTextFieldSnapshotTests

- (void)tearDown {
  self.textFieldController = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (BOOL)shouldTestExecute {
  // This class should not actually execute any tests.
  if ([self class] == [MDCAbstractTextFieldSnapshotTests class]) {
    return NO;
  }

  // Always require that `textField` and `textFieldController` are non-nil before starting the test.
  XCTAssertNotNil(self.textField);
  XCTAssertNotNil(self.textFieldController);

  return YES;
}

#pragma mark - Tests

- (void)testTextFieldEmpty {
  if (![self shouldTestExecute]) {
    return;
  }

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldEmptyIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Single field tests

- (void)testTextFieldWithShortPlaceholderText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortPlaceholderTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongPlaceholderText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongPlaceholderTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortHelperText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortHelperTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongHelperText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongHelperTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortErrorText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortErrorTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongErrorText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongErrorTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Multiple field tests

- (void)testTextFieldWithShortInputPlaceholderHelperTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderHelperTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderHelperTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderHelperTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderErrorTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderErrorTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderErrorTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderErrorTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

@end
