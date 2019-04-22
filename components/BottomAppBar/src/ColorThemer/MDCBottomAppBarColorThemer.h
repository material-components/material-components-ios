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

#import "MaterialBottomAppBar.h"
#import "MaterialColorScheme.h"

#import <Foundation/Foundation.h>

/**
 A color themer for MDCBottomAppBarView. This API does not fully implement the Material Design color
 system.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCBottomAppBarColorThemer : NSObject
@end

@interface MDCBottomAppBarColorThemer (ToBeDeprecated)

/**
 Applies a color scheme to theme an MDCBottomAppBarView using the "surface" variant theming. The
 "surface" variant applies the @c surfaceColor of the color scheme as the @c barTintColor instead
 of @c primaryColor.

 @param colorScheme a color scheme to apply to the bottom app bar.
 @param bottomAppBarView the bottom app bar to theme.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySurfaceVariantWithSemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                toBottomAppBarView:(nonnull MDCBottomAppBarView *)bottomAppBarView;

/**
 Applies a color scheme to theme a MDCBottomAppBarView.

 @param colorScheme The color scheme to apply to the component instance.
 @param bottomAppBarView A component instance to which the color scheme should be applied.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
      toBottomAppBarView:(nonnull MDCBottomAppBarView *)bottomAppBarView;

@end
