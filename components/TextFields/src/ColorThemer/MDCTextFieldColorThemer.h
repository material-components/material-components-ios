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

#import <Foundation/Foundation.h>

#import "MaterialColorScheme.h"
#import "MaterialTextFields.h"

/**
 The Material Design color system's text field themer.

 @warning This API will eventually be deprecated. See the individual method documentation for
 details on replacement APIs.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCTextFieldColorThemer : NSObject
@end

@interface MDCTextFieldColorThemer (ToBeDeprecated)

/**
 Applies a color scheme to theme MDCTextField in MDCTextInputController.

 @param colorScheme The color scheme to apply.
 @param textInputController A MDCTextInputController instance to apply a color scheme.

 @warning This API will eventually be deprecated. The replacement API is:
 `MDCTextInputControllerFilled`'s `-applyThemeWithScheme:` or
 `MDCTextInputControllerOutlined`'s `-applyThemeWithScheme:`.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
           toTextInputController:(nonnull id<MDCTextInputController>)textInputController;

/**
 Applies a color scheme to MDCTextField for all instances of the class
 using the default color class properties.

 @param colorScheme The color scheme to apply.
 @param textInputControllerClass A Class that conforms to MDCTextInputController (at least.)

 @warning This API will eventually be deprecated. There will be no replacement for this API.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
    toAllTextInputControllersOfClass:(nonnull Class<MDCTextInputController>)textInputControllerClass
    NS_SWIFT_NAME(apply(_:toAllControllersOfClass:));

/**
 Applies a color scheme to theme an MDCTextField.

 @param colorScheme The color scheme to apply.
 @param textInput A MDCTextInput instance to apply a color scheme.

 @warning This API will eventually be deprecated. There will be no replacement for this API.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                     toTextInput:(nonnull id<MDCTextInput>)textInput;

/**
 Applies a color scheme to theme MDCTextField in MDCTextInputController.

 @param colorScheme The color scheme to apply.
 @param textInputController A MDCTextInputController instance to apply a color scheme.

 @warning This API will eventually be deprecated. The replacement API is:
 `MDCTextInputControllerFilled`'s `-applyThemeWithScheme:` or
 `MDCTextInputControllerOutlined`'s `-applyThemeWithScheme:`.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
    toTextInputController:(nonnull id<MDCTextInputController>)textInputController;

/**
 Applies a color scheme to MDCTextField for all instances of the class
 using the default color class properties.

 @param colorScheme The color scheme to apply.
 @param textInputControllerClass A Class that conforms to MDCTextInputController (at least.)

 @warning This API will eventually be deprecated. There will be no replacement for this API.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
    toAllTextInputControllersOfClass:(nonnull Class<MDCTextInputController>)textInputControllerClass
    NS_SWIFT_NAME(apply(_:toAllControllersOfClass:));

@end
