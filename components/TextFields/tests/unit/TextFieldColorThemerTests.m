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

#import <XCTest/XCTest.h>

#import "MaterialTextFields.h"
#import "MaterialTypographyScheme.h"
#import "MaterialThemes.h"
#import "MDCTextFieldColorThemer.h"
#import "MDCSemanticColorScheme.h"

@interface MDCTextFieldColorThemer (ResetDefaults)

+ (void)resetDefaultsForClass:(Class<MDCTextInputController>)class;

@end

@implementation MDCTextFieldColorThemer (ResetDefaults)

// TODO: (larche) Drop this if defined and the pragmas when we drop Xcode 8 support.
// This is to silence a warning that doesn't appear in Xcode 9 when you use Class as an object.
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-method-access"
#endif
+ (void)resetDefaultsForClass:(Class<MDCTextInputController>)textInputControllerClass {
  [textInputControllerClass setActiveColorDefault:nil];
  [textInputControllerClass setErrorColorDefault:nil];
  [textInputControllerClass setNormalColorDefault:nil];
  [textInputControllerClass setInlinePlaceholderColorDefault:nil];
  [textInputControllerClass setTrailingUnderlineLabelTextColorDefault:nil];
  [textInputControllerClass setLeadingUnderlineLabelTextColorDefault:nil];

  if ([textInputControllerClass
       conformsToProtocol:@protocol(MDCTextInputControllerFloatingPlaceholder)]) {
    Class<MDCTextInputControllerFloatingPlaceholder> textInputControllerFloatingPlaceholderClass =
        (Class<MDCTextInputControllerFloatingPlaceholder>)textInputControllerClass;
    [textInputControllerFloatingPlaceholderClass
        setFloatingPlaceholderNormalColorDefault:nil];
  }
}
#if !defined(__IPHONE_11_0)
#pragma clang diagnostic pop
#endif

@end

@interface TextFieldColorThemerTests : XCTestCase

@end

@implementation TextFieldColorThemerTests

- (void)setUp{
  [super setUp];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
           toAllTextInputControllersOfClass:[MDCTextInputControllerFullWidth class]];
  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
           toAllTextInputControllersOfClass:[MDCTextInputControllerBase class]];

}

- (void)tearDown {
  [super tearDown];
  [MDCTextFieldColorThemer resetDefaultsForClass:[MDCTextInputControllerFullWidth class]];
  [MDCTextFieldColorThemer resetDefaultsForClass:[MDCTextInputControllerBase class]];
}

- (void)testDefaultValuesAreSet {
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  XCTAssertEqualObjects(MDCTextInputControllerBase.activeColorDefault, colorScheme.primaryColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.errorColorDefault, colorScheme.errorColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.normalColorDefault, colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.inlinePlaceholderColorDefault,
                        colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.trailingUnderlineLabelTextColorDefault,
                        colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.leadingUnderlineLabelTextColorDefault,
                        colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.floatingPlaceholderNormalColorDefault,
                        colorScheme.primaryColor);

  XCTAssertEqualObjects(MDCTextInputControllerFullWidth.errorColorDefault, colorScheme.errorColor);
  XCTAssertEqualObjects(MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault,
                        colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault,
                        colorScheme.onSurfaceColor);
}

- (void)testInstanceColorValuesAreSet {
  MDCTextField *textField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  MDCTextField *baseTextField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  MDCTextField *fullWidthTextField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  MDCTextInputControllerBase *baseInputController =
      [[MDCTextInputControllerBase alloc] initWithTextInput:baseTextField];
  MDCTextInputControllerFullWidth *fullWidthInputController =
      [[MDCTextInputControllerFullWidth alloc] initWithTextInput:fullWidthTextField];

  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.primaryColor = [UIColor blueColor];
  colorScheme.errorColor = [UIColor yellowColor];
  colorScheme.onSurfaceColor = [UIColor greenColor];
  colorScheme.errorColor = [UIColor redColor];

  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
                                        toTextInput:textField];
  XCTAssertEqualObjects(textField.cursorColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(textField.textColor, colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor, colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(textField.trailingUnderlineLabel.textColor, colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.textColor, colorScheme.onSurfaceColor);

  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
                              toTextInputController:baseInputController];
  XCTAssertEqualObjects(baseInputController.activeColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(baseInputController.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(baseInputController.normalColor, colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(baseInputController.inlinePlaceholderColor, colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(baseInputController.trailingUnderlineLabelTextColor,
                        colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(baseInputController.leadingUnderlineLabelTextColor,
                        colorScheme.onSurfaceColor);

  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
                      toTextInputController:fullWidthInputController];
  XCTAssertEqualObjects(fullWidthInputController.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(fullWidthInputController.inlinePlaceholderColor,
                        colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(fullWidthInputController.trailingUnderlineLabelTextColor,
                        colorScheme.onSurfaceColor);
}

@end
