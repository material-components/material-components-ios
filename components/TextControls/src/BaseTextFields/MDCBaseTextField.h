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

API_DEPRECATED_BEGIN(
    "🕘 Schedule time to migrate. "
    "Use branded UITextField or UITextView instead: go/material-ios-text-fields/gm2-migration. "
    "This is go/material-ios-migrations#not-scriptable 🕘",
    ios(12, 12))

@protocol MDCBaseTextFieldDelegate;

/**
 The superclass of MDCFilledTextField and MDCOutlinedTextField. While not forbidden by the compiler,
 subclassing this class is not supported and is highly discouraged.
 */
@interface MDCBaseTextField : UITextField

/**
 The @c label is a label that occupies the area the text usually occupies when there is no
 text. It is distinct from the placeholder in that it can move above the text region or disappear to
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
 This is an RTL-aware alternative to UITextField's leftView/rightView properties. Use this property
 instead of @c UITextField's @c rightView and @c leftView.
 */
@property(strong, nonatomic, nullable) UIView *leadingView;

/**
 This is an RTL-aware alternative to UITextField's leftView/rightView properties. Use this property
 instead of @c UITextField's @c rightView and @c leftView.
 */
@property(strong, nonatomic, nullable) UIView *trailingView;

/**
 This is an RTL-aware alternative to UITextField's leftView/rightView properties. Use this property
 instead of @c UITextField's @c rightViewMode and @c leftViewMode.
 */
@property(nonatomic, assign) UITextFieldViewMode leadingViewMode;

/**
 This is an RTL-aware alternative to UITextField's leftView/rightView properties. Use this property
 instead of @c UITextField's @c rightViewMode and @c leftViewMode.
 */
@property(nonatomic, assign) UITextFieldViewMode trailingViewMode;

/**
 Sets the floating label color for a given state.
 Floating label color refers to the color of the label when it's in its "floating position," i.e.
 when it's above the text region.
 @param floatingLabelColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setFloatingLabelColor:(nonnull UIColor *)floatingLabelColor
                     forState:(MDCTextControlState)state
    NS_SWIFT_NAME(setFloatingLabelColor(_:for:));

/**
 Returns the floating label color for a given state.
 Floating label color refers to the color of the label when it's in its "floating position," i.e.
 when it's above the text field.
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
                   forState:(MDCTextControlState)state NS_SWIFT_NAME(setNormalLabelColor(_:for:));

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

/**
 When this property is set, the text field will convert it to a @c CGFloat and use that as the
 horizontal distance between the leading edge of the text field and the subview closest to it. When
 this property is @c nil, the text field will use a default value that depends on the style. This
 property is @c nil by default.
 */
@property(nullable, nonatomic, strong) NSNumber *leadingEdgePaddingOverride;

/**
 When this property is set, the text field will convert it to a @c CGFloat and use that as the
 horizontal distance between the trailing edge of the text field and the subview closest to it. When
 this property is @c nil, the text field will use a default value that depends on the style. This
 property is @c nil by default.
 */
@property(nullable, nonatomic, strong) NSNumber *trailingEdgePaddingOverride;

/**
 When this property is set, the text field will convert it to a @c CGFloat and use that as the
 horizontal distance between things like the text field's text region, the leading/trailing views,
 and the clear button. When this property is @c nil, the text field will use a default value that is
 specific to its style. This property is @c nil by default.
 */
@property(nullable, nonatomic, strong) NSNumber *horizontalInterItemSpacingOverride;

/**
 This property allows the user to override the default height of the container. The container is the
 region above the assistive labels within the text field. If there is no assistive label text,
 the container's frame will be equal to the frame of the text field itself.

 If this property is set to a value that's smaller than the
 default height of the container it will be ignored.
 */
@property(nonatomic, assign) CGFloat preferredContainerHeight;

/**
 This delegate receives text field related updates not covered by @c UITextFieldDelegate.
 */
@property(nonatomic, weak, nullable) id<MDCBaseTextFieldDelegate> baseTextFieldDelegate;

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
 This property influences how much vertical space there is between the various elements contained in
 the text field. When it's 0 (the default) there is maximal vertical space between elements. When it
 is 1, there is minimal vertical space between elements. Values less than 0 and greater than 1 will
 be clamped.
 */
@property(nonatomic, assign) CGFloat verticalDensity;

/**
 The duration for any animations the text field performs.
 */
@property(nonatomic, assign) NSTimeInterval animationDuration;

@end

@interface MDCBaseTextField (UIAccessibility)

/**
Apple's documentation for this property states that it is NO by default, unless the object is a
UIKit control, in which case it is YES by default. UITextField is a subclass of UIControl, but its
default value for this property (on devices specifically, not simulators) appears to be NO.
MDCBaseTextField does not change UITextField's default value for this property. This means that on
MDCBaseTextField this property is by default NO as well. It also means that the text field behaves
more like an accessibility container, where every accessible thing within it is an accessibility
element.

Setting this property explicitly to YES on MDCBaseTextField results in the entire MDCBaseTextField
being treated as one accessibility element, as opposed to a container. When this happens,
@c accessibilityLabel will be treated as a computed property if it has not been explicitly set. The
value returned will be a concatenation of the elements contained within the text field. If @c
isAccessibilityElement has been set to YES, and @c accessibilityLabel has also been set, then the
assigned value of @c accessibilityLabel will be used for the entire text field. Explicitly setting
this property to NO (as opposed to leaving it as NO to begin with) causes VoiceOver to completely
ignore the text field, so that is not recommended.
 */
@property(nonatomic) BOOL isAccessibilityElement;

/**
 If you set @c accessibilityLabel, but not @c isAccessibilityElement, then UITextField will
 forward the @c accessibilityLabel value you set to an internal system text field element. This will
 be read out as just one of several accessibility elements within the text field. If you explicitly
 set @c isAccessibilityElement to YES, then set @c accessibilityLabel, the value you set here will
 be used as the entire text field's accessibility label. If you explicitly set @c
 isAccessibilityElement to YES, but not @c accessibilityLabel, then @c accessibilityLabel will
 return a computed value that is a concatenation of the elements contained within the text field.
 */
@property(nullable, nonatomic, copy) NSString *accessibilityLabel;

@end

API_DEPRECATED_END
