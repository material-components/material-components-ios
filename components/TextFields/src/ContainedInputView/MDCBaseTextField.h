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

#import "MDCTextControlLabelBehavior.h"

/**
 A UITextField subclass that will potentially provide the foundation for Material TextFields in the
 future. This class is under active development and should be used with caution.
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

@end
