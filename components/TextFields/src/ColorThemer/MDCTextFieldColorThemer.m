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

#import "MDCTextFieldColorThemer.h"

#import "MaterialTextFields.h"
#import "MaterialThemes.h"

@implementation MDCTextFieldColorThemer

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
    toTextInputController:(id<MDCTextInputController>)textInputController {
  textInputController.activeColor = colorScheme.primaryColor;
  if ([textInputController
          conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;

    if ([textInputControllerFloatingPlaceholder
            respondsToSelector:@selector(setFloatingPlaceholderNormalColor:)]) {
      textInputControllerFloatingPlaceholder.floatingPlaceholderNormalColor =
          colorScheme.primaryColor;
    }
  }
}

// TODO: (larche) Drop this if defined and the pragmas when we drop Xcode 8 support.
// This is to silence a warning that doesn't appear in Xcode 9 when you use Class as an object.
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
#endif
+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
    toAllTextInputControllersOfClass:(Class<MDCTextInputController>)textInputControllerClass {
  if ([textInputControllerClass respondsToSelector:@selector(setActiveColorDefault:)]) {
    [textInputControllerClass setActiveColorDefault:colorScheme.primaryColor];
  }
}
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic pop
#endif

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
           toTextInputController:(id<MDCTextInputController>)textInputController {
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface60Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  textInputController.activeColor = colorScheme.primaryColor;
  textInputController.errorColor = colorScheme.errorColor;
  textInputController.normalColor = onSurface87Opacity;
  textInputController.inlinePlaceholderColor = onSurface60Opacity;
  textInputController.trailingUnderlineLabelTextColor = onSurface60Opacity;
  textInputController.leadingUnderlineLabelTextColor = onSurface60Opacity;

  if ([textInputController
          conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;
    UIColor *primary87Opacity = [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.87];
    textInputControllerFloatingPlaceholder.floatingPlaceholderNormalColor = onSurface60Opacity;
    textInputControllerFloatingPlaceholder.floatingPlaceholderActiveColor = primary87Opacity;
  }
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                     toTextInput:(nonnull id<MDCTextInput>)textInput {
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface60Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  textInput.cursorColor = colorScheme.primaryColor;
  textInput.textColor = onSurface87Opacity;
  textInput.placeholderLabel.textColor = onSurface60Opacity;
  textInput.trailingUnderlineLabel.textColor = onSurface60Opacity;
  textInput.leadingUnderlineLabel.textColor = onSurface60Opacity;
}

// TODO: (larche) Drop this if defined and the pragmas when we drop Xcode 8 support.
// This is to silence a warning that doesn't appear in Xcode 9 when you use Class as an object.
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
#endif
+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
    toAllTextInputControllersOfClass:(Class<MDCTextInputController>)textInputControllerClass {
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface60Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  [textInputControllerClass setActiveColorDefault:colorScheme.primaryColor];
  [textInputControllerClass setErrorColorDefault:colorScheme.errorColor];
  [textInputControllerClass setNormalColorDefault:onSurface87Opacity];
  [textInputControllerClass setInlinePlaceholderColorDefault:onSurface60Opacity];
  [textInputControllerClass setTrailingUnderlineLabelTextColorDefault:onSurface60Opacity];
  [textInputControllerClass setLeadingUnderlineLabelTextColorDefault:onSurface60Opacity];

  if ([textInputControllerClass
          conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    Class<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholderClass =
        (Class<MDCTextInputControllerFloatingPlaceholder>)textInputControllerClass;
    UIColor *primary87Opacity = [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.87];
    [textInputControllerFloatingPlaceholderClass
        setFloatingPlaceholderNormalColorDefault:onSurface60Opacity];
    [textInputControllerFloatingPlaceholderClass
        setFloatingPlaceholderActiveColorDefault:primary87Opacity];
  }
}
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic pop
#endif

@end
