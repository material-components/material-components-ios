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
// WITHOUT WARRANTIES OR CONDITIONS OF ANY MDCTextFieldSnapshotTestsIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCTextFieldSnapshotTestCase.h"
#import "MDCTextFieldSnapshotTestsStrings.h"
#import "MaterialTextFields.h"
#import "SnapshotFakeMDCTextField.h"

@interface MDCTextFieldFilledControllerSnapshotTests : MDCTextFieldSnapshotTestCase
@property(nonatomic, strong) MDCTextInputControllerFilled *textFieldController;
@end

@implementation MDCTextFieldFilledControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  self.textField.clearButtonMode = UITextFieldViewModeAlways;

  self.textFieldController =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:self.textField];
}

- (void)tearDown {
  self.textFieldController = nil;

  [super tearDown];
}

#pragma mark - Tests

- (void)testFilledTextFieldEmpty {
  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldEmptyIsEditing {
  // When
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Single field tests

- (void)testFilledTextFieldWithShortPlaceholderText {
  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortPlaceholderTextIsEditing {
  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongPlaceholderText {
  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongPlaceholderTextIsEditing {
  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortHelperText {
  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortHelperTextIsEditing {
  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongHelperText {
  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongHelperTextIsEditing {
  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortErrorText {
  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortErrorTextIsEditing {
  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongErrorText {
  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongErrorTextIsEditing {
  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputText {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputTextIsEditing {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputText {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputTextIsEditing {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Multiple field tests

- (void)testFilledTextFieldWithShortInputPlaceholderHelperTexts {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputPlaceholderHelperTextsIsEditing {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputPlaceholderHelperTexts {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputPlaceholderHelperTextsIsEditing {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputPlaceholderErrorTexts {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputPlaceholderErrorTextsIsEditing {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputPlaceholderErrorTexts {
  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputPlaceholderErrorTextsIsEditing {
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
