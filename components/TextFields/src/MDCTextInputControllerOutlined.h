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
 Material Design compliant text field with border and border-crossing, floating label from 2017. It
 is intended to be used on single-line text fields.

 The placeholder text is laid out inline. It will float above the field when there is content or the
 field is being edited. The character count is below text.

 The background is opaque, the corners are rounded, there is a border, there is an underline, and
 the placeholder crosses the border cutting out a space.
 */

@interface MDCTextInputControllerOutlined : MDCTextInputControllerDefault

@end
