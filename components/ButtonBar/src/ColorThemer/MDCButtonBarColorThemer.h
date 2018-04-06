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

#import "MaterialButtonBar.h"
#import "MaterialColorScheme.h"

/**
 A color themer for MDCButtonBar that implements the Material design color system mappings.
 */
@interface MDCButtonBarColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCButtonBar.

 @param colorScheme The color scheme to apply to MDCButtonBar.
 @param buttonBar An MDCButtonBar instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                     toButtonBar:(nonnull MDCButtonBar *)buttonBar;

#pragma mark - Soon to be deprecated

/**
 Applies a color scheme to theme a MDCButtonBar. Use a UIAppearance proxy to apply a color scheme to
 all instances of MDCButtonBar.

 This method will soon be deprecated. Consider using +applySemanticColorScheme:toButtonBar: instead.

 @param colorScheme The color scheme to apply to MDCButtonBar.
 @param buttonBar A MDCButtonBar instance to apply a color scheme.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
             toButtonBar:(nonnull MDCButtonBar *)buttonBar;

@end
