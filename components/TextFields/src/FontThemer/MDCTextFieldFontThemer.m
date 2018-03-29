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

#import "MDCTextFieldFontThemer.h"

#import "MaterialTextFields.h"
#import "MaterialThemes.h"

@implementation MDCTextFieldFontThemer

+ (void)applyFontScheme:(id<MDCFontScheme>)fontScheme
  toTextInputController:(id<MDCTextInputController>)textInputController {
  textInputController.inlinePlaceholderFont = fontScheme.body1;
  textInputController.leadingUnderlineLabelFont = fontScheme.caption;
  textInputController.trailingUnderlineLabelFont = fontScheme.caption;
  if ([textInputController
       conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;
    if (!fontScheme.body1 || !fontScheme.caption || fontScheme.caption.pointSize <= 0) {
      [textInputControllerFloatingPlaceholder setFloatingPlaceholderScaleDefault:0];
    } else {
      textInputControllerFloatingPlaceholder.floatingPlaceholderScale =
          [NSNumber numberWithDouble:fontScheme.caption.pointSize/fontScheme.body1.pointSize];
    }
  }
}

+ (void)applyFontScheme:(id<MDCFontScheme>)fontScheme
            toTextField:(MDCTextField *)textField {
  textField.font = fontScheme.body1;
  textField.placeholderLabel.font = fontScheme.body1;
  textField.leadingUnderlineLabel.font = fontScheme.caption;
  textField.trailingUnderlineLabel.font = fontScheme.caption;
}

// TODO: (larche) Drop this "#if !defined..." and the pragmas when we drop Xcode 8 support.
// This is to silence a warning that doesn't appear in Xcode 9 when you use Class as an object.
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
#endif
+ (void)applyFontScheme:(id<MDCFontScheme>)fontScheme
toAllTextInputControllersOfClass:(Class<MDCTextInputController>)textInputControllerClass {
  [textInputControllerClass setInlinePlaceholderFontDefault:fontScheme.body1];
  [textInputControllerClass setTrailingUnderlineLabelFontDefault:fontScheme.caption];
  [textInputControllerClass setLeadingUnderlineLabelFontDefault:fontScheme.caption];
  if ([textInputControllerClass
       conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    Class<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholderClass =
        (Class<MDCTextInputControllerFloatingPlaceholder>)textInputControllerClass;
    if (!fontScheme.body1 || !fontScheme.caption || fontScheme.caption.pointSize <= 0) {
      [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderScaleDefault:0.75];
    } else {
      CGFloat scale = fontScheme.caption.pointSize/fontScheme.body1.pointSize;
      [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderScaleDefault:scale];
    }
  }
}
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic pop
#endif


@end
