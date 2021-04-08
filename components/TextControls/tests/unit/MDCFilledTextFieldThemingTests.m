// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialTextControls+Enums.h"
#import "MaterialTextControls+FilledTextFields.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTextControls+FilledTextFieldsTheming.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kDisabledOpacity = (CGFloat)0.60;

static const CGFloat kFilledSublayerFillColorNormalOpacity = (CGFloat)0.12;
static const CGFloat kTextColorNormalOpacity = (CGFloat)0.87;
static const CGFloat kNormalLabelColorNormalOpacity = (CGFloat)0.60;

static const CGFloat kPrimaryAssistiveLabelColorNormalOpacity = (CGFloat)0.60;
static const CGFloat kPrimaryFloatingLabelColorNormalOpacity = (CGFloat)0.60;
static const CGFloat kPrimaryFloatingLabelColorEditingOpacity = (CGFloat)0.87;
static const CGFloat kPrimaryUnderlineColorNormalOpacity = (CGFloat)0.42;

@interface MDCFilledTextFieldThemingTest : XCTestCase
@property(nonatomic, strong) MDCFilledTextField *textField;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@end

@implementation MDCFilledTextFieldThemingTest

- (void)setUp {
  [super setUp];

  self.textField = [[MDCFilledTextField alloc] init];
  self.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
  self.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;
}

- (void)tearDown {
  self.textField = nil;
  self.colorScheme = nil;
  self.typographyScheme = nil;
  self.containerScheme = nil;

  [super tearDown];
}

- (void)testTextFieldPrimaryThemingDefault {
  // When
  [self.textField applyThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextFieldPrimaryTheming];
}

- (void)testTextFieldPrimaryThemingCustom {
  // Given
  self.colorScheme = [self customColorScheme];
  self.typographyScheme = [self customTypographyScheme];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;

  // When
  [self.textField applyThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextFieldPrimaryTheming];
}

- (void)testTextFieldErrorThemingDefault {
  // When
  [self.textField applyErrorThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextFieldErrorTheming];
}

- (void)testTextFieldErrorThemingCustom {
  // Given
  self.colorScheme = [self customColorScheme];
  self.typographyScheme = [self customTypographyScheme];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;

  // When
  [self.textField applyErrorThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextFieldErrorTheming];
}

#pragma mark - Test helpers

- (MDCSemanticColorScheme *)customColorScheme {
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  colorScheme.primaryColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:0];
  colorScheme.primaryColorVariant = [UIColor colorWithWhite:(CGFloat)0.8 alpha:(CGFloat)0.1];
  colorScheme.secondaryColor = [UIColor colorWithWhite:(CGFloat)0.7 alpha:(CGFloat)0.2];
  colorScheme.errorColor = [UIColor colorWithWhite:(CGFloat)0.6 alpha:(CGFloat)0.3];
  colorScheme.surfaceColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:(CGFloat)0.4];
  colorScheme.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.4 alpha:(CGFloat)0.5];
  colorScheme.onPrimaryColor = [UIColor colorWithWhite:(CGFloat)0.3 alpha:(CGFloat)0.6];
  colorScheme.onSecondaryColor = [UIColor colorWithWhite:(CGFloat)0.2 alpha:(CGFloat)0.7];
  colorScheme.onSurfaceColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:(CGFloat)0.8];
  colorScheme.onBackgroundColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.9];

  return colorScheme;
}

- (MDCTypographyScheme *)customTypographyScheme {
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];

  typographyScheme.headline1 = [UIFont systemFontOfSize:1];
  typographyScheme.headline2 = [UIFont systemFontOfSize:2];
  typographyScheme.headline3 = [UIFont systemFontOfSize:3];
  typographyScheme.headline4 = [UIFont systemFontOfSize:4];
  typographyScheme.headline5 = [UIFont systemFontOfSize:5];
  typographyScheme.headline6 = [UIFont systemFontOfSize:6];
  typographyScheme.subtitle1 = [UIFont systemFontOfSize:7];
  typographyScheme.subtitle2 = [UIFont systemFontOfSize:8];
  typographyScheme.body1 = [UIFont systemFontOfSize:9];
  typographyScheme.body2 = [UIFont systemFontOfSize:10];
  typographyScheme.caption = [UIFont systemFontOfSize:11];
  typographyScheme.button = [UIFont systemFontOfSize:12];
  typographyScheme.overline = [UIFont systemFontOfSize:13];

  return typographyScheme;
}

- (void)verifyTextFieldPrimaryTheming {
  // Color
  UIColor *textColorNormal =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kTextColorNormalOpacity];
  UIColor *textColorEditing = textColorNormal;
  UIColor *textColorDisabled =
      [textColorNormal colorWithAlphaComponent:kTextColorNormalOpacity * kDisabledOpacity];

  UIColor *assistiveLabelColorNormal = [self.colorScheme.onSurfaceColor
      colorWithAlphaComponent:kPrimaryAssistiveLabelColorNormalOpacity];
  UIColor *assistiveLabelColorEditing = assistiveLabelColorNormal;
  UIColor *assistiveLabelColorDisabled = [assistiveLabelColorNormal
      colorWithAlphaComponent:kPrimaryAssistiveLabelColorNormalOpacity * kDisabledOpacity];

  UIColor *floatingLabelColorNormal = [self.colorScheme.onSurfaceColor
      colorWithAlphaComponent:kPrimaryFloatingLabelColorNormalOpacity];
  UIColor *floatingLabelColorEditing = [self.colorScheme.primaryColor
      colorWithAlphaComponent:kPrimaryFloatingLabelColorEditingOpacity];
  UIColor *floatingLabelColorDisabled = [floatingLabelColorNormal
      colorWithAlphaComponent:kPrimaryFloatingLabelColorNormalOpacity * kDisabledOpacity];

  UIColor *normalLabelColorNormal =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kNormalLabelColorNormalOpacity];
  UIColor *normalLabelColorEditing = normalLabelColorNormal;
  UIColor *normalLabelColorDisabled = [normalLabelColorNormal
      colorWithAlphaComponent:kNormalLabelColorNormalOpacity * kDisabledOpacity];

  UIColor *underlineColorNormal =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kPrimaryUnderlineColorNormalOpacity];
  UIColor *underlineColorEditing = self.colorScheme.primaryColor;
  UIColor *underlineColorDisabled = [underlineColorNormal
      colorWithAlphaComponent:kPrimaryUnderlineColorNormalOpacity * kDisabledOpacity];

  UIColor *filledSublayerFillColorNormal = [self.colorScheme.onSurfaceColor
      colorWithAlphaComponent:kFilledSublayerFillColorNormalOpacity];
  UIColor *filledSublayerFillColorEditing = filledSublayerFillColorNormal;
  UIColor *filledSublayerFillColorDisabled = [filledSublayerFillColorNormal
      colorWithAlphaComponent:kFilledSublayerFillColorNormalOpacity * kDisabledOpacity];

  UIColor *tintColor = self.colorScheme.primaryColor;

  XCTAssertEqualObjects([self.textField floatingLabelColorForState:MDCTextControlStateNormal],
                        floatingLabelColorNormal);
  XCTAssertEqualObjects([self.textField floatingLabelColorForState:MDCTextControlStateEditing],
                        floatingLabelColorEditing);
  XCTAssertEqualObjects([self.textField floatingLabelColorForState:MDCTextControlStateDisabled],
                        floatingLabelColorDisabled);
  XCTAssertEqualObjects([self.textField normalLabelColorForState:MDCTextControlStateNormal],
                        normalLabelColorNormal);
  XCTAssertEqualObjects([self.textField normalLabelColorForState:MDCTextControlStateEditing],
                        normalLabelColorEditing);
  XCTAssertEqualObjects([self.textField normalLabelColorForState:MDCTextControlStateDisabled],
                        normalLabelColorDisabled);
  XCTAssertEqualObjects([self.textField textColorForState:MDCTextControlStateNormal],
                        textColorNormal);
  XCTAssertEqualObjects([self.textField textColorForState:MDCTextControlStateEditing],
                        textColorEditing);
  XCTAssertEqualObjects([self.textField textColorForState:MDCTextControlStateDisabled],
                        textColorDisabled);
  XCTAssertEqualObjects(
      [self.textField leadingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textField leadingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textField leadingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects(
      [self.textField trailingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textField trailingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textField trailingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects([self.textField underlineColorForState:MDCTextControlStateNormal],
                        underlineColorNormal);
  XCTAssertEqualObjects([self.textField underlineColorForState:MDCTextControlStateEditing],
                        underlineColorEditing);
  XCTAssertEqualObjects([self.textField underlineColorForState:MDCTextControlStateDisabled],
                        underlineColorDisabled);
  XCTAssertEqualObjects([self.textField filledBackgroundColorForState:MDCTextControlStateNormal],
                        filledSublayerFillColorNormal);
  XCTAssertEqualObjects([self.textField filledBackgroundColorForState:MDCTextControlStateEditing],
                        filledSublayerFillColorEditing);
  XCTAssertEqualObjects([self.textField filledBackgroundColorForState:MDCTextControlStateDisabled],
                        filledSublayerFillColorDisabled);
  XCTAssertEqualObjects(self.textField.tintColor, tintColor);

  // Typography
  XCTAssertEqualObjects(self.textField.font, self.typographyScheme.subtitle1);
  XCTAssertEqualObjects(self.textField.leadingAssistiveLabel.font, self.typographyScheme.caption);
  XCTAssertEqualObjects(self.textField.trailingAssistiveLabel.font, self.typographyScheme.caption);
}

- (void)verifyTextFieldErrorTheming {
  // Color
  UIColor *textColorNormal =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kTextColorNormalOpacity];
  UIColor *textColorEditing = textColorNormal;
  UIColor *textColorDisabled =
      [textColorNormal colorWithAlphaComponent:kTextColorNormalOpacity * kDisabledOpacity];

  UIColor *assistiveLabelColorNormal = self.colorScheme.errorColor;
  UIColor *assistiveLabelColorEditing = assistiveLabelColorNormal;
  UIColor *assistiveLabelColorDisabled =
      [assistiveLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *floatingLabelColorNormal = self.colorScheme.errorColor;
  UIColor *floatingLabelColorEditing = floatingLabelColorNormal;
  UIColor *floatingLabelColorDisabled =
      [floatingLabelColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *normalLabelColorNormal =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kNormalLabelColorNormalOpacity];
  UIColor *normalLabelColorEditing = normalLabelColorNormal;
  UIColor *normalLabelColorDisabled = [normalLabelColorNormal
      colorWithAlphaComponent:kNormalLabelColorNormalOpacity * kDisabledOpacity];

  UIColor *underlineColorNormal = self.colorScheme.errorColor;
  UIColor *underlineColorEditing = underlineColorNormal;
  UIColor *underlineColorDisabled = [underlineColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *filledSublayerFillColorNormal = [self.colorScheme.onSurfaceColor
      colorWithAlphaComponent:kFilledSublayerFillColorNormalOpacity];
  UIColor *filledSublayerFillColorEditing = filledSublayerFillColorNormal;
  UIColor *filledSublayerFillColorDisabled = [filledSublayerFillColorNormal
      colorWithAlphaComponent:kFilledSublayerFillColorNormalOpacity * kDisabledOpacity];

  UIColor *tintColor = self.colorScheme.errorColor;

  XCTAssertEqualObjects([self.textField floatingLabelColorForState:MDCTextControlStateNormal],
                        floatingLabelColorNormal);
  XCTAssertEqualObjects([self.textField floatingLabelColorForState:MDCTextControlStateEditing],
                        floatingLabelColorEditing);
  XCTAssertEqualObjects([self.textField floatingLabelColorForState:MDCTextControlStateDisabled],
                        floatingLabelColorDisabled);
  XCTAssertEqualObjects([self.textField normalLabelColorForState:MDCTextControlStateNormal],
                        normalLabelColorNormal);
  XCTAssertEqualObjects([self.textField normalLabelColorForState:MDCTextControlStateEditing],
                        normalLabelColorEditing);
  XCTAssertEqualObjects([self.textField normalLabelColorForState:MDCTextControlStateDisabled],
                        normalLabelColorDisabled);
  XCTAssertEqualObjects([self.textField textColorForState:MDCTextControlStateNormal],
                        textColorNormal);
  XCTAssertEqualObjects([self.textField textColorForState:MDCTextControlStateEditing],
                        textColorEditing);
  XCTAssertEqualObjects([self.textField textColorForState:MDCTextControlStateDisabled],
                        textColorDisabled);
  XCTAssertEqualObjects(
      [self.textField leadingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textField leadingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textField leadingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects(
      [self.textField trailingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textField trailingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textField trailingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects([self.textField underlineColorForState:MDCTextControlStateNormal],
                        underlineColorNormal);
  XCTAssertEqualObjects([self.textField underlineColorForState:MDCTextControlStateEditing],
                        underlineColorEditing);
  XCTAssertEqualObjects([self.textField underlineColorForState:MDCTextControlStateDisabled],
                        underlineColorDisabled);
  XCTAssertEqualObjects([self.textField filledBackgroundColorForState:MDCTextControlStateNormal],
                        filledSublayerFillColorNormal);
  XCTAssertEqualObjects([self.textField filledBackgroundColorForState:MDCTextControlStateEditing],
                        filledSublayerFillColorEditing);
  XCTAssertEqualObjects([self.textField filledBackgroundColorForState:MDCTextControlStateDisabled],
                        filledSublayerFillColorDisabled);
  XCTAssertEqualObjects(self.textField.tintColor, tintColor);

  // Typography
  XCTAssertEqualObjects(self.textField.font, self.typographyScheme.subtitle1);
  XCTAssertEqualObjects(self.textField.leadingAssistiveLabel.font, self.typographyScheme.caption);
  XCTAssertEqualObjects(self.textField.trailingAssistiveLabel.font, self.typographyScheme.caption);
}

@end
