/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTextInputController.h"

/**
 Material Design compliant text field from 2016. The logic for 'automagic' error states changes:
 underline color, underline text color.
 https://www.google.com/design/spec/components/text-fields.html#text-fields-single-line-text-field

 The placeholder text is laid out inline. If floating is enabled, it will float above the field when
 there is content or the field is being edited. The character count is below text. The Material
 Design guidelines call this 'Floating inline labels.'
 https://material.io/guidelines/components/text-fields.html#text-fields-labels
*/
@interface MDCTextInputControllerLegacyDefault : NSObject <MDCTextInputController>

/**
 The color applied to the placeholder when floating. However, when in error state, it will be
 colored with the error color and when in active state, it will be colored with the active color.

 Only relevent when floatingEnabled = true.

 Default is floatingPlaceholderNormalColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *floatingPlaceholderNormalColor;

/**
 Default value for floatingPlaceholderNormalColor.

 Default is black with Material Design hint text opacity (textInput's tint).
 */
@property(class, nonatomic, null_resettable, strong) UIColor *floatingPlaceholderNormalColorDefault;

/**
 The scale of the the floating placeholder label in comparison to the inline placeholder specified
 as a value from 0.0 to 1.0. Only relevent when floatingEnabled = true.

 If null, the floatingPlaceholderScale is @(floatingPlaceholderScaleDefault).
 */
@property(nonatomic, null_resettable, strong) NSNumber *floatingPlaceholderScale;

/**
 Default value for the floating placeholder scale.

 Default is 0.75.
 */
@property(class, nonatomic, assign) CGFloat floatingPlaceholderScaleDefault;

/**
 If enabled, the inline placeholder label will float above the input when there is inputted text or
 the field is being edited.

 Default is floatingEnabledDefault.
 */
@property(nonatomic, assign, getter=isFloatingEnabled) BOOL floatingEnabled;

/**
 Default value for floatingEnabled.

 Default is YES.
 */
@property(class, nonatomic, assign, getter=isFloatingEnabledDefault) BOOL floatingEnabledDefault;

@end
