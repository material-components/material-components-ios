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

/**
 Called when the user taps the background or drags the bottom sheet off screen.
 @param controller The MDCBottomSheetPresentationController that was dismissed.
 */
- (void)bottomSheetPresentationControllerDidCancel:
    (nonnull MDCBottomSheetPresentationController *)controller;

@end

/**
 A UIPresentationController for presenting a modal view controller as a bottom sheet.
 */
@interface MDCBottomSheetPresentationController : UIPresentationController

/**
 Delegate to tell the presenter when to dismiss.
 */
@property(nonatomic, weak, nullable) id<MDCBottomSheetPresentationControllerDelegate> delegate;

/**
 If YES the bottom sheet presentation controller will dismiss the presented view controller when the
 user taps the dimming view or pulls the bottom sheet off the screen.
 If NO the bottom sheet will never automatically dismiss the presented view controller.

 @note If NO clients should dismiss the presented view controller inside the delegate callback
   |bottomSheetPresentationControllerDidCancel|.
 The default value is YES.
 */
@property(nonatomic, assign) BOOL automaticallyDismissBottomSheet;

/**
 Controls the height that the sheet should be when it appears. If NO, it defaults to half the height
 of the screen. If YES, and the @c -preferredContentSize is non-zero on the content view controller,
 it defaults to the preferredContentSize.

 @note The height used will never be any taller than the screen of the device.
 The default value is NO.
 */
@property(nonatomic) BOOL usePreferredHeight;

@end
