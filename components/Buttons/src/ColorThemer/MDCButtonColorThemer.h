// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialColorScheme.h"

#import <Foundation/Foundation.h>

#pragma mark - Soon to be deprecated

/**
 Color themers for instances of MDCButton and MDCFloatingButton.

 @warning This class will soon be deprecated. Please consider using one of the more specific
 @c MDC*ButtonColorThemer classes instead. Learn more at
 components/schemes/Color/docs/migration-guide-semantic-color-scheme.md
 */
__deprecated_msg("Please use the MDCButton+MaterialTheming API instead.")
    @interface MDCButtonColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCButton.

 @warning This method will soon be deprecated. There is no direct replacement. Consider using one of
 the more specific  @c MDC*ButtonColorThemer classes instead. Learn more at
 components/schemes/Color/docs/migration-guide-semantic-color-scheme.md

 @param colorScheme The color scheme to apply to the component instance.
 @param button A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toButton:(nonnull MDCButton *)button;

/**
 Applies a color scheme's properties to an MDCButton using the flat button style.

 @warning This method will soon be deprecated. Consider using @c MDCTextButtonColorThemer instead.
 Learn more at components/schemes/Color/docs/migration-guide-semantic-color-scheme.md

 @param colorScheme The color scheme to apply to the component instance.
 @param flatButton A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                    toFlatButton:(nonnull MDCButton *)flatButton;

/**
 Applies a color scheme's properties to an MDCButton using the raised button style.

 @warning This method will soon be deprecated. Consider using @c MDCContainedButtonColorThemer
 instead. Learn more at components/schemes/Color/docs/migration-guide-semantic-color-scheme.md

 @param colorScheme The color scheme to apply to the component instance.
 @param raisedButton A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                  toRaisedButton:(nonnull MDCButton *)raisedButton;

/**
 Applies a color scheme's properties to an MDCFloatingButton using the floating button style.

 @warning This method will soon be deprecated. Consider using @c MDCFloatingButtonColorThemer
 instead. Learn more at components/schemes/Color/docs/migration-guide-semantic-color-scheme.md

 @param colorScheme The color scheme to apply to the component instance.
 @param floatingButton A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                toFloatingButton:(nonnull MDCFloatingButton *)floatingButton;

/**
 Applies a color scheme's properties to an MDCButton.

 @warning This method will soon be deprecated. There is no direct replacement. Consider using one of
 the more specific  @c MDC*ButtonColorThemer classes instead. Learn more at
 components/schemes/Color/docs/migration-guide-semantic-color-scheme.md

 @param colorScheme The color scheme to apply to the component instance.
 @param button A component instance to which the color scheme should be applied.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
                toButton:(nonnull MDCButton *)button;

@end
