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

#pragma mark - Unapproved API
#import "MDCTextFieldPositioningDelegate.h"
#pragma mark - Approved API

@protocol MDCTextInput;
@protocol MDCTextInputCharacterCounter;

/**
 Presentation styles for a text input. The style determines specific aspects of the text
 input, such as sizing, placeholder placement and behavior, layout, etc.
 */
typedef NS_ENUM(NSUInteger, MDCTextInputPresentationStyle) {
  /**
   Default style with an inline placeholder (that disappears when text is entered) and character
   count / max below text.
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
@interface MDCTextInputController : NSObject <MDCTextFieldPositioningDelegate, NSCoding, NSCopying>

/** The text input the behavior is managing. */
@property(nonatomic, nullable, weak) UIView<MDCTextInput> *textInput NS_SWIFT_NAME(input);

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
 The character counter. Override to use a custom character counter.

 Default is an internal instance MDCTextInputAllCharactersCounter. Setting this property to null
 will reset it to return that instance.
 */
@property(nonatomic, null_resettable, weak) IBInspectable id<MDCTextInputCharacterCounter>
    characterCounter;

/**
 Controls when the character count will be shown and therefore whether character counting determines
 error state.

 Default is UITextFieldViewModeNever.
 */
@property(nonatomic, assign) UITextFieldViewMode characterCountViewMode NS_SWIFT_NAME(characterMode)
    ;

/**
 The character count maximum for the text input. A label under the input counts characters entered
 and presents the count / the max.

 If character count / max has been hidden by the characterCountViewMode
 (ie: UITextFieldViewModeNever) changing the value of characterLimit has no effect.

 If the character count goes above its max, the underline, the character count / max label and
 any floating placeholder label all turn to the error color; the text input will be in error state.
 Note: setErrorText:errorAccessibilityValue: also sets these MDCTextInput properties.

 There is no support for a minimum character count.

 Default is 0.
 */
@property(nonatomic, assign) IBInspectable NSUInteger characterCountMax;

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

#pragma mark - New API
/**
 Text displayed in the leading underline label.
 
 This text should give context or instruction to the user. If error text is set, it is
 not shown.
 */
@property(nonatomic, nullable, strong) IBInspectable NSString *helperText NS_SWIFT_NAME(helper);
#pragma mark - Approved API

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
 Convenience init. Never fails.
 @param input An MDCTextInput this behavior will manage.
 */
- (nonnull instancetype)initWithTextInput:(nullable UIView<MDCTextInput> *)input
    NS_SWIFT_NAME(init(input:));

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

 Note: The characterCountMax property also affects these same MDCTextInput properties.
 */
- (void)setErrorText:(nullable NSString *)errorText
    errorAccessibilityValue:(nullable NSString *)errorAccessibilityValue
    NS_SWIFT_NAME(set(errorText:errorAccessibilityValue:));

@end
