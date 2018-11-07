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
 Sets the top corners radius for an MDCBottomDrawerState drawerState

 @param radius The corner radius to set the top corners.
 @param drawerState MDCBottomDrawerState the drawer state.
 */
- (void)setTopCornersRadius:(CGFloat)radius forDrawerState:(MDCBottomDrawerState)drawerState;

/**
 Returns the top corners radius for an MDCBottomDrawerState drawerState.

 If no radius has been set for a state, the value 0.f is returned.

 @param drawerState MDCBottomDrawerState the drawer state.
 @return The corner radius to set the top corners.
 */
- (CGFloat)topCornersRadiusForDrawerState:(MDCBottomDrawerState)drawerState;

@end
