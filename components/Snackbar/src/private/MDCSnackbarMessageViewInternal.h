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

#import "../MDCSnackbarMessageView.h"

@class MDCSnackbarManager;
@class MDCSnackbarMessage;
@class MDCSnackbarMessageAction;

/**
 Called by the Snackbar message view when the user interacts with the Snackbar view.

 @c userInitiated indicates whether or not the handler is being called due to direct user
 interaction. @c action, if non-nil, indicates that the user chose to execute a specific action.
 */
typedef void (^MDCSnackbarMessageDismissHandler)(BOOL userInitiated,
                                                 MDCSnackbarMessageAction *_Nullable action);

@interface MDCSnackbarMessageView ()

/**
 If the user has tapped on the Snackbar or if @c dismissWithAction:userInitiated: has been called.
 */
@property(nonatomic, getter=isDismissing) BOOL dismissing;

/**
 The minimum width of the Snackbar.
 */
@property(nonatomic, readonly) CGFloat minimumWidth;

/**
 The maximum width of the Snackbar.
 */
@property(nonatomic, readonly) CGFloat maximumWidth;

/**
 Convenience pointer to the message used to create the view.
 */
@property(nonatomic, nullable, readonly, strong) MDCSnackbarMessage *message;

/**
 If the Snackbar view should be anchored to the bottom of the screen. Default is YES.
 */
@property(nonatomic) BOOL anchoredToScreenBottom;

/**
 Creates a Snackbar view to display @c message.

 The view will call @c handler when the user has interacted with the Snackbar view in such a way
 that it needs to be dismissed prior to its timer-based dismissal time.
 */
- (_Nonnull instancetype)initWithMessage:(MDCSnackbarMessage *_Nullable)message
                          dismissHandler:(MDCSnackbarMessageDismissHandler _Nullable)handler
                         snackbarManager:(MDCSnackbarManager *_Nonnull)manager;

/**
 Dismisses the message view.

 Does not call the message's completion handler or any action handler. Must be called from the main
 thread.

 @param action The action that prompted the dismissal.
 @param userInitiated Whether or not this is a user-initiated dismissal or a programmatic one.
 */
- (void)dismissWithAction:(MDCSnackbarMessageAction *_Nullable)action
            userInitiated:(BOOL)userInitiated;

/**
 When VoiceOver is enabled the view should wait for user action before dismissing.

 Default is YES.
 */
- (BOOL)shouldWaitForDismissalDuringVoiceover;

/**
 Animate the opacity text and button content.

 Creates and commits a CATransaction to perform the animation.
 */
- (void)animateContentOpacityFrom:(CGFloat)fromOpacity
                               to:(CGFloat)toOpacity
                         duration:(NSTimeInterval)duration
                   timingFunction:(CAMediaTimingFunction *_Nullable)timingFunction;

/**
 Animate the opacity of the Snackbar view.

 @param fromOpacity initial opacity to start animation.
 @param toOpacity opacity to finish animation.
 @return the opacity animation.
 */
- (CABasicAnimation *_Nullable)animateSnackbarOpacityFrom:(CGFloat)fromOpacity
                                                       to:(CGFloat)toOpacity;

/**
 Animate the scale of the Snackbar view.

 @param fromScale initial scale to start animation.
 @param toScale scale to finish animation.
 @return the scale animation.
 */
- (CABasicAnimation *_Nullable)animateSnackbarScaleFrom:(CGFloat)fromScale toScale:(CGFloat)toScale;

@end
