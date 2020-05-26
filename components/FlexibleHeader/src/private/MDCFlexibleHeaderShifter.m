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

#import "MDCFlexibleHeaderShifter.h"
#import "MaterialFlexibleHeader+ShiftBehaviorEnabledWithStatusBar.h"

// The suffix for an app extension bundle path.
static NSString *const kAppExtensionSuffix = @".appex";

@implementation MDCFlexibleHeaderShifter

- (instancetype)init {
  self = [super init];
  if (self) {
    _behavior = MDCFlexibleHeaderShiftBehaviorDisabled;
  }
  return self;
}

#pragma mark - Behavior

- (BOOL)hidesStatusBarWhenShiftedOffscreen {
  BOOL behaviorWantsStatusBarHidden =
      self.behavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar ||
      self.behavior == MDCFlexibleHeaderShiftBehaviorHideable;
  return behaviorWantsStatusBarHidden && !self.trackingScrollView.pagingEnabled;
}

+ (MDCFlexibleHeaderShiftBehavior)behaviorForCurrentContextFromBehavior:
    (MDCFlexibleHeaderShiftBehavior)behavior {
  // In app extensions we do not allow shifting with the status bar.
  if ([[[NSBundle mainBundle] bundlePath] hasSuffix:kAppExtensionSuffix] &&
      behavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar) {
    return MDCFlexibleHeaderShiftBehaviorEnabled;
  }
  return behavior;
}

@end
