/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
 
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

#import "MDCCollectionViewStyling.h"

@class MDCDialogPresentationController;

/** Delegate callbacks for MDCDialogPresentationController. */
@protocol MDCDialogPresentationControllerDelegate <NSObject>
@optional
/**
 Allows the receiver to dictate whether or not to allow the user to dismiss the dialog by tapping on the background view.
 
 @param presentationController The controller which is presenting the dialog.
 @return BOOL indicating that the presentation controller should dismiss the dialog when a user taps on the background view.
 */
- (BOOL)presentationControllerShouldDismissOnBackgroundTap:(nonnull MDCDialogPresentationController *)presentationController;

@end