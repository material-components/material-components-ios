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

#import "MaterialTextFields.h"
#import "MaterialTypographyScheme.h"

/**
 The Material Design typography system's text field themer.
 */
@interface MDCTextFieldTypographyThemer : NSObject

/**
 Applies a typography scheme's properties to a text input controller.

 @param typographyScheme The color scheme to apply to the component instance.
 @param textInputController A component instance to which the color scheme should be applied.
 */
+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
        toTextInputController:(nonnull id<MDCTextInputController>)textInputController;

/**
 Applies a typography scheme to theme an specific class type responding to MDCTextInputController
 protocol. Will not apply to existing instances.

 @param typographyScheme The typography scheme that applies to a MDCTextInputController.
 @param textInputControllerClass A MDCTextInputController class that typography scheme will be
 applied to.
 */
+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
    toAllTextInputControllersOfClass:(nonnull Class<MDCTextInputController>)textInputControllerClass
    NS_SWIFT_NAME(apply(_:toAllControllersOfClass:));

/**
 Applies a typography scheme's properties to a text input.

 @param typographyScheme The color scheme to apply to the component instance.
 @param textInput A component instance to which the color scheme should be applied.
 */
+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
                  toTextInput:(nonnull id<MDCTextInput>)textInput;

@end
