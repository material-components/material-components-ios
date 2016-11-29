/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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
static const CGFloat kOpacityLight = 0.54f;
static const CGFloat kOpacityMedium = 0.87f;
/**
 For our tests we are following a Given When Then structure as defined in
 http://martinfowler.com/bliki/GivenWhenThen.html

 The essential idea is to break down writing a scenario (or test) into three sections:

 The |given| part describes the state of the world before you begin the behavior you're specifying
 in this scenario. You can think of it as the pre-conditions to the test.
 The |when| section is that behavior that you're specifying.
 Finally the |then| section describes the changes you expect due to the specified behavior.

 For us this just means that we have the Given When Then guide posts as comments for each unit test.
 */
@interface TypographyTests : XCTestCase
@end

@interface MDCTypography (Testing)
+ (id<MDCTypographyFontLoading>)fontLoader;
@end

@implementation TypographyTests

- (void)testFontLoaderIsRoboto {
  // When
  id<MDCTypographyFontLoading> fontLoader = [MDCTypography fontLoader];

  // Then
  XCTAssertTrue([fontLoader isKindOfClass:[MDCRobotoFontLoader class]],
                @"Default fontLoader must be Roboto.");
}
@end

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
  // When
  CGFloat opacity = [MDCTypography display4FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityLight, kEpsilon,
                             @"Opacity of display 4 must be correct.");
}
- (void)testDisplay3FontOpacity {
  // When
  CGFloat opacity = [MDCTypography display3FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityLight, kEpsilon,
                             @"Opacity of display 3 must be correct.");
}
- (void)testDisplay2FontOpacity {
  // When
  CGFloat opacity = [MDCTypography display2FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityLight, kEpsilon,
                             @"Opacity of display 2 must be correct.");
}
- (void)testDisplay1FontOpacity {
  // When
  CGFloat opacity = [MDCTypography display1FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityLight, kEpsilon,
                             @"Opacity of display 1 must be correct.");
}

- (void)testHeadlineFontOpacity {
  // When
  CGFloat opacity = [MDCTypography headlineFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityMedium, kEpsilon,
                             @"Opacity of headline must be correct.");
}

- (void)testTitleFontOpacity {
  // When
  CGFloat opacity = [MDCTypography titleFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityMedium, kEpsilon,
                             @"Opacity of headline must be correct.");
}

- (void)testSubheadFontOpacity {
  // When
  CGFloat opacity = [MDCTypography subheadFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityMedium, kEpsilon,
                             @"Opacity of subhead must be correct.");
}

- (void)testBody2FontOpacity {
  // When
  CGFloat opacity = [MDCTypography body2FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityMedium, kEpsilon,
                             @"Opacity of body 2 must be correct.");
}

- (void)testBody1FontOpacity {
  // When
  CGFloat opacity = [MDCTypography body1FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityMedium, kEpsilon,
                             @"Opacity of body 1 must be correct.");
}

- (void)testCaptionFontOpacity {
  // When
  CGFloat opacity = [MDCTypography captionFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityLight, kEpsilon,
                             @"Opacity of caption must be correct.");
}

- (void)testButtonFontOpacity {
  // When
  CGFloat opacity = [MDCTypography buttonFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, kOpacityMedium, kEpsilon,
                             @"Opacity of button must be correct.");
}

#pragma mark - font name and size

- (void)testDisplay4Font {
  // Given
  // When
  UIFont *font = [MDCTypography display4Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 112, kEpsilon,
                             @"The font size of display 4 must be 112.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Light",
                        @"The font name of display 4 must be Roboto-Light.");
}

- (void)testDisplay3Font {
  // Given
  // When
  UIFont *font = [MDCTypography display3Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 56, kEpsilon,
                             @"The font size of display 3 must be 56.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular",
                        @"The font name of display 3 must be Roboto-Regular.");
}

- (void)testDisplay2Font {
  // Given
  // When
  UIFont *font = [MDCTypography display2Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 45, kEpsilon,
                             @"The font size of display 2 must be 45.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular",
                        @"The font name of display 2 must be Roboto-Regular.");
}

- (void)testDisplay1Font {
  // Given
  // When
  UIFont *font = [MDCTypography display1Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 34, kEpsilon,
                             @"The font size of display 1 must be 32.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular",
                        @"The font name of display 1 must be Roboto-Regular.");
}

- (void)testHeadlineFont {
  // Given
  // When
  UIFont *font = [MDCTypography headlineFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 24, kEpsilon,
                             @"The font size of headline must be 24.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular",
                        @"The font name of headline must be Roboto-Regular.");
}

- (void)testTitleFont {
  // Given
  // When
  UIFont *font = [MDCTypography titleFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 20, kEpsilon, @"The font size of title must be 20.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium",
                        @"The font name of title must be Roboto-Medium.");
}

- (void)testSubheadFont {
  // Given
  // When
  UIFont *font = [MDCTypography subheadFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 16, kEpsilon, @"The font size of subhead must be 16.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular",
                        @"The font name of subhead must be Roboto-Regular.");
}

- (void)testBody2Font {
  // Given
  // When
  UIFont *font = [MDCTypography body2Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon, @"The font size of body 2 must be 14.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium",
                        @"The font name of body 2 must be Roboto-Medium.");
}

- (void)testBody1Font {
  // Given
  // When
  UIFont *font = [MDCTypography body1Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon, @"The font size of body 1 must be 14.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular",
                        @"The font name of body 1 must be Roboto-Regular.");
}

- (void)testCaptionFont {
  // Given
  // When
  UIFont *font = [MDCTypography captionFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 12, kEpsilon, @"The font size of caption must be 12.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular",
                        @"The font name of caption must be Roboto-Regular.");
}

- (void)testButtonFont {
  // Given
  // When
  UIFont *font = [MDCTypography buttonFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon, @"The font size of button must be 14.");
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium",
                        @"The font name of button must be Roboto-Medium.");
}

#pragma mark - Setting a custom font loader

- (void)testSystemFontDisplay4Font {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography display4Font];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:112],
                        @"When the display 4 font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontDisplay3Font {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography display3Font];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:56],
                        @"When the display 3 font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontDisplay2Font {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography display2Font];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:45],
                        @"When the display 2 font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontDisplay1Font {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography display1Font];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:34],
                        @"When the display 1 font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontHeadlineFont {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography headlineFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:24],
                        @"When the headline font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontTitleFont {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography titleFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:20],
                        @"When the title font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontSubheadFont {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography subheadFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:16],
                        @"When the subhead font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontBody2Font {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography body2Font];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:14],
                        @"When the body 2 font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontBody1Font {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography body1Font];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:14],
                        @"When the body 1 font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontCaptionFont {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography captionFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:12],
                        @"When the caption font fails to load we must load a system font of the"
                        @"correct size.");
}

- (void)testSystemFontButtonFont {
  // Given
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];

  // When
  UIFont *font = [MDCTypography buttonFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:14],
                        @"When the button font fails to load we must load a system font of the"
                        @"correct size.");
}

@end
