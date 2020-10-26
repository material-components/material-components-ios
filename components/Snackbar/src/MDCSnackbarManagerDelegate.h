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

@class MDCSnackbarMessageView;

/**
 Delegate protocol for the MDCSnackbarManager.
 */
@protocol MDCSnackbarManagerDelegate <NSObject>

/**
 This method is called after the MDCSnackbarMessageView instance is initialized and right before
 The view is presented on the screen.

 @param messageView The messageView of the snackbar that will be presented.
 */
- (void)willPresentSnackbarWithMessageView:(nonnull MDCSnackbarMessageView *)messageView;

@optional

/**
 This method is called just before a Snackbar is dismissed.
 */
- (void)snackbarWillDisappear;

/**
 This method is called after a Snackbar's dismissal animation is finished.
 */
- (void)snackbarDidDisappear;

/**
 This method is called after the snackbar begins presenting (and is laid out),
 but before the animiation is finished.

 @param messageView The messageView of the snackbar that was just presented.
 */
- (void)isPresentingSnackbarWithMessageView:(nonnull MDCSnackbarMessageView *)messageView;

@end
