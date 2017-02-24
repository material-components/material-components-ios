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
 Presentation styles for a text input. The style determines specific aspects of the text
 input, such as sizing, placeholder placement and behavior, layout, etc.
 */
typedef NS_ENUM(NSUInteger, MDCTextInputPresentationStyle) {
  /**
   Default style with an inline placeholder (that disappears when text is entered) and character
   count / limit below text.
   */
  MDCTextInputPresentationStyleDefault = 0,

  /**
   The placeholder text is laid out inline but will float above the field when there is content or
   the field is being edited. The character count is below text. The Material Design guidelines
   call this 'Floating inline labels.'
   https://material.io/guidelines/components/text-fields.html#text-fields-labels
   */
  MDCTextInputPresentationStyleFloatingPlaceholder,

  /** The placeholder is laid out inline and the character count is also inline to the right. */
  MDCTextInputPresentationStyleFullWidth,
};

/**
 Material Design themed states for textInputs. The logic for 'automagic' error states changes:
 underline color, underline text color.
 https://www.google.com/design/spec/components/text-fields.html#text-fields-single-line-text-field
 */
@interface MDCTextInputBehavior : NSObject

/** The text input the behavior is managing. */
@property(nonatomic, nonnull, weak) UIView<MDCTextInput> *textInput NS_SWIFT_NAME(input);

/**
 The color used to denote error state in the underline, the errorText's label, the plceholder and
 the character count label.

 Default is red.
 */
@property(nonatomic, nullable, strong) UIColor *errorColor UI_APPEARANCE_SELECTOR;

/**
 Controls when the underline will be shown.

 The underline is an overlay that can be hidden depending on the editing state of the input text.

 Default is UITextFieldViewModeAlways.
 */
@property(nonatomic, assign) UITextFieldViewMode underlineViewMode NS_SWIFT_NAME(underlineMode)
    UI_APPEARANCE_SELECTOR;

/**
 Controls when the character count will be shown.

 Default is UITextFieldViewModeNever.
 */
@property(nonatomic, assign) UITextFieldViewMode characterCountViewMode NS_SWIFT_NAME(characterMode)
    ;

/**
 The character limit for the text input. A label under the input counts characters entered and
 presents the count / the limit.

 Default is 0.
 */
@property(nonatomic, assign) IBInspectable NSUInteger characterLimit;

/**
 The color applied to the placeholder when floating. However, when in error state, it will be
 colored with the error color.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong)
    UIColor *floatingPlaceholderColor NS_SWIFT_NAME(floatingColor) UI_APPEARANCE_SELECTOR;

/**
 The scale of the the floating placeholder label in comparison to the inline placeholder specified
 as a value from 0.0 to 1.0.

 Default is 0.75.
 */
@property(nonatomic, assign) CGFloat floatingPlaceholderScale NS_SWIFT_NAME(floatingScale)
    UI_APPEARANCE_SELECTOR;

/**
 The color applied to the placeholder when inline (not floating).

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *inlinePlaceholderColor NS_SWIFT_NAME(inlineColor)
    UI_APPEARANCE_SELECTOR;

/**
 The presentation style of the text input.

 Default is MDCTextInputPresentationStyleDefault.
 */
@property(nonatomic, assign)
    MDCTextInputPresentationStyle presentationStyle NS_SWIFT_NAME(presentation);

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
