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

/**
 A set of Contained Input View states outlined in the Material guidelines. These states overlap with
 and extend UIControlState.
 */
typedef NS_OPTIONS(NSInteger, MDCContainedInputViewState) {
  /**
   The default state of the contained input view.
   */
  MDCContainedInputViewStateNormal = 1 << 0,
  /**
   The state the view is in during normal editing.
   */
  MDCContainedInputViewStateFocused = 1 << 1,
  /**
   This state most closely resembles the @c selected UIControlState.
   */
  MDCContainedInputViewStateActivated = 1 << 2,
  /**
   The error state.
   */
  MDCContainedInputViewStateErrored = 1 << 3,
  /**
   The disabled state.
   */
  MDCContainedInputViewStateDisabled = 1 << 4,
};

/**
 A UITextField subclass that attempts to do the following:

 - Earnestly interpret and actualize the Material guidelines for text fields, which can be found
 here: https://material.io/design/components/text-fields.html#outlined-text-field

 - Feel intuitive for someone used to the conventions of iOS development and UIKit controls.

 - Enable easy set up and reliable and predictable behavior.

 */
@interface MDCInputTextField : UITextField

/**
 The @c floatingLabel is a label that occupies the area the text usually occupies when there is no
 text and that floats above the text once there is text. It is distinct from the placeholder.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *floatingLabel;

/**
 When set to YES, the floating label floats when the view becomes the first responder. When
 set to NO it disappears.

 @note The default is YES.
 */
@property(nonatomic, assign) BOOL canFloatingLabelFloat;

/**
 The @c leadingUnderlineLabel is a label below the text on the leading edge of the view. It can be
 used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *leadingUnderlineLabel;

/**
 The @c trailingUnderlineLabel is a label below the text on the trailing edge of the view. It can be
 used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *trailingUnderlineLabel;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftView/rightView property.
 */
@property(strong, nonatomic, nullable) UIView *leadingView;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftView/rightView property.
 */
@property(strong, nonatomic, nullable) UIView *trailingView;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftViewMode/rightViewMode property.
 */
@property(nonatomic, assign) UITextFieldViewMode leadingViewMode;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftViewMode/rightViewMode property.
 */
@property(nonatomic, assign) UITextFieldViewMode trailingViewMode;

/**
 This property toggles the error state (similar to @c isHighlighted, @c isEnabled, @c isSelected,
 etc.) that is part of a general interpretation of the states outlined in the Material guidelines
 for Text Fields. See the @c MDCContainedInputViewState enum for more information.
 */
@property(nonatomic, assign) BOOL isErrored;

/**
 This property toggles the activated state (similar to @c isHighlighted, @c isEnabled, @c
 isSelected, etc.) that is part of a general interpretation of the states outlined in the Material
 guidelines for Text Fields. See the @c MDCContainedInputViewState enum for more information.
 */
@property(nonatomic, assign) BOOL isActivated;

/**
 Indicates whether the text field should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Defaults value is NO.
 */
@property(nonatomic, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

/**
 Sets the text color for a given state.

 @param textColor the text color.
 @param state the state.
 */
- (void)setTextColor:(UIColor *)textColor forState:(MDCContainedInputViewState)state;

/**
 Sets the underline label color for a given state.

 @param underlineLabelColor the underline label color.
 @param state the state.
 */
- (void)setUnderlineLabelColor:(UIColor *)underlineLabelColor
                      forState:(MDCContainedInputViewState)state;

/**
 Sets the floating label color for a given state.

 @param floatingLabelColor the floating label color.
 @param state the state.
 */
- (void)setFloatingLabelColor:(UIColor *)floatingLabelColor
                     forState:(MDCContainedInputViewState)state;

/**
 Sets the placeholder color for a given state.

 @param placeholderColor the placeholder color.
 @param state the state.
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor forState:(MDCContainedInputViewState)state;

@end
