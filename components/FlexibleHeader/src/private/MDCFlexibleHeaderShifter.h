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

#import "MDCFlexibleHeaderView+ShiftBehavior.h"

#import <Foundation/Foundation.h>

/**
 The flexible header shifter is responsibile for vertical movement of the MDCFlexibleHeaderView.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCFlexibleHeaderShifter : NSObject

#pragma mark - Behavior

/**
 The behavior of the header's vertical movement.

 Default: MDCFlexibleHeaderShiftBehaviorDisabled
 */
@property(nonatomic) MDCFlexibleHeaderShiftBehavior behavior;

/**
 Returns a valid behavior for the current application context.

 Not all behaviors are usable in all application contexts. In app extensions, for example, it is not
 possible to adjust the status bar's positioning. This method should be used to adjust a desired
 behavior to the current context's supported behaviors.

 @param behavior The shift behavior that was originally desired.
 @returns If the code is running in an app extension, then
 MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar will be returned as
 MDCFlexibleHeaderShiftBehaviorEnabled. In all other contexts, @c behavior is returned unmodified.
 */
+ (MDCFlexibleHeaderShiftBehavior)behaviorForCurrentContextFromBehavior:
    (MDCFlexibleHeaderShiftBehavior)behavior;

@end
