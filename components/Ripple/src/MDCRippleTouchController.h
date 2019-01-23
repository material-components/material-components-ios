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

#import <UIKit/UIKit.h>

#import "MDCRippleView.h"

@protocol MDCRippleTouchControllerDelegate;

/**
 The MDCRippleTouchController is a convenience controller that adds all the needed touch tracking
 and logic to provide the correct ripple effect based on the user interacting with the view the
 ripple is added to.
 */
@interface MDCRippleTouchController : NSObject <UIGestureRecognizerDelegate>

/**
 A weak reference to the view that the ripple is added to, and that responds to the user
 events.
 */
@property(nonatomic, weak, readonly, nullable) UIView *view;

/**
 The ripple view added to the view.
 */
@property(nonatomic, strong, readonly, nonnull) MDCRippleView *rippleView;

/**
 A delegate to extend the behavior of the touch controller.
 */
@property(nonatomic, weak, nullable) id<MDCRippleTouchControllerDelegate> delegate;

/**
 The gesture recognizer used to bind the touch events to the ripple.
 */
@property(nonatomic, strong, readonly, nonnull) UILongPressGestureRecognizer *gestureRecognizer;

@property(nonatomic, assign) BOOL tapWentOutsideOfBounds;

@property(nonatomic, assign) BOOL processRippleWithScrollViewGestures;

/**
 Unavailable, please use `initWithView` instead.
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes the controller.

 @param view The view that responds to the touch events for the ripple, and the view which the
 ripple is added as a subview to.
 */
- (nonnull instancetype)initWithView:(nonnull UIView *)view NS_DESIGNATED_INITIALIZER;

/**
 Cancels all the existing ripples on the view with animation.
 */
- (void)cancelRippleTouchProcessing;

@end

/**
 Delegate methods for MDCRippleTouchController.
 */
@protocol MDCRippleTouchControllerDelegate <NSObject>
@optional

/**
 Controls whether the ripple touch controller should process touches.

 The touch controller will query this method to determine if it should start or continue to
 process touches controlling the ripple. Returning NO at the start of a gesture will prevent any
 ripple from being displayed, and returning NO in the middle of a gesture will cancel that gesture
 and evaporate the ripple.

 If not implemented then YES is assumed.

 @param rippleTouchController The ripple touch controller.
 @param location The touch location relative to the rippleTouchController view.
 @return YES if the controller should process touches at @c location.

 @see cancelRippleTouchProcessing
 */
- (BOOL)rippleTouchController:(nonnull MDCRippleTouchController *)rippleTouchController
    shouldProcessRippleTouchesAtTouchLocation:(CGPoint)location;

/**
 Notifies the receiver that the ripple touch controller did process an ripple view at the
 touch location.

 @param rippleTouchController The ripple touch controller.
 @param rippleView The ripple view.
 @param location The touch location relative to the rippleTouchController superView.
 */
- (void)rippleTouchController:(nonnull MDCRippleTouchController *)rippleTouchController
         didProcessRippleView:(nonnull MDCRippleView *)rippleView
              atTouchLocation:(CGPoint)location;

- (void)rippleTouchController:(nonnull MDCRippleTouchController *)rippleTouchController
       tapWentOutsideOfBounds:(BOOL)outsideOfBounds;

@end
