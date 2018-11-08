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
#import "MDCBottomDrawerPresentationController.h"
#import "MDCBottomDrawerState.h"

@protocol MDCBottomDrawerHeader;
@protocol MDCBottomDrawerViewControllerDelegate;

/**
 View controller for containing a Google Material bottom drawer.
 */
@interface MDCBottomDrawerViewController
    : UIViewController <MDCBottomDrawerPresentationControllerDelegate>

/**
 The main content displayed by the drawer.
 Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController *contentViewController;

/**
 A header to display above the drawer's main content.
 Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController<MDCBottomDrawerHeader> *headerViewController;

/**
 Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 the drawer movement. This allows the provided scroll view to load the visible
 content as the drawer moves, and therefore not load all the content at once
 and allow to reuse the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 The current state of the bottom drawer.
 */
@property(nonatomic, readonly) MDCBottomDrawerState drawerState;

/**
 The color applied to the background scrim.
 */
@property(nonatomic, strong, nullable) UIColor *scrimColor;

/**
 A Boolean value that determines whether the top handle of the drawer is hidden.
 Default is YES.
 */
@property(nonatomic, assign, getter=isTopHandleHidden) BOOL topHandleHidden;

/**
 The color applied to the top handle.
 Note: Make sure that topHandleHidden is set to NO to have the top handle be visible.
 Default is set to 0xE0E0E0.
 */
@property(nonatomic, strong, nullable) UIColor *topHandleColor;

/**
 The bottom drawer delegate.
 */
@property(nonatomic, weak, nullable) id<MDCBottomDrawerViewControllerDelegate> delegate;

/**
 Sets the top corners radius for an MDCBottomDrawerState drawerState

 @param radius The corner radius to set the top corners.
 @param drawerState MDCBottomDrawerState the drawer state.
 */
- (void)setTopCornersRadius:(CGFloat)radius forDrawerState:(MDCBottomDrawerState)drawerState;

/**
 Returns the top corners radius for an MDCBottomDrawerState drawerState.

 If no radius has been set for a state, the value 0 is returned.

 @param drawerState MDCBottomDrawerState the drawer state.
 @return The corner radius to set the top corners.
 */
- (CGFloat)topCornersRadiusForDrawerState:(MDCBottomDrawerState)drawerState;

@end

/**
 Delegate for MDCBottomDrawerViewController.
 */
@protocol MDCBottomDrawerViewControllerDelegate <NSObject>

/**
 Called when the top inset of the drawer changes due to size changes when moving into full screen
 to cover the status bar and safe area inset. Also if there is a top handle, the top inset will
 take into regards the handle height. The top inset indicates where the content can be safely
 laid out without it being clipped.

 @param controller The MDCBottomDrawerViewController.
 @param topInset The top inset in which the content should take into regards when being laid out.
 */
- (void)bottomDrawerControllerDidChangeTopInset:(nonnull MDCBottomDrawerViewController *)controller
                                       topInset:(CGFloat)topInset;

@end
