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

#import "MDCSheetState.h"

@class MDCBottomSheetController;

/**
 Delegate for MDCBottomSheetController.
 */
@protocol MDCBottomSheetControllerDelegate <NSObject>
@optional
/**
 Called when the user taps the dimmed background or swipes the bottom sheet off to dismiss the
 bottom sheet. Also called with accessibility escape "two finger Z" gestures.

 This method is not called if the bottom sheet is dismissed programatically.

 @param controller The MDCBottomSheetController that was dismissed.
 */
- (void)bottomSheetControllerDidDismissBottomSheet:(nonnull MDCBottomSheetController *)controller;

/**
 Called when the state of the bottom sheet changes.

 Note: See what states the sheet can transition to by looking at MDCSheetState.

 @param controller The MDCBottomSheetController that its state changed.
 @param state The state the sheet changed to.
 */
- (void)bottomSheetControllerStateChanged:(nonnull MDCBottomSheetController *)controller
                                    state:(MDCSheetState)state;

/**
 Called when the Y offset of the sheet's changes in relation to the top of the screen.

 @param controller The MDCBottomSheetController that its Y offset changed.
 @param yOffset The Y offset the bottom sheet changed to.
 */
- (void)bottomSheetControllerDidChangeYOffset:(nonnull MDCBottomSheetController *)controller
                                      yOffset:(CGFloat)yOffset;
@end
