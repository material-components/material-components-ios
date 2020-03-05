// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialContainerScheme.h"
#import "MaterialTextControls+OutlinedTextAreasTheming.h"

static const CGFloat kDisabledOpacity = (CGFloat)0.60;

static const CGFloat kTextColorNormalOpacity = (CGFloat)0.87;
static const CGFloat kFloatingLabelColorEditingOpacity = (CGFloat)0.87;
static const CGFloat kNormalLabelColorNormalOpacity = (CGFloat)0.60;
static const CGFloat kOutlineColorNormalOpacity = (CGFloat)0.38;

static const CGFloat kPrimaryFloatingLabelColorNormalOpacity = (CGFloat)0.60;
static const CGFloat kPrimaryAssistiveLabelColorNormalOpacity = (CGFloat)0.60;

@interface MDCOutlinedTextAreaThemingTest : XCTestCase
@property(nonatomic, strong) MDCOutlinedTextArea *textArea;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@end

@implementation MDCOutlinedTextAreaThemingTest

- (void)setUp {
  [super setUp];

  self.textArea = [[MDCOutlinedTextArea alloc] init];
  self.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
  self.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;
}

- (void)tearDown {
  self.textArea = nil;
  self.colorScheme = nil;
  self.typographyScheme = nil;
  self.containerScheme = nil;

  [super tearDown];
}

- (void)testTextAreaPrimaryThemingDefault {
  // When
  [self.textArea applyThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextAreaPrimaryTheming];
}

- (void)testTextAreaPrimaryThemingCustom {
  // Given
  self.colorScheme = [self customColorScheme];
  self.typographyScheme = [self customTypographyScheme];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;

  // When
  [self.textArea applyThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextAreaPrimaryTheming];
}

- (void)testTextAreaErrorThemingDefault {
  // When
  [self.textArea applyErrorThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextAreaErrorTheming];
}

- (void)testTextAreaErrorThemingCustom {
  // Given
  self.colorScheme = [self customColorScheme];
  self.typographyScheme = [self customTypographyScheme];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;

  // When
  [self.textArea applyErrorThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTextAreaErrorTheming];
}

#pragma mark - Test helpers

- (MDCSemanticColorScheme *)customColorScheme {
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];

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

- (void)verifyTextAreaPrimaryTheming {
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
  UIColor *floatingLabelColorEditing =
      [self.colorScheme.primaryColor colorWithAlphaComponent:kFloatingLabelColorEditingOpacity];
  UIColor *floatingLabelColorDisabled = [floatingLabelColorNormal
      colorWithAlphaComponent:kPrimaryFloatingLabelColorNormalOpacity * kDisabledOpacity];

  UIColor *normalLabelColorNormal =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kNormalLabelColorNormalOpacity];
  UIColor *normalLabelColorEditing = normalLabelColorNormal;
  UIColor *normalLabelColorDisabled = [normalLabelColorNormal
      colorWithAlphaComponent:kNormalLabelColorNormalOpacity * kDisabledOpacity];

  UIColor *outlineColorNormal =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kOutlineColorNormalOpacity];
  UIColor *outlineColorEditing = self.colorScheme.primaryColor;
  UIColor *outlineColorDisabled =
      [outlineColorNormal colorWithAlphaComponent:kOutlineColorNormalOpacity * kDisabledOpacity];

  UIColor *tintColor = self.colorScheme.primaryColor;

  XCTAssertEqualObjects([self.textArea floatingLabelColorForState:MDCTextControlStateNormal],
                        floatingLabelColorNormal);
  XCTAssertEqualObjects([self.textArea floatingLabelColorForState:MDCTextControlStateEditing],
                        floatingLabelColorEditing);
  XCTAssertEqualObjects([self.textArea floatingLabelColorForState:MDCTextControlStateDisabled],
                        floatingLabelColorDisabled);
  XCTAssertEqualObjects([self.textArea normalLabelColorForState:MDCTextControlStateNormal],
                        normalLabelColorNormal);
  XCTAssertEqualObjects([self.textArea normalLabelColorForState:MDCTextControlStateEditing],
                        normalLabelColorEditing);
  XCTAssertEqualObjects([self.textArea normalLabelColorForState:MDCTextControlStateDisabled],
                        normalLabelColorDisabled);
  XCTAssertEqualObjects([self.textArea textColorForState:MDCTextControlStateNormal],
                        textColorNormal);
  XCTAssertEqualObjects([self.textArea textColorForState:MDCTextControlStateEditing],
                        textColorEditing);
  XCTAssertEqualObjects([self.textArea textColorForState:MDCTextControlStateDisabled],
                        textColorDisabled);
  XCTAssertEqualObjects(
      [self.textArea leadingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textArea leadingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textArea leadingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects(
      [self.textArea trailingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textArea trailingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textArea trailingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects([self.textArea outlineColorForState:MDCTextControlStateNormal],
                        outlineColorNormal);
  XCTAssertEqualObjects([self.textArea outlineColorForState:MDCTextControlStateEditing],
                        outlineColorEditing);
  XCTAssertEqualObjects([self.textArea outlineColorForState:MDCTextControlStateDisabled],
                        outlineColorDisabled);
  XCTAssertEqualObjects(self.textArea.tintColor, tintColor);

  // Typography
  XCTAssertEqualObjects(self.textArea.textView.font, self.typographyScheme.subtitle1);
  XCTAssertEqualObjects(self.textArea.leadingAssistiveLabel.font, self.typographyScheme.caption);
  XCTAssertEqualObjects(self.textArea.trailingAssistiveLabel.font, self.typographyScheme.caption);
}

- (void)verifyTextAreaErrorTheming {
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

  UIColor *outlineColorNormal = self.colorScheme.errorColor;
  UIColor *outlineColorEditing = outlineColorNormal;
  UIColor *outlineColorDisabled = [outlineColorNormal colorWithAlphaComponent:kDisabledOpacity];

  UIColor *tintColor = self.colorScheme.errorColor;

  XCTAssertEqualObjects([self.textArea floatingLabelColorForState:MDCTextControlStateNormal],
                        floatingLabelColorNormal);
  XCTAssertEqualObjects([self.textArea floatingLabelColorForState:MDCTextControlStateEditing],
                        floatingLabelColorEditing);
  XCTAssertEqualObjects([self.textArea floatingLabelColorForState:MDCTextControlStateDisabled],
                        floatingLabelColorDisabled);
  XCTAssertEqualObjects([self.textArea normalLabelColorForState:MDCTextControlStateNormal],
                        normalLabelColorNormal);
  XCTAssertEqualObjects([self.textArea normalLabelColorForState:MDCTextControlStateEditing],
                        normalLabelColorEditing);
  XCTAssertEqualObjects([self.textArea normalLabelColorForState:MDCTextControlStateDisabled],
                        normalLabelColorDisabled);
  XCTAssertEqualObjects([self.textArea textColorForState:MDCTextControlStateNormal],
                        textColorNormal);
  XCTAssertEqualObjects([self.textArea textColorForState:MDCTextControlStateEditing],
                        textColorEditing);
  XCTAssertEqualObjects([self.textArea textColorForState:MDCTextControlStateDisabled],
                        textColorDisabled);
  XCTAssertEqualObjects(
      [self.textArea leadingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textArea leadingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textArea leadingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects(
      [self.textArea trailingAssistiveLabelColorForState:MDCTextControlStateNormal],
      assistiveLabelColorNormal);
  XCTAssertEqualObjects(
      [self.textArea trailingAssistiveLabelColorForState:MDCTextControlStateEditing],
      assistiveLabelColorEditing);
  XCTAssertEqualObjects(
      [self.textArea trailingAssistiveLabelColorForState:MDCTextControlStateDisabled],
      assistiveLabelColorDisabled);
  XCTAssertEqualObjects([self.textArea outlineColorForState:MDCTextControlStateNormal],
                        outlineColorNormal);
  XCTAssertEqualObjects([self.textArea outlineColorForState:MDCTextControlStateEditing],
                        outlineColorEditing);
  XCTAssertEqualObjects([self.textArea outlineColorForState:MDCTextControlStateDisabled],
                        outlineColorDisabled);
  XCTAssertEqualObjects(self.textArea.tintColor, tintColor);

  // Typography
  XCTAssertEqualObjects(self.textArea.textView.font, self.typographyScheme.subtitle1);
  XCTAssertEqualObjects(self.textArea.leadingAssistiveLabel.font, self.typographyScheme.caption);
  XCTAssertEqualObjects(self.textArea.trailingAssistiveLabel.font, self.typographyScheme.caption);
}

@end
