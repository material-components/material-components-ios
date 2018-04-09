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

@class MDCBottomSheetPresentationController;

/**
 Delegate for MDCBottomSheetPresentationController.
 */
@protocol MDCBottomSheetPresentationControllerDelegate <UIAdaptivePresentationControllerDelegate>
@optional

/**
 Called before the bottom sheet is presented.

 @param bottomSheet The MDCBottomSheetPresentationController being presented.
 */
- (void)prepareForBottomSheetPresentation:
    (nonnull MDCBottomSheetPresentationController *)bottomSheet;

/**
 Called after dimissing the bottom sheet to let clients know it is no longer onscreen. The bottom
 sheet controller calls this method only in response to user actions such as tapping the background
 or dragging the sheet offscreen. This method is not called if the bottom sheet is dismissed
 programmatically.

 @param bottomSheet The MDCBottomSheetPresentationController that was dismissed.
 */
- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (nonnull MDCBottomSheetPresentationController *)bottomSheet;

@end

/**
 A UIPresentationController for presenting a modal view controller as a bottom sheet.
 */
@interface MDCBottomSheetPresentationController : UIPresentationController

/**
 Interactions with the tracking scroll view will affect the bottom sheet's drag behavior.

 If no trackingScrollView is provided, then one will be inferred from the associated view
 controller.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 When set to false, the bottom sheet controller can't be dismissed by tapping outside of sheet area.
 */
@property(nonatomic, assign) BOOL dismissOnBackgroundTap;

/**
 Delegate to tell the presenter when to dismiss.
 */
@property(nonatomic, weak, nullable) id<MDCBottomSheetPresentationControllerDelegate> delegate;

@end
