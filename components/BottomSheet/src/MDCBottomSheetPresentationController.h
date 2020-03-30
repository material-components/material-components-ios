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
#import "MDCBottomSheetController.h"
// TODO(b/151929968): Delete import of MDCBottomSheetPresentationControllerDelegate.h when client
// code has been migrated to no longer import MDCBottomSheetPresentationControllerDelegate as a
// transitive dependency.
#import "MDCBottomSheetPresentationControllerDelegate.h"

@class MDCBottomSheetPresentationController;
@protocol MDCBottomSheetPresentationControllerDelegate;

/**
 A UIPresentationController for presenting a modal view controller as a bottom sheet.
 */
@interface MDCBottomSheetPresentationController : UIPresentationController

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

 Defaults to @c YES.
 */
@property(nonatomic, assign) BOOL dismissOnDraggingDownSheet;

/**
 When this property is set to @c YES the MDCBottomSheetController's @c safeAreaInsets are set as @c
 additionalSafeAreaInsets on the presented view controller. This property only works on iOS 11 and
 above.

 @note Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL shouldPropagateSafeAreaInsetsToPresentedViewController;

/**
 This is used to set a custom height on the sheet view.

 @note If a positive value is passed then the sheet view will be that height even if
 perferredContentSize has been set. Otherwise the sheet will open up to half the screen height or
 the size of the presentedViewController's preferredContentSize whatever value is smaller.
 @note The preferredSheetHeight can never be taller than the height of the content, if the content
 is smaller than the value passed to preferredSheetHeight then the sheet view will be the size of
 the content height.
 */
@property(nonatomic, assign) CGFloat preferredSheetHeight;

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

/**
 Delegate to tell the presenter when to dismiss.
 */
@property(nonatomic, weak, nullable) id<MDCBottomSheetPresentationControllerDelegate> delegate;

/**
 A block that is invoked when the @c MDCBottomSheetPresentationController receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCBottomSheetPresentationController *_Nonnull bottomSheetPresentationController,
     UITraitCollection *_Nullable previousTraitCollection);

@end
