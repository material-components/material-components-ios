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
#import "MDCSheetState.h"
#import "MaterialShapes.h"

@protocol MDCBottomSheetControllerDelegate;

/**
 A view controller for presenting other view controllers as bottom sheets.

 https://material.io/go/design-sheets-bottom

 Show a bottom sheet by creating an MDCBottomSheetController instance with a contentViewController
 and presenting it with -[UIViewController presentViewController:animated:completion].
 MDCBottomSheetController automatically sets the appropriate presentation style and
 transitioningDelegate for the bottom sheet behavior.
 */
@interface MDCBottomSheetController : UIViewController

/**
 The view controller being presented as a bottom sheet.
 */
@property(nonatomic, strong, nonnull, readonly) UIViewController *contentViewController;

/**
 Interactions with the tracking scroll view will affect the bottom sheet's drag behavior.

 If no trackingScrollView is provided, then one will be inferred from the associated view
 controller.

 Changes to this value will be ignored after the bottom sheet controller has been presented.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 When set to false, the bottom sheet controller can't be dismissed by tapping outside of sheet area.
 */
@property(nonatomic, assign) BOOL dismissOnBackgroundTap;

/**
 The bottom sheet delegate.
 */
@property(nonatomic, weak, nullable) id<MDCBottomSheetControllerDelegate> delegate;

/**
 The shape generator used to define the bottom sheet's shape.

 note: If a layer property is explicitly set after the shapeGenerator has been set,
 it can lead to unexpected behavior.

 When the shapeGenerator is nil, MDCBottomSheetController will use the default underlying layer with
 its default settings.

 Default value for shapeGenerator is nil.
 */
//@property(nullable, nonatomic, strong) id<MDCShapeGenerating> shapeGeneratorCollapsed;
//
//@property(nullable, nonatomic, strong) id<MDCShapeGenerating> shapeGeneratorExpanded;

@property(nonatomic, readonly) MDCSheetState state;

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator
                 forState:(MDCSheetState)state;


- (id<MDCShapeGenerating>)shapeGeneratorForState:(MDCSheetState)state;


/**
 Initializes the controller with a content view controller.

 @param contentViewController The view controller to be presented as a bottom sheet.
 */
- (nonnull instancetype)initWithContentViewController:
    (nonnull UIViewController *)contentViewController;

@end

/**
 Delegate for MDCBottomSheetController.
 */
@protocol MDCBottomSheetControllerDelegate <NSObject>

/**
 Called when the user taps the dimmed background or swipes the bottom sheet off to dismiss the
 bottom sheet. This method is not called if the bottom sheet is dismissed programatically.

 @param controller The MDCBottomSheetController that was dismissed.
 */
- (void)bottomSheetControllerDidDismissBottomSheet:(nonnull MDCBottomSheetController *)controller;

@end
