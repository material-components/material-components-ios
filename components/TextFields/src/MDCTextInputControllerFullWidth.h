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
 Material Design compliant text field for full width applications like email forms.
 https://material.io/guidelines/components/text-fields.html#text-fields-field-variations

 NOTE: This class does not inherit from MDCTextInputControllerBase. It does not have a floating
 placeholder.

 The placeholder is laid out inline and the character count is also inline to the trailing side.

 Defaults:

 Active Color - Blue A700

 Border Fill Color - Clear
 Border Stroke Color - Clear

 Disabled Color = [UIColor lightGrayColor]

 Error Color - Red A400

 Floating Placeholder Color Active - Blue A700
 Floating Placeholder Color Normal - Black, 54% opacity

 Inline Placeholder Color - Black, 54% opacity

 Leading Underline Label Text Color - Black, 54% opacity

 Normal Color - Black, 54% opacity

 Rounded Corners - None

 Trailing Underline Label Text Color - Black, 54% opacity

 Underline Height Active - 0p
 Underline Height Normal - 0p

 Underline View Mode - While editing
 */
@interface MDCTextInputControllerFullWidth : NSObject <MDCTextInputController>

@end
