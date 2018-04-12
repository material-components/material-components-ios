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

/**
 Used to apply a color scheme to theme MDCTabBar.
 */
@interface MDCButtonColorThemer : NSObject

/**
 Applies a color scheme to theme to an MDCButton.

 @param colorScheme The color scheme to apply to @c button.
 @param button An MDCButton instance to apply a color scheme.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toButton:(nonnull MDCButton *)button;

/**
 Applies a color scheme to theme to an MDCFlatButton.

 @param colorScheme The color scheme to apply to @c flatButton.
 @param flatButton An MDCFlatButton instance to apply a color scheme.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                    toFlatButton:(nonnull MDCFlatButton *)flatButton;

/**
 Applies a color scheme to theme to an MDCRaisedButton.

 @param colorScheme The color scheme to apply to @c raisedButton.
 @param raisedButton An MDCRaisedButton instance to apply a color scheme.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                  toRaisedButton:(nonnull MDCRaisedButton *)raisedButton;

/**
 Applies a color scheme to theme a MDCButton. Use a UIAppearance proxy to apply a color scheme to
 all instances of MDCButton.

 This method will soon be deprecated. Consider using applySemanticColorScheme:colorScheme.

 @param colorScheme The color scheme to apply to @c button.
 @param button An MDCButton instance to apply a color scheme.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
                toButton:(nonnull MDCButton *)button;

@end
