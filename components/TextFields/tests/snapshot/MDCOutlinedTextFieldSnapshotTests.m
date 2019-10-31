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

#import "MaterialSnapshot.h"

#import <UIKit/UIKit.h>

#import "../../src/ContainedInputView/private/MDCTextControl.h"
#import "MDCBaseTextFieldTestsSnapshotTestHelpers.h"
#import "MDCTextControlSnapshotTestHelpers.h"
#import "MaterialTextFields+ContainedInputView.h"

@interface MDCOutlinedTextFieldTestsSnapshotTests : MDCSnapshotTestCase
@property(strong, nonatomic) MDCOutlinedTextField *textField;
@property(nonatomic, assign) BOOL areAnimationsEnabled;
@end

@implementation MDCOutlinedTextFieldTestsSnapshotTests

- (void)setUp {
  [super setUp];

  self.areAnimationsEnabled = UIView.areAnimationsEnabled;
  [UIView setAnimationsEnabled:NO];
  self.textField = [self createOutlinedTextFieldInKeyWindow];
  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).

  //      self.recordMode = YES;
}

- (void)tearDown {
  [super tearDown];
  [self.textField removeFromSuperview];
  self.textField = nil;
  [UIView setAnimationsEnabled:self.areAnimationsEnabled];
}

- (MDCOutlinedTextField *)createOutlinedTextFieldInKeyWindow {
  MDCOutlinedTextField *textField =
      [[MDCOutlinedTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
  textField.animationDuration = 0;

  // Using a dummy inputView instead of the system keyboard cuts the execution time roughly in half,
  // at least locally.
  UIView *dummyInputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  textField.inputView = dummyInputView;

  // Add the textfield to the window so it's part of a valid view hierarchy and things like
  // `-becomeFirstResponder` work.
  UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
  [keyWindow addSubview:textField];
  return textField;
}

- (void)validateTextField:(MDCOutlinedTextField *)textField {
  [MDCTextControlSnapshotTestHelpers validateTextControl:(UIView<MDCTextControl> *)textField
                                            withTestCase:self];
}

#pragma mark - Tests

- (void)testTextFieldWithText {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers configureTextFieldWithText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingView {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers configureTextFieldWithLeadingView:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingViewWhileEditing {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithLeadingViewAndTextWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithTrailingView {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers configureTextFieldWithTrailingViewAndText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingViewAndTrailingView {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithLeadingViewAndTrailingViewAndText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithVisibleClearButton {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithVisibleClearButtonAndText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testFloatingLabelWithCustomColorWhileEditing {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureWithColoredFloatingLabelTextAndTextWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testDisabledTextField {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureDisabledTextFieldWithLabelTextAndText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testEditingTextFieldWithVisiblePlaceholder {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureEditingTextFieldWithVisiblePlaceholderAndLabelText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithAssistiveLabelText {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithColoredAssistiveLabelText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithAssistiveLabelTextWhileEditing {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithColoredAssistiveLabelTextWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithAssistiveLabelTextWhileDisabled {
  // Given
  MDCOutlinedTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithColoredAssistiveLabelTextWhileDisabled:textField];

  // Then
  [self validateTextField:textField];
}

@end
