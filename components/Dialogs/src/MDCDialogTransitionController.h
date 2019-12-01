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

/**
 MDCDialogTransitionController is used to setup a custom transition and animationed presentation
 and dismissal for material-styled alerts, simple dialogs and confirmation dialogs.

 https://material.io/go/design-dialogs

 This class provides a basic implementation of UIViewControllerAnimatedTransitioning and
 UIViewControllerTransitioningDelegate.

 In order to use a custom modal transition, the UIViewController to be presented must set two
 properties. The UIViewControllers transitioningDelegate should be set to an instance of this class.
 myDialogViewController.modalPresentationStyle = UIModalPresentationCustom;
 myDialogViewController.transitioningDelegate = dialogTransitionController;

 The presenting UIViewController then calls presentViewController:animated:completion:
 [rootViewController presentViewController:myDialogViewController animated:YES completion:...];
 */
@interface MDCDialogTransitionController
    : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

/**
 Duration of the dialog fade-in or fade-out animation.

 Defaults to 0.27 seconds.
 */
@property(nonatomic, assign) NSTimeInterval opacityAnimationDuration;

/**
 Duration of dialog scale-up or scale-down animation.

 Defaults to 0 seconds (no animation is performed).
 */
@property(nonatomic, assign) NSTimeInterval scaleAnimationDuration;

/**
 The starting scale factor of the dialog, between 0 and 1. The "animate in" transition scales the
 dialog from this value to 1.0.

 Defaults to 1.0 (no scaling is performed).
 */
@property(nonatomic, assign) CGFloat dialogInitialScaleFactor;

@end
