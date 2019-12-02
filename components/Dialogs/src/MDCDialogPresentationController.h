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

#import "MaterialShadowElevations.h"

@class MDCDialogPresentationController;

/**
 MDCDialogPresentationControllerDelegate provides a method that allows a delegate of an
 MDCDialogPresentationController to respond to its dismissals.
 */
@protocol MDCDialogPresentationControllerDelegate <NSObject>
@optional
/**
 This method allows a delegate conforming to MDCDialogPresentationControllerDelegate to respond to
 MDCDialogPresentationController dismissals.
 */
- (void)dialogPresentationControllerDidDismiss:
    (nonnull MDCDialogPresentationController *)dialogPresentationController;
@end

/**
 MDCDialogPresentationController will present a modal ViewController as a dialog according to the
 Material spec.

 https://material.io/go/design-dialogs

 MDCDialogPresentationController should not be used to present full-screen dialogs.

 The presented UIViewController will be asked for it's preferredContentSize to help determine
 the best size for the dialog to be displayed.

 This controller will manage the background dimming view and add a material-styled shadow underneath
 the presented view.

 This controller will respond to the display / dismissal of the keyboard and update the
 presentedView's frame.
 */
@interface MDCDialogPresentationController : UIPresentationController

/**
 An object conforming to MDCDialogPresentationControllerDelegate. When non-nil, the
 MDCDialogPresentationController will call the appropriate MDCDialogPresentationControllerDelegate
 methods on this object.
 */
@property(nonatomic, weak, nullable) id<MDCDialogPresentationControllerDelegate>
    dialogPresentationControllerDelegate;

/**
 Should a tap on the dimmed background view dismiss the presented controller.

 Defaults to YES.
 */
@property(nonatomic, assign) BOOL dismissOnBackgroundTap;

/**
 Customize the corner radius of the shadow to match the presented view's corner radius.

 By default, the corner radius of the presented shadow is adjusted to match the corner radius of the
 view being presented.  This behavior is achieved without making any changes to dialogCornerRadius.
 Once a value is set on dialogCornerRadius, that value will be used to determine the radius of both
 the presetned view and the shadow. That means that any further changes to the presented view's
 corner radius (yourViewController.view.layer.cornerRadius) will be ignored once dialogCornerRadius
 is set.

 In either cases, the presentation controller ensures that the shadow layer's corner radius matches
 the presented view's.

 Material themers use dialogCornerRadius for setting the corner radius, therefore, when applying
 a themer to your custom UIViewController, any value you assign to your view's corner radius
 will be ignored. If you wish to override the corner radius after a themer is called, make sure
 to set it to dialogCornerRadius, and not to the presented view's corner radius.

 Defaults to: The presented view's corner radius.
 */
@property(nonatomic, assign) CGFloat dialogCornerRadius;

/**
 Customize the elevation of the shadow to match the presented view's shadow.

 Defaults to 24.0.
 */
@property(nonatomic, assign) MDCShadowElevation dialogElevation;

/**
 The color of the shadow that will be applied to the @c MDCDialogPresentationController.

 Defaults to black.
 */
@property(nonatomic, copy, nonnull) UIColor *dialogShadowColor;

/**
 Customize the color of the background scrim.

 Defaults to a semi-transparent Black.
 */
@property(nonatomic, strong, nullable) UIColor *scrimColor;

/**
 The transform applied to the @c MDCDialogPresentationController. Used to ensure the shadow
 properly tracks the view.

 The default value is @c CGAffineTransformIdentity.
 */
@property(nonatomic, assign) CGAffineTransform dialogTransform;

/**
 Returns the size of the specified child view controller's content.

 The size is initially based on container.preferredSize. Width is will have a minimum of 280 and a
 maximum of the parentSize - 40 for the padding on the left and right size.

 Height has no minimum.  Height has a maximum of the parentSize - height of any displayed
 keyboards - 48 for the padding on the top and bottom.  If preferredSize.height is 0, height will
 be set to the maximum.
 */
- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container
               withParentContainerSize:(CGSize)parentSize;

/**
 Returns the frame rectangle to assign to the presented view at the end of the animations.

 The size of the frame is determined by sizeForChildContentContainer:withParentContainerSize:. The
 presentedView is centered horizontally and verically in the available space.  The available space
 is the size of the containerView subtracting any space taken up by the keyboard.
 */
- (CGRect)frameOfPresentedViewInContainerView;

/**
 A block that is invoked when the MDCDialogPresentationController receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCDialogPresentationController *_Nullable presentationController,
     UITraitCollection *_Nullable previousTraitCollection);

@end
