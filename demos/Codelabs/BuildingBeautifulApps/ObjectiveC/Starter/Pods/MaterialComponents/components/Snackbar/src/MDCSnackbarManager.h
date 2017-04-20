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

@class MDCSnackbarMessage;
@protocol MDCSnackbarSuspensionToken;

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
 Shows @c message to the user, in a style consistent with the data contained in @c message.

 For messages with the same category, the firing of completion blocks has a guaranteed FIFO
 ordering. Ordering between completion blocks of different categories is not guaranteed. This method
 is safe to call from any thread.
 */
+ (void)showMessage:(MDCSnackbarMessage *)message;

/**
 MDCSnackbarManager will display the messages in this view.

 Call this method to choose where in the view hierarchy snackbar messages will be presented. It is
 only necessary to provide a host view if the default behavior is unable to find one on it's own,
 most commonly when using MDCSnackbarManager inside an application extension. By default, if you use
 MDCSnackbarManager without calling @c setPresentationHostView, the manager will attempt to find a
 suitable view by stepping through the application windows. Explicitly providing a host view is only
 required if you need to manually manage the view hierarchy, or are inside a UIApplication
 extension.

 @note This method must be called from the main thread.
 @note Calling setPresentationHostView will not change the parent of the currently visible message.
 */
+ (void)setPresentationHostView:(UIView *)hostView;

/**
 Bypasses showing the messages of the given @c category.

 Completion blocks are called, but the UI won't show any queued messages and will dismiss any
 messages for the @c category. Calling this method with @c nil will dismiss all messages. This
 method is safe to call from any thread.
 */
+ (void)dismissAndCallCompletionBlocksWithCategory:(NSString *)category;

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
+ (id<MDCSnackbarSuspensionToken>)suspendAllMessages;

/**
 Suspends the display of all messages in a given category.

 Any messages currently on screen will remain on screen (and dismiss normally). During this time any
 incoming messages in this category will be queued as normal.

 @param category The category for which message display will be suspended. Should not be nil.
 @return A token suitable for use in {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 Letting this object dealloc is equivalent to calling
 {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 */
+ (id<MDCSnackbarSuspensionToken>)suspendMessagesWithCategory:(NSString *)category;

/**
 Resumes the display of messages once there are no outstanding suspension tokens.

 The provided token is invalidated and becomes useless.

 @param token The suspension token to invalidate.
 */
+ (void)resumeMessagesWithToken:(id<MDCSnackbarSuspensionToken>)token;

@end

/**
 A suspension token is returned when messages are suspended by the snackbar manager.

 Messages are suppressed while a suspension token is kept in memory. Messages will resume being
 displayed when the suspension token is released or when the suspension token is passed to
 @c resumeMessagesWithToken.
 */
@protocol MDCSnackbarSuspensionToken <NSObject>
@end
