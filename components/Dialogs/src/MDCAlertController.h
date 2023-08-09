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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialButtons.h"
// TODO(b/151929968): Delete import of delegate headers when client code has been migrated to no
// longer import delegates as transitive dependencies.
#import "MDCAlertControllerDelegate.h"
#import "MaterialElevation.h"
#import "M3CButton.h"
#import "MaterialShadowElevations.h"

NS_ASSUME_NONNULL_BEGIN

@class MDCAlertAction;
@class MDCAlertController;
@protocol MDCAlertControllerDelegate;

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 MDCAlertController displays an alert message to the user, similar to UIAlertController.

 https://material.io/go/design-dialogs

 MDCAlertController class is intended to be used as-is and does not support subclassing. The view
 hierarchy for this class is private and must not be modified.
 */
@interface MDCAlertController
    : UIViewController <MDCElevatable, MDCElevationOverriding, UIContentSizeCategoryAdjusting>
#pragma clang diagnostic pop

/**
 Convenience constructor to create and return a view controller for displaying an alert to the user.

 After creating the alert controller, add actions to the controller by calling -addAction.

 @param title The title of the alert.
 @param message Descriptive text that summarizes a decision in a sentence of two.
 @return An initialized MDCAlertController object.
 */
+ (nonnull instancetype)alertControllerWithTitle:(nullable NSString *)title
                                         message:(nullable NSString *)message;

/**
 Convenience constructor to create and return a view controller for displaying an alert to the user.

 After creating the alert controller, add actions to the controller by calling -addAction.

 @note Set `attributedMessageAction` to respond to link-tap events, if needed.

 @note This method receives an @c NSAttributedString for the display message. Use
       @c alertControllerWithTitle:message: for regular @c NSString support.

 @param alertTitle The title of the alert.
 @param attributedMessage Descriptive text that summarizes a decision in a sentence of two.
 @return An initialized MDCAlertController object.
 */
+ (nonnull instancetype)alertControllerWithTitle:(nullable NSString *)alertTitle
                               attributedMessage:(nullable NSAttributedString *)attributedMessage;

/** Alert controllers must be created with alertControllerWithTitle:message: */
- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                                 bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/** Alert controllers must be created with alertControllerWithTitle:message: */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 A block that is invoked when a link (a URL) in the attributed message text is
 tapped.

 @param URL The URL of the link that was tapped. May include external or internal URLs.
 @param range The range of characters (in the attributed text) of the link that was tapped.
 @param interaction The UITextItemInteraction type of interaction performed by the user.

 @return true if UIKit's default implementation of the interaction should proceed after this block
         is invoked.
*/
API_AVAILABLE(ios(10.0))
typedef BOOL (^MDCAttributedMessageActionHandler)(NSURL *_Nonnull URL, NSRange range,
                                                  UITextItemInteraction interaction);

/**
 Sets the flag to use `M3CButton` instead of `MDCButton`, this flag would be
 eventually removed when `MDCButton` is deleted.

 Defaults to NO.

 This function should be called right after creation of the
 MDCAlertController.
 */
@property(nonatomic, assign, getter=isM3CButtonEnabled) BOOL M3CButtonEnabled;

/**
 An action that is invoked when a link (URL) in the attributed message is interacted with. Applies
 only when `attributedMessage` is set.
*/

@property(nonatomic, copy, nullable)
    MDCAttributedMessageActionHandler attributedMessageAction API_AVAILABLE(ios(10.0));

/**
 An object conforming to @c MDCAlertControllerDelegate. When non-nil, the @c MDCAlertController will
 call the appropriate @c MDCAlertControllerDelegate methods on this object.
 */
@property(nonatomic, weak, nullable) id<MDCAlertControllerDelegate> delegate;

/** The font applied to the alert's title.*/
@property(nonatomic, strong, nullable) UIFont *titleFont;

/** The color applied to the alert's title.*/
@property(nonatomic, strong, nullable) UIColor *titleColor;

/** The alignment applied to the title of the Alert. Defaults to @c NSTextAlignmentNatural. */
@property(nonatomic, assign) NSTextAlignment titleAlignment;

/**
 An (optional) icon or image that appears above the title of the Alert Controller.

 @note: To proportionally scale large images to fit the available space, set
        `titleIconAlignment` to `MDCContentHorizontalAlignmentJustified`.
 */
@property(nonatomic, strong, nullable) UIImage *titleIcon;

/** The tint color applied to the titleIcon. Leave empty to preserve original image color(s).*/
@property(nonatomic, strong, nullable) UIColor *titleIconTintColor;

/**
 The alignment applied to the title icon.

 To preserve backward compatibility, the default alignment of the title icon matches the alignment
 of the title, set by @c titleAlignment. The @c titleIconAlignment value will automatically match
 @c titleAlignment until the value of @c titleIconAlignment is first set.

 @note: Large `titleIcon` images will be proportionally scaled to fit the available space when
        `titleIconAlignment` is set to `MDCContentHorizontalAlignmentJustified`.
 */
@property(nonatomic, assign) NSTextAlignment titleIconAlignment;

/** The font applied to the alert's message.*/
@property(nonatomic, strong, nullable) UIFont *messageFont;

/**
 The color applied to the alert's message.

 @note: If `messageColor` is set (including if set to nil), it will override foregroundColor
        attributes that were set by the attributed message text.
 */
@property(nonatomic, strong, nullable) UIColor *messageColor;

/**
 The alignment applied to the alert's message. Defaults to @c NSTextAlignmentNatural.
 */
@property(nonatomic, assign) NSTextAlignment messageAlignment;

// b/117717380: Will be deprecated
/** The color applied to the alert's buttons title text.*/
@property(nonatomic, strong, nullable) UIColor *buttonTitleColor;

// b/117717380: Will be deprecated
/** The color applied to the alert's buttons ink effect.*/
@property(nonatomic, strong, nullable) UIColor *buttonInkColor;

/**
 The semi-transparent color which is applied to the overlay covering the content
 behind the Alert (the scrim) when presented by
 @c MDCDialogPresentationController.
 */
@property(nonatomic, strong, nullable) UIColor *scrimColor;

/** The Alert background color.*/
@property(nonatomic, strong, nullable) UIColor *backgroundColor;

/**
 The corner radius applied to the Alert Controller view. Defaults to 0
 (no round corners)
 */
@property(nonatomic, assign) CGFloat cornerRadius;

/** The elevation that will be applied to the Alert Controller view. Defaults to 24. */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 The color of the shadow that will be applied to the @c MDCAlertController view.
 Defaults to black.
 */
@property(nonatomic, copy, nonnull) UIColor *shadowColor;

// TODO(iangordon): Add support for preferredAction to match UIAlertController.
// TODO(iangordon): Consider adding support for UITextFields to match UIAlertController.

/**
 High level description of the alert or decision being made.

 Use title only for high-risk situations, such as the potential loss of connectivity. If used,
 users should be able to understand the choices based on the title and button text alone.
 */
@property(nonatomic, nullable, copy) NSString *title;

/**
 A custom accessibility label for the title.

 When @c nil the title accessibilityLabel will be set to the value of the @c title.
 */
@property(nonatomic, nullable, copy) NSString *titleAccessibilityLabel;

/** Descriptive text that summarizes a decision in a sentence or two. */
@property(nonatomic, nullable, copy) NSString *message;

/**
 Descriptive text that summarizes a decision in a sentence or two, in an attributed string format.

 If provided and non-empty, will be used instead of @c message property.

 @note Set `attributedMessageAction` to respond to link-tap events, if needed.
 */
@property(nonatomic, nullable, copy) NSAttributedString *attributedMessage;

/**
 The color applied to links in the attributed message. When nil, UIKit's default tint color is used.
 */
@property(nonatomic, strong, nullable) UIColor *attributedLinkColor;

/**
 A custom accessibility label for the message.

 When @c nil the message accessibilityLabel will be set to the value of the @c message.
 */
@property(nonatomic, nullable, copy) NSString *messageAccessibilityLabel;

/** A custom accessibility label for the title icon view. */
@property(nonatomic, nullable, copy) NSString *imageAccessibilityLabel;

/**
 Accessory view that contains custom UI.

 The size of the accessory view is determined through Auto Layout. If your view uses manual layout,
 you can either add a height constraint (e.g. `[view.heightAnchor constraintEqualToConstant:100]`),
 or you can override
 `-systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:`.

 If the content of the view changes and the height needs to be recalculated, call
 `[alert setAccessoryViewNeedsLayout]`. Note that MDCAccessorizedAlertController will automatically
 recalculate the accessory view's size if the alert's width changes.
 */
@property(nonatomic, strong, nullable) UIView *accessoryView;

/**
 By setting this property to @c YES, the accessoryView will be placed on top of the message.

 Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL shouldPlaceAccessoryViewAboveMessage;

/**
 Notifies the alert controller that the size of the accessory view needs to be recalculated due to
 content changes. Note that MDCAccessorizedAlertController will automatically recalculate the
 accessory view's size if the alert's width changes.
 */
- (void)setAccessoryViewNeedsLayout;

/**
 Duration of the dialog fade-in or fade-out presentation animation.

 Defaults to 0.27 seconds.
 */
@property(nonatomic, assign) NSTimeInterval presentationOpacityAnimationDuration;

/**
 Duration of dialog scale-up or scale-down presentation animation.

 Defaults to 0 seconds (no animation is performed).
 */
@property(nonatomic, assign) NSTimeInterval presentationScaleAnimationDuration;

/**
 The starting scale factor of the dialog during the presentation animation, between 0 and 1. The
 "animate in" transition scales the dialog from this value to 1.0.

 Defaults to 1.0 (no scaling is performed).
 */
@property(nonatomic, assign) CGFloat presentationInitialScaleFactor;

/**
 The spacing between the dialog and the @c safeArea of the presenting view controller.

 @note Dialogs have a minimum width of 280pt. If the horizonal insets force the dialog to be less
 than the 280pt required the dialog will apply equal insets to both sides to allow the 280pt.

 Defaults to {24, 20, 24, 20}.
 */
@property(nonatomic, assign) UIEdgeInsets dialogEdgeInsets;

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink
 to display visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part
 of our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 A block that is invoked when the @c MDCAlertController receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCAlertController *_Nullable alertController,
     UITraitCollection *_Nullable previousTraitCollection);

/** @c MDCAlertController handles its own transitioning delegate. */
- (void)setTransitioningDelegate:
    (nullable id<UIViewControllerTransitioningDelegate>)transitioningDelegate NS_UNAVAILABLE;

/** @c MDCAlertController.modalPresentationStyle is always @c UIModalPresentationCustom. */
- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle NS_UNAVAILABLE;

/**
 Whether or not title should scroll with the content.

 If the title does not pin to the top of the content, it will scroll with the message when the
 message scrolls.

 Defaults to @c YES.
 */
@property(nonatomic, assign) BOOL titlePinsToTop;

#pragma mark - Alert Actions

/**
 The actions that the user can take in response to the alert.

 The order of the actions in the array matches the order in which they were added to the alert.
 */
@property(nonatomic, nonnull, readonly) NSArray<MDCAlertAction *> *actions;

/**
 Adds an action to the alert dialog.

 Actions are the possible reactions of the user to the presented alert. Actions are added as a
 button at the bottom of the alert. Affirmative actions should be added before dismissive actions.
 Action buttons will be laid out from right to left if possible or top to bottom depending on space.

 Material spec recommends alerts should not have more than two actions.

 @param action Will be added to the end of @c MDCAlertController actions.
 */
- (void)addAction:(nonnull MDCAlertAction *)action;

/**
 Adds an array of actions to the alert dialog.

 @param actions Will be added to the end of @c MDCAlertController actions.
 @seealso This is a _convenience_ API for @c addAction:.
 */
- (void)addActions:(nonnull NSArray<MDCAlertAction *> *)actions;

// TODO(https://github.com/material-components/material-components-ios/issues/9891): Replace
// MDCActionEmphasis with UIControlContentHorizontalAlignment after dropping support for iOS 10.
/** Content alignment for Alert actions. */
typedef NS_ENUM(NSInteger, MDCContentHorizontalAlignment) {
  /** Actions are centered. */
  MDCContentHorizontalAlignmentCenter = 0,
  /** Actions are left aligned in LTR and right aligned in RTL.  */
  MDCContentHorizontalAlignmentLeading = 1,
  /** Actions are right aligned in LTR and left aligned in RTL.  */
  MDCContentHorizontalAlignmentTrailing = 2,
  /**
   Actions fill the entire width of the alert (minus the insets). If more than one action is
   presented, equal width is applied to all actions so they fill the space evenly.
   */
  MDCContentHorizontalAlignmentJustified = 3
};

/**
 The alert actions alignment in horizontal layout.  This property controls both alignment and order
 of the actions in the horizontal layout.  Actions that are added first, are presented first based
 on the alignment: when alignment is trailing, the first action is presented on the trailing side
 (right in LTR). For all other alignments, the action added first is presented on the leading side
 (left in LTR).

 Default value is @c MDCContentHorizontalAlignmentTrailing.
 */
@property(nonatomic, assign) MDCContentHorizontalAlignment actionsHorizontalAlignment;

/**
 The horizontal alignment of the alert's actions when in vertical layout. When not enough horizontal
 space is available to present all actions, actions will layout vertically. That may happen in the
 portrait orientation on smaller devices. Actions may have centered, leading, trailing or filled
 alignment. In filled alignment, all actions will be as wide as the alert (minus insets).

 @note: Actions that are added first will be displayed on the bottom, unless overriden by
        orderVerticalActionsByEmphasis.

 Default value is @c MDCContentHorizontalAlignmentCenter.
 */
@property(nonatomic, assign)
    MDCContentHorizontalAlignment actionsHorizontalAlignmentInVerticalLayout;

/**
 Enables ordering actions by emphasis when they are vertically aligned. When set to @c YES,
 horizontally trailing actions, which typically have higher emphasis, will be displayed on top when
 presented vertically (for instance, in the portrait orientation on smaller devices). When set to @c
 NO, the higher emphasis actions will be displayed on the bottom.

 Defaults to @c NO.
*/
@property(nonatomic, assign) BOOL orderVerticalActionsByEmphasis;

/**
 A Boolean value that indicates whether the alert's contents autorotates.

 Defaults to UIKit's shouldAutorotate.
*/
@property(nonatomic) BOOL shouldAutorotateOverride;

/**
 A bit mask that specifies which orientations the view controller supports.

 Defaults to UIKit's supportedInterfaceOrientations.
*/
@property(nonatomic)
    UIInterfaceOrientationMask supportedInterfaceOrientationsOverride API_UNAVAILABLE(tvos, watchos)
        ;

/**
 The interface orientation to use when presenting the alert.

 Defaults to UIKit's preferredInterfaceOrientationForPresentation.
*/
@property(nonatomic)
    UIInterfaceOrientation preferredInterfaceOrientationForPresentationOverride API_UNAVAILABLE(
        tvos, watchos);

/**
 The transition style to use when presenting the view controller override.

 Defaults to UIKit's modalTransitionStyle.
*/
@property(nonatomic) UIModalTransitionStyle modalTransitionStyleOverride;

@end

#pragma mark - MDCAlertAction

typedef NS_ENUM(NSInteger, MDCActionEmphasis) {
  /* Low emphasis attribute produces low emphasis appearance when attached to actions or buttons */
  MDCActionEmphasisLow = 0,
  /* a Medium emphasis attribute produces a medium emphasis appearance */
  MDCActionEmphasisMedium = 1,
  /* a High emphasis attribute produces a high emphasis appearance */
  MDCActionEmphasisHigh = 2,
};

/**
 MDCActionHandler is a block that will be invoked when the action is selected.
 */
typedef void (^MDCActionHandler)(MDCAlertAction *_Nonnull action);

/**
 @c MDCAlertAction is passed to an @c MDCAlertController to add a button to the alert dialog.
 */
@interface MDCAlertAction : NSObject <NSCopying, UIAccessibilityIdentification>

/**
 A convenience method for adding actions that will be rendered as low emphasis buttons at the
 bottom of an alert controller.

 @param title The title of the button shown on the alert dialog.
 @param handler A block to execute when the user selects the action. This is called any
        time the action is selected, even if @c dismissOnAction is @c NO.
 @return An initialized @c MDCActionAlert object.
 */
+ (nonnull instancetype)actionWithTitle:(nonnull NSString *)title
                                handler:(nullable MDCActionHandler)handler;

/**
 An action that renders at the bottom of an alert controller as a button of the given emphasis.

 @param title The title of the button shown on the alert dialog.
 @param emphasis The emphasis of the button that will be rendered in the alert dialog.
        Unthemed actions will render all emphases as text. Apply themers to the alert
        to achieve different appearance for different emphases.
 @param handler A block to execute when the user selects the action. This is called any
        time the action is selected, even if @c dismissOnAction is @c NO.
 @return An initialized @c MDCActionAlert object.
 */
+ (nonnull instancetype)actionWithTitle:(nonnull NSString *)title
                               emphasis:(MDCActionEmphasis)emphasis
                                handler:(nullable MDCActionHandler)handler;

/** Alert actions must be created with actionWithTitle:handler: */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Title of the button shown on the alert dialog.
 */
@property(nonatomic, nullable, readonly) NSString *title;

/**
 The action to execute when the button is pressed.
 */
@property(nonatomic, nullable, readonly) MDCActionHandler tapHandler;

/**
 The @c MDCActionEmphasis emphasis of the button that will be rendered for the action.
 */
@property(nonatomic, readonly) MDCActionEmphasis emphasis;

// TODO(iangordon): Add support for enabled property to match UIAlertAction

/**
 The @c accessibilityIdentifier for the view associated with this action.
 */
@property(nonatomic, nullable, copy) NSString *accessibilityIdentifier;

/**
 Whether actions dismiss the dialog on action selection or persist the dialog after a selection has
 been made. If this is set to @c NO, then it is up to the presenting class to dismiss the
 controller. Callers may dismiss the controller by calling dismissViewControllerAnimated:completion:
 on the presenting view controller. Ex:

 __weak MDCAlertController *weakAlertController = alertController;
 MDCAlertAction *action = [MDCAlertAction actionWithTitle:@"Title" handler:^{
   MDCAlertController *strongAlertController = weakAlertController;
   if (strongAlertController) {
     [strongAlertController.presentingViewController dismissViewControllerAnimated:YES
 completion:nil];
   }
 }];
 action.dismissOnAction = NO;
 [alertController addAction:action];

 Defaults to @c YES meaning that when an action is performed, it also dismisses the dialog.
 */
@property(nonatomic, assign) BOOL dismissOnAction;

@end

NS_ASSUME_NONNULL_END
