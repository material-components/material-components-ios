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
@class MDCSnackbarMessageAction;

/**
 Called by the snackbar message view when the user interacts with the snackbar view.

 @c userInitiated indicates whether or not the handler is being called due to direct user
 interaction. @c action, if non-nil, indicates that the user chose to execute a specific action.
 */
typedef void (^MDCSnackbarMessageDismissHandler)(BOOL userInitiated,
                                                 MDCSnackbarMessageAction *action);

/**
 Class which provides the default implementation of a snackbar.
 */
@interface MDCSnackbarMessageView : UIView

/**
 If the user has tapped on the snackbar or if @c dismissWithAction:userInitiated: has been called.
 */
@property(nonatomic, getter=isDismissing) BOOL dismissing;

/**
 The minimum width of the snackbar.
 */
@property(nonatomic, readonly) CGFloat minimumWidth;

/**
 The maximum width of the snackbar.
 */
@property(nonatomic, readonly) CGFloat maximumWidth;

/**
 Convenience pointer to the message used to create the view.
 */
@property(nonatomic, readonly, strong) MDCSnackbarMessage *message;

/**
 The color for the background of the snackbar message view.
 */
@property(nonatomic, strong) UIColor *snackbarMessageViewBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 The color for the shadow color for the snackbar message view.
 */
@property(nonatomic, strong) UIColor *snackbarMessageViewShadowColor UI_APPEARANCE_SELECTOR;

/**
 The color for the message text in the snackbar message view.
 */
@property(nonatomic, strong) UIColor *snackbarMessageViewTextColor UI_APPEARANCE_SELECTOR;

/**
 Creates a snackbar view to display @c message.

 The view will call @c handler when the user has interacted with the snackbar view in such a way
 that it needs to be dismissed prior to its timer-based dismissal time.
 */
- (instancetype)initWithMessage:(MDCSnackbarMessage *)message
                 dismissHandler:(MDCSnackbarMessageDismissHandler)handler;

/**
 Dismisses the message view.

 Does not call the message's completion handler or any action handler. Must be called from the main
 thread.

 @param action The action that prompted the dismissal.
 @param userInitiated Whether or not this is a user-initiated dismissal or a programmatic one.
 */
- (void)dismissWithAction:(MDCSnackbarMessageAction *)action userInitiated:(BOOL)userInitiated;

/**
 When VoiceOver is enabled the view should wait for user action before dismissing.

 Default is YES.
 */
- (BOOL)shouldWaitForDismissalDuringVoiceover;

@end
