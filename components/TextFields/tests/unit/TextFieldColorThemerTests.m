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
#import "MaterialTypographyScheme.h"
#import "MaterialThemes.h"
#import "MaterialTextFields+ColorThemer.h"
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
    [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderActiveColorDefault:nil];
    [textInputControllerFloatingPlaceholderClass setFloatingPlaceholderNormalColorDefault:nil];
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
  UIColor *primary87Opacity = [colorScheme.primaryColor colorWithAlphaComponent:0.87f];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f];
  UIColor *onSurface60Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.60f];

  XCTAssertEqualObjects(MDCTextInputControllerBase.activeColorDefault, colorScheme.primaryColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.errorColorDefault, colorScheme.errorColor);
  XCTAssertEqualObjects(MDCTextInputControllerBase.normalColorDefault, onSurface87Opacity);
  XCTAssertEqualObjects(MDCTextInputControllerBase.inlinePlaceholderColorDefault,
                        onSurface60Opacity);
  XCTAssertEqualObjects(MDCTextInputControllerBase.trailingUnderlineLabelTextColorDefault,
                        onSurface60Opacity);
  XCTAssertEqualObjects(MDCTextInputControllerBase.leadingUnderlineLabelTextColorDefault,
                        onSurface60Opacity);
  XCTAssertEqualObjects(MDCTextInputControllerBase.floatingPlaceholderNormalColorDefault,
                        onSurface60Opacity);
  XCTAssertEqualObjects(MDCTextInputControllerBase.floatingPlaceholderActiveColorDefault,
                        primary87Opacity);

  XCTAssertEqualObjects(MDCTextInputControllerFullWidth.errorColorDefault, colorScheme.errorColor);
  XCTAssertEqualObjects(MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault,
                        onSurface60Opacity);
  XCTAssertEqualObjects(MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault,
                        onSurface60Opacity);
}

- (void)testInstanceColorValuesAreSet {
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.primaryColor = [UIColor blueColor];
  colorScheme.errorColor = [UIColor yellowColor];
  colorScheme.onSurfaceColor = [UIColor greenColor];
  colorScheme.errorColor = [UIColor redColor];

  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f];
  UIColor *onSurface60Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.60f];
  
  MDCTextField *textField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  MDCTextField *baseTextField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  MDCTextField *fullWidthTextField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  MDCTextInputControllerBase *baseInputController =
      [[MDCTextInputControllerBase alloc] initWithTextInput:baseTextField];
  MDCTextInputControllerFullWidth *fullWidthInputController =
      [[MDCTextInputControllerFullWidth alloc] initWithTextInput:fullWidthTextField];


  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
                                        toTextInput:textField];
  XCTAssertEqualObjects(textField.cursorColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(textField.textColor, onSurface87Opacity);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor, onSurface60Opacity);
  XCTAssertEqualObjects(textField.trailingUnderlineLabel.textColor, onSurface60Opacity);
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.textColor, onSurface60Opacity);

  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
                              toTextInputController:baseInputController];
  XCTAssertEqualObjects(baseInputController.activeColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(baseInputController.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(baseInputController.normalColor, onSurface87Opacity);
  XCTAssertEqualObjects(baseInputController.inlinePlaceholderColor, onSurface60Opacity);
  XCTAssertEqualObjects(baseInputController.trailingUnderlineLabelTextColor, onSurface60Opacity);
  XCTAssertEqualObjects(baseInputController.leadingUnderlineLabelTextColor, onSurface60Opacity);

  [MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
                      toTextInputController:fullWidthInputController];
  XCTAssertEqualObjects(fullWidthInputController.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(fullWidthInputController.inlinePlaceholderColor, onSurface60Opacity);
  XCTAssertEqualObjects(fullWidthInputController.trailingUnderlineLabelTextColor,
                        onSurface60Opacity);
}

@end
