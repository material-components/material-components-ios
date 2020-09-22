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

@class MDCSnackbarMessageAction;
@class MDCSnackbarMessageView;

/**
 Called when a message is finished displaying, regardless of whether or not buttons were tapped.
 */
typedef void (^MDCSnackbarMessageCompletionHandler)(BOOL userInitiated);

/**
 Called when a message is finished displaying, regardless of whether or not buttons were tapped.
 */
typedef void (^MDCSnackbarMessageCompletionHandlerWithError)(BOOL userInitiated,
                                                             NSError *_Nullable error);

/**
 Called when the button in the Snackbar is tapped.
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
extern NSString *__nonnull const MDCSnackbarMessageBoldAttributeName;

/**
 Represents a message to unobtrusively show to the user.

 A Snackbar message provides brief feedback about an operation. Messages are passed to the Snackbar
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
 Use the older legacy version of Snackbar. Default is NO.
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
 Snackbar. Either @c text or @c attributedText must be set.
 */
@property(nonatomic, copy, nullable) NSAttributedString *attributedText;

/**
 Optional button to show along with the rest of the message.

 A MDCSnackbarMessageAction is displayed as a button on the Snackbar. If no action is set no button
 will appear on the Snackbar.
 */
@property(nonatomic, strong, nullable) MDCSnackbarMessageAction *action;

/**
  The color used for button text on the Snackbar in normal state.

  Default is nil, but MDCRGBAColor(0xFF, 0xFF, 0xFF, (CGFloat)0.6) will be set as the default color
  and is taken from MDCSnackbarMessageView's buttonTitleColorForState:
  */
@property(nonatomic, strong, nullable) UIColor *buttonTextColor __deprecated_msg(
    "Use MDCSnackbarMessageView's buttonTitleColorForState: instead.");

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
 Called when a message is finished displaying.

 The message completion handler is called regardless of whether or not buttons were tapped and is
 always called on the main thread.
 */
@property(nonatomic, copy, nullable)
    MDCSnackbarMessageCompletionHandlerWithError completionHandlerWithError;

/**
 The category of messages to which a message belongs.

 Default is nil. If set, only the last message of this category will be shown, any currently
 showing or pending messages in this category will be dismissed as if the user had directly tapped
 the Snackbar.
 */
@property(nonatomic, copy, nullable) NSString *category;

/**
 Redeclaration from UIAccessibility to make clear that this class supports accessibility labels.
 */
@property(nonatomic, copy, nullable) NSString *accessibilityLabel;

/**
 Redeclaration from UIAccessibility to make clear that this class supports accessibility hints.
 */
@property(nonatomic, copy, nullable) NSString *accessibilityHint;

/**
 Text that should be read when the message appears on screen and VoiceOver is enabled.
 */
@property(nonatomic, readonly, nullable) NSString *voiceNotificationText;

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink
 to display visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part
 of our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 Whether to focus on the Snackbar message when VoiceOver is enabled.
 The message is announced but not focused when set to NO.

 Note: Setting this to YES will ensure the entire snackbar message is read during VoiceOver, and
 that the message persists until an action is made on the message.

 Defaults to NO.
 */
@property(nonatomic) BOOL focusOnShow;

/**
 Element to focus on snackbar message dismiss. Focuses the first element on screen
 after dismiss by default. The focus will change to the element only if the focus is on the snackbar
 message.

 Defaults to nil.
 */
@property(nonatomic, weak, nullable) UIView *elementToFocusOnDismiss;

/**
 A block that is invoked when the corresponding @c MDCSnackbarMessageView of the @c
 MDCSnackbarMessage instance will be presented. Use this to customize @c MDCSnackbarMessageView
 before presentation.
 */
@property(nonatomic, copy, nullable) void (^snackbarMessageWillPresentBlock)
    (MDCSnackbarMessage *_Nonnull message, MDCSnackbarMessageView *_Nonnull messageView);

/**
 Whether the Snackbar message is transient and automatically dismisses after the provided @c
 duration time or is not transient and will not dismiss automatically.

 @note: If VoiceOver is turned on, a snackbar will not automatically dismiss if the snackbar has an
 action, regardless of this property.

 Defaults to YES.
 */
@property(nonatomic) BOOL automaticallyDismisses;

/**
 MDCSnackbarManager.defaultManager will display the snackbar message in this view.

 Call this method to choose where in the view hierarchy this specific snackbar message will be
 presented. This method should be called only in cases where the default behavior is unable to find
 the correct view to place the snackbar message in. Furthermore, please set this property only if
 this message is a special case and needs to be presented on a view different than the other
 messages of this specific snackbar manager. Otherwise, please set the presentation host view by
 using MDCSnackbarManager's @c setPresentationHostView.
 */
@property(nonatomic, weak, nullable) UIView *presentationHostViewOverride;

/**
 If true, the snackbar is dismissed when the user taps anywhere on the overlay.

 @note: If VoiceOver is turned on, this value will be ignored and the snackbar will behave as if it
 were set to NO.

 Defaults to NO.
 */
@property(nonatomic) BOOL shouldDismissOnOverlayTap;

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
 Called when the button in the Snackbar is tapped.

 Always called on the main thread.
 */
@property(nonatomic, copy, nullable) MDCSnackbarMessageActionHandler handler;

@end
