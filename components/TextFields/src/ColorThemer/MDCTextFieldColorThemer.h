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

#import "MaterialTextFields.h"
#import "MaterialThemes.h"

/**
 Used to apply a color scheme to theme MDCTextField within MDCTextInputController.
 */
@interface MDCTextFieldColorThemer : NSObject

/**
 Applies a color scheme to theme MDCTextField in MDCTextInputController.

 @param colorScheme The color scheme to apply.
 @param textInputController A MDCTextInputController instance to apply a color scheme.
 */
+ (void)applyColorScheme:(NSObject<MDCColorScheme> *)colorScheme
    toTextInputController:(NSObject<MDCTextInputController> *)textInputController;

/**
 Applies a color scheme to theme MDCTextField in MDCTextInputControllerDefault.

 @param colorScheme The color scheme to apply.
 @param textInputControllerDefault A MDCTextInputControllerDefault instance to apply a color scheme.
 */
+ (void)applyColorScheme:(NSObject<MDCColorScheme> *)colorScheme
    toTextInputControllerDefault:(MDCTextInputControllerDefault *)textInputControllerDefault;

/**
 Applies a color scheme to MDCTextField for all instances of MDCTextInputControllerDefault using the
 default color class properties.

 @param colorScheme The color scheme to apply.
 */
+ (void)applyColorSchemeToAllTextInputControllerDefault:(NSObject<MDCColorScheme> *)colorScheme;

@end
