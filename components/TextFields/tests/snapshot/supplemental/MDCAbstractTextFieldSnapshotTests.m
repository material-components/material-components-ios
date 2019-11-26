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

- (void)setUp {
  [super setUp];
  // NOTE: Please keep the default value as `YES` so test authors don't forget to set this property.
  // Turning off "empty" tests is an optimization and it's better not to skip them.
  self.shouldExecuteEmptyTests = YES;

  // Default to Latin strings
  self.shortInputText = MDCTextFieldSnapshotTestsInputShortTextLatin;
  self.longInputText = MDCTextFieldSnapshotTestsInputLongTextLatin;
  self.shortPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextLatin;
  self.longPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextLatin;
  self.shortHelperText = MDCTextFieldSnapshotTestsHelperShortTextLatin;
  self.longHelperText = MDCTextFieldSnapshotTestsHelperLongTextLatin;
  self.shortErrorText = MDCTextFieldSnapshotTestsErrorShortTextLatin;
  self.longErrorText = MDCTextFieldSnapshotTestsErrorLongTextLatin;
}

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

- (void)invokeWillGenerateSnapshotAndVerify {
  if ([self conformsToProtocol:@protocol(MDCTextFieldSnapshotTestCaseHooking)]) {
    if ([self respondsToSelector:@selector(willGenerateSnapshotAndVerify)]) {
      id<MDCTextFieldSnapshotTestCaseHooking> selfAsHooking =
          (id<MDCTextFieldSnapshotTestCaseHooking>)self;
      [selfAsHooking willGenerateSnapshotAndVerify];
    }
  }
}

#pragma mark - Tests

- (void)testTextFieldEmpty {
  if (![self shouldTestExecute]) {
    return;
  }

  if (!self.shouldExecuteEmptyTests) {
    return;
  }

  // When
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldEmptyIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  if (!self.shouldExecuteEmptyTests) {
    return;
  }

  // When
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldEmptyDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  if (!self.shouldExecuteEmptyTests) {
    return;
  }

  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Single field tests

- (void)testTextFieldWithShortPlaceholderText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortPlaceholderTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortPlaceholderTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongPlaceholderText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = self.longPlaceholderText;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongPlaceholderTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = self.longPlaceholderText;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongPlaceholderTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.placeholderText = self.longPlaceholderText;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortHelperText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = self.shortHelperText;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortHelperTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = self.shortHelperText;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortHelperTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = self.shortHelperText;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongHelperText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = self.longHelperText;
  self.textField.leadingUnderlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.textField.leadingUnderlineLabel.numberOfLines = 0;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongHelperTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = self.longHelperText;
  self.textField.leadingUnderlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.textField.leadingUnderlineLabel.numberOfLines = 0;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongHelperTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textFieldController.helperText = self.longHelperText;
  self.textField.leadingUnderlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.textField.leadingUnderlineLabel.numberOfLines = 0;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortErrorText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:self.shortErrorText
                 errorAccessibilityValue:self.shortErrorText];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortErrorTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:self.shortErrorText
                 errorAccessibilityValue:self.shortErrorText];
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortErrorTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:self.shortErrorText
                 errorAccessibilityValue:self.shortErrorText];
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongErrorText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:self.longErrorText
                 errorAccessibilityValue:self.longErrorText];
  self.textField.leadingUnderlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.textField.leadingUnderlineLabel.numberOfLines = 0;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongErrorTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:self.longErrorText
                 errorAccessibilityValue:self.longErrorText];
  self.textField.leadingUnderlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.textField.leadingUnderlineLabel.numberOfLines = 0;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongErrorTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  [self.textFieldController setErrorText:self.longErrorText
                 errorAccessibilityValue:self.longErrorText];
  self.textField.leadingUnderlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.textField.leadingUnderlineLabel.numberOfLines = 0;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputText {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputTextIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputTextDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

#pragma mark - Multiple field tests

- (void)testTextFieldWithShortInputPlaceholderHelperTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  self.textFieldController.helperText = self.shortHelperText;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderHelperTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  self.textFieldController.helperText = self.shortHelperText;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderHelperTextsDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  self.textFieldController.helperText = self.shortHelperText;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderHelperTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  self.textFieldController.placeholderText = self.longPlaceholderText;
  self.textFieldController.helperText = self.longHelperText;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderHelperTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  self.textFieldController.placeholderText = self.longPlaceholderText;
  self.textFieldController.helperText = self.longHelperText;
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderHelperTextsDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  self.textFieldController.placeholderText = self.longPlaceholderText;
  self.textFieldController.helperText = self.longHelperText;
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderErrorTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  [self.textFieldController setErrorText:self.shortErrorText
                 errorAccessibilityValue:self.shortErrorText];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderErrorTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  [self.textFieldController setErrorText:self.shortErrorText
                 errorAccessibilityValue:self.shortErrorText];
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithShortInputPlaceholderErrorTextsDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.shortInputText;
  self.textFieldController.placeholderText = self.shortPlaceholderText;
  [self.textFieldController setErrorText:self.shortErrorText
                 errorAccessibilityValue:self.shortErrorText];
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderErrorTexts {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  self.textFieldController.placeholderText = self.longPlaceholderText;
  [self.textFieldController setErrorText:self.longErrorText
                 errorAccessibilityValue:self.longErrorText];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderErrorTextsIsEditing {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  self.textFieldController.placeholderText = self.longPlaceholderText;
  [self.textFieldController setErrorText:self.longErrorText
                 errorAccessibilityValue:self.longErrorText];
  [self.textField MDCtest_setIsEditing:YES];
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

- (void)testTextFieldWithLongInputPlaceholderErrorTextsDisabled {
  if (![self shouldTestExecute]) {
    return;
  }

  // When
  self.textField.text = self.longInputText;
  self.textFieldController.placeholderText = self.longPlaceholderText;
  [self.textFieldController setErrorText:self.longErrorText
                 errorAccessibilityValue:self.longErrorText];
  self.textField.enabled = NO;
  [self invokeWillGenerateSnapshotAndVerify];

  // Then
  [self generateSnapshotAndVerify];
}

@end
