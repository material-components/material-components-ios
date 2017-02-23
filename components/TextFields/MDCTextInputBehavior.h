/*
 Copyright 2016-present the Material Components for iOS authors. All Rights
 Reserved.

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

#import <UIKit/UIKit.h>

@class MDCTextInput;

/**
 Material Design themed states for textInputs. The logic for 'automagic' error states changes:
 underline color, underline text color.
 https://www.google.com/design/spec/components/text-fields.html#text-fields-single-line-text-field
 */
@interface MDCTextInputBehavior : NSObject

/** The text input the behavior is managing. */
@property(nonatomic, nonnull, strong) id<MDCTextInput> textInput NS_SWIFT_NAME(input);

/**
 The color used to denote error state in the underline, the errorText's label, the plceholder and
 the character count label.

 Default is red.
 */
@property(nonatomic, nullable, copy) UIColor *errorColor UI_APPEARANCE_SELECTOR;

/**
 A localized string that represents the value of the errorText label. Use only when the you need
 to override the default which is the errorText itself.
 */
@property(nonatomic, nullable, copy, readonly) NSString *errorAccessibilityText;

/**
 Controls when the underline will be shown.

 The underline is an overlay that can be hidden depending on the editing state of the input text.

 Default is UITextFieldViewModeAlways.
 */
@property(nonatomic, assign) UITextFieldViewMode underlineViewMode NS_SWIFT_NAME(underlineMode) UI_APPEARANCE_SELECTOR;

/**
 Controls when the character count will be shown.

 Default is UITextFieldViewModeNever.
 */
@property(nonatomic, assign) UITextFieldViewMode characterCountViewMode NS_SWIFT_NAME(characterMode)
    ;

/**
 Sets the state of the controller by setting the values of properties errorText and
 errorAccessibilityValue.

 The value of errorText controls the state of the text input.

 @param errorText               The error text to be shown as underline text.
 @param errorAccessibilityValue Optional override of default underline text accessibility value.

 When errorText != nil, the text input is in an error state:
 - The error text appears in the underline text with the errorColor as text color.
 - The input rectangle's underline, placeholder and character is colored with the errorColor.

 When errorText == nil, the text input is not in error state:
 - The underline text is restored to the color and value it was.
 - The underline color and width is restored.
 - The placeholder text is restored to the color it was.
 - The character count text is restored to the color it was.

 Setting errorText to an empty string (@"") will put the input in error state but the underline text
 will be empty. It will color (if visible) the underline, the placeholder, and the character
 count in the errorColor.

 Setting errorAccessibilityValue when errorText == nil has no effect.
 */
- (void)setErrorText:(nullable NSString *)errorText
    errorAccessibilityValue:(nullable NSString *)errorAccessibilityValue
    NS_SWIFT_NAME(set(errorText:errorAccessibilityValue:));

@end
