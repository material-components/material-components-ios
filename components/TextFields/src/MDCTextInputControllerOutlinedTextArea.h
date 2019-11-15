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

#import "MDCTextInputControllerBase.h"

/**
 Material Design compliant outlined background text field from 2017. The logic for 'automagic' error
 states changes:
 underline color, underline text color.
 https://www.google.com/design/spec/components/text-fields.html#text-fields-single-line-text-field

 The placeholder text is laid out inline. If floating is enabled, it will float to the top of the
 field when there is content or the field is being edited. The character count is below text. The
 Material Design guidelines call this 'Floating inline labels.'
 https://material.io/go/design-text-fields#text-fields-labels

 The background is clear, the corners are rounded, there's a border, there is no underline, and
 the placeholder is centered vertically in the filled area but does NOT cross the border when
 floating.

 This design defaults to 5 lines minimum and does not expand on overflow by default.

 Defaults:

 Active Color - Blue A700

 Border Stroke Color - Clear
 Border Fill Color - Clear

 Disabled Color = [UIColor lightGrayColor]

 Error Color - Red A400

 Floating Placeholder Color Active - Blue A700
 Floating Placeholder Color Normal - Black, 54% opacity

 Inline Placeholder Color - Black, 54% opacity

 Leading Underline Label Text Color - Black, 54% opacity

 Normal Color - Black, 54% opacity

 Rounded Corners - All

 Trailing Underline Label Text Color - Black, 54% opacity

 Underline Color Normal - Black, 54% opacity

 Underline Height Active - 2p
 Underline Height Normal - 1p

 Underline View Mode - While editing

 Note: The [Design guidance](https://material.io/components/text-fields/#anatomy) changed and treats
 placeholder as distinct from `label text`. The placeholder-related properties of this class most
 closely align with the "label text" as described in the guidance.
 */

@interface MDCTextInputControllerOutlinedTextArea : MDCTextInputControllerBase

@end
