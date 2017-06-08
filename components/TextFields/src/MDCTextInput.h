/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
 The Material Design guidelines have many suggestions for handling text input. The inputs that
 conform to this protocol have all the API necessary to achieve those suggestions.

 They are, however, dumb; they do not handle error state nor validation.

 - For handling error states and other Material behaviors use an MDCTextInputController on your
 inputs.
 - For validation, there are many 3rd party libraries you can use like:
   - https://github.com/3lvis/Validation
   - https://github.com/adamwaite/Validator
 */

@class MDCTextInputUnderlineView;

@protocol MDCTextInputPositioningDelegate;

/** Common API for Material Design compliant text inputs. */
@protocol MDCTextInput <NSObject>

/**
 The attributed text string of the placeholder label.
 Bringing convenience api found in UITextField to all MDCTextInputs. Maps to the .attributedText of
 the
 placeholder label.
 */
@property(nonatomic, nullable, copy) NSAttributedString *attributedPlaceholder;

/** The text displayed in the text input with style attributes. */
@property(nonatomic, nullable, copy) NSAttributedString *attributedText;

/**
 A button that can appear inline that when touched clears all entered text and resets the input to
 an empty state.
 */
@property(nonatomic, nonnull, strong, readonly) UIButton *clearButton;

/**
 Color for the "clear the text" button image.

 Color changes are not animated.

 Default is black with 38% opacity.
 */
@property(nonatomic, nullable, strong) UIColor *clearButtonColor UI_APPEARANCE_SELECTOR;

/**
 Controls when the clear button will display.

 Note: The clear button will never display when there is no entered text.
 */
@property(nonatomic, assign) UITextFieldViewMode clearButtonMode;

/** A Boolean value indicating whether the text field is currently in edit mode. */
@property(nonatomic, assign, readonly, getter=isEditing) BOOL editing;

/** The font of the text in the input. */
@property(nonatomic, nullable, strong) UIFont *font;

/** Should it have the standard behavior of disappearing when you type? Defaults to YES. */
@property(nonatomic, assign) BOOL hidesPlaceholderOnInput;

/**
 The label on the leading side under the input.

 This will usually be used for placeholder text to be displayed when no text has been entered. The
 Material Design guidelines call this 'helper text.'
 */
@property(nonatomic, nonnull, strong, readonly) UILabel *leadingUnderlineLabel;

/*
 Indicates whether the alert contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIConnectSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default value is NO.
 */
@property(nonatomic, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

/**
 The text string of the placeholder label.
 Bringing convenience api found in UITextField to all MDCTextInputs. Maps to the .text of the
 placeholder label.
 */
@property(nonatomic, nullable, copy) NSString *placeholder;

/**
 The label displaying text when no input text has been entered. The Material Design guidelines call
 this 'Hint text.'
 */
@property(nonatomic, nonnull, strong, readonly) UILabel *placeholderLabel;

/**
 An optional delegate that can be queried for important layout information like the text insets for
 any input and the editing rect, clear button rect for a text field.
 */
@property(nonatomic, nullable, weak) id<MDCTextInputPositioningDelegate> positioningDelegate;

/** The text displayed in the text input. */
@property(nonatomic, nullable, copy) NSString *text;

/** The color of the text in the input. */
@property(nonatomic, nullable, strong) UIColor *textColor;

/**
 The label on the trailing side under the input.

 This will usually be for the character count / limit.
 */
@property(nonatomic, nonnull, strong, readonly) UILabel *trailingUnderlineLabel;

/** The underline view */
@property(nonatomic, nullable, strong, readonly) MDCTextInputUnderlineView *underline;

@end
