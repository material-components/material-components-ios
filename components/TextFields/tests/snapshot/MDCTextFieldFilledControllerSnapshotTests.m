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

  // Uncomment below to recreate the golden images for all test methods. Add it to a test method to
  // update only that golden image.
  //  self.recordMode = YES;

  self.textField.clearButtonMode = UITextFieldViewModeAlways;

  self.textFieldController =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:self.textField];
  self.textFieldController.floatingEnabled = NO;
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

- (void)testFilledFloatingTextFieldEmpty {
  // When
  self.textFieldController.floatingEnabled = YES;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldEmptyIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithShortPlaceholderText {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithShortPlaceholderTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithLongPlaceholderText {
  // When

  // When
  self.textFieldController.floatingEnabled = YES;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithLongPlaceholderTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithShortHelperText {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithShortHelperTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithLongHelperText {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithLongHelperTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithShortErrorText {
  // When
  self.textFieldController.floatingEnabled = YES;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithShortErrorTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithLongErrorText {
  // When
  self.textFieldController.floatingEnabled = YES;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithLongErrorTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithShortInputText {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithShortInputTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithLongInputText {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithLongInputTextIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithShortInputPlaceholderHelperTexts {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithShortInputPlaceholderHelperTextsIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithLongInputPlaceholderHelperTexts {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithLongInputPlaceholderHelperTextsIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithShortInputPlaceholderErrorTexts {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithShortInputPlaceholderErrorTextsIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
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

- (void)testFilledFloatingTextFieldWithLongInputPlaceholderErrorTexts {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledFloatingTextFieldWithLongInputPlaceholderErrorTextsIsEditing {
  // When
  self.textFieldController.floatingEnabled = YES;
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

@end
