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

#import <XCTest/XCTest.h>

#import "MaterialTextFields+TypographyThemer.h"
#import "MaterialTextFields.h"
#import "MaterialThemes.h"

@interface MDCTextFieldTypographyThemer (ResetDefaults)

+ (void)resetDefaultsForClass:(Class<MDCTextInputController>)class;

@end

@implementation MDCTextFieldTypographyThemer (ResetDefaults)

// TODO: (larche) Drop this if defined and the pragmas when we drop Xcode 8 support.
// This is to silence a warning that doesn't appear in Xcode 9 when you use Class as an object.
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
#endif
+ (void)resetDefaultsForClass:(Class<MDCTextInputController>)textInputControllerClass {
  [textInputControllerClass setInlinePlaceholderFontDefault:nil];
  [textInputControllerClass setTrailingUnderlineLabelFontDefault:nil];
  [textInputControllerClass setLeadingUnderlineLabelFontDefault:nil];

  if ([textInputControllerClass
          conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    Class<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholderClass =
        (Class<MDCTextInputControllerFloatingPlaceholder>)textInputControllerClass;
    [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderScaleDefault:0];
  }
}
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic pop
#endif

@end

@interface TextFieldTypographyThemer : XCTestCase

@end

@implementation TextFieldTypographyThemer

- (void)tearDown {
  [super tearDown];
  [MDCTextFieldTypographyThemer resetDefaultsForClass:[MDCTextInputControllerFullWidth class]];
  [MDCTextFieldTypographyThemer resetDefaultsForClass:[MDCTextInputControllerBase class]];
}

- (void)testTypographyThemerSetsTheFontsForTextFieldProperly {
  MDCTextField *textField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  textField.font = [UIFont systemFontOfSize:28];
  textField.leadingUnderlineLabel.font = [UIFont systemFontOfSize:28];
  textField.trailingUnderlineLabel.font = [UIFont systemFontOfSize:28];
  textField.placeholderLabel.font = [UIFont systemFontOfSize:28];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  [MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme toTextInput:textField];
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.font, typographyScheme.caption);
  XCTAssertEqualObjects(textField.trailingUnderlineLabel.font, typographyScheme.caption);
  XCTAssertEqualObjects(textField.placeholderLabel.font, typographyScheme.subtitle1);
  XCTAssertEqualObjects(textField.font, typographyScheme.subtitle1);
}

- (void)testTypographyThemerSetsTheFontsForTextInputControllerClass {
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  [MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme
                     toAllTextInputControllersOfClass:[MDCTextInputControllerFullWidth class]];
  XCTAssertEqualObjects([MDCTextInputControllerFullWidth trailingUnderlineLabelFontDefault],
                        typographyScheme.caption);
  XCTAssertEqualObjects([MDCTextInputControllerFullWidth inlinePlaceholderFontDefault],
                        typographyScheme.subtitle1);
}

- (void)testTypographyThemerSetsTheFontsForTextInputControllerFloatingPlaceHolderClass {
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  [MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme
                     toAllTextInputControllersOfClass:[MDCTextInputControllerBase class]];
  XCTAssertEqualObjects([MDCTextInputControllerBase trailingUnderlineLabelFontDefault],
                        typographyScheme.caption);
  XCTAssertEqualObjects([MDCTextInputControllerBase leadingUnderlineLabelFontDefault],
                        typographyScheme.caption);
  XCTAssertEqualObjects([MDCTextInputControllerBase inlinePlaceholderFontDefault],
                        typographyScheme.subtitle1);
  XCTAssertEqual([MDCTextInputControllerBase floatingPlaceholderScaleDefault],
                 typographyScheme.caption.pointSize / typographyScheme.subtitle1.pointSize);
}

- (void)testTypographyThemerSetsTheFontsForTextInputControllerInstance {
  MDCTextInputControllerFullWidth *inputController = [[MDCTextInputControllerFullWidth alloc] init];
  inputController.trailingUnderlineLabelFont = [UIFont systemFontOfSize:80];
  inputController.inlinePlaceholderFont = [UIFont systemFontOfSize:80];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  [MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme
                                toTextInputController:inputController];
  XCTAssertEqualObjects(inputController.trailingUnderlineLabelFont, typographyScheme.caption);
  XCTAssertEqualObjects(inputController.inlinePlaceholderFont, typographyScheme.subtitle1);
}

- (void)testTypographyThemerSetsTheFontsForTextInputControllerFloatingPlaceHolderInstance {
  MDCTextInputControllerBase *floatingInputController = [[MDCTextInputControllerBase alloc] init];
  floatingInputController.trailingUnderlineLabelFont = [UIFont systemFontOfSize:80];
  floatingInputController.leadingUnderlineLabelFont = [UIFont systemFontOfSize:80];
  floatingInputController.inlinePlaceholderFont = [UIFont systemFontOfSize:80];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  [MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme
                                toTextInputController:floatingInputController];
  XCTAssertEqualObjects(floatingInputController.trailingUnderlineLabelFont,
                        typographyScheme.caption);
  XCTAssertEqualObjects(floatingInputController.leadingUnderlineLabelFont,
                        typographyScheme.caption);
  XCTAssertEqualObjects(floatingInputController.inlinePlaceholderFont, typographyScheme.subtitle1);
  XCTAssertEqual([floatingInputController.floatingPlaceholderScale doubleValue],
                 typographyScheme.caption.pointSize / typographyScheme.subtitle1.pointSize);
}

@end
