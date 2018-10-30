// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MDCBottomDrawerState.h"

@class MDCBottomDrawerPresentationController;

/**
 Delegate for MDCBottomSheetPresentationController.
 */
@protocol MDCBottomDrawerPresentationControllerDelegate <UIAdaptivePresentationControllerDelegate>
/**
 This method is called when the bottom drawer will change its presented state to one of the
 MDCBottomDrawerState states.

 @param presentationController presentation controller of the bottom drawer
 @param drawerState the drawer's state
 */
- (void)bottomDrawerWillChangeState:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                        drawerState:(MDCBottomDrawerState)drawerState;

/**
 This method is called when the drawer is scrolled/dragged and provides a transition ratio value
 between 0-100% (0-1) that indicates the percentage in which the drawer is close to reaching the end
 of its scrolling. If the drawer is about to reach fullscreen, its percentage moves between 0-100%
 as it starts covering the safe area and status bar. If the drawer doesn't reach full screen, it
 moves between 0-100% as it reaches 20 points away from being fully expanded.

 @param presentationController the bottom drawer presentation controller.
 @param transitionRatio The transition ratio betwen 0-100% (0-1).
 */
- (void)bottomDrawerTopTransitionRatio:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                       transitionRatio:(CGFloat)transitionRatio;
@end

/**
 The presentation controller to use for presenting an MDC bottom drawer.
 */
@interface MDCBottomDrawerPresentationController : UIPresentationController

/**
 Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 the drawer movement. This allows the provided scroll view to load the visible
 content as the drawer moves, and therefore not load all the content at once
 and allow to reuse the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 Delegate to tell the presenter when the drawer will change state.
 */
@property(nonatomic, weak, nullable) id<MDCBottomDrawerPresentationControllerDelegate> delegate;

@end
