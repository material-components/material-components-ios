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

@protocol MDCTextInput;

/**
 Presentation styles for a text input. The style determines specific aspects of the text
 input, such as sizing, placeholder placement and behavior, ability to show error state,
 layout, etc.

 NOTE: Showing or hiding the character count / limit label is done via setting characterLimit: when
 characterLimit == 0, the label is hidden. When characterLimit > 0, the label is shown.
 */
typedef NS_ENUM(NSUInteger, MDCTextInputPresentationStyle) {
  /** Default style with an inline placeholder and character count below text. */
  MDCTextInputPresentationStyleDefault = 0,

  /**
   The placeholder text is laid out inline but will float above the field when there is content or
   the field is being edited. The character count is below text. The Material Design guideslines
   call this 'Floating inline labels.'
   https://material.io/guidelines/components/text-fields.html#text-fields-labels
   */
  MDCTextInputPresentationStyleFloatingPlaceholder,

  /** The placeholder is laid out inline and the character count is also inline to the right. */
  MDCTextInputPresentationStyleFullWidth,
};

/** Delegate for MDCTextInput size changes. */
@protocol MDCTextInputLayoutDelegate <NSObject>

@optional
/**
 Notifies the delegate that the textInput's content size changed, requiring the size provided.

 @param textInput The text input for which the content size changed.
 @param size      The size required by the text input to fit all of its content.
 */
- (void)textInput:(_Nonnull id<MDCTextInput>)textInput contentSizeChanged:(CGSize)size;

@end

/** Behavior exhibited by Material Design themed text inputs. */
@protocol MDCTextInput <NSObject>

/** A Boolean value indicating whether the text field is currently in edit mode. */
@property(nonatomic, readonly, getter=isEditing) BOOL editing;

/**
 The text to be displayed when no text has been entered.

 If presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder this text will also float
 above the input when text has been entered. The Material Design guidelines call this 'Hint text'.
 https://material.io/guidelines/components/text-fields.html#text-fields-input
 */
@property(nonatomic, nullable, copy) IBInspectable NSString *placeholder;

/**
 The color applied to the placeholder when inline (not floating.)

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *inlinePlaceholderColor UI_APPEARANCE_SELECTOR;

/**
 The color applied to the placeholder when floating. However, when in error state, it will be
 colored with the error color.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *floatingPlaceholderColor UI_APPEARANCE_SELECTOR;

/** The text displayed in the text input. */
@property(nonatomic, nullable, copy) NSString *text;

/**
 The text displayed under input rectangle, when in error state, that explains the nature of the
 error.

 The value of this property controls the state of the text input. When errorText != nil, the text
 input is in an error state:
  - The error text appears in a label below the input rectangle's underline with the errorColor as
  text color.
  - The input rectangle's underline is colored with the errorColor.
 */
@property(nonatomic, nullable, copy, readonly) IBInspectable NSString *errorText;

/**
 The color used to denote error state in the underline and the errorText's label.

 Default is red.
 */
@property(nonatomic, nullable, copy) UIColor *errorColor UI_APPEARANCE_SELECTOR;

/**
 A localized string that represents the value of the errorText label. Use only when the you need
 to override the default which is the errorText itself.
 */
@property(nonatomic, nullable, copy, readonly) NSString *errorAccessibilityText;

/** The delegate for the text input. */
@property(nonatomic, nullable, weak) IBInspectable id<MDCTextInputLayoutDelegate> layoutDelegate;

/**
 The presentation style of the text input.

 Default is MDCTextInputPresentationStyleDefault.
 */
@property(nonatomic, assign)
    MDCTextInputPresentationStyle presentationStyle NS_SWIFT_NAME(presentation);

/**
 The character limit for the text input.

 Displays the character limit text taking into account the MDCTextInputPresentationStyle. A value
 of 0 removes the limit text.

 Default is 0.
 */
@property(nonatomic, assign) IBInspectable NSUInteger characterLimit;

/**
 The color applied to the character count / character limit label. However, when in error state,
 it will be colored with the error color.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *characterCountColor UI_APPEARANCE_SELECTOR;

/**
 The color applied to the underline. However, when in error state, it will be colored with the
 error color.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *underlineColor UI_APPEARANCE_SELECTOR;

/**
 The view mode for the underline.

 Default is UITextFieldViewModeAlways.
 */
@property(nonatomic, assign) UITextFieldViewMode underlineViewMode NS_SWIFT_NAME(underlineMode);

/**
 Set the values of properties: errorText, errorColor, errorAccessibilityValue.

 The value of errorText controls the state of the text input.

 @param errorText               The errorText to be shown under the input rectangle's underline.
 @param errorAccessibilityValue Optional override of default errorText accessibility value
 (errorText.text).

 When errorText != nil, the text input is in an error state:
 - The error text appears in a label below the input rectangle's underline with the errorColor as
 text color.
 - The input rectangle's underline is colored with the errorColor.

 When errorText == nil, the text input is not in error state:
 - There is no error text under the input rectangle.
 - The input rectangle's underline is colored either blue (when isEditing == true) or gray (when
 isEditing == false.)

 Setting errorText to an empty string (@"") will put the input in error state but without an
 errorText label. It will just show the input rectangle's underline, the floating placeholder, and
 the character count in the errorColor.

 Setting errorAccessibilityValue when errorText == nil has no effect.
 */
- (void)setErrorText:(nullable NSString *)errorText
    errorAccessibilityValue:(nullable NSString *)errorAccessibilityValue
    NS_SWIFT_NAME(set(errorText:errorAccessibilityValue:));

@end
