// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextInputControllerFloatingPlaceholder.h"

/**
 Base class providing floating placeholder animation and other functionality.

 NOTE: This class is intended to be subclassed. It contains the logic for 'automagic' error states.

 The placeholder text is laid out inline. If floating is enabled, it will float above the field when
 there is content or the field is being edited. The character count is below text. The Material
 Design guidelines call this 'Floating inline labels.'
 https://material.io/go/design-text-fields#text-fields-labels

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

 Note: The [Design guidance](https://material.io/components/text-fields/#anatomy) changed and treats
 placeholder as distinct from `label text`. The placeholder-related properties of this class most
 closely align with the "label text" as described in the guidance.
*/
@interface MDCTextInputControllerBase : NSObject <MDCTextInputControllerFloatingPlaceholder>

/**
 The color behind the input and label that defines the preferred tap zone.

 Default is borderFillColorDefault.
 */
@property(nonatomic, nullable, strong) UIColor *borderFillColor;

/**
 Default value for borderFillColor.

 Default is clear.
 */
@property(class, nonatomic, null_resettable, strong) UIColor *borderFillColorDefault;

/**
 The color the input field's border in the resting state. A nil value yields a clear border.

 Default is nil.
 */
@property(nonatomic, nullable, strong) UIColor *borderStrokeColor;

/**
 The radius of the input field's border.

 Default is 4.
 */
@property(nonatomic, assign) CGFloat borderRadius;

/**
 Should the controller's .textInput grow vertically as new lines are added.

 If the text input does not conform to MDCMultilineTextInput, this parameter has no effect.

 Default is YES.
 */
@property(nonatomic, assign) BOOL expandsOnOverflow;

/**
 The minimum number of lines the controller's .textInput should use for rendering text.

 The height of an empty text field is measured in potential lines. If the value were 3, the height
 of would never be shorter than 3 times the line height of the input font (plus clearance for
 auxillary views like the underline and the underline labels.)

 The smallest number of lines allowed is 1. A value of 0 has no effect.

 If the text input does not conform to MDCMultilineTextInput, this parameter has no effect.

 Default is 1.
 */
@property(nonatomic, assign) NSUInteger minimumLines;

@end
