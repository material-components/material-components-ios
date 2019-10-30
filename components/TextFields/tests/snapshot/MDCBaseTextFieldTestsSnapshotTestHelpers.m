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

#import "MDCBaseTextFieldTestsSnapshotTestHelpers.h"

/**
 This class puts the configuration for TextControl based TextField snapshot tests in one place so
 that snapshot test cases for the MDCFilledTextField and MDCOutlinedTextField can test the same
 things being tested for MDCBaseTextField. When b/133313258 is fixed this configuration code will
 probably be moved back to a MDCBaseTextField snapshot test case that will have a subclass for each
 MDCBaseTextField subclass.
 */
@implementation MDCBaseTextFieldTestsSnapshotTestHelpers

#pragma mark "When" configurations

+ (void)configureTextFieldWithColoredAssistiveLabelText:(MDCBaseTextField *)textField {
  textField.text = @"text";
  textField.leadingAssistiveLabel.text = @"leading assistive label text";
  textField.trailingAssistiveLabel.text = @"trailing assistive label text";
  [textField setLeadingAssistiveLabelColor:[UIColor blueColor] forState:MDCTextControlStateNormal];
  [textField setTrailingAssistiveLabelColor:[UIColor redColor] forState:MDCTextControlStateNormal];
}

+ (void)configureTextFieldWithText:(MDCBaseTextField *)textField {
  textField.text = @"Text";
}

+ (void)configureTextFieldWithLeadingView:(MDCBaseTextField *)textField {
  textField.text = @"Text";
  textField.leadingView = [self createRedSideView];
  textField.leadingViewMode = UITextFieldViewModeAlways;
}

+ (void)configureTextFieldWithLeadingViewAndTextWhileEditing:(MDCBaseTextField *)textField {
  textField.leadingView = [self createRedSideView];
  textField.leadingViewMode = UITextFieldViewModeWhileEditing;
  textField.text = @"Text";
  [textField becomeFirstResponder];
}

+ (void)configureTextFieldWithTrailingViewAndText:(MDCBaseTextField *)textField {
  textField.text = @"Text";
  textField.trailingView = [self createBlueSideView];
  textField.trailingViewMode = UITextFieldViewModeAlways;
}

+ (void)configureTextFieldWithLeadingViewAndTrailingViewAndText:(MDCBaseTextField *)textField {
  textField.text = @"Text";
  textField.leadingView = [self createBlueSideView];
  textField.trailingView = [self createRedSideView];
  textField.trailingViewMode = UITextFieldViewModeAlways;
  textField.leadingViewMode = UITextFieldViewModeAlways;
}

+ (void)configureTextFieldWithVisibleClearButtonAndText:(MDCBaseTextField *)textField {
  textField.clearButtonMode = UITextFieldViewModeAlways;
  textField.text = @"Text";
}

+ (void)configureWithColoredFloatingLabelTextAndTextWhileEditing:(MDCBaseTextField *)textField {
  textField.label.text = @"Floating label text";
  textField.text = @"Text";
  [textField setFloatingLabelColor:[UIColor purpleColor] forState:MDCTextControlStateEditing];
  [textField becomeFirstResponder];
}

+ (void)configureDisabledTextFieldWithLabelTextAndText:(MDCBaseTextField *)textField {
  textField.label.text = @"Floating label text";
  textField.text = @"Text";
  textField.enabled = NO;
}

+ (void)configureEditingTextFieldWithVisiblePlaceholderAndLabelText:(MDCBaseTextField *)textField {
  textField.label.text = @"Floating label text";
  textField.placeholder = @"Placeholder";
  [textField becomeFirstResponder];
}

+ (void)configureTextFieldWithColoredAssistiveLabelTextWhileEditing:(MDCBaseTextField *)textField {
  textField.text = @"text";
  textField.leadingAssistiveLabel.text = @"leading assistive label text";
  textField.trailingAssistiveLabel.text = @"trailing assistive label text";
  [textField setLeadingAssistiveLabelColor:[UIColor blueColor] forState:MDCTextControlStateEditing];
  [textField setTrailingAssistiveLabelColor:[UIColor redColor] forState:MDCTextControlStateEditing];
  [textField becomeFirstResponder];
}

+ (void)configureTextFieldWithColoredAssistiveLabelTextWhileDisabled:(MDCBaseTextField *)textField {
  textField.text = @"text";
  textField.leadingAssistiveLabel.text = @"leading assistive label text";
  textField.trailingAssistiveLabel.text = @"trailing assistive label text";
  [textField setLeadingAssistiveLabelColor:[UIColor blueColor]
                                  forState:MDCTextControlStateDisabled];
  [textField setTrailingAssistiveLabelColor:[UIColor redColor]
                                   forState:MDCTextControlStateDisabled];
  textField.enabled = NO;
}

#pragma mark Helpers

+ (UIView *)createBlueSideView {
  return [MDCBaseTextFieldTestsSnapshotTestHelpers createSideViewWithColor:[UIColor blueColor]];
}

+ (UIView *)createRedSideView {
  return [MDCBaseTextFieldTestsSnapshotTestHelpers createSideViewWithColor:[UIColor redColor]];
}

+ (UIView *)createSideViewWithColor:(UIColor *)color {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  view.backgroundColor = color;
  return view;
}

@end
