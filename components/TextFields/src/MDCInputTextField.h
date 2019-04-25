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
 Indicates whether the text field should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Defaults value is NO.
 */
@property(nonatomic, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

/**
 The floating label color when the text field is enabled and not editing.
 */
@property(strong, nonatomic) UIColor *floatingLabelColorNormal;

/**
 The floating label color when the text field is enabled and editing.
 */
@property(strong, nonatomic) UIColor *floatingLabelColorEditing;

/**
 The floating label color when the text field is disabled.
 */
@property(strong, nonatomic) UIColor *floatingLabelColorDisabled;

/**
 The text color when the text field is enabled and not editing.
 */
@property(strong, nonatomic) UIColor *textColorNormal;

/**
 The text color when the text field is enabled and editing.
 */
@property(strong, nonatomic) UIColor *textColorEditing;

/**
 The text color when the text field is disabled.
 */
@property(strong, nonatomic) UIColor *textColorDisabled;

@end
