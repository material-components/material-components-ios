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

#import "MDCSnapshotTestCase.h"
#import "MDCTextFieldSnapshotTestsStrings.h"
#import "MaterialTextFields.h"
#import "SnapshotFakeMDCTextField.h"

@interface MDCTextFieldFilledControllerSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) SnapshotFakeMDCTextField *textField;
@property(nonatomic, strong) MDCTextInputControllerFilled *textFieldController;
@end

@implementation MDCTextFieldFilledControllerSnapshotTests

- (void)setUp {
  [super setUp];

  self.textField = [[SnapshotFakeMDCTextField alloc] init];
  self.textField.clearButtonMode = UITextFieldViewModeAlways;

  self.textFieldController =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:self.textField];
}

- (void)tearDown {
  self.textFieldController = nil;
  self.textField = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)triggerTextFieldLayout {
  CGSize aSize = [self.textField sizeThatFits:CGSizeMake(300, INFINITY)];
  self.textField.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [self.textField setNeedsUpdateConstraints];
  [self.textField layoutIfNeeded];
}

- (void)generateSnapshotAndVerify {
  [self triggerTextFieldLayout];
  UIView *snapshotView = [self addBackgroundViewToView:self.textField];

  // Perform the actual verification.
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testFilledTextFieldEmpty {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldEmptyIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Single field tests

- (void)testFilledTextFieldWithShortPlaceholderText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortPlaceholderTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongPlaceholderText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongPlaceholderTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortHelperText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortHelperTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongHelperText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongHelperTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortErrorText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortErrorTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongErrorText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongErrorTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputText {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputTextIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Multiple field tests

- (void)testFilledTextFieldWithShortInputPlaceholderHelperTexts {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputPlaceholderHelperTextsIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputPlaceholderHelperTexts {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputPlaceholderHelperTextsIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.textFieldController.helperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;
  [self.textField MDCtest_setIsEditing:YES];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputPlaceholderErrorTexts {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorShortTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorShortTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithShortInputPlaceholderErrorTextsIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

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
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // When
  self.textField.text = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.textFieldController.placeholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  [self.textFieldController setErrorText:MDCTextFieldSnapshotTestsErrorLongTextLatin
                 errorAccessibilityValue:MDCTextFieldSnapshotTestsErrorLongTextLatin];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testFilledTextFieldWithLongInputPlaceholderErrorTextsIsEditing {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

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
