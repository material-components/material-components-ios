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

#import "MaterialDialogs.h"

@interface MDCAlertController (ButtonForAction)

/**
 Returns an MDCButton associated with the given action. This method might create the button if
 no associated button exists for the action. Buttons returned by this method may not (yet)
 be attached to the view hierarchy at the time the method is called.

 This method is commonly used by themers to style the button associated with the action.

 @param action The action with which the button is associated. Must be an existing action that
 had been previously added through addAction: to the alert.
 @return The button associated with the action, or nil if the action doesn't exist (the action
 must first be added to the alert).
 */
- (nullable MDCButton *)buttonForAction:(nonnull MDCAlertAction *)action;

@end
