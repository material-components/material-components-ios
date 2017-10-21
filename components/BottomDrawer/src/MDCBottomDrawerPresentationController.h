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

// TODO: (larche) Cite spec article.
/**
 A controller for modally presenting view controllers from the bottom of the screen either partial
 or full screen.

 Also provides a dark, translucent scrim for easy dismissal and free rounding of corners on the
 presented view that "heal" if the presented view is full screen.
 */
@interface MDCBottomDrawerPresentationController: NSObject
    <UIAdaptivePresentationControllerDelegate>

/** Is the presented view full screen? */
@property(nonatomic, assign, readonly, getter=isPresentedViewFullScreen) BOOL
    presentedViewFullScreen;

/** Is the presented view's preferredContentSize.height completely visible? */
@property(nonatomic, assign, readonly, getter=isPresentedViewFullyExtended) BOOL
    presentedViewFullyExtended;

@end
