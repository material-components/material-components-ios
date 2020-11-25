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

#import "MaterialTextControls+FilledTextFieldsTheming.h"
#import "MaterialTextControls+OutlinedTextFieldsTheming.h"
#import "MaterialTextControls+UnderlinedTextFieldsTheming.h"

@interface MDCBaseTextFieldTestsSnapshotTestHelpers : NSObject

+ (MDCBaseTextField *)createBaseTextField;
+ (MDCFilledTextField *)createFilledTextField;
+ (MDCOutlinedTextField *)createOutlinedTextField;
+ (MDCUnderlinedTextField *)createUnderlinedTextField;

+ (void)configureTextFieldWithColoredAssistiveLabelText:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithText:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithLeadingView:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithLeadingViewAndTextWhileEditing:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithTrailingViewAndText:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithLeadingViewAndTrailingViewAndTextWithCustomPadding:
    (MDCBaseTextField *)textField;
+ (void)configureTextFieldWithVisibleClearButtonAndText:(MDCBaseTextField *)textField;
+ (void)configureWithColoredFloatingLabelTextAndTextWhileEditing:(MDCBaseTextField *)textField;
+ (void)configureDisabledTextFieldWithLabelTextAndText:(MDCBaseTextField *)textField;
+ (void)configureEditingTextFieldWithVisiblePlaceholderAndLabelText:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithColoredAssistiveLabelTextWhileEditing:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithColoredAssistiveLabelTextWhileDisabled:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithScaledFontsAndAXXXLargeContentSize:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithTextAndLabelTextAndPreferredContainerHeightWhileEditing:
    (MDCBaseTextField *)textField;
+ (void)configureTextFieldWithTextAndNoLabelTextAndPreferredContainerHeightWhileEditing:
    (MDCBaseTextField *)textField;
+ (void)configureTextFieldWithHebrewTextAndTrailingViewInRTL:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithHebrewTextAndLeadingViewInRTL:(MDCBaseTextField *)textField;
+ (void)configureTextFieldWithLeadingViewTrailingViewAndCustomPaddings:
    (MDCBaseTextField *)textField;

@end
