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

@implementation TypographyTests

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
}

- (void)testDisplay3Font {
  // Given
  // When
  UIFont *font = [MDCTypography display3Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 56, kEpsilon,
                             @"The font size of display 3 must be 56.");
}

- (void)testDisplay2Font {
  // Given
  // When
  UIFont *font = [MDCTypography display2Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 45, kEpsilon,
                             @"The font size of display 2 must be 45.");
}

- (void)testDisplay1Font {
  // Given
  // When
  UIFont *font = [MDCTypography display1Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 34, kEpsilon,
                             @"The font size of display 1 must be 32.");
}

- (void)testHeadlineFont {
  // Given
  // When
  UIFont *font = [MDCTypography headlineFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 24, kEpsilon,
                             @"The font size of headline must be 24.");
}

- (void)testTitleFont {
  // Given
  // When
  UIFont *font = [MDCTypography titleFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 20, kEpsilon, @"The font size of title must be 20.");
}

- (void)testSubheadFont {
  // Given
  // When
  UIFont *font = [MDCTypography subheadFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 16, kEpsilon, @"The font size of subhead must be 16.");
}

- (void)testBody2Font {
  // Given
  // When
  UIFont *font = [MDCTypography body2Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon, @"The font size of body 2 must be 14.");
}

- (void)testBody1Font {
  // Given
  // When
  UIFont *font = [MDCTypography body1Font];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon, @"The font size of body 1 must be 14.");
}

- (void)testCaptionFont {
  // Given
  // When
  UIFont *font = [MDCTypography captionFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 12, kEpsilon, @"The font size of caption must be 12.");
}

- (void)testButtonFont {
  // Given
  // When
  UIFont *font = [MDCTypography buttonFont];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon, @"The font size of button must be 14.");
}

@end
