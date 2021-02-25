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

@class MDCAlertAction;
@class MDCAlertController;

@protocol MDCAlertControllerDelegate <NSObject>

@optional

/**
 Informs the receiver that the alert controller will appear on the screen or the application is
 entering the foreground.
 */
- (void)alertController:(nonnull MDCAlertController *)alertController willAppear:(BOOL)animated;

/**
 Informs the receiver that the alert controller appeared on the screen or the application has
 entered the foreground.
 */
- (void)alertController:(nonnull MDCAlertController *)alertController didAppear:(BOOL)animated;

/**
 Informs the receiver that the alert controller will disappear from the screen or the application is
 entering the background.
 */
- (void)alertController:(nonnull MDCAlertController *)alertController willDisappear:(BOOL)animated;

/**
 Informs the receiver that the alert controller disappeared from the screen or the application has
 entered the background.
 */
- (void)alertController:(nonnull MDCAlertController *)alertController didDisappear:(BOOL)animated;

/**
 Called on the delegate after the alert action is tapped by the user and while the alert is still on
 the screen. This is called whenever the action is tapped regardless of whether it dismisses the
 alert controller or not.
 */
- (void)alertController:(nonnull MDCAlertController *)alertController
           didTapAction:(nonnull MDCAlertAction *)action
              withEvent:(nonnull UIEvent *)event;

@end
