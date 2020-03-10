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

#import <UIKit/UIKit.h>

#import "MaterialTextControls+Enums.h"

/**
 The superclass of MDCFilledTextField and MDCOutlinedTextField. While not forbidden by the compiler,
 subclassing this class is not supported and is highly discouraged.
 */
@interface MDCBaseTextField : UITextField

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
 This is an RTL-aware wrapper around UITextField's leftView/rightView class.
 */
@property(strong, nonatomic, nullable) UIView *leadingView;

/**
 This is an RTL-aware wrapper around UITextField's leftView/rightView class.
 */
@property(strong, nonatomic, nullable) UIView *trailingView;

/**
 This is an RTL-aware wrapper around UITextField's leftViewMode/rightViewMode class.
 */
@property(nonatomic, assign) UITextFieldViewMode leadingViewMode;

/**
 This is an RTL-aware wrapper around UITextField's leftViewMode/rightViewMode class.
 */
@property(nonatomic, assign) UITextFieldViewMode trailingViewMode;

/**
 Sets the floating label color for a given state.
 Floating label color refers to the color of the label when it's in its "floating position," i.e.
 when it's above the text area.
 @param floatingLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setFloatingLabelColor:(nonnull UIColor *)floatingLabelColor
                     forState:(MDCTextControlState)state
    NS_SWIFT_NAME(setFloatingLabelColor(_:for:));

/**
 Returns the floating label color for a given state.
 Floating label color refers to the color of the label when it's in its "floating position," i.e.
 when it's above the text area.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)floatingLabelColorForState:(MDCTextControlState)state;

/**
 Sets the normal label color for a given state.
 Normal label color refers to the color of the label when it's in its "normal position," i.e. when
 it's not floating.
 @param normalLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setNormalLabelColor:(nonnull UIColor *)normalLabelColor
                   forState:(MDCTextControlState)state
    NS_SWIFT_NAME(setNormalLabelColor(_:for:));

/**
 Returns the normal label color for a given state.
 Normal label color refers to the color of the label when it's in its "normal position," i.e. when
 it's not floating.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)normalLabelColorForState:(MDCTextControlState)state;

/**
 Sets the text color for a given state.
 Text color in this case refers to the color of the input text.
 @param textColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setTextColor:(nonnull UIColor *)textColor forState:(MDCTextControlState)state;
/**
 Returns the text color for a given state.
 Text color in this case refers to the color of the input text.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)textColorForState:(MDCTextControlState)state;

/**
 Sets the leading assistive label text color.
 @param leadingAssistiveLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setLeadingAssistiveLabelColor:(nonnull UIColor *)leadingAssistiveLabelColor
                             forState:(MDCTextControlState)state
    NS_SWIFT_NAME(setLeadingAssistiveLabelColor(_:for:));

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
                              forState:(MDCTextControlState)state
    NS_SWIFT_NAME(setTrailingAssistiveLabelColor(_:for:));

/**
 Returns the trailing assistive label color for a given state.
 @param state The MDCTextControlState.
 */
- (nonnull UIColor *)trailingAssistiveLabelColorForState:(MDCTextControlState)state;

@end

@interface MDCBaseTextField (UIAccessibility)

/**
 If @c accessibilityLabel is not set, this value will be a concatenation of any @c label text, @c
 leadingAssistiveLabel text, and @c trailingAssistiveLabel text.
 */
@property(nullable, nonatomic, copy) NSString *accessibilityLabel;

@end
