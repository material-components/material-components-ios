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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MDCFloatingButton.h"

API_DEPRECATED_BEGIN("🤖👀 Use branded M3CButton instead. "
                     "See go/material-ios-buttons/gm2-migration for more details. "
                     "This has go/material-ios-migrations#scriptable-potential 🤖👀.",
                     ios(12, 12))

@class MDCFloatingButtonModeAnimator;

/**
 MDCFloatingButtonModeAnimator uses this delegate to interact with its owning context.
 */
@protocol MDCFloatingButtonModeAnimatorDelegate <NSObject>
@required

/**
 Asks the receiver to commit any layout changes relevant to the mode change.
 */
- (void)floatingButtonModeAnimatorCommitLayoutChanges:
            (nonnull MDCFloatingButtonModeAnimator *)modeAnimator
                                                 mode:(MDCFloatingButtonMode)mode;

@end

API_DEPRECATED_END
