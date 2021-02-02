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

#import "supplemental/MDCBaseTextFieldTestsSnapshotTestHelpers.h"
#import "supplemental/MDCTextControlSnapshotTestHelpers.h"
#import "MaterialTextControls+FilledTextFields.h"

@interface MDCFilledTextFieldTestsSnapshotTests : MDCSnapshotTestCase
@property(strong, nonatomic) MDCFilledTextField *textField;
@property(nonatomic, assign) BOOL areAnimationsEnabled;
@end

@implementation MDCFilledTextFieldTestsSnapshotTests

- (void)setUp {
  [super setUp];

  self.areAnimationsEnabled = UIView.areAnimationsEnabled;
  [UIView setAnimationsEnabled:NO];
  [MDCTextControlSnapshotTestHelpers setUpViewControllerHierarchy];
  self.textField = [MDCBaseTextFieldTestsSnapshotTestHelpers createFilledTextField];
  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).

  //    self.recordMode = YES;
}

- (void)tearDown {
  [super tearDown];
  [MDCTextControlSnapshotTestHelpers
      removeTextControlFromViewHierarchy:(UIView<MDCTextControl> *)self.textField];
  self.textField = nil;
  [MDCTextControlSnapshotTestHelpers tearDownViewControllerHierarchy];
  [UIView setAnimationsEnabled:self.areAnimationsEnabled];
}

- (void)validateTextField:(MDCFilledTextField *)textField {
  [MDCTextControlSnapshotTestHelpers validateTextControl:(UIView<MDCTextControl> *)textField
                                            withTestCase:self];
}

#pragma mark - Tests

- (void)testTextFieldWithText {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers configureTextFieldWithText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingView {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers configureTextFieldWithLeadingView:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingViewWhileEditing {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithLeadingViewAndTextWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithTrailingView {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers configureTextFieldWithTrailingViewAndText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingViewAndTrailingView {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithLeadingViewAndTrailingViewAndTextWithCustomPadding:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithVisibleClearButton {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithVisibleClearButtonAndText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testFloatingLabelWithCustomColorWhileEditing {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureWithColoredFloatingLabelTextAndTextWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testDisabledTextField {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureDisabledTextFieldWithLabelTextAndText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testEditingTextFieldWithVisiblePlaceholder {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureEditingTextFieldWithVisiblePlaceholderAndLabelText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithAssistiveLabelText {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithColoredAssistiveLabelText:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithAssistiveLabelTextWhileEditing {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithColoredAssistiveLabelTextWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithAssistiveLabelTextWhileDisabled {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithColoredAssistiveLabelTextWhileDisabled:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithScaledFontsAndXXXLargeContentSize {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithScaledFontsAndAXXXLargeContentSize:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithTextAndLabelTextAndPreferredContainerHeightWhileEditing {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithTextAndLabelTextAndPreferredContainerHeightWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithTextAndNoLabelTextAndPreferredContainerHeightWhileEditing {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithTextAndNoLabelTextAndPreferredContainerHeightWhileEditing:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithHebrewTextAndLeadingViewInRTL {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithHebrewTextAndLeadingViewInRTL:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithHebrewTextAndTrailingViewInRTL {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithHebrewTextAndTrailingViewInRTL:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingViewTrailingViewAndCustomPaddings {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureTextFieldWithLeadingViewTrailingViewAndCustomPaddings:textField];

  // Then
  [self validateTextField:textField];
}

- (void)testEditingDenseTextFieldWithLabelTextAndText {
  // Given
  MDCFilledTextField *textField = self.textField;

  // When
  [MDCBaseTextFieldTestsSnapshotTestHelpers
      configureEditingDenseTextFieldWithLabelTextAndText:textField];

  // Then
  [self validateTextField:textField];
}

@end
