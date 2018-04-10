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

#import "MDCTextFieldTypographyThemer.h"

@implementation MDCTextFieldTypographyThemer

+ (void)applyTypographyScheme:(id<MDCTypographyScheming>)typographyScheme
        toTextInputController:(id<MDCTextInputController>)textInputController {
  textInputController.inlinePlaceholderFont = typographyScheme.subtitle1;
  textInputController.leadingUnderlineLabelFont = typographyScheme.caption;
  textInputController.trailingUnderlineLabelFont = typographyScheme.caption;
  if ([textInputController
       conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    id<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholder =
        (id<MDCTextInputControllerFloatingPlaceholder>)textInputController;

    // if caption.pointSize <= 0 there is no meaningful ratio so we fallback to default.
    if (typographyScheme.caption.pointSize <= 0) {
      textInputControllerFloatingPlaceholder.floatingPlaceholderScale = nil;
    } else {
      double ratio = typographyScheme.caption.pointSize/typographyScheme.subtitle1.pointSize;
      textInputControllerFloatingPlaceholder.floatingPlaceholderScale =
          [NSNumber numberWithDouble:ratio];
    }
  }
}

+ (void)applyTypographyScheme:(id<MDCTypographyScheming>)typographyScheme
                  toTextInput:(id<MDCTextInput>)textInput {
  textInput.font = typographyScheme.subtitle1;
  textInput.placeholderLabel.font = typographyScheme.subtitle1;
  textInput.leadingUnderlineLabel.font = typographyScheme.caption;
  textInput.trailingUnderlineLabel.font = typographyScheme.caption;
}

// TODO: (larche) Drop this "#if !defined..." and the pragmas when we drop Xcode 8 support.
// This is to silence a warning that doesn't appear in Xcode 9 when you use Class as an object.
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
#endif
+ (void)applyTypographyScheme:(id<MDCTypographyScheming>)typographyScheme
  toAllTextInputControllersOfClass:(Class<MDCTextInputController>)textInputControllerClass {
  [textInputControllerClass setInlinePlaceholderFontDefault:typographyScheme.subtitle1];
  [textInputControllerClass setTrailingUnderlineLabelFontDefault:typographyScheme.caption];
  [textInputControllerClass setLeadingUnderlineLabelFontDefault:typographyScheme.caption];
  if ([textInputControllerClass
       conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    Class<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholderClass =
        (Class<MDCTextInputControllerFloatingPlaceholder>)textInputControllerClass;
    // if caption.pointSize <= 0 there is no meaningful ratio so we fallback to default.
  if (typographyScheme.caption.pointSize <= 0) {
      [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderScaleDefault:0];
    } else {
      CGFloat scale = typographyScheme.caption.pointSize/typographyScheme.subtitle1.pointSize;
      [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderScaleDefault:scale];
    }
  }
}
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic pop
#endif


@end
