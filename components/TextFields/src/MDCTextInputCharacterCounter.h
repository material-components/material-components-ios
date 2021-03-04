// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

@protocol MDCTextInput;

/**
 Protocol for custom character counters.

 Instead of relying on the default character count which is naive (counts each character regardless
 of context), this object can instead choose to do sophisticated counting (ie: ignoring whitespace,
 ignoring url strings, ignoring usernames, etc).
 */
__deprecated_msg(
    "MDCTextField and its associated classes are deprecated. Please use TextControls instead.")
    @protocol MDCTextInputCharacterCounter<NSObject>

/**
 Returns the count of characters for the text field.

 @param textInput   The text input to count from.

 @return            The count of characters.
 */
- (NSUInteger)characterCountForTextInput:(nullable UIView<MDCTextInput> *)textInput;

@end

/**
 The default character counter.

 MDCTextInputAllCharactersCounter is naive (counts each character regardless of context).
 */
__deprecated_msg(
    "MDCTextField and its associated classes are deprecated. Please use TextControls instead.")
    @interface MDCTextInputAllCharactersCounter : NSObject<MDCTextInputCharacterCounter>

@end
