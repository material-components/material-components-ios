// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>
#import "MaterialButtons.h"
#import "MDCAlertController.h"

@interface MDCAlertActionManager : NSObject

/**
 List of the actions that were added to the action manager.
 */
@property(nonatomic, nonnull, strong, readonly) NSArray<MDCAlertAction *> *actions;

/**
 Sets the flag to use `M3CButton` instead of `MDCButton`, this flag would be
 eventually removed when `MDCButton` is deleted.

 Defaults to NO
 */
@property(nonatomic, assign, getter=isM3CButtonEnabled) BOOL M3CButtonEnabled;

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 Returns the list of buttons for the provided actions. Only returns buttons which have already
 been created. Unlike buttonForAction, it does not create buttons, and as a results, may
 return a shorter list than the actions array. Order of buttons resembles order of actions,
 but is not guaranteed.

 Note: It is the caller's responsibility to make sure buttons is added to the view hierarchy.
 */
@property(nonatomic, nonnull, strong, readonly) NSArray<UIButton *> *buttonsInActionOrder;
#pragma clang diagnostic pop

/**
 Adding an action with no associated button (will be created later)
 */
- (void)addAction:(nonnull MDCAlertAction *)action;

/**
 Returns true if the action has been previously added to the array
 */
- (BOOL)hasAction:(nonnull MDCAlertAction *)action;

/**
 Returns the button for the action. Returns nil if the button hasn't been created yet.

 Note: It is the caller's responsibility to make sure the button is added to the view hierarchy.
 */
- (nullable UIButton *)buttonForAction:(nonnull MDCAlertAction *)action;

// TODO(b/238930139): Remove usage of MDCButton API and replace with M3CButton.
/**
 Returns the action for the given button.
 */
- (nullable MDCAlertAction *)actionForButton:(nonnull UIButton *)button;

/**
 Creates a button for the given action if the action is not yet associated with
 a button. If the action is already associated with a button, then the existing
 button is returned. The given Target and selector are assigned to the button
 when it's created (or ignored if the button is already exists).

 Note: It is the caller's responsibility to make sure the button is added to the view hierarchy.
 */
- (UIButton *)createButtonForAction:(nonnull MDCAlertAction *)action
                             target:(nullable id)target
                           selector:(SEL _Nonnull)selector;

@end
