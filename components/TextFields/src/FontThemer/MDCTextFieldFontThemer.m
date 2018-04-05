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

+ (void)applyTypographyScheme:(id<MDCTypographyScheming>)scheme
  toTextInputController:(id<MDCTextInputController>)textInputController {
  textInputController.inlinePlaceholderFont = scheme.body1;
  textInputController.leadingUnderlineLabelFont = scheme.caption;
  textInputController.trailingUnderlineLabelFont = scheme.caption;
  if ([textInputController
       conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;
    if (!scheme.body1 || !scheme.caption || scheme.caption.pointSize <= 0) {
      [textInputControllerFloatingPlaceholder setFloatingPlaceholderScaleDefault:0];
    } else {
      textInputControllerFloatingPlaceholder.floatingPlaceholderScale =
          [NSNumber numberWithDouble:scheme.caption.pointSize/scheme.body1.pointSize];
    }
  }
}

+ (void)applyTypographyScheme:(id<MDCTypographyScheming>)scheme
            toTextField:(MDCTextField *)textField {
  textField.font = scheme.body1;
  textField.placeholderLabel.font = scheme.body1;
  textField.leadingUnderlineLabel.font = scheme.caption;
  textField.trailingUnderlineLabel.font = scheme.caption;
}

// TODO: (larche) Drop this "#if !defined..." and the pragmas when we drop Xcode 8 support.
// This is to silence a warning that doesn't appear in Xcode 9 when you use Class as an object.
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
#endif
+ (void)applyTypographyScheme:(id<MDCTypographyScheming>)scheme
toAllTextInputControllersOfClass:(Class<MDCTextInputController>)textInputControllerClass {
  [textInputControllerClass setInlinePlaceholderFontDefault:scheme.body1];
  [textInputControllerClass setTrailingUnderlineLabelFontDefault:scheme.caption];
  [textInputControllerClass setLeadingUnderlineLabelFontDefault:scheme.caption];
  if ([textInputControllerClass
       conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    Class<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholderClass =
        (Class<MDCTextInputControllerFloatingPlaceholder>)textInputControllerClass;
    if (!scheme.body1 || !scheme.caption || scheme.caption.pointSize <= 0) {
      [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderScaleDefault:0.75];
    } else {
      CGFloat scale = scheme.caption.pointSize/scheme.body1.pointSize;
      [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderScaleDefault:scale];
    }
  }
}
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic pop
#endif


@end
