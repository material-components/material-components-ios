// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <MaterialComponents/MaterialDialogs.h>
#import "MaterialContainerScheme.h"

/**
 An MDCDialogPresentationController theming extension used in theming
 presentation attributes of custom UIViewControllers according to the
 [Material Guidelines](https://material.io/design/components/dialogs.html).
 */
@interface MDCDialogPresentationController (MaterialTheming)

/**
 Applying material theming to the presentation attributes of a MDCDialogPresentationController,
 when it is used in a custom UIViewController presentation. Themeable presentation attributes
 may inclue scrim color corner raidus or shadow elevation.

 @note Make sure to call this method *after* a transition delegate has been
       assigned to a Material transition controller instance (MDCDialogTransitionController).
       Calling this method before the transition delegate is assigned may
       lead to undesired effects and is not supported.

 @example:

 myViewController.modalPresentationStyle = UIModalPresentationCustom;
 // Note: make sure to store a strong reference to the transitionController instance
 myViewController.transitioningDelegate = self.transitionController;
 [myViewController.mdc_dialogPresentationController applyThemeWithScheme:self.containerScheme];
 [self presentViewController:myViewController animated:YES completion:nil];

 @param scheme The container scheme whose values are used in theming the presentation attributes
 */
- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme;

@end
