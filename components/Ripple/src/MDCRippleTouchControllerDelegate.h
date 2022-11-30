// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

API_DEPRECATED_BEGIN(
    "🕘 Schedule time to migrate. "
    "Use default system highlight behavior instead: go/material-ios-touch-response. "
    "This is go/material-ios-migrations#not-scriptable 🕘",
    ios(12, 12))

@class MDCRippleTouchController;
@class MDCRippleView;

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

/**
 Returns the ripple view to use for a touch located at location in rippleTouchController.view.

 If the delegate implements this method, the controller will not create a ripple view of its own and
 rippleTouchController:insertRippleView:intoView: will not be called. This method allows the
 delegate to control the creation and reuse of ripple views.

 @param rippleTouchController The ripple touch controller.
 @param location The touch location in the coordinates of @c rippleTouchController.view.
 @return A ripple view to use at the touch location.
 */
- (nullable MDCRippleView *)rippleTouchController:
                                (nonnull MDCRippleTouchController *)rippleTouchController
                        rippleViewAtTouchLocation:(CGPoint)location;

@end

API_DEPRECATED_END
