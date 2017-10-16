/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

/**
 MDCTextInputPositioningDelegate allows objects outside an MDCTextInput, like
 MDCTextInputController, to pass the MDCTextInput important layout information.

 Usually, these methods are direct mirrors of internal methods with the addition of a default value.
 */

@protocol MDCTextInputPositioningDelegate <NSObject>

@optional

/**
 The actual input view and the rendered inputted text's position is determined by applying these
 insets to the bounds.

 @param defaultInsets The value of text container insets that the MDCTextInput has calculated by
 default.
 */
- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets;

/**
 The area that inputted text should be displayed while isEditing = true.

 @param defaultRect The default value of the editing rect. It is usually the text rect shrunk or
 enlarged depending on rightView, leftView, or clearButton presences.
 */
- (CGRect)editingRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect;

/** Called from the end of the input's layoutSubviews. */
- (void)textInputDidLayoutSubviews;

/** Called from the end of the input's updateConstraints. */
- (void)textInputDidUpdateConstraints;

@end
