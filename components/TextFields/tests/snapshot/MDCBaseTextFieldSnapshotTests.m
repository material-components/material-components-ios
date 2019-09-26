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

#import "MaterialTextFields+ContainedInputView.h"

// This timeout value is intended to be temporary. These snapshot tests currently take longer than
// we'd want them to.
static const NSTimeInterval kTextFieldValidationAnimationTimeout = 30.0;

@interface MDCBaseTextFieldTestsSnapshotTests : MDCSnapshotTestCase
@property(strong, nonatomic) MDCBaseTextField *textField;
@property(nonatomic, assign) BOOL areAnimationsEnabled;
@end

@implementation MDCBaseTextFieldTestsSnapshotTests

- (void)setUp {
  [super setUp];

  self.areAnimationsEnabled = UIView.areAnimationsEnabled;
  [UIView setAnimationsEnabled:NO];
  self.textField = [self createBaseTextFieldInKeyWindow];
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

- (MDCBaseTextField *)createBaseTextFieldInKeyWindow {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
  textField.borderStyle = UITextBorderStyleRoundedRect;

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

- (void)validateTextField:(MDCBaseTextField *)textField {
  [textField setNeedsLayout];
  [textField layoutIfNeeded];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"textfield_validation_expectation"];
  dispatch_async(dispatch_get_main_queue(), ^{
    // We take a snapshot of the textfield so we don't have to remove it from the app
    // host's key window. Removing the textfield from the app host's key window
    // before validation can affect the textfield's editing behavior, which has a
    // large effect on the appearance of the textfield.
    UIView *textFieldSnapshot = [textField snapshotViewAfterScreenUpdates:NO];
    [self generateSnapshotAndVerifyForView:textFieldSnapshot];
    [expectation fulfill];
  });
  [self waitForExpectations:@[ expectation ] timeout:kTextFieldValidationAnimationTimeout];
}

- (UIView *)createBlueSideView {
  return [self createSideViewWithColor:[UIColor blueColor]];
}

- (UIView *)createRedSideView {
  return [self createSideViewWithColor:[UIColor redColor]];
}

- (UIView *)createSideViewWithColor:(UIColor *)color {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  view.backgroundColor = color;
  return view;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testTextFieldWithText {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.text = @"Text";

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingView {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.text = @"Text";
  textField.leadingView = [self createRedSideView];
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingViewWhileEditing {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.leadingView = [self createRedSideView];
  textField.leadingViewMode = UITextFieldViewModeWhileEditing;
  textField.text = @"Text";
  [textField becomeFirstResponder];

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithTrailingView {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.text = @"Text";
  textField.trailingView = [self createBlueSideView];
  textField.trailingViewMode = UITextFieldViewModeAlways;

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithLeadingViewAndTrailingView {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.text = @"Text";
  textField.leadingView = [self createBlueSideView];
  textField.trailingView = [self createRedSideView];
  textField.trailingViewMode = UITextFieldViewModeAlways;
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  [self validateTextField:textField];
}

- (void)testTextFieldWithVisibleClearButton {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.clearButtonMode = UITextFieldViewModeAlways;
  textField.text = @"Text";

  // Then
  [self validateTextField:textField];
}

- (void)testFloatingLabelWithCustomColorWhileEditing {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.label.text = @"Floating label text";
  textField.text = @"Text";
  [textField setFloatingLabelColor:[UIColor purpleColor] forState:MDCTextControlStateEditing];
  [textField becomeFirstResponder];

  // Then
  [self validateTextField:textField];
}

- (void)testDisabledTextField {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.label.text = @"Floating label text";
  textField.text = @"Text";
  textField.enabled = NO;

  // Then
  [self validateTextField:textField];
}

- (void)testEditingTextFieldWithVisiblePlaceholder {
  // Given
  MDCBaseTextField *textField = self.textField;

  // When
  textField.label.text = @"Floating label text";
  textField.placeholder = @"Placeholder";
  [textField becomeFirstResponder];

  // Then
  [self validateTextField:textField];
}

@end
