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

@class MDCRippleGestureRecognizer;
@class MDCRippleTouchController;
@class MDCRippleView;
@protocol MDCRippleTouchControllerDelegate;

typedef NS_ENUM(NSInteger, MDCRippleState) {
  MDCRippleStateNormal = 0, // No Ripple
  MDCRippleStateSelected, // Ripple has spread and is staying
};

@interface MDCRippleTouchController : NSObject <UIGestureRecognizerDelegate>

/** Weak reference to the view that responds to touch events. */
@property(nonatomic, weak, readonly, nullable) UIView *view;

/**
 The ripple view for clients who do not create their own ripple views via the delegate.
 */
@property(nonatomic, strong, readonly, nonnull) MDCRippleView *rippleView;

/** Delegate to extend the behavior of the touch control. */
@property(nonatomic, weak, nullable) id<MDCRippleTouchControllerDelegate> delegate;

/** Gesture recognizer used to bind touch events to ripple. */
@property(nonatomic, strong, readonly, nonnull) UILongPressGestureRecognizer *gestureRecognizer;

@property(nonatomic, strong, readonly, nullable)
    UILongPressGestureRecognizer *selectionGestureRecognizer;


@property (nonatomic) BOOL allowsSelection;
@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic) BOOL selectionMode;

- (void)setRippleColor:(nullable UIColor *)rippleColor forState:(MDCRippleState)state;
- (nullable UIColor *)rippleColorForState:(MDCRippleState)state;
- (void)setRippleAlpha:(CGFloat)rippleAlpha forState:(MDCRippleState)state;
- (CGFloat)rippleAlphaForState:(MDCRippleState)state;

@property (nonatomic, readonly) MDCRippleState state;

/** Unavailable, please use initWithView: instead. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes the controller.

 @param view View that responds to touch events for ripple.
 */
- (nonnull instancetype)initWithView:(nonnull UIView *)view NS_DESIGNATED_INITIALIZER;

/**
 Cancels all touch processing and dissipates the ripple.

 This is useful if your application needs to remove the ripple on scrolling, when preparing a view
 for reuse, etc.
 */
- (void)cancelRippleTouchProcessing;

@end

/** Delegate methods for MDCRippleTouchController. */
@protocol MDCRippleTouchControllerDelegate <NSObject>
@optional

/**
 Inserts the ripple view into the given view.

 If this method is not implemented, the ripple view is added as a subview of the view when the
 controller's addRippleView method is called. Delegates can choose to insert the ripple view below the
 contents as a background view. When rippleTouchController:rippleViewAtTouchLocation is implemented
 this method will not be invoked.

 @param rippleTouchController The ripple touch controller.
 @param rippleView The ripple view.
 @param view The view to add the ripple view to.
 */
- (void)rippleTouchController:(nonnull MDCRippleTouchController *)rippleTouchController
             insertRippleView:(nonnull UIView *)rippleView
                  intoView:(nonnull UIView *)view;

/**
 Returns the ripple view to use for a touch located at location in rippleTouchController.view.

 If the delegate implements this method, the controller will not create an ripple view of its own and
 rippleTouchController:insertRippleView:intoView: will not be called. This method allows the delegate
 to control the creation and reuse of ripple views.

 @param rippleTouchController The ripple touch controller.
 @param location The touch location in the coords of @c rippleTouchController.view.
 @return An ripple view to use at the touch location.
 */
- (nullable MDCRippleView *)rippleTouchController:(nonnull MDCRippleTouchController *)rippleTouchController
                     rippleViewAtTouchLocation:(CGPoint)location;

/**
 Controls whether the ripple touch controller should be processing touches.

 The touch controller will query this method to determine if it should start or continue to
 process touches controlling the ripple. Returning NO at the start of a gesture will prevent any ripple
 from being displayed, and returning NO in the middle of a gesture will cancel that gesture and
 evaporate the ripple.

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
