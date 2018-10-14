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
#import "MaterialDialogs.h"

@interface MDCAlertActionManager : NSObject

@property(nonatomic, nonnull, strong, readonly) NSArray<MDCAlertAction *> *actions;
/**
 returns the list of buttons for the provided actions, if they're already created. May
 return a different size list than actions, if the buttons hasn't materialized yet.
 Returns the buttons in the order they appear on screen (matches the order of "actions").
 */
@property(nonatomic, nonnull, strong, readonly) NSArray<MDCButton *> *sortedButtons;

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

 Note: It is the caller's responsibility to ensure the button is in the view hierarchy.
 */
- (nullable MDCButton *)buttonForAction:(nonnull MDCAlertAction *)action;

/**
 Returns the action for the given button.
 */
- (nullable MDCAlertAction *)actionForButton:(nonnull MDCButton *)button;

/**
 Creates a button and associates it with the action. Given Target and selector are
 assigned to the button.

 Note: It is the caller's responsibility to add the button to the view hierarchy.
 */
- (nullable MDCButton *)addButtonForAction:(nonnull MDCAlertAction *)action
                                    target:(nullable id)target
                                  selector:(SEL _Nonnull)selector;

@end
