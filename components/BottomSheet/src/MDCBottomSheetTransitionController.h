// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 MDCBottomSheetTransitionController is be used to setup a custom transition and animationed
 presentation and dismissal for material-styled bottom-sheet presentation.

 This class provides a basic implementation of UIViewControllerAnimatedTransitioning and
 UIViewControllerTransitioningDelegate.

 In order to use a custom modal transition, the UIViewController to be presented must set two
 properties. The UIViewControllers transitioningDelegate should be set to an instance of this class.
 myDialogViewController.modalPresentationStyle = UIModalPresentationCustom;
 myDialogViewController.transitioningDelegate = bottomSheetTransitionController;

 The presenting UIViewController then calls presentViewController:animated:completion:
 [rootViewController presentViewController:myDialogViewController animated:YES completion:...];
 */
@interface MDCBottomSheetTransitionController
    : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

/**
 Interactions with the tracking scroll view will affect the bottom sheet's drag behavior.

 If no trackingScrollView is provided, then one will be inferred from the associated view
 controller.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 When set to false, the bottom sheet controller can't be dismissed by tapping outside of sheet area.
 */
@property(nonatomic, assign) BOOL dismissOnBackgroundTap;

/**
 When set to false, the bottom sheet controller can't be dismissed by dragging the sheet down.
 */
@property(nonatomic, assign) BOOL dismissOnDraggingDownSheet;

/**
 This is used to set a custom height on the sheet view. This is can be used to set the initial
 height when the ViewController is presented.

 @note If a positive value is passed then the sheet view will be that height even if
 perferredContentSize has been set. Otherwise the sheet will open up to half the screen height or
 the size of the presentedViewController's preferredContentSize whatever value is smaller.
 @note The preferredSheetHeight can never be taller than the height of the content, if the content
 is smaller than the value passed to preferredSheetHeight then the sheet view will be the size of
 the content height.
 */
@property(nonatomic, assign) CGFloat preferredSheetHeight;

/**
Whether or not the height of the bottom sheet should adjust to include extra height for any bottom
safe area insets. If, for example, this is set to @c YES, and the preferred content size height is
100 and the screen has a bottom safe area inset of 10, the total height of the displayed bottom
sheet height would be 110. If set to @c NO, the height would be 100.

Defaults to @c YES.
*/
@property(nonatomic, assign) BOOL adjustHeightForSafeAreaInsets;

/**
 A Boolean value that controls whether the height of the keyboard should affect
 the bottom sheet's frame when the keyboard shows on the screen.

 The default value is @c NO.
 */
@property(nonatomic) BOOL ignoreKeyboardHeight;

@end

@interface MDCBottomSheetTransitionController (ScrimAccessibility)

/**
 Customize the color of the background scrim.

 Defaults to a semi-transparent Black.
 */
@property(nonatomic, strong, nullable) UIColor *scrimColor;

/**
 If @c YES, then the dimmed scrim view will act as an accessibility element for dismissing the
 bottom sheet.

 Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL isScrimAccessibilityElement;

/**
 The @c accessibilityLabel value of the dimmed scrim view.

 Defaults to @c nil.
 */
@property(nullable, nonatomic, copy) NSString *scrimAccessibilityLabel;

/**
 The @c accessibilityHint value of the dimmed scrim view.

 Defaults to @c nil.
 */
@property(nullable, nonatomic, copy) NSString *scrimAccessibilityHint;

/**
 The @c accessibilityTraits of the dimmed scrim view.

 Defaults to @c UIAccessibilityTraitButton.
 */
@property(nonatomic, assign) UIAccessibilityTraits scrimAccessibilityTraits;

@end
