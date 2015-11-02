/*
 Copyright 2015-present Google Inc. All Rights Reserved.
 
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

#import "MDCTypography.h"

#import <XCTest/XCTest.h>

static const CGFloat kEpsilon = 0.001f;

@interface TypographyTests : XCTestCase
@end

@implementation TypographyTests

#pragma mark - Font opacity

- (void)testDisplayFont4Opacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography displayFont4Opacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplayFont3Opacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography displayFont3Opacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplayFont2Opacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography displayFont2Opacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplayFont1Opacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography displayFont1Opacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}

- (void)testHeadlineFontOpacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography headlineFontOpacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testSubheadFontOpacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography subheadFontOpacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testBody2FontOpacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography body2FontOpacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testBody1FontOpacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography body1FontOpacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testCaptionFontOpacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography captionFontOpacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}

- (void)testButtonFontOpacity {
  // Given
  
  // When
  CGFloat opacity = [MDCTypography buttonFontOpacity];
  
  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

#pragma mark - font name and size

- (void)testDisplayFont4 {
  // Given
  // When
  UIFont *font = [MDCTypography displayFont4];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 112, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Light");
}

- (void)testDisplayFont3 {
  // Given
  // When
  UIFont *font = [MDCTypography displayFont3];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 56, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testDisplayFont2 {
  // Given
  // When
  UIFont *font = [MDCTypography displayFont2];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 45, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testDisplayFont1 {
  // Given
  // When
  UIFont *font = [MDCTypography displayFont1];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 34, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testHeadlineFont {
  // Given
  // When
  UIFont *font = [MDCTypography headlineFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 24, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testTitleFont {
  // Given
  // When
  UIFont *font = [MDCTypography titleFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 20, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}

- (void)testSubheadFont {
  // Given
  // When
  UIFont *font = [MDCTypography subheadFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 16, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testBody2Font {
  // Given
  // When
  UIFont *font = [MDCTypography body2Font];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}

- (void)testBody1Font {
  // Given
  // When
  UIFont *font = [MDCTypography body1Font];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testCaptionFont {
  // Given
  // When
  UIFont *font = [MDCTypography captionFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 12, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testButtonFont {
  // Given
  // When
  UIFont *font = [MDCTypography buttonFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}
#pragma mark - Roboto fonts

- (void)testRobotoRegularWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  
  // When
  UIFont *font = [MDCTypography robotoRegularWithSize:size];
  
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testRobotoBoldWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  
  // When
  UIFont *font = [MDCTypography robotoBoldWithSize:size];
  
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Bold");
}

- (void)testRobotoMediumWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  
  // When
  UIFont *font = [MDCTypography robotoMediumWithSize:size];
  
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}

- (void)testRobotoLightWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  
  // When
  UIFont *font = [MDCTypography robotoLightWithSize:size];
  
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Light");
}

- (void)testRobotoItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  
  // When
  UIFont *font = [MDCTypography robotoItalicWithSize:size];
  
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Italic");
}

- (void)testRobotoBoldItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  
  // When
  UIFont *font = [MDCTypography robotoBoldItalicWithSize:size];
  
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-BoldItalic");
}

@end
