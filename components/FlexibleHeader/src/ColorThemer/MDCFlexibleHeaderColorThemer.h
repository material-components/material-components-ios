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
#import "MaterialFlexibleHeader.h"

/**
 Used to apply a color scheme to theme MDCFlexibleHeaderView.
 */
@interface MDCFlexibleHeaderColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCFlexibleHeaderView.

 @param colorScheme The color scheme to apply to MDCFlexibleHeaderView.
 @param flexibleHeaderView An MDCFlexibleHeaderView instance to which the color scheme should be
 applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
            toFlexibleHeaderView:(nonnull MDCFlexibleHeaderView *)flexibleHeaderView;

#pragma mark - Soon to be deprecated

/**
 Applies a color scheme to theme a MDCFlexibleHeaderView. Use a UIAppearance proxy to apply a color
 scheme to all instances of MDCFlexibleHeaderView.

 This method will soon be deprecated. Consider using +applySemanticColorScheme:toFlexibleHeaderView:
 instead.

 @param colorScheme The color scheme to apply to MDCFlexibleHeaderView.
 @param flexibleHeaderView A MDCFlexibleHeaderView instance to apply a color scheme.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
    toFlexibleHeaderView:(nonnull MDCFlexibleHeaderView *)flexibleHeaderView;

/**
 Applies a color scheme to theme a MDCFlexibleHeaderViewController. Use a UIAppearance proxy to
 apply a color scheme to all instances of MDCFlexibleHeaderViewController.

 This method will soon be deprecated. Consider using +applySemanticColorScheme:toFlexibleHeaderView:
 instead.

 @param colorScheme The color scheme to apply to MDCFlexibleHeaderView.
 @param flexibleHeaderController A MDCFlexibleHeaderViewController instance to apply a color scheme.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
    toMDCFlexibleHeaderController:(nonnull MDCFlexibleHeaderViewController *)flexibleHeaderController;

@end
