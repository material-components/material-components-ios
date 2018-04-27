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

#pragma mark - Soon to be deprecated

/**
 Used to apply a font scheme to theme a MDCTextField/MDCTextInputController.

 @warning This class will soon be deprecated. Please consider using
 MDCTextFieldTypographyThemer instead.
 */
@interface MDCTextFieldFontThemer : NSObject

/**
 Applies a font scheme to theme a MDCTextInputController instance.

 @param fontScheme The font scheme that applies to a MDCTextInputController.
 @param textInputController A MDCTextInputController instance that font scheme will be applied to.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
  toTextInputController:(nonnull id<MDCTextInputController>)textInputController;

/**
 Applies a font scheme to theme a specific class type responding to MDCTextInputController protocol.
 Will not apply to existing instances.

 @param fontScheme The font scheme that applies to a MDCTextInputController.
 @param textInputControllerClass A MDCTextInputController class that font scheme will be applied to.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
  toAllTextInputControllersOfClass:(nonnull Class<MDCTextInputController>)textInputControllerClass
  NS_SWIFT_NAME(apply(_:toAllControllersOfClass:));

/**
 Applies a font scheme to a MDCTextField instance.

 @param fontScheme The font scheme that applies to MDCTextField.
 @param textField A MDCTextField instance that font scheme will be applied to.
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
            toTextField:(nullable MDCTextField *)textField;

@end
