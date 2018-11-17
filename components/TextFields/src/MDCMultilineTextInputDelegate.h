// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 MDCMultilineTextInputDelegate has a method common to the UITextFieldDelegate protocol but not
 found in UITextViewDelegate.
 */

#import <UIKit/UIKit.h>

@protocol MDCMultilineTextInputDelegate <NSObject>

@optional

/**
 Called when the clear button is tapped.

 Return YES to set the textfield's .text to nil.
 Return NO to ignore and keep the .text.

 A direct mirror of UITextFieldDelegate's textFieldShouldClear:.

 UITextView's don't require this method already because they do not have clear buttons. The clear
 button in MDCMultilineTextField is custom.
 */
- (BOOL)multilineTextFieldShouldClear:(UIView<MDCTextInput> *)textField;

@end
