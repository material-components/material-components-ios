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
#import "MaterialMath.h"
#import "UIColor+MaterialDynamic.h"

@interface MaterialElevationColorTests : XCTestCase

@end

@implementation MaterialElevationColorTests

- (void)testResolvedColorWithElevation {
  // Given
  CGFloat elevation = (CGFloat)10;
  UIColor *color = UIColor.blackColor;

  // When
  UIColor *resolvedColor = [color resolvedColorWithElevation:elevation];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.1279052872759267
                                           green:(CGFloat)0.1279052872759267
                                            blue:(CGFloat)0.1279052872759267
                                           alpha:(CGFloat)1];

  // Then
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resolvedColor
                                                    secondColor:expectedColor]);
}

- (void)testResolvedColorWithElevationForDynamicColorOniOS13AndAbove {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    CGFloat elevation = (CGFloat)10;
    UIColor *darkColor = UIColor.blackColor;
    UIColor *lightColor = UIColor.whiteColor;
    UIColor *dynamicColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkColor
                                                             defaultColor:lightColor];

    // When
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UIColor *resolvedColor = [dynamicColor resolvedColorWithTraitCollection:traitCollection
                                                                  elevation:elevation];

    // Then
    UIColor *expectedColor = [darkColor resolvedColorWithElevation:elevation];
    XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resolvedColor
                                                      secondColor:expectedColor]);
  }
#endif
}

- (void)testResolvedColorWithElevationForStaticColorOniOS13AndAbove {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    CGFloat elevation = (CGFloat)10;
    UIColor *staticColor = UIColor.blackColor;

    // When
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UIColor *resolvedColor = [staticColor resolvedColorWithTraitCollection:traitCollection
                                                                 elevation:elevation];

    // Then
    UIColor *expectedColor = [staticColor resolvedColorWithElevation:elevation];
    XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resolvedColor
                                                      secondColor:expectedColor]);
  }
#endif
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

@end
