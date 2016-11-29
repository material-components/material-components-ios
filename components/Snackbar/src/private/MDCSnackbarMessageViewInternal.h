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

@class MDCSnackbarMessage;
@class MDCSnackbarMessageAction;

@interface MDCSnackbarMessageView ()

/**
 If the user has tapped on the snackbar or if @c dismissWithAction:userInitiated: has been called.
 */
@property(nonatomic, getter=isDismissing) BOOL dismissing;

/**
 The minimum width of the snackbar.
 */
@property(nonatomic, readonly) CGFloat minimumWidth;

/**
 The maximum width of the snackbar.
 */
@property(nonatomic, readonly) CGFloat maximumWidth;

/**
 Convenience pointer to the message used to create the view.
 */
@property(nonatomic, readonly, strong) MDCSnackbarMessage *message;

@end
