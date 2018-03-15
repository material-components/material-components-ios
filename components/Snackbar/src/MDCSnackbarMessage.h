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

@class MDCSnackbarMessageAction;

/**
 Called when a message is finished displaying, regardless of whether or not buttons were tapped.
 */
typedef void (^MDCSnackbarMessageCompletionHandler)(BOOL userInitiated);

/**
 Called when the button in the snackbar is tapped.
 */
typedef void (^MDCSnackbarMessageActionHandler)(void);

/**
 Maximum duration allowed for a MDCSnackbarMessage.

 Set to 10 seconds. If longer durations are necessary than this value consider creating a custom UI
 for your use case.
 */
extern const NSTimeInterval MDCSnackbarMessageDurationMax;

/**
 Bold style attribute that can be used in attributed text.

 This attribute can be set over any range of @c attributedText and that text will have the proper
 font applied.
 */
extern NSString * __nonnull const MDCSnackbarMessageBoldAttributeName;

/**
 Represents a message to unobtrusively show to the user.

 A snackbar message provides brief feedback about an operation. Messages are passed to the snackbar
 manager to be displayed.

 Snackbars prefer an application's main window is a subclass of @c MDCOverlayWindow. When a standard
 UIWindow is used an attempt is made to find the top-most view controller in the view hierarchy.
 */
@interface MDCSnackbarMessage : NSObject <NSCopying, UIAccessibilityIdentification>

/**
 Returns a MDCSnackbarMessage with its text initialized.

 @param text The text to display in the message.
 @return An initialized MDCSnackbarMessage object with @c text.
 */
+ (nonnull instancetype)messageWithText:(nonnull NSString *)text;

/**
 Returns a MDCSnackbarMessage with its attributed text initialized.

 @param attributedText The attributed text to display in the message.
 @return An initialized MDCSnackbarMessage object with @c attributedText.
 */
+ (nonnull instancetype)messageWithAttributedText:(nonnull NSAttributedString *)attributedText;

/**
 Use the older legacy version of snackbar. Default is YES.
 */
@property(class, nonatomic, assign) BOOL usesLegacySnackbar;

/**
 The primary text of the message.

 Either @c text or @c attributedText must be set.
 */
@property(nonatomic, copy, nullable) NSString *text;

/**
 The primary text of the message with styling.

 Any attributes supported by UIKit may be set, though font and color will be overridden by the
 snackbar. Either @c text or @c attributedText must be set.
 */
@property(nonatomic, copy, nullable) NSAttributedString *attributedText;

/**
 Optional button to show along with the rest of the message.

 A MDCSnackbarMessageAction is displayed as a button on the snackbar. If no action is set no button
 will appear on the Snackbar.
 */
@property(nonatomic, strong, nullable) MDCSnackbarMessageAction *action;

/**
  The color used for button text on the snackbar in normal state.

  Default is nil, but MDCRGBAColor(0xFF, 0xFF, 0xFF, 0.6f) will be set as the default color
  and is taken from MDCSnackbarMessageView's buttonTitleColorForState:
  */
@property(nonatomic, strong, nullable) UIColor *buttonTextColor
    __deprecated_msg("Use MDCSnackbarMessageView's buttonTitleColorForState: instead.");

/**
 How long the message should be displayed.

 Defaults to 4 seconds and can be set up to the maximum duration defined by
 @c MDCSnackbarMessageDurationMax. Any value set above this limit will use the maximum duration.
 */
@property(nonatomic, assign) NSTimeInterval duration;

/**
 Called when a message is finished displaying.

 The message completion handler is called regardless of whether or not buttons were tapped and is
 always called on the main thread.
 */
@property(nonatomic, copy, nullable) MDCSnackbarMessageCompletionHandler completionHandler;

/**
 The category of messages to which a message belongs.

 Default is nil. If set, only the last message of this category will be shown, any currently
 showing or pending messages in this category will be dismissed as if the user had directly tapped
 the snackbar.
 */
@property(nonatomic, copy, nullable) NSString *category;

/**
 Redeclaration from UIAccessibility to make clear that this class supports accessibility labels.
 */
@property(nonatomic, copy, nullable) NSString *accessibilityLabel;

/**
 Text that should be read when the message appears on screen and VoiceOver is enabled.
 */
@property(nonatomic, readonly, nullable) NSString *voiceNotificationText;

@end

/**
 Represents a button in a MDCSnackbarMessage.
 */
@interface MDCSnackbarMessageAction : NSObject <UIAccessibilityIdentification, NSCopying>

/**
 The title text on the button.
 */
@property(nonatomic, copy, nullable) NSString *title;

/**
 Called when the button in the snackbar is tapped.

 Always called on the main thread.
 */
@property(nonatomic, copy, nullable) MDCSnackbarMessageActionHandler handler;

@end
