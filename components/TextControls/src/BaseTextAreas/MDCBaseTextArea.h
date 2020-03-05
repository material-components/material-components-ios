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

#import "MDCTextControlLabelBehavior.h"
#import "MDCTextControlState.h"

/**
 A UIControl subclass that leverages UITextView to provide multi-line text input
*/
@interface MDCBaseTextArea : UIControl <UIContentSizeCategoryAdjusting>

/**
 The @c label is a label that occupies the area the text usually occupies when there is no
 text. It is distinct from the placeholder in that it can move above the text area or disappear to
 reveal the placeholder when editing begins.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *label;

/**
 This property determines the behavior of the textfield's label during editing.
 @note The default is MDCTextControlLabelBehaviorFloats.
 */
@property(nonatomic, assign) MDCTextControlLabelBehavior labelBehavior;

/**
 The @c leadingAssistiveLabel is a label below the text on the leading edge of the view. It can be
 used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *leadingAssistiveLabel;

/**
 The @c trailingAssistiveLabel is a label below the text on the trailing edge of the view. It can be
 used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *trailingAssistiveLabel;

/**
The UITextView contained within the text area.
 */
@property(strong, nonatomic, readonly, nonnull) UITextView *textView;

/**
The minimum number of simultaneously visible lines of text. The height of the text area will reflect
this value if the number of lines of total text is less than or equal to this value. Fractional
values are allowed.
 */
@property(nonatomic, assign) CGFloat minimumNumberOfVisibleRows;

/**
The maximum number of simultaneously visible lines of text. The height of the text area will reflect
this value if the number of lines of total text is greater than or equal to this value. Fractional
values are allowed.
 */
@property(nonatomic, assign) CGFloat maximumNumberOfVisibleRows;

/**
 Sets the floating label color for a given state. Floating label color refers to the color of the
 label when it's in its "floating position," i.e. when it's floating.
 @param floatingLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setFloatingLabelColor:(nonnull UIColor *)floatingLabelColor
                     forState:(MDCTextControlState)state;
/**
 Returns the floating label color for a given state. Floating label color refers to the color of the
 label when it's in its "floating position," i.e. when it's floating.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)floatingLabelColorForState:(MDCTextControlState)state;

/**
 Sets the normal label color for a given state. Normal label color refers to the color of the label
 when it's in its "normal position," i.e. when it's not floating.
 @param normalLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setNormalLabelColor:(nonnull UIColor *)normalLabelColor forState:(MDCTextControlState)state;
/**
 Returns the normal label color for a given state. Normal label color refers to the color of the
 label when it's in its "normal position," i.e. when it's not floating.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)normalLabelColorForState:(MDCTextControlState)state;

/**
 Sets the text color for a given state.
 @param textColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setTextColor:(nonnull UIColor *)textColor forState:(MDCTextControlState)state;
/**
 Returns the text color for a given state.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)textColorForState:(MDCTextControlState)state;

/**
 Sets the leading assistive label text color.
 @param leadingAssistiveLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setLeadingAssistiveLabelColor:(nonnull UIColor *)leadingAssistiveLabelColor
                             forState:(MDCTextControlState)state;

/**
 Returns the leading assistive label color for a given state.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)leadingAssistiveLabelColorForState:(MDCTextControlState)state;

/**
 Sets the trailing assistive label text color.
 @param trailingAssistiveLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setTrailingAssistiveLabelColor:(nonnull UIColor *)trailingAssistiveLabelColor
                              forState:(MDCTextControlState)state;

/**
 Returns the trailing assistive label color for a given state.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)trailingAssistiveLabelColorForState:(MDCTextControlState)state;

@end
