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

#import "MaterialTextFields.h"
#import "MaterialThemes.h"
#import "MaterialTextFields+FontThemer.h"

@interface TextFieldsFontThemerTests : XCTestCase

@end

@implementation TextFieldsFontThemerTests

- (void)tearDown {
  [super tearDown];
  // Reset class default values.
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.body1 = nil;
  fontScheme.caption = nil;
  [MDCTextFieldFontThemer applyFontScheme:fontScheme
         toAllTextInputControllersOfClass:[MDCTextInputControllerFullWidth class]];
  [MDCTextFieldFontThemer applyFontScheme:fontScheme
         toAllTextInputControllersOfClass:[MDCTextInputControllerBase class]];
}

- (void)testFontThemerSetsTheFontsForTextFieldProperly {
  MDCTextField *textField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  textField.font = [UIFont systemFontOfSize:28];
  textField.leadingUnderlineLabel.font = [UIFont systemFontOfSize:28];
  textField.trailingUnderlineLabel.font = [UIFont systemFontOfSize:28];
  textField.placeholderLabel.font = [UIFont systemFontOfSize:28];
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.body1 = [UIFont systemFontOfSize:20];
  fontScheme.caption = [UIFont systemFontOfSize:16];
  [MDCTextFieldFontThemer applyFontScheme:fontScheme toTextField:textField];
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.font, fontScheme.caption);
  XCTAssertEqualObjects(textField.trailingUnderlineLabel.font, fontScheme.caption);
  XCTAssertEqualObjects(textField.placeholderLabel.font, fontScheme.body1);
  XCTAssertEqualObjects(textField.font, fontScheme.body1);
}

- (void)testFontThemerSetsTheFontsForTextInputControllerClass {
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.body1 = [UIFont systemFontOfSize:20];
  fontScheme.caption = [UIFont systemFontOfSize:16];
  [MDCTextFieldFontThemer applyFontScheme:fontScheme
         toAllTextInputControllersOfClass:[MDCTextInputControllerFullWidth class]];
  XCTAssertEqualObjects([MDCTextInputControllerFullWidth trailingUnderlineLabelFontDefault],
                        fontScheme.caption);
  XCTAssertEqualObjects([MDCTextInputControllerFullWidth inlinePlaceholderFontDefault],
                        fontScheme.body1);
}

- (void)testFontThemerSetsTheFontsForTextInputControllerFloatingPlaceHolderClass {
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.body1 = [UIFont systemFontOfSize:20];
  fontScheme.caption = [UIFont systemFontOfSize:16];
  [MDCTextFieldFontThemer applyFontScheme:fontScheme
         toAllTextInputControllersOfClass:[MDCTextInputControllerBase class]];
  XCTAssertEqualObjects([MDCTextInputControllerBase trailingUnderlineLabelFontDefault],
                        fontScheme.caption);
  XCTAssertEqualObjects([MDCTextInputControllerBase leadingUnderlineLabelFontDefault],
                        fontScheme.caption);
  XCTAssertEqualObjects([MDCTextInputControllerBase inlinePlaceholderFontDefault],
                        fontScheme.body1);
  XCTAssertEqual([MDCTextInputControllerBase floatingPlaceholderScaleDefault],
                 fontScheme.caption.pointSize/fontScheme.body1.pointSize);
}

- (void)testFontThemerSetsTheFontsForTextInputControllerInstance {
  MDCTextInputControllerFullWidth *inputController = [[MDCTextInputControllerFullWidth alloc] init];
  inputController.trailingUnderlineLabelFont = [UIFont systemFontOfSize:80];
  inputController.inlinePlaceholderFont = [UIFont systemFontOfSize:80];
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.body1 = [UIFont systemFontOfSize:20];
  fontScheme.caption = [UIFont systemFontOfSize:16];
  [MDCTextFieldFontThemer applyFontScheme:fontScheme toTextInputController:inputController];
  XCTAssertEqualObjects(inputController.trailingUnderlineLabelFont, fontScheme.caption);
  XCTAssertEqualObjects(inputController.inlinePlaceholderFont, fontScheme.body1);
}

- (void)testFontThemerSetsTheFontsForTextInputControllerFloatingPlaceHolderInstance {
  MDCTextInputControllerBase *floatingInputController = [[MDCTextInputControllerBase alloc] init];
  floatingInputController.trailingUnderlineLabelFont = [UIFont systemFontOfSize:80];
  floatingInputController.leadingUnderlineLabelFont = [UIFont systemFontOfSize:80];
  floatingInputController.inlinePlaceholderFont = [UIFont systemFontOfSize:80];
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.body1 = [UIFont systemFontOfSize:20];
  fontScheme.caption = [UIFont systemFontOfSize:16];
  [MDCTextFieldFontThemer applyFontScheme:fontScheme toTextInputController:floatingInputController];
  XCTAssertEqualObjects(floatingInputController.trailingUnderlineLabelFont, fontScheme.caption);
  XCTAssertEqualObjects(floatingInputController.leadingUnderlineLabelFont, fontScheme.caption);
  XCTAssertEqualObjects(floatingInputController.inlinePlaceholderFont, fontScheme.body1);
  XCTAssertEqual([floatingInputController.floatingPlaceholderScale doubleValue],
                 fontScheme.caption.pointSize/fontScheme.body1.pointSize);
}

@end
