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
 Invoked immediately after @c dismissViewControllerAnimated:completed: is passed to the
 presentingController. The bottom sheet controller calls this method only in response to user
 actions such as tapping the background or dragging the sheet offscreen. This method is not called
 if the bottom sheet is dismissed programmatically.

 @param bottomSheet The @c MDCBottomSheetPresentationController that was dismissed.
 */
- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (nonnull MDCBottomSheetPresentationController *)bottomSheet;

/**
 Informs the delegate that the bottom sheet has completed animating offscreen. As with
 @c bottomSheetPresentationControllerDidDismissBottomSheet, this method is not called if the bottom
 sheet is dismissed programmatically.

 @param bottomSheet The @c MDCBottomSheetPresentationController that was dismissed.
 */
- (void)bottomSheetPresentationControllerDismissalAnimationCompleted:
    (nonnull MDCBottomSheetPresentationController *)bottomSheet;

/**
 Called when the state of the bottom sheet changes.

 Note: See what states the sheet can transition to by looking at MDCSheetState.

 @param bottomSheet The MDCBottomSheetPresentationController that its state changed.
 @param sheetState The state the sheet changed to.
 */
- (void)bottomSheetWillChangeState:(nonnull MDCBottomSheetPresentationController *)bottomSheet
                        sheetState:(MDCSheetState)sheetState;

/**
 Called when the Y offset of the sheet's changes in relation to the top of the screen.

 @param bottomSheet The MDCBottomSheetPresentationController that its Y offset changed.
 @param yOffset The Y offset the bottom sheet changed to.
 */
- (void)bottomSheetDidChangeYOffset:(nonnull MDCBottomSheetPresentationController *)bottomSheet
                            yOffset:(CGFloat)yOffset;
@end
