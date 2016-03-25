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

#import <XCTest/XCTest.h>

#import "MDCRobotoFontLoader.h"
#import "MaterialTypography.h"

static const CGFloat kEpsilon = 0.001f;

@interface MDCTypography (Testing)
+ (id<MDCTypographyFontLoader>)fontLoader;
@end

/** These tests have set the fontloader because it is a singleton. */
@interface TypographyTests : XCTestCase
@end

@implementation TypographyTests

- (void)testFontLoaderIsRoboto {
  // Given

  // When
  id<MDCTypographyFontLoader> fontLoader = [MDCTypography fontLoader];

  // Then
  XCTAssertTrue([fontLoader isKindOfClass:[MDCRobotoFontLoader class]]);
}
@end

/** These tests have set the fontloader because it is a singleton. */
@interface TypographyFontLoaderSetTest : XCTestCase
@end

@interface MDCRobotoFontLoader (Testing)
- (instancetype)initInternal;
@end

@implementation TypographyFontLoaderSetTest

- (void)tearDown {
  // Since we are using a singleton we need to restore the custom fontLoader back for other tests
  [MDCTypography setFontLoader:[MDCRobotoFontLoader sharedInstance]];
}

#pragma mark - Font opacity

- (void)testDisplay4FontOpacity {
  // Given

  // When
  CGFloat opacity = [MDCTypography display4FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplay3FontOpacity {
  // Given

  // When
  CGFloat opacity = [MDCTypography display3FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplay2FontOpacity {
  // Given

  // When
  CGFloat opacity = [MDCTypography display2FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplay1FontOpacity {
  // Given

  // When
  CGFloat opacity = [MDCTypography display1FontOpacity];

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

- (void)testDisplay4Font {
  // Given
  // When
  UIFont *font = [MDCTypography display4Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 112, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Light");
}

- (void)testDisplay3Font {
  // Given
  // When
  UIFont *font = [MDCTypography display3Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 56, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testDisplay2Font {
  // Given
  // When
  UIFont *font = [MDCTypography display2Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 45, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testDisplay1Font {
  // Given
  // When
  UIFont *font = [MDCTypography display1Font];

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

#pragma mark - Setting a custom font loader

- (void)testSystemFontDisplay4Font {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography display4Font];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:112]);
}

- (void)testSystemFontDisplay3Font {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography display3Font];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:56]);
}

- (void)testSystemFontDisplay2Font {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography display2Font];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:45]);
}

- (void)testSystemFontDisplay1Font {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography display1Font];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:34]);
}

- (void)testSystemFontHeadlineFont {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography headlineFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:24]);
}

- (void)testSystemFontTitleFont {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography titleFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:20]);
}

- (void)testSystemFontSubheadFont {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography subheadFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:16]);
}

- (void)testSystemFontBody2Font {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography body2Font];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:14]);
}

- (void)testSystemFontBody1Font {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography body1Font];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:14]);
}

- (void)testSystemFontCaptionFont {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography captionFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:12]);
}

- (void)testSystemFontButtonFont {
  // Given
  [MDCTypography setFontLoader:[MDCSystemFontLoader new]];

  // When
  UIFont *font = [MDCTypography buttonFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:14]);
}

@end
