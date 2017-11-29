/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
__deprecated_msg("Assign an instance of MDCBottomSheetTransition to your view controller's "
                 "mdm_transitionController.transition instead.")
@interface MDCBottomSheetTransitionController
    : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

/**
 Interactions with the tracking scroll view will affect the bottom sheet's drag behavior.

 If no trackingScrollView is provided, then one will be inferred from the associated view
 controller.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

@end
