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

#import "MDCSnackbarAlignment.h"
#import "MaterialElevation.h"
#import "MaterialShadowElevations.h"
// TODO(b/151929968): Delete import of delegate headers when client code has been migrated to no
// longer import delegates as transitive dependencies.
#import "MDCSnackbarManagerDelegate.h"

@class MDCSnackbarMessage;
@class MDCSnackbarMessageView;
@protocol MDCSnackbarManagerDelegate;
@protocol MDCSnackbarSuspensionToken;

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 Provides a means of displaying an unobtrusive message to the user.

 The style and location of the message can vary depending on the configuration of the message to be
 shown. This class will queue repeated calls to @c showMessage: and show them at the appropriate
 time, once previous messages have been dismissed. This class is thread-safe as long as the messages
 given to MDCSnackbarManager.defaultManager are not mutated after being passed to @c showMessage:

 Snackbars prefer an application's main window is a subclass of @c MDCOverlayWindow. When a standard
 UIWindow is used an attempt is made to find the top-most view controller in the view hierarchy.
 */
@interface MDCSnackbarManager : NSObject <MDCElevationOverriding>
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

/**
 Initializes a snackbar manager.

 If windowScene is null then there is no guarantee that the window that presents a snackbar will
 belong to a given scene.

 @param windowScene The scene that is searched for an appropriate window when presenting a snackbar.
 @return An initialized MDCSnackbarManager object.
 */
- (instancetype)initWithWindowScene:(nullable UIWindowScene *)windowScene NS_DESIGNATED_INITIALIZER;

/**
 Convenience initializer.

 @return An initialized MDCSnackbarManager object.
 */
- (instancetype)init;

NS_ASSUME_NONNULL_END

/**
 The default shared instance of MDCSnackbarManager.

 Any property set on this shared manager affects all the snackbar messages sent to this manager.

 Consider creating a new manager instance or resetting the property values
 (e.g. leadingMargin, trailingMargin) to their default values on the default
 manager instance if you don't want the property values to affect all
 snackbar messages.
 */
@property(class, nonnull, nonatomic, readonly, strong) MDCSnackbarManager *defaultManager;

/**
 Determines the Snackbar alignment to the screen horizontally.

 If called within an animation block, the change will be animated.

 @note This setting is only used when both the horizontal and vertical size classes of the
 presenting window are @c UIUserInterfaceSizeClassRegular. Otherwise @c MDCSnackbarAlignmentCenter
 will be used.

 @note The setter must be called from the main thread.
 */
@property(nonatomic, assign) MDCSnackbarHorizontalAlignment horizontalAlignment;

/**
 Determines the Snackbar alignment to the screen vertically.

 @note The setter must be called from the main thread.
 */
@property(nonatomic, assign) MDCSnackbarVerticalAlignment verticalAlignment;

/**
 Determines the Snackbar's top margin to the safe area of the screen.

 Defaults to 8.
 */
@property(nonatomic, assign) CGFloat topMargin;

/**
 Determines the Snackbar's leading margin to the safe area of the screen.

 Defaults to 8 when the traitCollection horizontal size class is compact.

 Defaults to 24 when the traitCollection horizontal size class is regular.
 */
@property(nonatomic, assign) CGFloat leadingMargin;

/**
 Determines the Snackbar's trailing margin to the safe area of the screen.

 Defaults to 8 when the traitCollection horizontal size class is compact.

 Defaults to 24 when the traitCollection horizontal size class is regular.
 */
@property(nonatomic, assign) CGFloat trailingMargin;

/**
 Shows @c message to the user, in a style consistent with the data contained in @c message.

 For messages with the same category, the firing of completion blocks has a guaranteed FIFO
 ordering. Ordering between completion blocks of different categories is not guaranteed. This method
 is safe to call from any thread.
 */
- (void)showMessage:(nullable MDCSnackbarMessage *)message;

/**
 MDCSnackbarManager.defaultManager will display the messages in this view.

 Call this method to choose where in the view hierarchy Snackbar messages will be presented. It is
 only necessary to provide a host view if the default behavior is unable to find one on it's own,
 most commonly when using MDCSnackbarManager.defaultManager inside an application extension. By
 default, if you use MDCSnackbarManager.defaultManager without calling @c setPresentationHostView,
 the manager will attempt to find a suitable view by stepping through the application windows.
 Explicitly providing a host view is only required if you need to manually manage the view
 hierarchy, or are inside a UIApplication extension.

 @note This method must be called from the main thread.
 @note Calling setPresentationHostView will not change the parent of the currently visible message.
 */
- (void)setPresentationHostView:(nullable UIView *)hostView;

/**
 Checks if there is any message showing or queued. Does not consider suspended messages.

 @note This method must be called from the main thread.
 */
- (BOOL)hasMessagesShowingOrQueued;

/**
 Bypasses showing the messages of the given @c category.

 Completion blocks are called, but the UI won't show any queued messages and will dismiss any
 messages for the @c category. Calling this method with @c nil will dismiss all messages. This
 method is safe to call from any thread.
 */
- (void)dismissAndCallCompletionBlocksWithCategory:(nullable NSString *)category;

/**
 How far from the bottom of the screen messages are displayed when @c verticalAlignment is @c
 MDCSnackbarHorizontalAlignmentBottom.

 If called within an animation block, the change will be animated.

 @note This method must be called from the main thread.
 @note This is meant for apps which have a navigation element such as a tab bar, which cannot
 move and should not be obscured.
 */
- (void)setBottomOffset:(CGFloat)offset;

#pragma mark Suspending

/**
 Suspends the display of all messages.

 Any messages currently on screen will remain on screen (and dismiss normally). During this time any
 incoming messages will be queued as normal.

 @return A token suitable for use in {@c +[MDCSnackbarManager resumeWithToken:]}. Letting this
 object deallocate is equivalent to calling {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 */
- (nullable id<MDCSnackbarSuspensionToken>)suspendAllMessages;

/**
 Suspends the display of all messages in a given category.

 Any messages currently on screen will remain on screen (and dismiss normally). During this time any
 incoming messages in this category will be queued as normal.

 @param category The category for which message display will be suspended. Should not be nil.
 @return A token suitable for use in {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 Letting this object dealloc is equivalent to calling
 {@c +[MDCSnackbarManager resumeMessagesWithToken:]}.
 */
- (nullable id<MDCSnackbarSuspensionToken>)suspendMessagesWithCategory:
    (nullable NSString *)category;

/**
 Resumes the display of messages once there are no outstanding suspension tokens.

 The provided token is invalidated and becomes useless.

 @param token The suspension token to invalidate.
 */
- (void)resumeMessagesWithToken:(nullable id<MDCSnackbarSuspensionToken>)token;

#pragma mark Styling

/**
 The color for the background of the Snackbar message view.

 If using the MDCSnackbarMessageView GM3 branding API, setting this property will have no effect.
 Instead, customize background color in the MDCSnackbarManagerDelegate method
 `snackbarManager:willPresentSnackbarWithMessageView:` after calling the branding API. See
 go/material-ios-snackbar for details on using GM3 branding APIs.
 */
@property(nonatomic, strong, nullable) UIColor *snackbarMessageViewBackgroundColor;

/**
 The color for the shadow color for the Snackbar message view.

 If using the MDCSnackbarMessageView GM3 branding API, setting this property will have no effect.
 Instead, customize shadow color in the MDCSnackbarManagerDelegate method
 `snackbarManager:willPresentSnackbarWithMessageView:` after calling the branding API. See
 go/material-ios-snackbar for details on using GM3 branding APIs.
 */
@property(nonatomic, strong, nullable) UIColor *snackbarMessageViewShadowColor;

/**
 The elevation for the Snackbar message view.

 If `usesGM3Shapes` is true, setting this property will have no effect. Instead, customize elevation
 in the MDCSnackbarManagerDelegate method `snackbarManager:willPresentSnackbarWithMessageView:`
 after calling the branding API. See go/material-ios-snackbar and go/material-ios-elevation for
 details on using GM3 branding APIs.
 */
@property(nonatomic, assign) MDCShadowElevation messageElevation;

/**
 The font for the message text in the Snackbar message view.

 If using the MDCSnackbarMessageView GM3 branding API, setting this property will have no effect.
 Instead, customize message font in the MDCSnackbarManagerDelegate method
 `snackbarManager:willPresentSnackbarWithMessageView:` after calling the branding API. See
 go/material-ios-snackbar for details on using GM3 branding APIs.
 */
@property(nonatomic, strong, nullable) UIFont *messageFont;

/**
 The color for the message text in the Snackbar message view.

 If using the MDCSnackbarMessageView GM3 branding API, setting this property will have no effect.
 Instead, customize message text color in the MDCSnackbarManagerDelegate method
 `snackbarManager:willPresentSnackbarWithMessageView:` after calling the branding API. See
 go/material-ios-snackbar for details on using GM3 branding APIs.
 */
@property(nonatomic, strong, nullable) UIColor *messageTextColor;

/**
 The font for the button text in the Snackbar message view.

 If using the MDCSnackbarMessageView GM3 branding API, setting this property will have no effect.
 Instead, customize button font in the MDCSnackbarManagerDelegate method
 `snackbarManager:willPresentSnackbarWithMessageView:` after calling the branding API. See
 go/material-ios-snackbar for details on using GM3 branding APIs.
 */
@property(nonatomic, strong, nullable) UIFont *buttonFont;

/**
 If true, converts button titles to uppercase. Defaults to MDCButton's default (YES).

 If using the MDCSnackbarMessageView GM3 branding API, setting this property will have no effect and
 button titles will not be converted to uppercase. See go/material-ios-snackbar for details on using
 GM3 branding APIs.
 */
@property(nonatomic, assign) BOOL uppercaseButtonTitle;

/**
 The color for the ink view in the Snackbar message view's buttons.

 If using the MDCSnackbarMessageView GM3 branding API, setting this property will have no effect.
 See go/material-ios-snackbar for details on using GM3 branding APIs.
 */
@property(nonatomic, strong, nullable) UIColor *buttonInkColor;

/**
 Enable a hidden touch affordance (button) for users to dismiss under VoiceOver.

 It allows users to dismiss the snackbar in an explicit way. When it is enabled,
 tapping on the message label won't dismiss the snackbar.

 Defaults to @c NO.

 If using the MDCSnackbarMessageView GM3 branding API, setting this value will have no effect; the
 affordance will be enabled.
 */
@property(nonatomic, assign) BOOL enableDismissalAccessibilityAffordance;

/**
 If enabled, modifications of class styling properties will be applied immediately
 to the currently presented Snackbar.

 Default is set to NO.
 */
@property(nonatomic, assign) BOOL shouldApplyStyleChangesToVisibleSnackbars;

/**
 This accessibility notification posted when a Snackbar changes the focus of VoiceOver.

 Default is set to UIAccessibilityLayoutChangedNotification.
 */
@property(nonatomic, assign) UIAccessibilityNotifications focusAccessibilityNotification;

/**
 Returns the button title color for a particular control state.

 @param state The control state.
 @return The button title color for the requested state.
 */
- (nullable UIColor *)buttonTitleColorForState:(UIControlState)state;

/**
 Sets the button title color for a particular control state.

 If using the MDCSnackbarMessageView GM3 branding API, setting this value will have no effect.
 Instead, customize button title color in the MDCSnackbarManagerDelegate method
 `snackbarManager:willPresentSnackbarWithMessageView:` after calling the branding API. See
 go/material-ios-snackbar for details on using GM3 branding APIs.

 @param titleColor The title color.
 @param state The control state.
 */
- (void)setButtonTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state;

/**
 If enabled, snackbars will use GM3 shape styling for buttons, shadows, etc.

 Note that enabling this BOOL is insufficient to style snackbars for GM3; see
 go/material-ios-snackbar for details on how to use the GM3 branding APIs.

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL usesGM3Shapes;

/**
 If enabled, accessibilityViewIsModal will be enabled for all non-transient snackbar views by
 default. If accessibilityViewIsModal needs to be set for specific snackbar views,
 -snackbarManager:willPresentSnackbarWithMessageView: in MDCSnackbarManagerDelegate can be used to
 access snackbar view and set the accessibilityViewIsModal value.

 Default is set to NO.
 */
@property(nonatomic, assign) BOOL shouldEnableAccessibilityViewIsModal;

/**
 If disabled, @c MDCSnackbarManager will not show snackbar messages when VoiceOver
 is running. Only consider setting this property to @c NO when your use case of snackbar provides
 disruptive user experience when VoiceOver is running and not showing snackbar wouldn't block
 user critical journey.

 Default is set to YES.
 */
@property(nonatomic, assign) BOOL shouldShowMessageWhenVoiceOverIsRunning;

/**
 The delegate for MDCSnackbarManager.defaultManager through which it may inform of snackbar
 presentation updates.
 */
@property(nonatomic, weak, nullable) id<MDCSnackbarManagerDelegate> delegate;

/**
 A block that is invoked when the manager's current snackbar's MDCSnackbarMessageView receives a
 call to @c traitCollectionDidChange:.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlockForMessageView)
    (MDCSnackbarMessageView *_Nonnull messageView,
     UITraitCollection *_Nullable previousTraitCollection);

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 A block that is invoked when the manager's current snackbar's MDCSnackbarMessageView elevation
 changes, and its mdc_elevationDidChangeBlock is called.
 */
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlockForMessageView)
    (id<MDCElevatable> _Nonnull object, CGFloat absoluteElevation);
#pragma clang diagnostic pop

@end


/**
 A suspension token is returned when messages are suspended by the Snackbar manager.

 Messages are suppressed while a suspension token is kept in memory. Messages will resume being
 displayed when the suspension token is released or when the suspension token is passed to
 @c resumeMessagesWithToken.
 */
@protocol MDCSnackbarSuspensionToken <NSObject>
@end
