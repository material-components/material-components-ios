// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

@class MDCBaseTextField;

/**
This delegate protocol for @c MDCBaseTextField and its subclasses provides updates not already
covered by @c UITextFieldDelegate.
 */
@protocol MDCBaseTextFieldDelegate <NSObject>

@optional

/**
 This method is called at the end of @c MDCBaseTextField's implementation of @c -deleteBackward.

 @param textField The @c MDCBaseTextField calling @c -deleteBackward.
 */
- (void)baseTextFieldDidDeleteBackward:(MDCBaseTextField *)textField;

/**
 This method is called at the beginning of @c -deleteBackward. If it returns @c NO, the superclass
 (@c UITextField) implementation of @c -deleteBackward will not be called. If it is not implemented,
 the superclass implementation of @c -deleteBackward will always be called.

 @param textField The @c MDCBaseTextField calling @c -deleteBackward.
 */
- (BOOL)baseTextFieldShouldDeleteBackward:(MDCBaseTextField *)textField;

/**
 This method is called from @c MDCBaseTextField's implementation of the @c UIResponder method @c
 -canPerformAction:withSender:. Implementing this method can allow you to do things like preventing
 the user from pasting into the text field, for example.

 @param textField The MDCBaseTextField.
 @param action The action.
 @param sender The sender.
 @param canPerformAction This is the value that the superclass implementation of @c
 -canPerformAction:withSender: returns.
 */
- (BOOL)baseTextField:(MDCBaseTextField *)textField
    shouldPerformAction:(SEL)action
             withSender:(id)sender
       canPerformAction:(BOOL)canPerformAction;

/**
 At the end of every layout pass @c MDCBaseTextField checks to see if the intrinsic height it
 calculates has changed. If it has, it calls this method. Setting assistive label text is an example
 of something that results in this method getting called. If you have a height constraint set on the
 text field, this method is a good place to update that constraint's constant.

 @param textField The MDCBaseTextField.
 @param height The newly calculated height.
 */
- (void)baseTextField:(MDCBaseTextField *)textField didUpdateIntrinsicHeight:(CGFloat)height;

@end
