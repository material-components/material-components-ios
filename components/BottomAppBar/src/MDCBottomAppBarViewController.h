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

#import "MaterialButtons.h"

/** The position of the floating action button. */
typedef NS_ENUM(NSInteger, MDCBottomAppBarFloatingButtonPosition) {
  MDCBottomAppBarFloatingButtonPositionCenter = 0,
  MDCBottomAppBarFloatingButtonPositionLeading = 1,
  MDCBottomAppBarFloatingButtonPositionTrailing = 2
};

/**
 A bottom app bar with an embedded floating button.

 The bottom app bar is a bar docked at the bottom of the screen. A floating action button is
 provided for a primary action.
 */
@interface MDCBottomAppBarViewController : UIViewController

/**
 Is the floating button on the bottom bar visible.
 Default is YES.
 */
@property(nonatomic, assign, getter=isFloatingButtonHidden) BOOL floatingButtonHidden;

/**
 The floating button on the bottom bar. This button is exposed for customizability.
 */
@property(nonatomic, strong, readonly, nonnull) MDCFloatingButton *floatingButton;

/**
 The position of the floating action button.
 Default is MDCBottomAppBarFloatingButtonPositionCenter.
 */
@property(nonatomic, assign) MDCBottomAppBarFloatingButtonPosition floatingButtonPosition;

/**
 The embedded view controller that appears behind the bottom app bar. This content is part of the
 application and not visually connected to the bottom app bar.
 */
@property(nonatomic, strong, nonnull) UIViewController *viewController;

/**
 A content view controller that will be embedded in the bottom app bar in the area that contains the
 floating action button.
 */
@property(nonatomic, strong, nullable) UIViewController *contentViewController;

/**
 Creates an instance of the bottom app bar view controller.

 @param viewController The embedded view controller to appear behind the bottom app bar.
 */
- (nonnull instancetype)initWithViewController:(nonnull UIViewController *)viewController;

/**
 Sets the position of the floating action button. Note, if the set position is the same as the
 current position there is no change in the position nor animation.

 @param animated Enable or disable animation.
 */
- (void)setFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition
                         animated:(BOOL)animated;

/**
 Sets the visibility of the floating action button.

 @param animated Enable or disable animation.
 */
- (void)setFloatingButtonHidden:(BOOL)floatingButtonHidden animated:(BOOL)animated;

@end
