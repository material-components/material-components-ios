// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "../../src/private/UIFont+MaterialTypographyPrivate.h"
#import "MDCTypographyFontLoader.h"
#import "MaterialTypography.h"

static const CGFloat kEpsilon = (CGFloat)0.001;
static const CGFloat kOpacityLight = (CGFloat)0.54;
static const CGFloat kOpacityMedium = (CGFloat)0.87;
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

/** This font loader is for Bodoni Ornaments and is for testing the missing bold/italic fonts. */
@interface BodoniOrnamentsFontLoader : NSObject <MDCTypographyFontLoading>
@end

@implementation BodoniOrnamentsFontLoader

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  return [UIFont fontWithName:@"Bodoni Ornaments" size:fontSize];
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  return [UIFont fontWithName:@"Bodoni Ornaments" size:fontSize];
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  return [UIFont fontWithName:@"Bodoni Ornaments" size:fontSize];
}

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

- (void)testItalicFontFromFont {
  // Given
  CGFloat size = 8;
  MDCSystemFontLoader *fontLoader = [[MDCSystemFontLoader alloc] init];
  UIFont *normalFont = [UIFont systemFontOfSize:size];
  UIFont *italicFont = [UIFont italicSystemFontOfSize:size];
  UIFont *mediumFont = [fontLoader mediumFontOfSize:size];
  UIFontDescriptor *fontDescriptor =
      [mediumFont.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
  UIFont *italicMediumFont = [UIFont fontWithDescriptor:fontDescriptor size:0];

  // Then
  XCTAssertEqualObjects([MDCTypography italicFontFromFont:mediumFont], italicMediumFont);
  XCTAssertEqualObjects([MDCTypography italicFontFromFont:normalFont], italicFont);
}

- (void)testBoldFontFromFont {
  // Given
  CGFloat size = 8;
  MDCSystemFontLoader *fontLoader = [[MDCSystemFontLoader alloc] init];
  UIFont *normalFont = [UIFont systemFontOfSize:size];
  UIFont *boldFont = [UIFont boldSystemFontOfSize:size];
  UIFont *italicFont = [UIFont italicSystemFontOfSize:size];
  UIFontDescriptor *fontDescriptor = [[UIFont systemFontOfSize:size].fontDescriptor
      fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic | UIFontDescriptorTraitBold];
  UIFont *italicBoldFont = [UIFont fontWithDescriptor:fontDescriptor size:0];
  UIFont *fontLoaderRegularFont = [fontLoader regularFontOfSize:size];
  UIFont *fontLoaderBoldFont = [fontLoader boldFontOfSize:size];

  // Then
  XCTAssertEqualObjects([MDCTypography boldFontFromFont:italicFont], italicBoldFont);
  XCTAssertEqualObjects([MDCTypography boldFontFromFont:normalFont], boldFont);
  // For some reason the fonts are not equal, the names are the same though.
  XCTAssertEqualObjects([MDCTypography boldFontFromFont:fontLoaderRegularFont].fontName,
                        fontLoaderBoldFont.fontName);
}

- (void)testBoldFontFromFontWithNoBold {
  // Given
  BodoniOrnamentsFontLoader *fontLoader = [[BodoniOrnamentsFontLoader alloc] init];
  [MDCTypography setFontLoader:fontLoader];
  UIFont *font = [MDCTypography buttonFont];

  // When
  UIFont *boldFont = [MDCTypography boldFontFromFont:font];

  // Then
  XCTAssertNotNil(boldFont);

  // Cleanup
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];
}

- (void)testItalicFontFromFontWithNoItalic {
  // Given
  BodoniOrnamentsFontLoader *fontLoader = [[BodoniOrnamentsFontLoader alloc] init];
  [MDCTypography setFontLoader:fontLoader];
  UIFont *font = [MDCTypography buttonFont];

  // When
  UIFont *italicFont = [MDCTypography italicFontFromFont:font];

  // Then
  XCTAssertNotNil(italicFont);

  // Cleanup
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];
}

- (void)testFontFamilyMatchesSystemFontFamily {
  // Given
  NSArray<NSNumber *> *allFontStyles = @[
    @(MDCFontTextStyleBody1),
    @(MDCFontTextStyleBody2),
    @(MDCFontTextStyleCaption),
    @(MDCFontTextStyleHeadline),
    @(MDCFontTextStyleSubheadline),
    @(MDCFontTextStyleTitle),
    @(MDCFontTextStyleDisplay1),
    @(MDCFontTextStyleDisplay2),
    @(MDCFontTextStyleDisplay3),
    @(MDCFontTextStyleDisplay4),
    @(MDCFontTextStyleButton),
  ];

  for (NSNumber *styleObject in allFontStyles) {
    // When
    MDCFontTextStyle style = styleObject.integerValue;
    UIFont *mdcFont = [UIFont mdc_preferredFontForMaterialTextStyle:style];
    UIFont *systemFont = [UIFont systemFontOfSize:mdcFont.pointSize weight:UIFontWeightRegular];

    // Then
    XCTAssertEqualObjects(systemFont.familyName, mdcFont.familyName);
  }
}

- (void)testExtendedDescription {
  // Given
  UIFont *systemFont = [UIFont systemFontOfSize:22.0 weight:UIFontWeightRegular];
  XCTAssertNotNil(systemFont);

  // When
  NSString *fontExtendedDescription = [systemFont mdc_extendedDescription];

  // Then
  XCTAssertNotNil(fontExtendedDescription);
}

@end
