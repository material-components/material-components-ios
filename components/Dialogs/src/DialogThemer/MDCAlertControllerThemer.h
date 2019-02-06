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

#import "MDCAlertScheme.h"
#import "MaterialDialogs.h"

__deprecated_msg("Please use MaterialDialogs+Theming.") @interface MDCAlertControllerThemer
    : NSObject

/**
 Applies a component scheme's properties to an MDCAlertController.

 @param alertScheme The component scheme to apply to the alert dialog instance.
 @param alertController An alert dialog instance to which the component scheme should be applied.
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (void)applyScheme:(nonnull id<MDCAlertScheming>)alertScheme
    toAlertController:(nonnull MDCAlertController *)alertController;
#pragma clang diagnostic pop
@end
