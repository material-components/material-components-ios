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

@class MDCInkTouchController;
@class MDCInkView;

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
