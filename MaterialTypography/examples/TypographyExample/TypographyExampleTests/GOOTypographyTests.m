#import <XCTest/XCTest.h>

#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOORobotoFontLoader.h"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GoogleKitTypography.h"

static const CGFloat kEpsilon = 0.001f;

@interface GOOTypography (Testing)
+ (id<GOOTypographyFontLoader>)fontLoader;
@end

/** These tests have set the fontloader because it is a singleton. */
@interface GOOTypographyTests : XCTestCase
@end

@implementation GOOTypographyTests

- (void)testFontLoaderIsRoboto {
  // Given

  // When
  id<GOOTypographyFontLoader> fontLoader = [GOOTypography fontLoader];

  // Then
  XCTAssertTrue([fontLoader isKindOfClass:[GOORobotoFontLoader class]]);
}
@end

/** These tests have set the fontloader because it is a singleton. */
@interface GOOTypographyFontLoaderSetTest : XCTestCase
@end

@interface GOORobotoFontLoader (Testing)
- (instancetype)initInternal;
@end

@implementation GOOTypographyFontLoaderSetTest

- (void)tearDown {
  // Since we are using a singleton we need to restore the custom fontLoader back for other tests
  [GOOTypography setFontLoader:[GOORobotoFontLoader sharedInstance]];
}

#pragma mark - Font opacity

- (void)testDisplayFont4Opacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography displayFont4Opacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplayFont3Opacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography displayFont3Opacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplayFont2Opacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography displayFont2Opacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}
- (void)testDisplayFont1Opacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography displayFont1Opacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}

- (void)testHeadlineFontOpacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography headlineFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testSubheadFontOpacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography subheadFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testBody2FontOpacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography body2FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testBody1FontOpacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography body1FontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

- (void)testCaptionFontOpacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography captionFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.54, kEpsilon);
}

- (void)testButtonFontOpacity {
  // Given

  // When
  CGFloat opacity = [GOOTypography buttonFontOpacity];

  // Then
  XCTAssertEqualWithAccuracy(opacity, 0.87, kEpsilon);
}

#pragma mark - font name and size

- (void)testDisplayFont4 {
  // Given
  // When
  UIFont *font = [GOOTypography displayFont4];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 112, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Light");
}

- (void)testDisplayFont3 {
  // Given
  // When
  UIFont *font = [GOOTypography displayFont3];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 56, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testDisplayFont2 {
  // Given
  // When
  UIFont *font = [GOOTypography displayFont2];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 45, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testDisplayFont1 {
  // Given
  // When
  UIFont *font = [GOOTypography displayFont1];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 34, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testHeadlineFont {
  // Given
  // When
  UIFont *font = [GOOTypography headlineFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 24, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testTitleFont {
  // Given
  // When
  UIFont *font = [GOOTypography titleFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 20, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}

- (void)testSubheadFont {
  // Given
  // When
  UIFont *font = [GOOTypography subheadFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 16, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testBody2Font {
  // Given
  // When
  UIFont *font = [GOOTypography body2Font];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}

- (void)testBody1Font {
  // Given
  // When
  UIFont *font = [GOOTypography body1Font];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testCaptionFont {
  // Given
  // When
  UIFont *font = [GOOTypography captionFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 12, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}

- (void)testButtonFont {
  // Given
  // When
  UIFont *font = [GOOTypography buttonFont];
  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, 14, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}

#pragma mark - Setting a custom font loader

- (void)testSystemFontDisplayFont4 {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography displayFont4];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:112]);
}

- (void)testSystemFontDisplayFont3 {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography displayFont3];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:56]);
}

- (void)testSystemFontDisplayFont2 {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography displayFont2];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:45]);
}

- (void)testSystemFontDisplayFont1 {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography displayFont1];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:34]);
}

- (void)testSystemFontHeadlineFont {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography headlineFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:24]);
}

- (void)testSystemFontTitleFont {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography titleFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:20]);
}

- (void)testSystemFontSubheadFont {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography subheadFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:16]);
}

- (void)testSystemFontBody2Font {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography body2Font];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:14]);
}

- (void)testSystemFontBody1Font {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography body1Font];
  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:14]);
}

- (void)testSystemFontCaptionFont {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography captionFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:12]);
}

- (void)testSystemFontButtonFont {
  // Given
  [GOOTypography setFontLoader:[GOOSystemFontLoader new]];

  // When
  UIFont *font = [GOOTypography buttonFont];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:14]);
}

#pragma mark - Roboto fonts

- (void)testRobotoRegularWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);

  // When
  UIFont *font = [GOOTypography robotoRegularWithSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Regular");
}
- (void)testRobotoMediumWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);

  // When
  UIFont *font = [GOOTypography robotoMediumWithSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Medium");
}

- (void)testRobotoLightWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);

  // When
  UIFont *font = [GOOTypography robotoLightWithSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Light");
}

#pragma mark - Google additions

- (void)testItalicFontFromFontRegular {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  UIFont *regularFont = [GOOTypography robotoRegularWithSize:size];

  // When
  UIFont *font = [GOOTypography italicFontFromFont:regularFont];

  // Then
  XCTAssertEqualObjects(font.fontName, @"Roboto-Italic");
}

- (void)testItalicFontFromFontMedium {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  UIFont *regularFont = [GOOTypography robotoMediumWithSize:size];

  // When
  UIFont *font = [GOOTypography italicFontFromFont:regularFont];

  // Then
  XCTAssertEqualObjects(font.fontName, @"Roboto-MediumItalic");
}

- (void)testRobotoBoldWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);

  // When
  UIFont *font = [GOOTypography robotoBoldWithSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Bold");
}

#pragma mark - deprecated

- (void)testRobotoItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);

  // When
  UIFont *font = [GOOTypography robotoItalicWithSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-Italic");
}

- (void)testRobotoBoldItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);

  // When
  UIFont *font = [GOOTypography robotoBoldItalicWithSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilon);
  XCTAssertEqualObjects(font.fontName, @"Roboto-BoldItalic");
}

@end
