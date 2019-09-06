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

#import "MaterialElevation.h"
#import "UIColor+MaterialDynamic.h"

/** Returns a generated image of the given color and bounds. */
static UIImage *fakeImageWithColorAndSize(UIColor *color, CGRect bounds) {
  UIGraphicsBeginImageContext(bounds.size);
  [color setFill];
  UIRectFill(bounds);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MaterialElevationColorTests : XCTestCase

@property(nonatomic, readwrite) UIColor *rgbColor;
@property(nonatomic, readwrite) UIColor *greyScaleColor;
@property(nonatomic, readwrite) UIColor *p3DisplayColor;
@property(nonatomic, readwrite) UIColor *patternColor;

@end

@implementation MaterialElevationColorTests

- (void)setUp {
  [super setUp];

  self.rgbColor = [UIColor colorWithRed:0.9f
                                  green:0.8f
                                   blue:0.6f
                                  alpha:0.6f];
  self.greyScaleColor = [UIColor colorWithWhite:0.8f alpha:0.6f];
  if (@available(iOS 10.0, *)) {
    self.p3DisplayColor = [UIColor colorWithDisplayP3Red:0.8f
                                                   green:0.7f
                                                    blue:0.5f
                                                   alpha:0.4f];
  } else {
    self.p3DisplayColor = nil;
  }
  UIImage *patternImage = fakeImageWithColorAndSize(UIColor.blueColor, CGRectMake(0, 0, 100, 100));
  self.patternColor = [UIColor colorWithPatternImage:patternImage];
}

- (void)tearDown {
  self.rgbColor = nil;
  self.greyScaleColor = nil;
  self.p3DisplayColor = nil;
  self.patternColor = nil;

  [super tearDown];
}

- (void)testResolvedColorWithZeroElevation {
  // Given
  CGFloat elevation = 0.f;

  // When
  UIColor *resolvedRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedGreyScaleColor = [self.greyScaleColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedP3DisplayColor = [self.p3DisplayColor mdc_resolvedColorWithElevation:elevation];

  // Then
  UIColor *expectedRGBColor = self.rgbColor;
  UIColor *expectedGreyScaleColor = self.greyScaleColor;
  UIColor *expectedP3Display = self.p3DisplayColor;
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedRGBColor
                                          secondColor:expectedRGBColor];
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedGreyScaleColor
                                          secondColor:expectedGreyScaleColor];
  if (@available(iOS 10.0, *)) {
    [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedP3DisplayColor
                                            secondColor:expectedP3Display];
  }
}

- (void)testResolvedColorWithLowElevation {
  // Given
  CGFloat elevation = 10.f;

  // When
  UIColor *resolvedRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedGreyScaleColor = [self.greyScaleColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedP3DisplayColor = [self.p3DisplayColor mdc_resolvedColorWithElevation:elevation];

  // Then
  UIColor *expectedRGBColor = [UIColor colorWithRed:0.91964261807423053f
                                              green:0.83928523614846129f
                                               blue:0.67857047229692247f
                                              alpha:0.65116211491037057f];
  ;
  UIColor *expectedGreyScaleColor = [UIColor colorWithRed:0.83928523614846129f
                                                    green:0.83928523614846129f
                                                     blue:0.83928523614846129f
                                                    alpha:0.65116211491037057f];
  ;
  UIColor *expectedP3Display = [UIColor colorWithRed:0.86849367970437186f
                                               green:0.77713910118968843f
                                                blue:0.61272176809458923f
                                               alpha:0.47674317236555602f];
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedRGBColor
                                          secondColor:expectedRGBColor];
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedGreyScaleColor
                                          secondColor:expectedGreyScaleColor];
  if (@available(iOS 10.0, *)) {
    [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedP3DisplayColor
                                            secondColor:expectedP3Display];
  }
}

- (void)testResolvedColorWithHighElevation {
  // Given
  CGFloat elevation = 10000.f;

  // When
  UIColor *resolvedRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedGreyScaleColor = [self.greyScaleColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedP3DisplayColor = [self.p3DisplayColor mdc_resolvedColorWithElevation:elevation];

  // Then
  UIColor *expectedRGBColor = [UIColor colorWithRed:0.95614843571155961f
                                              green:0.91229687142311943f
                                               blue:0.82459374284623876f
                                              alpha:0.77378792660557727f];
  ;
  UIColor *expectedGreyScaleColor = [UIColor colorWithRed:0.91229687142311943f
                                                    green:0.91229687142311943f
                                                     blue:0.91229687142311943f
                                                    alpha:0.77378792660557727f];
  ;
  UIColor *expectedP3Display = [UIColor colorWithRed:0.9384637763413608f
                                               green:0.89571590108272103f
                                                blue:0.81877950928077237f
                                               alpha:0.66068188990836596f];
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedRGBColor
                                          secondColor:expectedRGBColor];
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedGreyScaleColor
                                          secondColor:expectedGreyScaleColor];
  if (@available(iOS 10.0, *)) {
    [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedP3DisplayColor
                                            secondColor:expectedP3Display];
  }
}

- (void)testResolvedColorWithNegativeElevation {
  // Given
  CGFloat elevation = (CGFloat)-10;

  // When
  UIColor *resolvedRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedGreyScaleColor = [self.greyScaleColor mdc_resolvedColorWithElevation:elevation];
  UIColor *resolvedP3DisplayColor = [self.p3DisplayColor mdc_resolvedColorWithElevation:elevation];

  // Then
  UIColor *expectedRGBColor = self.rgbColor;
  UIColor *expectedGreyScaleColor = self.greyScaleColor;
  UIColor *expectedP3Display = self.p3DisplayColor;
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedRGBColor
                                          secondColor:expectedRGBColor];
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedGreyScaleColor
                                          secondColor:expectedGreyScaleColor];
  if (@available(iOS 10.0, *)) {
    [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedP3DisplayColor
                                            secondColor:expectedP3Display];
  }
}

- (void)testResolvedColorWithElevationForDynamicColorOniOS13AndAbove {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    CGFloat elevation = 10.f;
    UIColor *darkColor = UIColor.blackColor;
    UIColor *lightColor = UIColor.whiteColor;
    UIColor *dynamicColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkColor
                                                             defaultColor:lightColor];

    // When
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UIColor *resolvedColor = [dynamicColor mdc_resolvedColorWithTraitCollection:traitCollection
                                                                      elevation:elevation];

    // Then
    UIColor *expectedColor = [darkColor mdc_resolvedColorWithElevation:elevation];
    [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedColor secondColor:expectedColor];
  }
#endif
}

- (void)testResolvedColorWithElevationForStaticColorOniOS13AndAbove {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    CGFloat elevation = 10.f;
    UIColor *staticColor = UIColor.blackColor;

    // When
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UIColor *resolvedColor = [staticColor mdc_resolvedColorWithTraitCollection:traitCollection
                                                                     elevation:elevation];

    // Then
    UIColor *expectedColor = [staticColor mdc_resolvedColorWithElevation:elevation];
    [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedColor secondColor:expectedColor];
  }
#endif
}

- (void)testResolvedColorWithElevationForStaticColorOnPreiOS13 {
  if (@available(iOS 13.0, *)) {
  } else {
    // Given
    CGFloat elevation = 10.f;
    UIColor *staticColor = UIColor.blackColor;
    UITraitCollection *traitCollection = [[UITraitCollection alloc] init];

    // When
    UIColor *color = [staticColor mdc_resolvedColorWithTraitCollection:traitCollection
                                                             elevation:elevation];

    // Then
    [self assertEqualColorsWithFloatPrecisionFirstColor:color secondColor:staticColor];
  }
}

- (void)testResolvedColorWithElevationForPatternBasedColorThrowException {
  // Given
  CGFloat elevation = 10.f;

  // When/Then
  XCTAssertThrowsSpecificNamed(
      [self.patternColor mdc_resolvedColorWithElevation:elevation], NSException, NSGenericException,
      @"Expected exception when resolving a Pattern-Based color with elevation");
}

- (void)assertEqualColorsWithFloatPrecisionFirstColor:(UIColor *)firstColor
                                          secondColor:(UIColor *)secondColor {
  CGFloat fRed = 0.0, fGreen = 0.0, fBlue = 0.0, fAlpha = 0.0;
  [firstColor getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
  CGFloat sRed = 0.0, sGreen = 0.0, sBlue = 0.0, sAlpha = 0.0;
  [secondColor getRed:&sRed green:&sGreen blue:&sBlue alpha:&sAlpha];

  XCTAssertEqualWithAccuracy(fRed, sRed, 0.001, @"(%@) is not equal to (%@)", firstColor,
                             secondColor);
  XCTAssertEqualWithAccuracy(fGreen, sGreen, 0.001, @"(%@) is not equal to (%@)", firstColor,
                             secondColor);
  XCTAssertEqualWithAccuracy(fBlue, sBlue, 0.001, @"(%@) is not equal to (%@)", firstColor,
                             secondColor);
  XCTAssertEqualWithAccuracy(fAlpha, sAlpha, 0.001, @"(%@) is not equal to (%@)", firstColor,
                             secondColor);
}

- (void)testSmoothJumpBetweenElevationToAlphaForValuesCloseToZero {
  // Given
  CGFloat firstElevation = 0.01f;
  CGFloat secondElevation = 0.f;

  // When
  UIColor *resolvedFirstRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:firstElevation];
  UIColor *resolvedSecondRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:secondElevation];

  // Then
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedFirstRGBColor
                                          secondColor:resolvedSecondRGBColor];
}

- (void)testSmoothJumpBetweenElevationToAlphaForValuesCloseToOne {
  // Given
  CGFloat firstElevation = 0.99f;
  CGFloat secondElevation = 1.f;

  // When
  UIColor *resolvedFirstRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:firstElevation];
  UIColor *resolvedSecondRGBColor = [self.rgbColor mdc_resolvedColorWithElevation:secondElevation];

  // Then
  [self assertEqualColorsWithFloatPrecisionFirstColor:resolvedFirstRGBColor
                                          secondColor:resolvedSecondRGBColor];
}

- (void)testResolvingColorWithSameCurrentTraitCollectionAndPreviousTraitCollection {
  if (@available(iOS 13.0, *)) {
    // Given
    CGFloat elevation = 10.f;
    UIColor *darkColor = UIColor.blackColor;
    UIColor *lightColor = UIColor.whiteColor;
    UIColor *dynamicColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkColor
                                                             defaultColor:lightColor];

    // When
    UITraitCollection *previousTraitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UITraitCollection *currentTraitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UIColor *resolvedColor =
        [dynamicColor mdc_resolvedColorWithTraitCollection:currentTraitCollection
                                   previousTraitCollection:previousTraitCollection
                                                 elevation:elevation];
    // Then
    XCTAssertEqualObjects(resolvedColor, dynamicColor);
  }
}

- (void)testResolvingColorWithDifferenceCurrentTraitCollectionAndPreviousTraitCollection {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    CGFloat elevation = 10.f;
    UIColor *darkColor = UIColor.blackColor;
    UIColor *lightColor = UIColor.whiteColor;
    UIColor *dynamicColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkColor
                                                             defaultColor:lightColor];

    // When
    UITraitCollection *previousTraitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UITraitCollection *currentTraitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
    UIColor *resolvedColor =
        [dynamicColor mdc_resolvedColorWithTraitCollection:currentTraitCollection
                                   previousTraitCollection:previousTraitCollection
                                                 elevation:elevation];
    // Then
    XCTAssertNotEqual(resolvedColor, dynamicColor);
    UIColor *expectedColor =
        [dynamicColor mdc_resolvedColorWithTraitCollection:currentTraitCollection
                                                 elevation:elevation];
    XCTAssertEqual(resolvedColor, expectedColor);
  }
#endif
}

@end
