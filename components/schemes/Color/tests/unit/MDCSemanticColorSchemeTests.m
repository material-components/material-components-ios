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
- (BOOL)compareColorsWithFloatPrecisionFirstColor:(UIColor *)firstColor
                                      secondColor:(UIColor *)secondColor {
  CGFloat fRed = 0.0, fGreen = 0.0, fBlue = 0.0, fAlpha = 0.0;
  [firstColor getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
  CGFloat sRed = 0.0, sGreen = 0.0, sBlue = 0.0, sAlpha = 0.0;
  [secondColor getRed:&sRed green:&sGreen blue:&sBlue alpha:&sAlpha];
  return (roundf(fRed) == roundf(sRed) &&
          roundf(fGreen) == roundf(sGreen) &&
          roundf(fBlue) == roundf(sBlue) &&
          roundf(fAlpha) == roundf(sAlpha));
}

@end
