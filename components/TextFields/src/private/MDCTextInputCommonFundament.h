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
 limitations under the License. */

/** Protocol implemented by a text field controlled by a |MDCTextFieldController|. */

#import "MaterialTextFields.h"

extern const CGFloat MDCTextInputFullPadding;
extern const CGFloat MDCTextInputHalfPadding;

/** A controller for common traits shared by text inputs. */
@interface MDCTextInputCommonFundament : NSObject <MDCTextInput, NSCopying, NSCoding>

/** The color of the caret indicating where inputted characters will be placed (in the text.) */
@property(nonatomic, nullable, strong) UIColor *cursorColor;

/** Whether the text field is enabled. */
@property(nonatomic, assign, getter=isEnabled) BOOL enabled;

/** The color of the input's text. */
@property(nonatomic, nullable, strong) UIColor *textColor;

/** Inset set on the text container based upon the text input's style. */
@property(nonatomic, assign, readonly) UIEdgeInsets textContainerInset;

/** Designated initializer with the controlled text input. */
- (nonnull instancetype)initWithTextInput:(UIView<MDCTextInput> *_Nonnull)textInput
    NS_DESIGNATED_INITIALIZER;

/** Please use initWithTextInput:. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/** Text began being edited event. */
- (void)didBeginEditing;

/** Text did change event. */
- (void)didChange;

/** Text stopped being edited event. */
- (void)didEndEditing;

/** Called by the controlled text input to notify the controller that it's font was set. */
- (void)didSetFont;

/** Called by the controlled text input to notify the controller that it's text was set manually. */
- (void)didSetText;

/** Mirror of UIView's layoutSubviews(). */
- (void)layoutSubviewsOfInput;

/** Mirror of UIView's updateConstraints(). */
- (void)updateConstraintsOfInput;

- (nullable instancetype)initWithCoder:(NSCoder *_Nonnull)aDecoder NS_DESIGNATED_INITIALIZER;
@end
