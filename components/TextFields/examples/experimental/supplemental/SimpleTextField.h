// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "SimpleTextFieldLayoutUtils.h"

#import "MaterialColorScheme.h"

#import "MaterialContainerScheme.h"

/**
 A UITextField subclass that attempts to do the following:

 - Earnestly interpret and actualize the Material guidelines for text fields, which can be found
 here: https://material.io/design/components/text-fields.html#outlined-text-field

 - Feel intuitive for someone used to the conventions of iOS development and UIKit controls.

 - Enable easy set up and reliable and predictable behavior.

 */
@interface SimpleTextField : UITextField

/**
 Dictates the @c TextFieldStyle of the text field.
 */
@property(nonatomic, assign) TextFieldStyle textFieldStyle;

/**
 This is a computed property that determines the current @c TextFieldState of the text field.
 */
@property(nonatomic, assign, readonly) TextFieldState textFieldState;

/**
 When set to YES, the placeholder floats above the text when the TextFieldState is @c .focused. When
 set to NO, it does not.

 @note The default is YES.
 @note When set to YES, the text field will reserve space for the floating placeholder in the
 layout, which will result in a text field that requires more height to render properly. Consider
 resizing the text field after setting this property, perhaps by calling @c -sizeToFit.
 */
@property(nonatomic, assign) BOOL canPlaceholderFloat;

/**
 The @c leadingUnderlineLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *leadingUnderlineLabel;

/**
 The @c trailingUnderlineLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *trailingUnderlineLabel;

/**
 This property is used to determine how much horizontal space to allot for each of the two underline
 labels.
 */
@property(nonatomic, assign) UnderlineLabelDrawPriority underlineLabelDrawPriority;

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
 Setting this property determines the typography and coloring of the text field.
 */
@property(strong, nonatomic, nullable) MDCContainerScheme *containerScheme;

/**
 This property toggles a state (similar to @c isHighlighted, @c isEnabled, @c isSelected, etc.) that
 is part of a general interpretation of the states outlined in the Material guidelines for Text
 Fields. See the @c TextFieldState enum for more information.
 */
@property(nonatomic, assign) BOOL isErrored;

/**
 This property toggles a state (similar to @c isHighlighted, @c isEnabled, @c isSelected, etc.) that
 is part of a general interpretation of the states outlined in the Material guidelines for Text
 Fields. See the @c TextFieldState enum for more information.
 */
@property(nonatomic, assign) BOOL isActivated;

/**
 When @c underlineLabelDrawPriority is set to @c .custom the value of this property helps determine
 what percentage of the available width each underline label gets. It can be thought of as a
 divider. A value of @c 0 would result in the trailing underline label getting all the available
 width. A value of @c 1 would result in the leading underline label getting all the available width.
 A value of @c .5 would result in each underline label getting 50% of the available width.
 */
@property(nonatomic, assign) CGFloat customUnderlineLabelDrawPriority;

@end
