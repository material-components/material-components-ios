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

#import "MDCTextInputControllerDefault.h"

/**
 Material Design compliant outlined background text field from 2017. The logic for 'automagic' error
 states changes:
 underline color, underline text color.
 https://www.google.com/design/spec/components/text-fields.html#text-fields-single-line-text-field

 The placeholder text is laid out inline. If floating is enabled, it will float to the top of the
 field when there is content or the field is being edited. The character count is below text. The
 Material Design guidelines call this 'Floating inline labels.'
 https://material.io/guidelines/components/text-fields.html#text-fields-labels

 The background is clear, the corners are rounded, there's a border, there is no underline, and
 the placeholder is centered vertically in the filled area but does NOT cross the border when
 floating.
 */

@interface MDCTextInputControllerOutlinedTextArea : MDCTextInputControllerDefault

@end
