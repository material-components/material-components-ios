/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialColorScheme.h"
#import "MaterialDialogs.h"

#import <Foundation/Foundation.h>

/**
 The Material Design color system's themer for instances of MDCAlertController.
 */
@interface MDCAlertColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCAlertController.

 @param colorScheme The color scheme to apply to the component instance.
 @param alertController A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
               toAlertController:(nonnull MDCAlertController *)alertController;

#pragma mark - Soon to be deprecated

/**
 Applies a color scheme to theme to all MDCAlertController alert dialogs.

 @warning This method will soon be deprecated. There is no direct replacement. Consider using
 @c applySemanticColorScheme:toAlertController: instead.

 @param colorScheme The color scheme to apply to all MDCAlertController alert dialogs.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme;

@end
