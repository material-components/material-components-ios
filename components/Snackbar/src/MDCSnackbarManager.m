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

#import "MDCSnackbarManager.h"

#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"
#import "MaterialApplication.h"
#import "MaterialOverlayWindow.h"

#import "private/MDCSnackbarManagerInternal.h"
#import "private/MDCSnackbarMessageInternal.h"
#import "private/MDCSnackbarMessageViewInternal.h"
#import "private/MDCSnackbarOverlayView.h"

/** Test whether any of the accessibility elements of a view is focused */
static BOOL UIViewHasFocusedAccessibilityElement(UIView *view) {
  for (NSInteger i = 0; i < [view accessibilityElementCount]; i++) {
    id accessibilityElement = [view accessibilityElementAtIndex:i];
    if ([accessibilityElement accessibilityElementIsFocused]) {
      return YES;
    }
  }
  return NO;
};

@class MDCSnackbarManagerSuspensionToken;

/**
 Special category representing all messages.
 */
static NSString *const kAllMessagesCategory = @"$$___ALL_MESSAGES___$$";

/**
 The 'actual' Snackbar manager which will take care of showing/hiding Snackbar messages.
 */
@interface MDCSnackbarManagerInternal ()

/**
 This property is used to test logic flows only when voiceover is on.

 Note: we can't fake or mock the system calls like UIAccessibilityIsVoiceOverRunning()
 */
@property(nonatomic) BOOL isVoiceOverRunningOverride;

/**
 The instance of MDCSnackbarManager that "owns" this internal manager.  Used to get theming
 properties. Can be refactored away in the future.
 */
@property(nonatomic, weak) MDCSnackbarManager *manager;

/**
 The list of messages waiting to be displayed.
 */
@property(nonatomic) NSMutableArray *pendingMessages;

/**
 The current suspension tokens.

 @note: Keys are the message category, or the all messages category. Values are sets of suspension
        tokens.
 */
@property(nonatomic) NSMutableDictionary<NSString *, NSMutableSet<NSUUID *> *> *suspensionTokens;

/**
 The view which will host our Snackbar messages.
 */
@property(nonatomic) MDCSnackbarOverlayView *overlayView;

/**
 The view which contains the overlayView.
 */
@property(nonatomic) UIView *presentationHostView;

/**
 The currently-showing Snackbar.
 */
@property(nonatomic) MDCSnackbarMessageView *currentSnackbar;

/**
 Whether or not we are currently showing a message.
 */
@property(nonatomic) BOOL showingMessage;

/**
 The delegate for MDCSnackbarManagerDelegate
 */
@property(nonatomic, weak) id<MDCSnackbarManagerDelegate> delegate;

- (instancetype)initWithSnackbarManager:(__weak MDCSnackbarManager *)manager;

@end

@interface MDCSnackbarManagerSuspensionToken : NSObject <MDCSnackbarSuspensionToken>

/**
 The unique identifier for this token.
 */
@property(nonatomic, readonly) NSUUID *identifier;

/**
 The category string associated with this token.
 */
@property(nonatomic) NSString *category;

- (instancetype)initWithManager:(nonnull MDCSnackbarManager *)manager;

@end

@implementation MDCSnackbarManagerInternal

- (instancetype)initWithSnackbarManager:(MDCSnackbarManager *__weak)manager {
  self = [super init];
  if (self) {
    _manager = manager;
    _pendingMessages = [[NSMutableArray alloc] init];
    _suspensionTokens = [NSMutableDictionary dictionary];
  }
  return self;
}

#pragma mark - Message Displaying

/**
 Determines whether or not a message is eligible to be shown based on the Snackbar manager's current
 configuration.

 @note This method should ensure that messages in the same category are not shown out of order.
 */
- (BOOL)shouldShowMessageRightNowMainThread:(MDCSnackbarMessage *)message {
  // If there are outstanding suspension tokens for all messages (not just specific categories),
  // then hold off on displaying.
  if ([self allMessagesSuspendedMainThread]) {
    return NO;
  }

  // If there is an outstanding suspension token for this message category, then hold off on
  // displaying.
  if (message.category != nil && [self categorySuspended:message.category]) {
    return NO;
  }

  return YES;
}

- (MDCSnackbarMessage *)dequeueNextShowableMessageMainThread {
  // NOTE: In pathological cases, the iteration through the pending messages can be an O(n)
  //       operation. Though we expect `n` to be low, to protect against needless iteration we'll
  //       do a quick check to see if message displaying is completely suspended.
  if ([self allMessagesSuspendedMainThread]) {
    return nil;
  }

  __block NSUInteger messageIndex = NSNotFound;
  [self.pendingMessages
      enumerateObjectsUsingBlock:^(MDCSnackbarMessage *message, NSUInteger idx, BOOL *stop) {
        if ([self shouldShowMessageRightNowMainThread:message]) {
          messageIndex = idx;
          *stop = YES;
        }
      }];

  if (messageIndex != NSNotFound) {
    MDCSnackbarMessage *message = self.pendingMessages[messageIndex];
    [self.pendingMessages removeObjectAtIndex:messageIndex];

    return message;
  }

  return nil;
}

// Dequeues and schedules the display of a particular message.
- (void)showNextMessageIfNecessaryMainThread {
  // Ensure that this method is called on the main thread.
  NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

  if (self.pendingMessages.count == 0) {
    return;
  }

  if (!self.showingMessage) {
    MDCSnackbarMessage *message = [self dequeueNextShowableMessageMainThread];

    if (message != nil) {
      self.showingMessage = YES;
      [self displaySnackbarViewForMessage:message];
    }
  }
}

// This method should only be called from within @c showNextMessageIfNecessaryMainThread.
- (void)displaySnackbarViewForMessage:(MDCSnackbarMessage *)message {
  // Ensure that this method is called on the main thread.
  NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

  __block MDCSnackbarMessageView *snackbarView = nil;

  // Guard against the timer firing and trying to dismiss us multiple times.
  __block BOOL shouldDismiss = YES;
  MDCSnackbarMessageDismissHandler dismissHandler =
      ^(BOOL userInitiated, MDCSnackbarMessageAction *action) {
        // Because we start a timer to dismiss the Snackbar once it is on screen, there exists the
        // potential to try and dismiss the Snackbar view multiple times, say if the user taps on
        // the Snackbar (dismissal one) and then the timer fires (dismissal two). This check ensures
        // that the dismissal logic will only fire one time for a given Snackbar view.
        if (shouldDismiss) {
          shouldDismiss = NO;

          // If the user
          [self hideSnackbarViewReally:snackbarView withAction:action userPrompted:userInitiated];
        }
      };

  Class viewClass = [message viewClass];
  snackbarView = [[viewClass alloc] initWithMessage:message
                                     dismissHandler:dismissHandler
                                    snackbarManager:self.manager];
  snackbarView.accessibilityViewIsModal =
      self.manager.shouldEnableAccessibilityViewIsModal && ![self isSnackbarTransient:snackbarView];
  [self.delegate willPresentSnackbarWithMessageView:snackbarView];
  self.currentSnackbar = snackbarView;
  self.overlayView.accessibilityViewIsModal = snackbarView.accessibilityViewIsModal;
  self.overlayView.hidden = NO;
  [self activateOverlay:self.overlayView];

  // Once the Snackbar has finished animating on screen, start the automatic dismiss timeout, but
  // only if the user isn't running VoiceOver.
  [self.overlayView
      showSnackbarView:snackbarView
              animated:YES
            completion:^{
              if (snackbarView.accessibilityViewIsModal ||
                  ![self isSnackbarTransient:snackbarView]) {
                UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification,
                                                snackbarView);
              } else {
                snackbarView.accessibilityElementsHidden = YES;
                UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,
                                                message.voiceNotificationText);
              }

              if ([self isSnackbarTransient:snackbarView]) {
                __weak MDCSnackbarMessageView *weakSnackbarView = snackbarView;
                dispatch_time_t popTime =
                    dispatch_time(DISPATCH_TIME_NOW, (int64_t)(message.duration * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
                  MDCSnackbarMessageView *strongSnackbarView = weakSnackbarView;
                  BOOL hasVoiceOverFocus = UIAccessibilityIsVoiceOverRunning() &&
                                           UIViewHasFocusedAccessibilityElement(strongSnackbarView);
                  if (strongSnackbarView && !hasVoiceOverFocus) {
                    // Mimic the user tapping on the Snackbar.
                    [strongSnackbarView dismissWithAction:nil userInitiated:NO];
                  }
                });
              }
            }];
}

- (MDCSnackbarOverlayView *)overlayView {
  if (!_overlayView) {
    // Only initialize on the main thread.
    NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

    _overlayView = [[MDCSnackbarOverlayView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  }
  return _overlayView;
}

- (void)hideSnackbarViewReally:(MDCSnackbarMessageView *)snackbarView
                    withAction:(MDCSnackbarMessageAction *)action
                  userPrompted:(BOOL)userPrompted {
  // Ensure that this method is called on the main thread.
  NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

  // Mark the Snackbar as being in the process of dismissal.
  snackbarView.dismissing = YES;

  MDCSnackbarMessage *message = snackbarView.message;

  // Fire off the button action, if necessary. Always call the message's completion handler.
  [message executeActionHandler:action
                     completion:^{
                       [message executeCompletionHandlerWithUserInteraction:userPrompted
                                                                 completion:nil];
                     }];

  [self.overlayView dismissSnackbarViewAnimated:YES
                                     completion:^{
                                       self.overlayView.hidden = YES;
                                       [self deactivateOverlay:self.overlayView];

                                       // If the snackbarView was transient and
                                       // accessibilityViewIsModal is NO, the Snackbar was just
                                       // announced (layout was not reported as changed) so there is
                                       // no need to post a layout change here.
                                       if (self.overlayView.accessibilityViewIsModal ||
                                           ![self isSnackbarTransient:snackbarView]) {
                                         UIAccessibilityPostNotification(
                                             UIAccessibilityLayoutChangedNotification, nil);
                                       }

                                       self.currentSnackbar = nil;

                                       // Now that the snackbarView is offscreen, we can allow more
                                       // messages to be shown.
                                       self.showingMessage = NO;
                                       [self showNextMessageIfNecessaryMainThread];
                                     }];
}

#pragma mark - Helper methods

- (BOOL)isVoiceOverRunning {
  if (UIAccessibilityIsVoiceOverRunning() || UIAccessibilityIsSwitchControlRunning() ||
      self.isVoiceOverRunningOverride) {
    return YES;
  }
  return NO;
}

- (BOOL)isSnackbarTransient:(MDCSnackbarMessageView *)snackbarView {
  if ([self isVoiceOverRunning]) {
    return ![snackbarView shouldWaitForDismissalDuringVoiceover];
  }

  return YES;
}

#pragma mark - Overlay Activation

- (void)activateOverlay:(UIView *)overlay {
  UIWindow *window = [self bestGuessWindow];
  UIView *targetView = nil;

  if (self.presentationHostView) {
    targetView = self.presentationHostView;
  } else if ([window isKindOfClass:[MDCOverlayWindow class]]) {
    // If the application's window is an overlay window, take advantage of it. Otherwise, just add
    // our overlay view into the main view controller's hierarchy.
    MDCOverlayWindow *overlayWindow = (MDCOverlayWindow *)window;
    [overlayWindow activateOverlay:overlay withLevel:UIWindowLevelNormal];
  } else {
    // Find the most top view controller to display overlay.
    UIViewController *topViewController = [window rootViewController];
    while ([topViewController presentedViewController]) {
      topViewController = [topViewController presentedViewController];
    }
    targetView = [topViewController view];
  }

  if (targetView) {
    overlay.frame = targetView.bounds;
    overlay.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    overlay.translatesAutoresizingMaskIntoConstraints = YES;

    [targetView addSubview:overlay];
  }
}

- (UIWindow *)bestGuessWindow {
  UIApplication *application = [UIApplication mdc_safeSharedApplication];

  // Check all of the windows in existence for an overlay window, because that's what we prefer to
  // present in.
  for (UIWindow *window in application.windows) {
    if ([window isKindOfClass:[MDCOverlayWindow class]]) {
      return window;
    }
  }

  // Next see if the application's delegate declares a window. That's a good indicator of it being
  // the 'main' window for an application.
  if ([application.delegate respondsToSelector:@selector(window)]) {
    id potentialWindow = application.delegate.window;
    if (potentialWindow != nil) {
      return potentialWindow;
    }
  }

  // Default to the key window, since we couldn't find anything better.
  return [[UIApplication mdc_safeSharedApplication] keyWindow];
}

- (void)deactivateOverlay:(UIView *)overlay {
  UIWindow *window = [[UIApplication mdc_safeSharedApplication] keyWindow];
  if ([window isKindOfClass:[MDCOverlayWindow class]]) {
    MDCOverlayWindow *overlayWindow = (MDCOverlayWindow *)window;
    [overlayWindow deactivateOverlay:overlay];
  } else {
    [overlay removeFromSuperview];
  }
}

#pragma mark - Public API

// Must be called from the main thread only.
- (void)showMessageMainThread:(MDCSnackbarMessage *)message {
  // Ensure that this method is called on the main thread.
  NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

  // Dismiss and call the completion block for all the messages from the same category.
  [self dismissAndCallCompletionBlocksOnMainThreadWithCategory:message.category];

  // Add the new message to the queue, the call to @c showNextMessageIfNecessaryMainThread will take
  // care of getting it on screen. At this moment, @c message is the only message of its category
  // in @c _sPendingMessages.
  [self.pendingMessages addObject:message];

  // Pulse the UI as needed.
  [self showNextMessageIfNecessaryMainThread];
}

- (void)dismissAndCallCompletionBlocksOnMainThreadWithCategory:(NSString *)categoryToDismiss {
  // Ensure that this method is called on the main thread.
  NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

  // Make sure that if there is a Snackbar on screen, it does not belong to the current category.
  if (self.currentSnackbar != nil && !self.currentSnackbar.dismissing) {
    MDCSnackbarMessage *currentMessage = self.currentSnackbar.message;

    if (!categoryToDismiss || [currentMessage.category isEqualToString:categoryToDismiss]) {
      // Mimic the user tapping on the Snackbar. This will trigger the display of other messages,
      // but because the dismissal animations happen on the main thread, we can modify
      // @c _sPendingMessages in this cycle of the runloop without fear of the dismiss
      // animation interfering.
      [self.currentSnackbar dismissWithAction:nil userInitiated:NO];
    }
  }

  // Now that we've ensured that the currently showing Snackbar has been taken care of, we can go
  // through pending messages and fire off their completion blocks as we remove them from the
  // queue.
  NSMutableIndexSet *indexesToRemove = [NSMutableIndexSet indexSet];
  [self.pendingMessages enumerateObjectsUsingBlock:^(MDCSnackbarMessage *pendingMessage,
                                                     NSUInteger idx, __unused BOOL *stop) {
    if (!categoryToDismiss || [pendingMessage.category isEqualToString:categoryToDismiss]) {
      // Mark the message for removal from the pending messages list.
      [indexesToRemove addIndex:idx];

      // Notify the outside world that this Snackbar has been completed.
      [pendingMessage executeCompletionHandlerWithUserInteraction:NO completion:nil];
    }
  }];

  // Make sure the queued up messages aren't shown.
  if ([indexesToRemove count]) {
    [self.pendingMessages removeObjectsAtIndexes:indexesToRemove];
  }
}

#pragma mark - Suspend/Resume

/**
 Returns YES if message display is completely suspended.
 */
- (BOOL)allMessagesSuspendedMainThread {
  NSMutableSet *allMessageSuspensions = self.suspensionTokens[kAllMessagesCategory];
  if (allMessageSuspensions.count > 0) {
    return YES;
  }
  return NO;
}

/**
 Returns YES if message display is suspended for the given category.
 */
- (BOOL)categorySuspended:(NSString *)category {
  NSMutableSet *thisCategorySuspensions = self.suspensionTokens[category];
  if (thisCategorySuspensions.count > 0) {
    return YES;
  }
  return NO;
}

- (void)addSuspensionIdentifierMainThread:(NSUUID *)identifier forCategory:(NSString *)category {
  // Ensure that this method is called on the main thread.
  NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

  NSMutableSet *tokens = self.suspensionTokens[category];
  if (tokens == nil) {
    tokens = [NSMutableSet set];
    self.suspensionTokens[category] = tokens;
  }

  [tokens addObject:identifier];
}

- (void)removeSuspensionIdentifierMainThread:(NSUUID *)identifier forCategory:(NSString *)category {
  // Ensure that this method is called on the main thread.
  NSAssert([NSThread isMainThread], @"Method is not called on main thread.");

  NSMutableSet *tokens = self.suspensionTokens[category];
  [tokens removeObject:identifier];

  // If that was the last token for this category, do some cleanup.
  if (tokens != nil && tokens.count == 0) {
    [self.suspensionTokens removeObjectForKey:category];
  }

  // We may have removed the last suspend, so trigger a display.
  [self showNextMessageIfNecessaryMainThread];
}

@end

#pragma mark - Public API

@interface MDCSnackbarManager ()
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end

@implementation MDCSnackbarManager {
  UIColor *_snackbarMessageViewBackgroundColor;
  UIColor *_snackbarMessageViewShadowColor;
  UIColor *_messageTextColor;
  UIFont *_messageFont;
  UIFont *_buttonFont;
  NSMutableDictionary<NSNumber *, UIColor *> *_buttonTitleColors;
  BOOL _mdc_adjustsFontForContentSizeCategory;
  BOOL _shouldApplyStyleChangesToVisibleSnackbars;
}

+ (instancetype)defaultManager {
  static MDCSnackbarManager *defaultManager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    defaultManager = [[MDCSnackbarManager alloc] init];
  });
  return defaultManager;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _internalManager = [[MDCSnackbarManagerInternal alloc] initWithSnackbarManager:self];
  }
  return self;
}

- (void)setDelegate:(id<MDCSnackbarManagerDelegate>)delegate {
  self.internalManager.delegate = delegate;
}

- (id<MDCSnackbarManagerDelegate>)delegate {
  return self.internalManager.delegate;
}

- (void)showMessage:(MDCSnackbarMessage *)inputMessage {
  if (!inputMessage) {
    return;
  }

  // Snag a copy now, we'll use that internally.
  MDCSnackbarMessage *message = [inputMessage copy];

  // Ensure that all of our work happens on the main thread.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.internalManager showMessageMainThread:message];
  });
}

- (void)setPresentationHostView:(UIView *)hostView {
  NSAssert([NSThread isMainThread], @"setPresentationHostView must be called on main thread.");

  self.internalManager.presentationHostView = hostView;
}

- (BOOL)hasMessagesShowingOrQueued {
  NSAssert([NSThread isMainThread], @"hasMessagesShowingOrQueued must be called on main thread.");

  return (self.internalManager.showingMessage || self.internalManager.pendingMessages.count != 0);
}

- (void)dismissAndCallCompletionBlocksWithCategory:(NSString *)category {
  // Snag a copy now, we'll use that internally.
  NSString *categoryToDismiss = [category copy];

  // Ensure that all of our work happens on the main thread.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.internalManager dismissAndCallCompletionBlocksOnMainThreadWithCategory:categoryToDismiss];
  });
}

- (void)setBottomOffset:(CGFloat)offset {
  NSAssert([NSThread isMainThread], @"setBottomOffset must be called on main thread.");

  self.internalManager.overlayView.bottomOffset = offset;
}

- (void)setAlignment:(MDCSnackbarAlignment)alignment {
  NSAssert([NSThread isMainThread], @"setAlignment must be called on main thread.");

  self.internalManager.overlayView.alignment = alignment;
}

- (MDCSnackbarAlignment)alignment {
  return self.internalManager.overlayView.alignment;
}

#pragma mark - Suspension

- (id<MDCSnackbarSuspensionToken>)suspendMessagesWithCategory:(NSString *)category {
  MDCSnackbarManagerSuspensionToken *token =
      [[MDCSnackbarManagerSuspensionToken alloc] initWithManager:self];
  token.category = category;

  // Ensure that all of our work happens on the main thread.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.internalManager addSuspensionIdentifierMainThread:token.identifier
                                                forCategory:token.category];
  });

  return token;
}

- (id<MDCSnackbarSuspensionToken>)suspendAllMessages {
  return [self suspendMessagesWithCategory:kAllMessagesCategory];
}

- (void)handleInvalidatedIdentifier:(NSUUID *)identifier forCategory:(NSString *)category {
  // Ensure that all of our work happens on the main thread.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.internalManager removeSuspensionIdentifierMainThread:identifier forCategory:category];
  });
}

- (void)resumeMessagesWithToken:(id<MDCSnackbarSuspensionToken>)inToken {
  if (![inToken isKindOfClass:[MDCSnackbarManagerSuspensionToken class]]) {
    return;
  }

  MDCSnackbarManagerSuspensionToken *token = (MDCSnackbarManagerSuspensionToken *)inToken;
  [self handleInvalidatedIdentifier:token.identifier forCategory:token.category];
}

#pragma mark - Styling

- (void)runSnackbarUpdatesOnMainThread:(void (^)(void))block {
  if (_shouldApplyStyleChangesToVisibleSnackbars) {
    if ([NSThread isMainThread]) {
      block();
    } else {
      dispatch_async(dispatch_get_main_queue(), block);
    }
  }
}

- (void)setSnackbarMessageViewBackgroundColor:(UIColor *)snackbarMessageViewBackgroundColor {
  if (snackbarMessageViewBackgroundColor != _snackbarMessageViewBackgroundColor) {
    _snackbarMessageViewBackgroundColor = snackbarMessageViewBackgroundColor;
    [self runSnackbarUpdatesOnMainThread:^{
      [self.internalManager.currentSnackbar
          setSnackbarMessageViewBackgroundColor:snackbarMessageViewBackgroundColor];
    }];
  }
}

- (UIColor *)snackbarMessageViewBackgroundColor {
  return _snackbarMessageViewBackgroundColor;
}

- (void)setSnackbarMessageViewShadowColor:(UIColor *)snackbarMessageViewShadowColor {
  if (snackbarMessageViewShadowColor != _snackbarMessageViewShadowColor) {
    _snackbarMessageViewShadowColor = snackbarMessageViewShadowColor;
    [self runSnackbarUpdatesOnMainThread:^{
      [self.internalManager.currentSnackbar
          setSnackbarMessageViewShadowColor:snackbarMessageViewShadowColor];
    }];
  }
}

- (UIColor *)snackbarMessageViewShadowColor {
  return _snackbarMessageViewShadowColor;
}

- (void)setMessageTextColor:(UIColor *)messageTextColor {
  if (messageTextColor != _messageTextColor) {
    _messageTextColor = messageTextColor;
    [self runSnackbarUpdatesOnMainThread:^{
      [self.internalManager.currentSnackbar setMessageTextColor:messageTextColor];
    }];
  }
}

- (UIColor *)messageTextColor {
  return _messageTextColor;
}

- (void)setMessageFont:(UIFont *)messageFont {
  if (messageFont != _messageFont) {
    _messageFont = messageFont;
    [self runSnackbarUpdatesOnMainThread:^{
      [self.internalManager.currentSnackbar setMessageFont:messageFont];
    }];
  }
}

- (UIFont *)messageFont {
  return _messageFont;
}

- (void)setButtonFont:(UIFont *)buttonFont {
  if (buttonFont != _buttonFont) {
    _buttonFont = buttonFont;
    [self runSnackbarUpdatesOnMainThread:^{
      [self.internalManager.currentSnackbar setButtonFont:buttonFont];
    }];
  }
}

- (UIFont *)buttonFont {
  return _buttonFont;
}

- (void)setButtonTitleColor:(UIColor *)titleColor forState:(UIControlState)state {
  if (_buttonTitleColors == nil) {
    _buttonTitleColors = [NSMutableDictionary dictionary];
  }
  if (titleColor != _buttonTitleColors[@(state)]) {
    _buttonTitleColors[@(state)] = titleColor;
    [self runSnackbarUpdatesOnMainThread:^{
      [self.internalManager.currentSnackbar setButtonTitleColor:titleColor forState:state];
    }];
  }
}

- (UIColor *)buttonTitleColorForState:(UIControlState)state {
  return _buttonTitleColors[@(state)];
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)mdc_adjustsFontForContentSizeCategory {
  if (mdc_adjustsFontForContentSizeCategory != _mdc_adjustsFontForContentSizeCategory) {
    _mdc_adjustsFontForContentSizeCategory = mdc_adjustsFontForContentSizeCategory;
    [self runSnackbarUpdatesOnMainThread:^{
      [self.internalManager.currentSnackbar
          mdc_setAdjustsFontForContentSizeCategory:mdc_adjustsFontForContentSizeCategory];
    }];
  }
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)setShouldApplyStyleChangesToVisibleSnackbars:
    (BOOL)shouldApplyStyleChangesToVisibleSnackbars {
  _shouldApplyStyleChangesToVisibleSnackbars = shouldApplyStyleChangesToVisibleSnackbars;
}

- (BOOL)shouldApplyStyleChangesToVisibleSnackbars {
  return _shouldApplyStyleChangesToVisibleSnackbars;
}

@end

@interface MDCSnackbarManagerSuspensionToken ()
@property(nonatomic, weak) MDCSnackbarManager *manager;
@end

@implementation MDCSnackbarManagerSuspensionToken

- (instancetype)initWithManager:(MDCSnackbarManager *)manager {
  self = [super init];
  if (self != nil) {
    _identifier = [NSUUID UUID];
    _manager = manager;
  }
  return self;
}

- (void)dealloc {
  [_manager resumeMessagesWithToken:self];
}

@end

@implementation MDCSnackbarManager (LegacyAPI)

+ (MDCSnackbarAlignment)alignment {
  return MDCSnackbarManager.defaultManager.alignment;
}

+ (void)setAlignment:(MDCSnackbarAlignment)alignment {
  MDCSnackbarManager.defaultManager.alignment = alignment;
}

+ (void)showMessage:(nullable MDCSnackbarMessage *)message {
  [MDCSnackbarManager.defaultManager showMessage:message];
}

+ (void)setPresentationHostView:(nullable UIView *)hostView {
  [MDCSnackbarManager.defaultManager setPresentationHostView:hostView];
}

+ (BOOL)hasMessagesShowingOrQueued {
  return MDCSnackbarManager.defaultManager.hasMessagesShowingOrQueued;
}

+ (void)dismissAndCallCompletionBlocksWithCategory:(nullable NSString *)category {
  [MDCSnackbarManager.defaultManager dismissAndCallCompletionBlocksWithCategory:category];
}

+ (void)setBottomOffset:(CGFloat)offset {
  [MDCSnackbarManager.defaultManager setBottomOffset:offset];
}

+ (nullable id<MDCSnackbarSuspensionToken>)suspendAllMessages {
  return MDCSnackbarManager.defaultManager.suspendAllMessages;
}

+ (nullable id<MDCSnackbarSuspensionToken>)suspendMessagesWithCategory:
    (nullable NSString *)category {
  return [MDCSnackbarManager.defaultManager suspendMessagesWithCategory:category];
}

+ (void)resumeMessagesWithToken:(nullable id<MDCSnackbarSuspensionToken>)token {
  [MDCSnackbarManager.defaultManager resumeMessagesWithToken:token];
}

+ (UIColor *)snackbarMessageViewBackgroundColor {
  return MDCSnackbarManager.defaultManager.snackbarMessageViewBackgroundColor;
}

+ (void)setSnackbarMessageViewBackgroundColor:(UIColor *)snackbarMessageViewBackgroundColor {
  MDCSnackbarManager.defaultManager.snackbarMessageViewBackgroundColor =
      snackbarMessageViewBackgroundColor;
}

+ (UIColor *)snackbarMessageViewShadowColor {
  return MDCSnackbarManager.defaultManager.snackbarMessageViewShadowColor;
}

+ (void)setSnackbarMessageViewShadowColor:(UIColor *)snackbarMessageViewShadowColor {
  MDCSnackbarManager.defaultManager.snackbarMessageViewShadowColor = snackbarMessageViewShadowColor;
}

+ (UIColor *)messageTextColor {
  return MDCSnackbarManager.defaultManager.messageTextColor;
}

+ (void)setMessageTextColor:(UIColor *)messageTextColor {
  MDCSnackbarManager.defaultManager.messageTextColor = messageTextColor;
}

+ (UIFont *)messageFont {
  return MDCSnackbarManager.defaultManager.messageFont;
}

+ (void)setMessageFont:(UIFont *)messageFont {
  MDCSnackbarManager.defaultManager.messageFont = messageFont;
}

+ (UIFont *)buttonFont {
  return MDCSnackbarManager.defaultManager.buttonFont;
}

+ (void)setButtonFont:(UIFont *)buttonFont {
  MDCSnackbarManager.defaultManager.buttonFont = buttonFont;
}

+ (BOOL)shouldApplyStyleChangesToVisibleSnackbars {
  return MDCSnackbarManager.defaultManager.shouldApplyStyleChangesToVisibleSnackbars;
}

+ (void)setShouldApplyStyleChangesToVisibleSnackbars:
    (BOOL)shouldApplyStyleChangesToVisibleSnackbars {
  MDCSnackbarManager.defaultManager.shouldApplyStyleChangesToVisibleSnackbars =
      shouldApplyStyleChangesToVisibleSnackbars;
}

+ (UIColor *)buttonTitleColorForState:(UIControlState)state {
  return [MDCSnackbarManager.defaultManager buttonTitleColorForState:state];
}

+ (void)setButtonTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state {
  [MDCSnackbarManager.defaultManager setButtonTitleColor:titleColor forState:state];
}

+ (BOOL)mdc_adjustsFontForContentSizeCategory {
  return MDCSnackbarManager.defaultManager.mdc_adjustsFontForContentSizeCategory;
}

+ (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)mdc_adjustsFontForContentSizeCategory {
  [MDCSnackbarManager.defaultManager
      mdc_setAdjustsFontForContentSizeCategory:mdc_adjustsFontForContentSizeCategory];
}

+ (id<MDCSnackbarManagerDelegate>)delegate {
  return MDCSnackbarManager.defaultManager.delegate;
}

+ (void)setDelegate:(id<MDCSnackbarManagerDelegate>)delegate {
  MDCSnackbarManager.defaultManager.delegate = delegate;
}

@end
