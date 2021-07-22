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

#import "MDCBaseTextAreaDelegate.h"
#import "MDCTextControlLabelBehavior.h"
#import "MDCTextControlState.h"

/**
 A UIControl subclass that leverages UITextView to provide multi-line text input
*/
@interface MDCBaseTextArea : UIControl <UIContentSizeCategoryAdjusting>

/**
 The text area's delegate.
 */
@property(weak, nonatomic, nullable) id<MDCBaseTextAreaDelegate> baseTextAreaDelegate;

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
 This is an RTL-aware version of UITextField's leftView/rightView properties.
 */
@property(strong, nonatomic, nullable) UIView *leadingView;

/**
 This is an RTL-aware version of UITextField's leftView/rightView properties.
 */
@property(strong, nonatomic, nullable) UIView *trailingView;

/**
 This is an RTL-aware version of UITextField's leftViewMode/rightViewMode properties.
 */
@property(nonatomic, assign) UITextFieldViewMode leadingViewMode;

/**
 This is an RTL-aware version of UITextField's leftViewMode/rightViewMode properties.
 */
@property(nonatomic, assign) UITextFieldViewMode trailingViewMode;

/**
The UITextView contained within the text area.
 */
@property(strong, nonatomic, readonly, nonnull) UITextView *textView;

/**
The minimum number of simultaneously visible lines of text. The height of the text area will reflect
this value if the number of lines of total text is less than or equal to this value. Fractional
values are allowed.

 @note The @c preferredContainerHeight property takes precedence over this one. If you set a valid
@c preferredContainerHeight it will be used and @c minimumNumberOfVisibleRows will be ignored.
 */
@property(nonatomic, assign) CGFloat minimumNumberOfVisibleRows;

/**
The maximum number of simultaneously visible lines of text. The height of the text area will reflect
this value if the number of lines of total text is greater than or equal to this value. Fractional
values are allowed.

 @note The @c preferredContainerHeight property takes precedence over this one. If you set a valid
@c preferredContainerHeight it will be used and @c maximumNumberOfVisibleRows will be ignored.
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

/**
 When this property is set, the text area will convert it to a @c CGFloat and use that as the
 horizontal distance between the leading edge of the text area and the subview closest to it. When
 this property is @c nil, the text area will use a default value that is specific to its style. This
 property is @c nil by default.
 */
@property(nullable, nonatomic, strong) NSNumber *leadingEdgePaddingOverride;

/**
 When this property is set, the text area will convert it to a @c CGFloat and use that as the
 horizontal distance between the trailing edge of the text area and the subview closest to it. When
 this property is @c nil, the text area will use a default value that is specific to its style. This
 property is @c nil by default.
 */
@property(nullable, nonatomic, strong) NSNumber *trailingEdgePaddingOverride;

/**
 When this property is set, the text area will convert it to a @c CGFloat and use that as the
 horizontal distance between the text area's contained text view and its leading and trailing views.
 When this property is @c nil, the text area will use a default value that is specific to its style.
 This property is @c nil by default.
 */
@property(nullable, nonatomic, strong) NSNumber *horizontalInterItemSpacingOverride;

/**
 This property allows the user to override the default height of the container. The container is the
 region above the assistive labels within the text area. If there is no assistive label text,
 the container's frame will be equal to the frame of the text area itself.

 If this property is set to a value that's smaller than the
 default height of the container it will be ignored.

 @note This property takes precedence over @c minimumNumberOfVisibleRows and @c
 maximumNumberOfVisibleRows. If you set a valid  @c preferredContainerHeight then @c
 minimumNumberOfVisibleRows and @c maximumNumberOfVisibleRows will be ignored.
 */
@property(nonatomic, assign) CGFloat preferredContainerHeight;

/**
 This property determines the corner radius of the container, when applicable. Setting this property
 is a no-op for MDCBaseTextField and any subclasses with invisible containers. For subclasses with
 visible containers it will apply the radius to a combination of the four corners that is
 approrpriate for the given style.

 @note If the value of this property is sufficiently large you may need to set @c
 leadingEdgePaddingOverride or @c trailingEdgePaddingOverride.
 */
@property(nonatomic, assign) CGFloat containerRadius;

/**
 This property is modeled after the @c placeholder property on UITextField. Note that setting @c
 placeholder is different than setting the @c text property on MDCBaseTextArea's @c label property.
 @c label and @c placeholder are unrelated.
 */
@property(nonatomic, strong, nullable) NSString *placeholder;

/**
 The color of the placeholder. The default value is the color used by the placeholder in @c
 UITextField.
 */
@property(nonatomic, strong, null_resettable) UIColor *placeholderColor;

/**
 This property influences how much vertical space there is between the various elements contained in
 the text area. When it's 0 (the default) there is maximal vertical space between elements. When it
 is 1, there is minimal vertical space between elements. Values less than 0 and greater than 1 will
 be clamped.
 */
@property(nonatomic, assign) CGFloat verticalDensity;

@end
