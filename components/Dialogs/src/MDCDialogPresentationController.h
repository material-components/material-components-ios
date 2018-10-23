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
 Should a tap on the dimmed background view dismiss the presented controller.

 Defaults to YES.
 */
@property(nonatomic, assign) BOOL dismissOnBackgroundTap;

/**
 Customize the corner radius of the shadow to match the presented view's corner radius.
 If the presented view corner radius and dialogCornerRadius are different, the rendered shadow will
 not match.
 
 Defaults to 0.0.
 */
@property(nonatomic, assign) CGFloat dialogCornerRadius;

/**
 Customize the elevation of the shadow to match the presented view's shadow.

 Defaults to 24.0.
 */
@property(nonatomic, assign) MDCShadowElevation dialogElevation;

/**
 Customize the color of the background scrim.

 Defaults to a semi-transparent Black.
 */
@property(nonatomic, strong, nullable) UIColor *scrimColor;

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

@end
