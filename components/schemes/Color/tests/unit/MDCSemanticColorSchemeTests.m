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

#import "MDCMath.h"
#import "MaterialColorScheme.h"

static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [[UIColor alloc] initWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                                green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                                 blue:(CGFloat)((colorValue & 0xFF) / 255.0)
                                alpha:1];
}

@interface MDCSemanticColorSchemeTests : XCTestCase
@end

@implementation MDCSemanticColorSchemeTests

- (void)testInitMatchesInitWithMaterialDefaults {
  // Given
  MDCSemanticColorScheme *initScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
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
  XCTAssertEqualObjects(initScheme.elevationOverlayColor, mdDefaultScheme.elevationOverlayColor);
  XCTAssertEqual(initScheme.elevationOverlayEnabledForDarkMode,
                 mdDefaultScheme.elevationOverlayEnabledForDarkMode);
}

- (void)testInitWithMaterialDefaults {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // Then
  XCTAssertEqualObjects(colorScheme.primaryColor, ColorFromRGB(0x6200EE));
  XCTAssertEqualObjects(colorScheme.primaryColorVariant, ColorFromRGB(0x3700B3));
  XCTAssertEqualObjects(colorScheme.secondaryColor, ColorFromRGB(0x03DAC6));
  XCTAssertEqualObjects(colorScheme.errorColor, ColorFromRGB(0xB00020));
  XCTAssertEqualObjects(colorScheme.surfaceColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.backgroundColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.onPrimaryColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.onSecondaryColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onSurfaceColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onBackgroundColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.elevationOverlayColor, ColorFromRGB(0x000000));
  XCTAssertEqual(colorScheme.elevationOverlayEnabledForDarkMode, NO);
}

- (void)testInitWithMaterialDefaultsDark {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterialDark201907];

  // Then
  XCTAssertEqualObjects(colorScheme.primaryColor, ColorFromRGB(0xBB86FC));
  XCTAssertEqualObjects(colorScheme.primaryColorVariant, ColorFromRGB(0x3700B3));
  XCTAssertEqualObjects(colorScheme.secondaryColor, ColorFromRGB(0x03DAC6));
  XCTAssertEqualObjects(colorScheme.errorColor, ColorFromRGB(0xCF6679));
  XCTAssertEqualObjects(colorScheme.surfaceColor, ColorFromRGB(0x121212));
  XCTAssertEqualObjects(colorScheme.backgroundColor, ColorFromRGB(0x121212));
  XCTAssertEqualObjects(colorScheme.onPrimaryColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onSecondaryColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onSurfaceColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.onBackgroundColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.elevationOverlayColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqual(colorScheme.elevationOverlayEnabledForDarkMode, YES);
}

- (void)testInitWithMaterialDefaults201907WhenUserInterfaceStyleIsDarkForiOS13 {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    MDCSemanticColorScheme *colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];

    // When
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];

    // Then
    XCTAssertEqualObjects(
        [colorScheme.primaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0xBB86FC));
    XCTAssertEqualObjects(
        [colorScheme.primaryColorVariant resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x3700B3));
    XCTAssertEqualObjects(
        [colorScheme.secondaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x03DAC6));
    XCTAssertEqualObjects([colorScheme.errorColor resolvedColorWithTraitCollection:traitCollection],
                          ColorFromRGB(0xCF6679));
    XCTAssertEqualObjects(
        [colorScheme.surfaceColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x121212));
    XCTAssertEqualObjects(
        [colorScheme.backgroundColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x121212));
    XCTAssertEqualObjects(
        [colorScheme.onPrimaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x000000));
    XCTAssertEqualObjects(
        [colorScheme.onSecondaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x000000));
    XCTAssertEqualObjects(
        [colorScheme.onSurfaceColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(
        [colorScheme.onBackgroundColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(
        [colorScheme.elevationOverlayColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0xFFFFFF));
    XCTAssertEqual(colorScheme.elevationOverlayEnabledForDarkMode, YES);
  }
#endif
}

- (void)testInitWithMaterialDefaults201907WhenUserInterfaceStyleIsLightForiOS13 {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    MDCSemanticColorScheme *colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];

    // When
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];

    // Then
    XCTAssertEqualObjects(
        [colorScheme.primaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x6200EE));
    XCTAssertEqualObjects(
        [colorScheme.primaryColorVariant resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x3700B3));
    XCTAssertEqualObjects(
        [colorScheme.secondaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x03DAC6));
    XCTAssertEqualObjects([colorScheme.errorColor resolvedColorWithTraitCollection:traitCollection],
                          ColorFromRGB(0xB00020));
    XCTAssertEqualObjects(
        [colorScheme.surfaceColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(
        [colorScheme.backgroundColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(
        [colorScheme.onPrimaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(
        [colorScheme.onSecondaryColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x000000));
    XCTAssertEqualObjects(
        [colorScheme.onSurfaceColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x000000));
    XCTAssertEqualObjects(
        [colorScheme.onBackgroundColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x000000));
    XCTAssertEqualObjects(
        [colorScheme.elevationOverlayColor resolvedColorWithTraitCollection:traitCollection],
        ColorFromRGB(0x000000));
    XCTAssertEqual(colorScheme.elevationOverlayEnabledForDarkMode, YES);
  }
#endif
}

- (void)testInitWithMaterialDefaults201907WhenUserInterfaceStyleIsLightForPreiOS13 {
  if (@available(iOS 13.0, *)) {
  } else {
    // Given
    MDCSemanticColorScheme *colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];

    // Then
    XCTAssertEqualObjects(colorScheme.primaryColor, ColorFromRGB(0x6200EE));
    XCTAssertEqualObjects(colorScheme.primaryColorVariant, ColorFromRGB(0x3700B3));
    XCTAssertEqualObjects(colorScheme.secondaryColor, ColorFromRGB(0x03DAC6));
    XCTAssertEqualObjects(colorScheme.errorColor, ColorFromRGB(0xB00020));
    XCTAssertEqualObjects(colorScheme.surfaceColor, ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(colorScheme.backgroundColor, ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(colorScheme.onPrimaryColor, ColorFromRGB(0xFFFFFF));
    XCTAssertEqualObjects(colorScheme.onSecondaryColor, ColorFromRGB(0x000000));
    XCTAssertEqualObjects(colorScheme.onSurfaceColor, ColorFromRGB(0x000000));
    XCTAssertEqualObjects(colorScheme.onBackgroundColor, ColorFromRGB(0x000000));
    XCTAssertEqualObjects(colorScheme.elevationOverlayColor, ColorFromRGB(0x000000));
    XCTAssertEqual(colorScheme.elevationOverlayEnabledForDarkMode, YES);
  }
}

- (void)testColorMergeForOpaqueColor {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
  UIColor *expectedColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
  UIColor *resultColor = [MDCSemanticColorScheme blendColor:blendColor
                                        withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testColorMergeFor50OpacityBlackOnWhite {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:(CGFloat)0.5];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.5
                                           green:(CGFloat)0.5
                                            blue:(CGFloat)0.5
                                           alpha:1];
  UIColor *resultColor = [MDCSemanticColorScheme blendColor:blendColor
                                        withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testColorMergeFor60GrayOpacityOnWhite {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithRed:(CGFloat)0.9
                                        green:(CGFloat)0.9
                                         blue:(CGFloat)0.9
                                        alpha:(CGFloat)0.6];
  UIColor *resultColor = [MDCSemanticColorScheme blendColor:blendColor
                                        withBackgroundColor:backgroundColor];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.94000000000000006
                                           green:(CGFloat)0.94000000000000006
                                            blue:(CGFloat)0.94000000000000006
                                           alpha:(CGFloat)1];

  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testColorMergeFor50OpacityWhiteOnBlack {
  UIColor *backgroundColor = [UIColor blackColor];
  UIColor *blendColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:(CGFloat)0.5];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.5
                                           green:(CGFloat)0.5
                                            blue:(CGFloat)0.5
                                           alpha:1];
  UIColor *resultColor = [MDCSemanticColorScheme blendColor:blendColor
                                        withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testBasicColorMergeTest {
  UIColor *backgroundColor = [UIColor colorWithRed:(CGFloat)0.4
                                             green:(CGFloat)0.6
                                              blue:(CGFloat)0.9
                                             alpha:(CGFloat)0.8];
  UIColor *blendColor = [UIColor colorWithRed:(CGFloat)0.1
                                        green:(CGFloat)0.8
                                         blue:(CGFloat)0.8
                                        alpha:(CGFloat)0.2];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.32857142857142863
                                           green:(CGFloat)0.64761904761904765
                                            blue:(CGFloat)0.87619047619047618
                                           alpha:(CGFloat)0.84000000000000008];
  UIColor *resultColor = [MDCSemanticColorScheme blendColor:blendColor
                                        withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testHBSColorMergeTest {
  UIColor *backgroundColor = [UIColor colorWithHue:(CGFloat)0.7
                                        saturation:(CGFloat)0.6
                                        brightness:(CGFloat)0.2
                                             alpha:(CGFloat)0.7];
  UIColor *blendColor = [UIColor colorWithRed:(CGFloat)0.3
                                        green:(CGFloat)0.3
                                         blue:(CGFloat)0.2
                                        alpha:(CGFloat)0.8];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.27080851063829786
                                           green:(CGFloat)0.2672340425531915
                                            blue:(CGFloat)0.20000000000000004
                                           alpha:(CGFloat)0.93999999999999994];
  UIColor *resultColor = [MDCSemanticColorScheme blendColor:blendColor
                                        withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testGrayScaleColorMergeTest {
  UIColor *backgroundColor = [UIColor colorWithWhite:(CGFloat)0.3 alpha:(CGFloat)0.8];
  UIColor *blendColor = [UIColor colorWithRed:(CGFloat)0.9
                                        green:(CGFloat)0.82
                                         blue:(CGFloat)0.1
                                        alpha:(CGFloat)0.6];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.69130434782608696
                                           green:(CGFloat)0.63913043478260867
                                            blue:(CGFloat)0.16956521739130434
                                           alpha:(CGFloat)0.92000000000000004];
  UIColor *resultColor = [MDCSemanticColorScheme blendColor:blendColor
                                        withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (BOOL)compareColorsWithFloatPrecisionFirstColor:(UIColor *)firstColor
                                      secondColor:(UIColor *)secondColor {
  CGFloat fRed = 0.0, fGreen = 0.0, fBlue = 0.0, fAlpha = 0.0;
  [firstColor getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
  CGFloat sRed = 0.0, sGreen = 0.0, sBlue = 0.0, sAlpha = 0.0;
  [secondColor getRed:&sRed green:&sGreen blue:&sBlue alpha:&sAlpha];

  return (MDCCGFloatEqual(fRed, sRed) && MDCCGFloatEqual(fGreen, sGreen) &&
          MDCCGFloatEqual(fBlue, sBlue) && MDCCGFloatEqual(fAlpha, sAlpha));
}

- (void)testColorSchemeCopy {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];

  // When
  MDCSemanticColorScheme *colorSchemeCopy = [colorScheme copy];

  // Then
  XCTAssertNotEqual(colorScheme, colorSchemeCopy);
  XCTAssertEqualObjects(colorScheme.primaryColor, colorSchemeCopy.primaryColor);
  XCTAssertEqualObjects(colorScheme.primaryColorVariant, colorSchemeCopy.primaryColorVariant);
  XCTAssertEqualObjects(colorScheme.secondaryColor, colorSchemeCopy.secondaryColor);
  XCTAssertEqualObjects(colorScheme.surfaceColor, colorSchemeCopy.surfaceColor);
  XCTAssertEqualObjects(colorScheme.backgroundColor, colorSchemeCopy.backgroundColor);
  XCTAssertEqualObjects(colorScheme.errorColor, colorSchemeCopy.errorColor);
  XCTAssertEqualObjects(colorScheme.onPrimaryColor, colorSchemeCopy.onPrimaryColor);
  XCTAssertEqualObjects(colorScheme.onSecondaryColor, colorSchemeCopy.onSecondaryColor);
  XCTAssertEqualObjects(colorScheme.onSurfaceColor, colorSchemeCopy.onSurfaceColor);
  XCTAssertEqualObjects(colorScheme.onBackgroundColor, colorSchemeCopy.onBackgroundColor);
}

@end
