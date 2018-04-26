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

#import "MaterialButtons.h"
#import "MaterialColorScheme.h"

#import <Foundation/Foundation.h>

/**
 Used to apply a color scheme to theme MDCButton.
 */
@interface MDCButtonColorThemer : NSObject

/**
 Applies a color scheme to theme to an MDCButton.

 This method will soon be deprecated. Consider using MDCContainedButtonColorThemer's
 applySemanticColorScheme:toButton:
 or @c applySemanticColorScheme:toTextButton:.

 @param colorScheme The color scheme to apply to @c button.
 @param button A MDCButton instance to apply a color scheme.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toButton:(nonnull MDCButton *)button;

/**
 Applies a color scheme to theme to an MDCFlatButton.

 This method will soon be deprecated. Consider using MDCTextButtonColorThemer's
 applySemanticColorScheme:toButton:

 @param colorScheme The color scheme to apply to @c flatButton.
 @param flatButton An MDCFlatButton instance to apply a color scheme.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                    toFlatButton:(nonnull MDCButton *)flatButton;

/**
 Applies a color scheme to theme to an MDCRaisedButton.

 This method will soon be deprecated. Consider using MDCContainedButtonColorThemer's
 applySemanticColorScheme:toButton:

 @param colorScheme The color scheme to apply to @c raisedButton.
 @param raisedButton An MDCRaisedButton instance to apply a color scheme.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                  toRaisedButton:(nonnull MDCButton *)raisedButton;

/**
 Applies a color scheme to theme to an MDCFloatingButton.

 This method will soon be deprecated. Consider using MDCFloatingButtonColorThemer's
 applySemanticColorScheme:toButton:

 @param colorScheme The color scheme to apply to @c floatingButton.
 @param floatingButton An MDCFloatingButton instance to apply a color scheme.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                toFloatingButton:(nonnull MDCFloatingButton *)floatingButton;

/**
 Applies a color scheme to theme a MDCButton.

 This method will soon be deprecated. Consider using @c applySemanticColorScheme:toContainedButton:
 or @c applySemanticColorScheme:toTextButton:.

 @param colorScheme The color scheme to apply to @c button.
 @param button An MDCButton instance to apply a color scheme.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
                toButton:(nonnull MDCButton *)button;

@end
