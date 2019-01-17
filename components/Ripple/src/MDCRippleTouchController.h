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
 Provides the current state of the ripple. The ripple is either in its normal state, or in the
 selected state where the ripple remains spread on the view.

 - MDCRippleStateNormal: The ripple is in its normal state.
 - MDCRippleStateSelected: The ripple is in the selected state.
 */
typedef NS_ENUM(NSInteger, MDCRippleState) {
  MDCRippleStateNormal = 0,
  MDCRippleStateHighlighted = 1 << 0,
  MDCRippleStateSelected = 1 << 1,
  MDCRippleStateDragged = 1 << 2,
};

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

/** Delegate to extend the behavior of the touch control. */

/**
 A delegate to extend the behavior of the touch controller.
 */
@property(nonatomic, weak, nullable) id<MDCRippleTouchControllerDelegate> delegate;

/** Gesture recognizer used to bind touch events to ripple. */

/**
 The gesture recognizer used to bind the touch events to the ripple.
 */
@property(nonatomic, strong, readonly, nonnull) UILongPressGestureRecognizer *gestureRecognizer;

/**
 The selection gesture recognizer used to bind the touch events related to selection to the ripple.
 */
@property(nonatomic, strong, readonly, nullable)
    UILongPressGestureRecognizer *selectionGestureRecognizer;

/**
 This BOOL tells the touch controller to allow selection and all the logic and visuals
 that come with it, for this ripple.

 Defaults to NO.
 */
@property(nonatomic) BOOL enableLongPressGestureForSelection;

/**
 This BOOL is set to YES if the ripple is currently selected, or NO otherwise.
 It only has significance if selectionMode is activated.

 Defaults to NO.
 */
@property(nonatomic, getter=isSelected) BOOL selected;

@property(nonatomic, getter=isHighlighted) BOOL highlighted;

@property(nonatomic, getter=isDragged) BOOL dragged;


/**
 This BOOL is set to YES if the ripple is currently in the selection mode, or NO otherwise.

 Defaults to NO.
 */
@property(nonatomic) BOOL selectionMode;

/**
 The current state of the ripple.
 */
@property(nonatomic, readonly) MDCRippleState state;

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
 Sets the color of the ripple for state.

 @param rippleColor The ripple color to set the ripple to.
 @param state The state of the ripple in which to set the ripple color.
 */
- (void)setRippleColor:(nullable UIColor *)rippleColor forState:(MDCRippleState)state;

/**
 Gets the ripple color for the given state.

 @param state The ripple's state.
 @return the color of the ripple for state.
 */
- (nullable UIColor *)rippleColorForState:(MDCRippleState)state;

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

@end
