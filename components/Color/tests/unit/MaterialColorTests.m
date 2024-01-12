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

#import "UIColor+MaterialBlending.h"
#import "MDCMath.h"

/** Returns a generated image of the given color and bounds. */
static UIImage *fakeImageWithColorAndSize(UIColor *color, CGRect bounds) {
  UIGraphicsBeginImageContext(bounds.size);
  [color setFill];
  UIRectFill(bounds);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MaterialColorTests : XCTestCase
@end

@implementation MaterialColorTests

- (void)testColorMergeForOpaqueColor {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithWhite:0 alpha:1.0];
  UIColor *expectedColor = [UIColor colorWithWhite:0 alpha:1];
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testColorMergeFor50OpacityBlackOnWhite {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.5];
  UIColor *expectedColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:1];
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertEqualObjects(resultColor, expectedColor);
}

- (void)testColorMergeFor60GrayOpacityOnWhite {
  UIColor *backgroundColor = [UIColor whiteColor];
  UIColor *blendColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:(CGFloat)0.6];
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
  UIColor *expectedColor = [UIColor colorWithWhite:(CGFloat)0.94000000000000006 alpha:(CGFloat)1];

  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testColorMergeFor50OpacityWhiteOnBlack {
  UIColor *backgroundColor = [UIColor blackColor];
  UIColor *blendColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.5];
  UIColor *expectedColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:1];
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
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
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
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
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
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
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testClearColorMergeTest {
  UIColor *backgroundColor = UIColor.clearColor;
  UIColor *blendColor = UIColor.clearColor;
  UIColor *expectedColor = UIColor.clearColor;
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testP3ColorMergeTest {
  UIColor *backgroundColor = [UIColor colorWithWhite:(CGFloat)0.3 alpha:(CGFloat)0.8];
  UIColor *blendColor = [UIColor colorWithRed:(CGFloat)0.9
                                        green:(CGFloat)0.82
                                         blue:(CGFloat)0.1
                                        alpha:(CGFloat)0.6];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.69130434782608696
                                           green:(CGFloat)0.63913043478260867
                                            blue:(CGFloat)0.16956521739130434
                                           alpha:(CGFloat)0.92000000000000004];
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
  XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:resultColor
                                                    secondColor:expectedColor]);
}

- (void)testColorWithPatternImageMergeTest {
  UIColor *backgroundColor = [UIColor colorWithHue:(CGFloat)0.7
                                        saturation:(CGFloat)0.6
                                        brightness:(CGFloat)0.2
                                             alpha:(CGFloat)0.7];
  UIColor *imageColor = [UIColor colorWithRed:(CGFloat)0.3
                                        green:(CGFloat)0.3
                                         blue:(CGFloat)0.2
                                        alpha:(CGFloat)0.8];
  UIImage *fakeImage = fakeImageWithColorAndSize(imageColor, CGRectMake(0, 0, 100, 100));
  UIColor *blendColor = [UIColor colorWithPatternImage:fakeImage];
  UIColor *expectedColor = [UIColor colorWithRed:(CGFloat)0.10399999999999993
                                           green:(CGFloat)0.080000000000000016
                                            blue:(CGFloat)0.19999999999999998
                                           alpha:(CGFloat)0.69999999999999996];
  UIColor *resultColor = [UIColor mdc_blendColor:blendColor withBackgroundColor:backgroundColor];
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

@end
