/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import <Foundation/Foundation.h>

@class MDCTextField;

@protocol MDCFontScheme;
@protocol MDCTextInputController;

/**
 Used to apply a font scheme to theme to MDCTextField/MDCTextInputController.
 */
@interface MDCTextFieldFontThemer : NSObject

/**
 Applies a font scheme to theme to a MDCTextInputController instance.

 @param fontScheme The font scheme to apply to MDCTextInputController.
 @param textInputController a MDCTextInputController instance to apply a font scheme.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
  toTextInputController:(nullable id<MDCTextInputController>)textInputController;

/**
 Applies a font scheme to theme to MDCTextInputController for a specific class type.

 @param fontScheme The font scheme to apply to MDCTextInputController.
 @param textInputControllerClass a MDCTextInputController class to apply the font scheme to.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
  toAllTextInputControllersOfClass:(nullable Class<MDCTextInputController>)textInputControllerClass
  NS_SWIFT_NAME(apply(_:toAllControllersOfClass:));

/**
 Applies a font scheme to theme to MDCTextField instance.

 @param fontScheme The font scheme to apply to MDCTextField.
 @param textField a MDCTextField instance to apply the font scheme to.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
            toTextField:(nullable MDCTextField *)textField;

@end
