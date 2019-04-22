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

#import "MaterialColorScheme.h"
#import "MaterialList.h"

#import <Foundation/Foundation.h>

/**
 The Material Design color system's themer for List Item classes.

 @warning This API will eventually be deprecated. See the individual method documentation for
 details on replacement APIs.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCListColorThemer : NSObject
@end

@interface MDCListColorThemer (ToBeDeprecated)

/**
 Applies a color scheme's properties to an MDCSelfSizingStereoCell

 @param colorScheme The color scheme to apply to the component instance.
 @param cell A component instance to which the color scheme should be applied.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
          toSelfSizingStereoCell:(MDCSelfSizingStereoCell *)cell;

/**
 Applies a color scheme's properties to an MDCBaseCell

 @param colorScheme The color scheme to apply to the component instance.
 @param cell A component instance to which the color scheme should be applied.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme toBaseCell:(MDCBaseCell *)cell;

@end
