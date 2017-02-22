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

/**
 The Material Design guideslines have many suggestions for handling text input. The inputs that
 conform to this protocol have all the API necessary to customize them to those suggestions.

 They are, however, dumb; they do not handle error state nor validation.

 - For handling error states and other Material behaviors use an MDCTextInputBehavior on your inputs
 - For validation, there are many 3rd party libraries you can use like:
   - https://github.com/3lvis/Validation
   - https://github.com/adamwaite/Validator
 */

@protocol MDCTextInput;

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

/** Common API for Material Design themed text inputs. */
@protocol MDCTextInput <NSObject>

/** A Boolean value indicating whether the text field is currently in edit mode. */
@property(nonatomic, readonly, getter=isEditing) BOOL editing;

/**
 The text to be displayed when no text has been entered. The Material Design guidelines call this
 'Hint text.'

 If presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder this text will also float
 above the input when text has been entered.
 https://material.io/guidelines/components/text-fields.html#text-fields-input
 */
@property(nonatomic, nullable, copy) IBInspectable NSString *placeholder;

/**
 The color applied to the placeholder when inline (not floating.)

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *inlinePlaceholderColor NS_SWIFT_NAME(inlineScale)
    UI_APPEARANCE_SELECTOR;

/**
 The color applied to the placeholder when floating. However, when in error state, it will be
 colored with the error color.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong)
    UIColor *floatingPlaceholderColor NS_SWIFT_NAME(floatingColor) UI_APPEARANCE_SELECTOR;

/**
 The font applied to placeholder labels.

 The UIFont.pointSize is respected for placeholders in an inline mode. However, the pointSize of
 a placeholder in floating mode is placeholderFont.pointSize * floatingPlaceholderScale.

 Default is system body.
 */
@property(nonatomic, nullable, strong) UIFont *placeholderFont UI_APPEARANCE_SELECTOR;

/**
 The scale of the the floating placeholder label in comparison to the inline placeholder specified
 as a value from 0.0 to 1.0.

 Default is 0.75.
 */
@property(nonatomic, assign) CGFloat floatingPlaceholderScale NS_SWIFT_NAME(floatingScale)
    UI_APPEARANCE_SELECTOR;

/** The text displayed in the text input. */
@property(nonatomic, nullable, copy) NSString *text;

/**
 The presentation style of the text input.

 Default is MDCTextInputPresentationStyleDefault.
 */
@property(nonatomic, assign)
    MDCTextInputPresentationStyle presentationStyle NS_SWIFT_NAME(presentation);

/**
 The character limit for the text input. A label under the input counts characters entered and
 presents the count / the limit.

 Default is 0.
 */
@property(nonatomic, assign) IBInspectable NSUInteger characterLimit;

/**
 The color applied to the character count / character limit label.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *characterLimitColor NS_SWIFT_NAME(limitColor)
    UI_APPEARANCE_SELECTOR;

/**
 The font applied to the character count / character limit label.

 Default is system caption1.
 */
@property(nonatomic, nullable, strong) UIFont *characterLimitFont NS_SWIFT_NAME(limitFont)
    UI_APPEARANCE_SELECTOR;

/**
 The color applied to the underline.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *underlineColor UI_APPEARANCE_SELECTOR;

/** The thickness of the underline. */
@property(nonatomic, assign) CGFloat underlineWidth UI_APPEARANCE_SELECTOR;

/**
 The text displayed under input rectangle. The Material Design guidelines call this 'Helper text.'

 This is usually error text or further instructions.
 */
@property(nonatomic, nullable, copy, readonly) IBInspectable NSString *underlineText;

/**
 The color of the underlineText label.

 Default is 38% black.
 */
@property(nonatomic, nullable, copy) UIColor *underlineTextColor UI_APPEARANCE_SELECTOR;

/**
 The font applied to the underlineText label.

 Default is system caption1.
 */
@property(nonatomic, nullable, strong) UIFont *underlineTextFont UI_APPEARANCE_SELECTOR;

/**
 A localized string that represents the value of the underline text label. Use only when the you
 need
 to override the default which is the underline text itself.
 */
@property(nonatomic, nullable, copy, readonly) IBInspectable NSString *underlineAccessibilityText;

@end
