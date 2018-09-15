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

#import "MDCTextFieldPositioningDelegate.h"

@protocol MDCTextInput;
@protocol MDCTextInputCharacterCounter;

/** Controllers that manipulate styling and animation of text inputs. */
@protocol MDCTextInputController <NSObject, NSCopying, MDCTextInputPositioningDelegate>

/**
 Color for decorations that indicates the input is currently editing.

 Default is activeColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *activeColor;

/**
 Default value for activeColor.
 */
@property(class, nonatomic, null_resettable, strong) UIColor *activeColorDefault;

/**
 The character counter. Override to use a custom character counter.

 Default is an internal instance MDCTextInputAllCharactersCounter. Setting this property to null
 will reset it to return that instance.
 */
@property(nonatomic, null_resettable, weak) IBInspectable id<MDCTextInputCharacterCounter>
    characterCounter;

/**
 The character count maximum for the text input. A label under the input counts characters entered
 and presents the count / the max.

 If character count / max has been hidden by the characterCountViewMode
 (ie: UITextFieldViewModeNever) changing the value of characterLimit has no effect.

 If the character count goes above its max, the underline, the character count / max label and
 any floating placeholder label all turn to the error color; the text input will be in error state.
 Note: setErrorText:errorAccessibilityValue: also sets these MDCTextInput properties.

 There is no support for a minimum character count.
 */
@property(nonatomic, assign) IBInspectable NSUInteger characterCountMax;

/**
 Controls when the character count will be shown and therefore whether character counting determines
 error state.
 */
@property(nonatomic, assign) UITextFieldViewMode characterCountViewMode;

/**
 Color for decorations that indicates the input is not enabled / not accepting touch.

 Default is disabledColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *disabledColor;

/** Default value for disabledColor. */
@property(class, nonatomic, null_resettable, strong) UIColor *disabledColorDefault;

/**
 The color used to denote error state in decorations, the errorText's label, the placeholder and
 the character count label.

 Default is errorColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *errorColor;

/** Default value for errorColor. */
@property(class, nonatomic, null_resettable, strong) UIColor *errorColorDefault;

/**
 The text being displayed in the leading underline label when in an error state.

 NOTE: To set this value, you must use setErrorText:errorAccessibilityValue:.
 */
@property(nonatomic, nullable, copy, readonly) NSString *errorText;

/**
 Text displayed in the leading underline label.

 This text should give context or instruction to the user. If error text is set, it is
 not shown.
 */
@property(nonatomic, nullable, copy) IBInspectable NSString *helperText;

/**
 The color applied to the placeholder when inline (not floating).

 Default is inlinePlaceholderColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *inlinePlaceholderColor;

/** Default value for inlinePlaceholderColor. */
@property(class, nonatomic, null_resettable, strong) UIColor *inlinePlaceholderColorDefault;

/**
 The font applied to the text input.

 Default or in case this property is nil, the value will be textInputFontDefault.
 If textInputFontDefault is nil, textInput.font would be the fallback.
 */
@property(nonatomic, null_resettable, strong) UIFont *textInputFont;

/** Default value for textInputFontDefault. If nil, textInput.font would be the fallback.  */
@property(class, nonatomic, nullable, strong) UIFont *textInputFontDefault;


/**
 The font applied to the placeholder when inline (not floating).

 Default is inlinePlaceholderFontDefault;
 */
@property(nonatomic, null_resettable, strong) UIFont *inlinePlaceholderFont;

/** Default value for inlinePlaceholderFont. */
@property(class, nonatomic, null_resettable, strong) UIFont *inlinePlaceholderFontDefault;

/**
 The font applied to the leading side underline label.

 Default is leadingUnderlineLabelFontDefault.
 */
@property(nonatomic, null_resettable, strong) UIFont *leadingUnderlineLabelFont;

/** Default value for leadingUnderlineLabelFont. */
@property(class, nonatomic, null_resettable, strong) UIFont *leadingUnderlineLabelFontDefault;

/**
 The color applied to the leading side underline label when not in error state.

 Default is leadingUnderlineLabelTextColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *leadingUnderlineLabelTextColor;

/** Default value for leadingUnderlineLabelTextColor. */
@property(class, nonatomic, null_resettable, strong) UIColor *leadingUnderlineLabelTextColorDefault;

/*
 Indicates whether the alert contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIConnectSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default is mdc_adjustsFontForContentSizeCategoryDefault.
 */
@property(nonatomic, assign, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

/** Default value for mdc_adjustsFontForContentSizeCategory. */
@property(class, nonatomic, assign) BOOL mdc_adjustsFontForContentSizeCategoryDefault;

/**
 Color for decorations that indicates the input is enabled but not currently editing.

 Default is normalColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *normalColor;

/** Default value for normalColor. */
@property(class, nonatomic, null_resettable, strong) UIColor *normalColorDefault;

/** The text displayed in the placeholder label.*/
@property(nonatomic, nullable, copy) NSString *placeholderText;

/**
 The corners to be rounded in the border area.

 Default is roundedCornersDefault.
 */
@property(nonatomic, assign) UIRectCorner roundedCorners;

/** Default for roundedCorners. */
@property(class, nonatomic, assign) UIRectCorner roundedCornersDefault;

/** The text input the controller is affecting. */
@property(nonatomic, nullable, strong) UIView<MDCTextInput> *textInput;

/**
 The tintColor applied to the textInput's clear button.
 See @c UIImageView.tintColor for additional details.
 */
@property(nonatomic, null_resettable, strong) UIColor *textInputClearButtonTintColor;

/**
 Default value for @c textInputClearButtonTintColor. */
@property(class, nonatomic, nullable, strong) UIColor *textInputClearButtonTintColorDefault;

/**
 The font applied to the trailing side underline label.

 Default is trailingUnderlineLabelFontDefault.
 */
@property(nonatomic, null_resettable, strong) UIFont *trailingUnderlineLabelFont;

/** Default value for trailingUnderlineLabelFont. */
@property(class, nonatomic, null_resettable, strong) UIFont *trailingUnderlineLabelFontDefault;
/**
 The color applied to the trailing side underline label when not in error state.

 Default is trailingUnderlineLabelTextColorDefault.
 */
@property(nonatomic, nullable, strong) UIColor *trailingUnderlineLabelTextColor;

/** Default value for trailingUnderlineLabelTextColor. */
@property(class, nonatomic, nullable, strong) UIColor *trailingUnderlineLabelTextColorDefault;

/**
 Height of the underline when text field is first responder.

 Default is underlineHeightActiveDefault.
 */
@property(nonatomic, assign) CGFloat underlineHeightActive;

/** Default value for underlineHeightActive. */
@property(class, nonatomic, assign) CGFloat underlineHeightActiveDefault;

/**
 Height of the underline when NOT first responder.

 Default is underlineHeightNormalDefault.
 */
@property(nonatomic, assign) CGFloat underlineHeightNormal;

/** Default value for underlineHeightNormal. */
@property(class, nonatomic, assign) CGFloat underlineHeightNormalDefault;

/**
 Controls when the underline will be shown.

 The underline is an overlay that can be hidden depending on the editing state of the input text.

 Default is underlineViewModeDefault.
 */
@property(nonatomic, assign) UITextFieldViewMode underlineViewMode;

/** Default value for underlineViewMode. */
@property(class, nonatomic, assign) UITextFieldViewMode underlineViewModeDefault;

/**
 Convenience init. Never fails.

 @param input An MDCTextInput this controller will manage.
 */
- (nonnull instancetype)initWithTextInput:(nullable UIView<MDCTextInput> *)input;

/**
 Sets the state of the controller by setting the values of properties errorText and
 errorAccessibilityValue.

 The value of errorText controls the state of the text input.

 @param errorText               The error text to be shown as underline text. (Copied.)
 @param errorAccessibilityValue Optional override of default underline text accessibility value.
                                (Copied.)

 This method is usually called from whatever object is the UITextFieldDelegate for the MDCTextField.
 That object is responsible for validation of the text and calling this method if the error state
 needs to change.

 When errorText != nil, the text input is in an error state:
 - The error text appears in the underline text with the errorColor as text color.
 - The input rectangle's underline, placeholder and character are colored to the errorColor.

 When errorText == nil, the text input is not in error state:
 - The underline text is restored to the color and value it was.
 - The underline color and height is restored.
 - The placeholder text is restored to the color it was.
 - The character count text is restored to the color it was.

 Setting errorText to an empty string (@"") will put the input in error state but the underline text
 will be empty. It will color (if visible) the underline, the placeholder, and the character
 count in the errorColor.

 Setting errorAccessibilityValue when errorText == nil has no effect.

 Note: The characterCountMax property also affects these same MDCTextInput properties.
 */
- (void)setErrorText:(nullable NSString *)errorText
    errorAccessibilityValue:(nullable NSString *)errorAccessibilityValue;

/**
 Sets helper text and a corresponding accessibilityLabel.

 @param helperText               The helper text to be shown as leading underline text. (Copied.)
 @param helperAccessibilityLabel Optional override of leading underline accessibilityLabel when
                                 helper text is displayed. (Copied.)

 If the TextField is in an error state helperText is saved as the previousLeadingText, and
 helperAccessibilityLabel is saved in an instance variable. When the TextField eventually leaves the
 error state the previousLeadingText becomes the leadingUnderlineLabel's text and the
 helperAccessibilityLabel becomes the leadingUnderlinLabel's accessibilityLabel.

 If the TextField is not in an error state helperText is set as the leadingUnderlineLabel's text and
 helperAccessibilityLabel is set as the leadingUnderlineLabel's accessibilityLabel.
 */
-(void)setHelperText:(nullable NSString *)helperText
    helperAccessibilityLabel:(nullable NSString *)helperAccessibilityLabel;

@end
