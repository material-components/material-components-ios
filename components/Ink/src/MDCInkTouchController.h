// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCInkGestureRecognizer;
@class MDCInkTouchController;
@class MDCInkView;
@protocol MDCInkTouchControllerDelegate;

/**
 MDCInkTouchController associates a MDCInkView with a UIGestureRecognizer to control the spread of
 the ink.

 Subclasses should avoid overriding the UIGestureRecognizerDelegate gestureRecognizerShouldBegin:
 and gestureRecognizer:shouldReceiveTouch: methods to avoid breaking
 MDCInkTouchControllerDelegate.

 **NOTE:** The controller does not keep a strong reference to the view to which it is attaching an
 ink view.
 It is expected that the view will keep a strong reference to its own ink controller, or that the
 view controller controlling the view will keep a strong reference to that view's ink controller.
 */
@interface MDCInkTouchController : NSObject <UIGestureRecognizerDelegate>

/** Weak reference to the view that responds to touch events. */
@property(nonatomic, weak, readonly, nullable) UIView *view;

/**
 The ink view for clients who do not create their own ink views via the delegate.
 */
@property(nonatomic, strong, readonly, nonnull) MDCInkView *defaultInkView;

/** Delegate to extend the behavior of the touch control. */
@property(nonatomic, weak, nullable) id<MDCInkTouchControllerDelegate> delegate;

/** If YES, the gesture recognizer should delay the start of ink spread. Default is NO. */
@property(nonatomic, assign) BOOL delaysInkSpread;

/** The distance that causes the recognizer to cancel. Defaults to 20pt. */
@property(nonatomic, assign) CGFloat dragCancelDistance;

/**
 Whether dragging outside of the view causes the gesture recognizer to cancel.
 Defaults to YES.
 */
@property(nonatomic, assign) BOOL cancelsOnDragOut;

/**
 If enabled, the ink gesture will require failure of UIScrollView gesture recognizers in order to
 activate.

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL requiresFailureOfScrollViewGestures;

/**
 Bounds inside of which the recognizer will recognize ink gestures, relative to self.view.frame.

 If set to CGRectNull (the default), then the recognizer will use self.view.bounds as the target
 bounds.

 If cancelsOnDragOut is YES and the user's touch moves beyond the target bounds inflated by
 dragCancelDistance then the gesture is cancelled.
 */
@property(nonatomic) CGRect targetBounds;

/** Gesture recognizer used to bind touch events to ink. */
@property(nonatomic, strong, readonly, nonnull) MDCInkGestureRecognizer *gestureRecognizer;

/** Unavailable, please use initWithView: instead. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes the controller.

 @param view View that responds to touch events for ink.
 */
- (nonnull instancetype)initWithView:(nonnull UIView *)view NS_DESIGNATED_INITIALIZER;

/**
 When called the @c defaultInkView is added to the @c view.

 This method is a no-op when the delegate conforms to @c inkTouchController:inkViewAtTouchLocation:
 because this is how a client specifies a custom ink view.

 If you want to specify a specific z-index order for your inkView please conform to
 @c inkTouchController:insertInkView:intoView: and do so there.
 */
- (void)addInkView;

/**
 Cancels all touch processing and dissipates the ink.

 This is useful if your application needs to remove the ink on scrolling, when preparing a view
 for reuse, etc.
 */
- (void)cancelInkTouchProcessing;

/**
 Returns the ink view at a particular touch location.

 If the delegate responds to @c inkTouchController:inkViewAtLocation: then this method queries it.
 Otherwise, if @c addInkView has been called and @c location is in the bounds of
 @c self.defaultView, then that view is returned. If none of these conditions are met, @c nil is
 returned.

 @param location The query location in the coordinates of @c self.view.
 @return The ink view at the touch location, or nil.
*/
- (MDCInkView *_Nullable)inkViewAtTouchLocation:(CGPoint)location;

@end

/** Delegate methods for MDCInkTouchController. */
@protocol MDCInkTouchControllerDelegate <NSObject>
@optional

/**
 Inserts the ink view into the given view.

 If this method is not implemented, the ink view is added as a subview of the view when the
 controller's addInkView method is called. Delegates can choose to insert the ink view below the
 contents as a background view. When inkTouchController:inkViewAtTouchLocation is implemented
 this method will not be invoked.

 @param inkTouchController The ink touch controller.
 @param inkView The ink view.
 @param view The view to add the ink view to.
 */
- (void)inkTouchController:(nonnull MDCInkTouchController *)inkTouchController
             insertInkView:(nonnull UIView *)inkView
                  intoView:(nonnull UIView *)view;

/**
 Returns the ink view to use for a touch located at location in inkTouchController.view.

 If the delegate implements this method, the controller will not create an ink view of its own and
 inkTouchController:insertInkView:intoView: will not be called. This method allows the delegate
 to control the creation and reuse of ink views.

 @param inkTouchController The ink touch controller.
 @param location The touch location in the coords of @c inkTouchController.view.
 @return An ink view to use at the touch location.
 */
- (nullable MDCInkView *)inkTouchController:(nonnull MDCInkTouchController *)inkTouchController
                     inkViewAtTouchLocation:(CGPoint)location;

/**
 Controls whether the ink touch controller should be processing touches.

 The touch controller will query this method to determine if it should start or continue to
 process touches controlling the ink. Returning NO at the start of a gesture will prevent any ink
 from being displayed, and returning NO in the middle of a gesture will cancel that gesture and
 evaporate the ink.

 If not implemented then YES is assumed.

 @param inkTouchController The ink touch controller.
 @param location The touch location relative to the inkTouchController view.
 @return YES if the controller should process touches at @c location.

 @see cancelInkTouchProcessing
 */
- (BOOL)inkTouchController:(nonnull MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location;

/**
 Notifies the receiver that the ink touch controller did process an ink view at the
 touch location.

 @param inkTouchController The ink touch controller.
 @param inkView The ink view.
 @param location The touch location relative to the inkTouchController superView.
 */
- (void)inkTouchController:(nonnull MDCInkTouchController *)inkTouchController
         didProcessInkView:(nonnull MDCInkView *)inkView
           atTouchLocation:(CGPoint)location;

@end
