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
 A UITextField subclass that attempts to do the following:

 - Earnestly interpret and actualize the Material guidelines for text fields, which can be found
 here: https://material.io/design/components/text-fields.html#outlined-text-field

 - Feel intuitive for someone used to the conventions of iOS development and UIKit controls.

 - Enable easy set up and reliable and predictable behavior.

 */
@interface MDCInputTextField : UITextField

/**
 The @c floatingLabel is a label that occupies the text area when there is no text and that floats
 above the text once there is some. It is distinct from a placeholder.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *floatingLabel;

/**
 The @c leadingUnderlineLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *leadingUnderlineLabel;

/**
 The @c trailingUnderlineLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *trailingUnderlineLabel;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftView/rightView class.
 */
@property(strong, nonatomic, nullable) UIView *leadingView;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftView/rightView class.
 */
@property(strong, nonatomic, nullable) UIView *trailingView;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftViewMode/rightViewMode class.
 */
@property(nonatomic, assign) UITextFieldViewMode leadingViewMode;

/**
 This is essentially an RTL-aware wrapper around UITextField's leftViewMode/rightViewMode class.
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

@end
