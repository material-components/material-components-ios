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
#import "MDCSnackbarAlignment.h"

@class MDCSnackbarMessage;
@class MDCSnackbarMessageView;
@protocol MDCSnackbarSuspensionToken;


/**
 Delegate protocol for the MDCSnackbarManager.
 */
@protocol MDCSnackbarManagerDelegate <NSObject>


/**
 This method is called after the MDCSnackbarMessageView instance is initialized and right before
 The view is presented on the screen.

 @param messageView The messageView of the snackbar that will be presented.
 */
- (void)willPresentSnackbarWithMessageView:(nullable MDCSnackbarMessageView *)messageView;

@end

/**
 Provides a means of displaying an unobtrusive message to the user.

 The style and location of the message can vary depending on the configuration of the message to be
 shown. This class will queue repeated calls to @c showMessage: and show them at the appropriate
 time, once previous messages have been dismissed. This class is thread-safe as long as the messages
 given to MDCSnackbarManager are not mutated after being passed to @c showMessage:

 Snackbars prefer an application's main window is a subclass of @c MDCOverlayWindow. When a standard
 UIWindow is used an attempt is made to find the top-most view controller in the view hierarchy.
 */
@interface MDCSnackbarManager : NSObject

/**
 Determines the Snackbar alignment to the screen.

 If called within an animation block, the change will be animated.

 @note This setting is only used when both the horizontal and vertical size classes of the presenting
 window are @c UIUserInterfaceSizeClassRegular. Otherwise @c MDCSnackbarAlignmentCenter
 will be used.

 @note The setter must be called from the main thread.
 */
@property (class, nonatomic, assign) MDCSnackbarAlignment alignment;

/**
 Shows @c message to the user, in a style consistent with the data contained in @c message.

 For messages with the same category, the firing of completion blocks has a guaranteed FIFO
 ordering. Ordering between completion blocks of different categories is not guaranteed. This method
 is safe to call from any thread.
 */
+ (void)showMessage:(nullable MDCSnackbarMessage *)message;

/**
 MDCSnackbarManager will display the messages in this view.

 Call this method to choose where in the view hierarchy Snackbar messages will be presented. It is
 only necessary to provide a host view if the default behavior is unable to find one on it's own,
 most commonly when using MDCSnackbarManager inside an application extension. By default, if you use
 MDCSnackbarManager without calling @c setPresentationHostView, the manager will attempt to find a
 suitable view by stepping through the application windows. Explicitly providing a host view is only
 required if you need to manually manage the view hierarchy, or are inside a UIApplication
 extension.

 @note This method must be called from the main thread.
 @note Calling setPresentationHostView will not change the parent of the currently visible message.
 */
+ (void)setPresentationHostView:(nullable UIView *)hostView;

/**
 Checks if there is any message showing or queued. Does not consider suspended messages.

 @note This method must be called from the main thread.
 */
+ (BOOL)hasMessagesShowingOrQueued;

/**
 Bypasses showing the messages of the given @c category.

 Completion blocks are called, but the UI won't show any queued messages and will dismiss any
 messages for the @c category. Calling this method with @c nil will dismiss all messages. This
 method is safe to call from any thread.
 */
+ (void)dismissAndCallCompletionBlocksWithCategory:(nullable NSString *)category;

/**
 How far from the bottom of the screen messages are displayed.

 If called within an animation block, the change will be animated.

 @note This method must be called from the main thread.
 @note This is meant for apps which have a navigation element such as a tab bar, which cannot
 move and should not be obscured.
 */
+ (void)setBottomOffset:(CGFloat)offset;

#pragma mark Suspending

/**
 Suspends the display of all messages.

 Any messages currently on screen will remain on screen (and dismiss normally). During this time any
 incoming messages will be queued as normal.

 @return A token suitable for use in {@c +[MDCSnackbarManager resumeWithToken:]}. Letting this
 object deallocate is equivalent to calling {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 */
+ (nullable id <MDCSnackbarSuspensionToken>)suspendAllMessages;

/**
 Suspends the display of all messages in a given category.

 Any messages currently on screen will remain on screen (and dismiss normally). During this time any
 incoming messages in this category will be queued as normal.

 @param category The category for which message display will be suspended. Should not be nil.
 @return A token suitable for use in {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 Letting this object dealloc is equivalent to calling
 {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 */
+ (nullable id <MDCSnackbarSuspensionToken>)
    suspendMessagesWithCategory:(nullable NSString *)category;

/**
 Resumes the display of messages once there are no outstanding suspension tokens.

 The provided token is invalidated and becomes useless.

 @param token The suspension token to invalidate.
 */
+ (void)resumeMessagesWithToken:(nullable id <MDCSnackbarSuspensionToken>)token;

#pragma mark Styling

/**
 The color for the background of the Snackbar message view.
 */
@property(class, nonatomic, strong, nullable) UIColor *snackbarMessageViewBackgroundColor;

/**
 The color for the shadow color for the Snackbar message view.
 */
@property(class, nonatomic, strong, nullable) UIColor *snackbarMessageViewShadowColor;

/**
 The color for the message text in the Snackbar message view.
 */
@property(class, nonatomic, strong, nullable) UIColor *messageTextColor;

/**
 The font for the message text in the Snackbar message view.
 */
@property(class, nonatomic, strong, nullable) UIFont *messageFont;

/**
 The font for the button text in the Snackbar message view.
 */
@property(class, nonatomic, strong, nullable) UIFont *buttonFont;

/**
 If enabled, modifications of class styling properties will be applied immediately
 to the currently presented Snackbar.

 Default is set to NO.
 */
@property(class, nonatomic, assign) BOOL shouldApplyStyleChangesToVisibleSnackbars;

/**
 Returns the button title color for a particular control state.

 @param state The control state.
 @return The button title color for the requested state.
 */
+ (nullable UIColor *)buttonTitleColorForState:(UIControlState)state;

/**
 Sets the button title color for a particular control state.

 @param titleColor The title color.
 @param state The control state.
 */
+ (void)setButtonTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state;

/**
 Indicates whether the Snackbar should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 If set to YES, this button will base its message font on MDCFontTextStyleBody2
 and its button font on MDCFontTextStyleButton.

 Default is set to NO.
 */
@property(class, nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;


/**
 The delegate for MDCSnackbarManager through which it may inform of snackbar presentation updates.
 */
@property(class, nonatomic, weak, nullable) id<MDCSnackbarManagerDelegate> delegate;

@end

/**
 A suspension token is returned when messages are suspended by the Snackbar manager.

 Messages are suppressed while a suspension token is kept in memory. Messages will resume being
 displayed when the suspension token is released or when the suspension token is passed to
 @c resumeMessagesWithToken.
 */
@protocol MDCSnackbarSuspensionToken <NSObject>
@end
