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

/** Controllers that have the ability to move the placeholder to a title position. */
@protocol MDCTextInputControllerFloatingPlaceholder <MDCTextInputController>

/**
 The color applied to the placeholder when floating and the text field is first responder. However,
 when in error state, it will be colored with the error color.

 Only relevent when floatingEnabled is true.

 Default is floatingPlaceholderActiveColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *floatingPlaceholderActiveColor;

/**
 Default value for floatingPlaceholderActiveColor.

 Default is activeColor.
 */
@property(class, nonatomic, null_resettable, strong) UIColor *floatingPlaceholderActiveColorDefault;

/**
 The color applied to the placeholder when floating. However, when in error state, it will be
 colored with the error color and when in active state, it will be colored with the active color.

 Only relevent when floatingEnabled is true.

 Default is floatingPlaceholderNormalColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *floatingPlaceholderNormalColor;

/**
 Default value for floatingPlaceholderNormalColor.

 Default is black with Material Design hint text opacity (textInput's tint).
 */
@property(class, nonatomic, null_resettable, strong) UIColor *floatingPlaceholderNormalColorDefault;

/**
 When the placeholder floats up, constraints are created that use this value for constants.
 */
@property(nonatomic, readonly) UIOffset floatingPlaceholderOffset;

/**
 The scale of the the floating placeholder label in comparison to the inline placeholder specified
 as a value from 0.0 to 1.0. Only relevent when floatingEnabled = true.

 If nil, the floatingPlaceholderScale is @(floatingPlaceholderScaleDefault).
 */
@property(nonatomic, null_resettable, strong) NSNumber *floatingPlaceholderScale;

/**
 Default value for the floating placeholder scale.
 NOTE:Setting this value to 0 or lower would automatically set the scale to default.
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
