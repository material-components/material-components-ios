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

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "MaterialColorScheme.h"

static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [[UIColor alloc] initWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                                green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                                 blue:(CGFloat)((colorValue & 0xFF) / 255.0) alpha:1];
}

@interface MDCSemanticColorSchemeTests : XCTestCase
@end

@implementation MDCSemanticColorSchemeTests

- (void)testInitMatchesInitWithMaterialDefaults {
  // Given
  MDCSemanticColorScheme *initScheme = [[MDCSemanticColorScheme alloc] init];
  MDCSemanticColorScheme *mdDefaultScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // Then
  XCTAssertEqualObjects(initScheme.primaryColor, mdDefaultScheme.primaryColor);
  XCTAssertEqualObjects(initScheme.primaryColorVariant, mdDefaultScheme.primaryColorVariant);
  XCTAssertEqualObjects(initScheme.secondaryColor, mdDefaultScheme.secondaryColor);
  XCTAssertEqualObjects(initScheme.errorColor, mdDefaultScheme.errorColor);
  XCTAssertEqualObjects(initScheme.surfaceColor, mdDefaultScheme.surfaceColor);
  XCTAssertEqualObjects(initScheme.backgroundColor, mdDefaultScheme.backgroundColor);
  XCTAssertEqualObjects(initScheme.onPrimaryColor, mdDefaultScheme.onPrimaryColor);
  XCTAssertEqualObjects(initScheme.onSecondaryColor, mdDefaultScheme.onSecondaryColor);
  XCTAssertEqualObjects(initScheme.onSurfaceColor, mdDefaultScheme.onSurfaceColor);
  XCTAssertEqualObjects(initScheme.onBackgroundColor, mdDefaultScheme.onBackgroundColor);
}

- (void)testInitWithMaterialDefaults {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // Then
  XCTAssertEqualObjects(colorScheme.primaryColor, ColorFromRGB(0x6200EE));
  XCTAssertEqualObjects(colorScheme.primaryColorVariant, ColorFromRGB(0x3700B3));
  XCTAssertEqualObjects(colorScheme.secondaryColor, ColorFromRGB(0x03DAC6));
  XCTAssertEqualObjects(colorScheme.errorColor, ColorFromRGB(0xFF1744));
  XCTAssertEqualObjects(colorScheme.surfaceColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.backgroundColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.onPrimaryColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.onSecondaryColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onSurfaceColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onBackgroundColor, ColorFromRGB(0x000000));
}

- (void)testColorMergeForOpaqueColor {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
  UIColor *expectedColor =
      [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:1.0f];
  UIColor *resultColor =
      [MDCSemanticColorScheme blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testColorMergeFor50OpacityBlackOnWhite {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
  UIColor *expectedColor =
      [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
  UIColor *resultColor =
      [MDCSemanticColorScheme blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testColorMergeFor60GrayOpacityOnWhite {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor =
      [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:0.60f];
  UIColor *resultColor =
      [MDCSemanticColorScheme blendColor:blendColor withBackgroundColor:backgroundColor];
  UIColor *expectedColor =
      [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];

  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testColorMergeFor50OpacityWhiteOnBlack {
  UIColor *backgroundColor = [UIColor blackColor];
  UIColor *blendColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
  UIColor *expectedColor =
      [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
  UIColor *resultColor =
      [MDCSemanticColorScheme blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testBasicColorMergeTest {
  UIColor *backgroundColor =  [UIColor colorWithRed:0.4f green:0.6f blue:0.9f alpha:0.8f];
  UIColor *blendColor = [UIColor colorWithRed:0.1 green:0.8 blue:0.8 alpha:0.2f];
  UIColor *expectedColor =
      [UIColor colorWithRed:0.328571439f green:0.647619068f blue:0.876190483f alpha:0.840000033f];
  UIColor *resultColor =
      [MDCSemanticColorScheme blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testHBSColorMergeTest {
  UIColor *backgroundColor =  [UIColor colorWithHue:0.7f saturation:0.6f brightness:0.2f alpha:0.7f];
  UIColor *blendColor = [UIColor colorWithRed:0.3f green:0.3f blue:0.2f alpha:0.8f];
  UIColor *expectedColor =
      [UIColor colorWithRed:0.270808518f green:0.267234057f blue:0.200000003f alpha:0.939999997f];
  UIColor *resultColor =
      [MDCSemanticColorScheme blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testGrayScaleColorMergeTest {
  UIColor *backgroundColor =  [UIColor colorWithWhite:0.3f alpha:0.8f];
  UIColor *blendColor = [UIColor colorWithRed:0.9f green:0.82f blue:0.1f alpha:0.6f];
  UIColor *expectedColor =
      [UIColor colorWithRed:0.691304326f green:0.639130473f blue:0.169565216f alpha:0.9200000016f];
  UIColor *resultColor =
      [MDCSemanticColorScheme blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (BOOL)compareColorsWithFloatPrecisionFirstColor:(UIColor *)firstColor
                                      secondColor:(UIColor *)secondColor {
  CGFloat fRed = 0.0, fGreen = 0.0, fBlue = 0.0, fAlpha = 0.0;
  [firstColor getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
  CGFloat sRed = 0.0, sGreen = 0.0, sBlue = 0.0, sAlpha = 0.0;
  [secondColor getRed:&sRed green:&sGreen blue:&sBlue alpha:&sAlpha];

  return ((float)fRed == (float)sRed &&
          (float)(fGreen) == (float)(sGreen) &&
          (float)(fBlue) == (float)(sBlue) &&
          (float)(fAlpha) == (float)(sAlpha));
}

@end
