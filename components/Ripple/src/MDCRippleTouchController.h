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

/**
 If set to NO, the ripple gesture will fail and not be initiated if there are other competing
 gestures that belong to a UIScrollView. This helps the ripple not be invoked if a user wants
 to scroll but does so while tapping on a view that incorporates a ripple.

 Defaults to YES.
 */
@property(nonatomic, assign) BOOL shouldProcessRippleWithScrollViewGestures;

/**
 Initializes the controller and adds the initialized ripple view as a subview of the provided view.

 Note: When using this initializer, calling `addRippleToView:` isn't needed.

 @param view The view that responds to the touch events for the ripple. The ripple
 is added to it as a subview.
 @return an MDCRippleTouchController instance.
 */
- (nonnull instancetype)initWithView:(nonnull UIView *)view;

/**
 Initializes the controller.

 Note: To effectively use the controller a call to `addRippleToView:` is needed to provide a view
 that responds to the touch events for the ripple. The ripple is added to the view as a subview.

 @return an MDCRippleTouchController instance.
 */
- (nonnull instancetype)init;

/**
 Initializes the controller and based on the deferred parameter is adding the ripple view
 immediately as subview of the priovided view.

 @Note If YES is passed for the deferred parameter and
 @c rippleTouchController:insertRippleView:intoView: is not implemented, the rippleview will be
 automatically added as the top subview to the given view when the first tap event is happening.
 When @c rippleTouchController:insertRippleView:intoView: is implemented, it's the responsibility of
 the delegate to add the ripple view in the proper position within view's hierarchy if the delegate
 method is called.

 @param view The view that responds to the touch events for the ripple. The ripple
 is added to it as a subview.
 @param deferred Wheter the insertion of the rippleView to the provided view should be
 happened deferred
 @return an MDCRippleTouchController instance.
*/
- (nonnull instancetype)initWithView:(nonnull UIView *)view deferred:(BOOL)deferred;

/**
 Adds the ripple view as a subview to the provided view, and adds the ripple's gesture recognizer
 to it.

 Note: This needs to be called if using the `init` initialized rather than the `initWithView:`
 initializer.

 @param view The view that responds to the touch events for the ripple. The ripple
 is added to it as a subview.
 */
- (void)addRippleToView:(nonnull UIView *)view;

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

/**
 Provides an opportunity to add the rippleView anywhere in the given view's hierarchy.

 If this method is not implemented, the ripple view is added as a subview of the given view provided
 in the controller's `addRippleToView:` method or convenience initializer `initWithView:`.
 Delegates can choose to insert the ripple view anywhere in the view hierarchy.

 @param rippleTouchController The ripple touch controller.
 @param rippleView The ripple view.
 @param view The requested superview of the ripple view.
 */
- (void)rippleTouchController:(nonnull MDCRippleTouchController *)rippleTouchController
             insertRippleView:(nonnull MDCRippleView *)rippleView
                     intoView:(nonnull UIView *)view;

@end
