#import <XCTest/XCTest.h>

#import "GOORobotoFontLoader.h"
#import "Private/GOOTypography+Constants.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

@interface GOORobotoFontLoaderTests : XCTestCase
@end

@implementation GOORobotoFontLoaderTests

- (void)testRobotoRegularWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader regularFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kRegularFontName);
  XCTAssertEqualObjects([fontLoader.regularFontResource fontOfSize:size], font);
}

- (void)testRobotoMediumWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader mediumFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kMediumFontName);
  XCTAssertEqualObjects([fontLoader.mediumFontResource fontOfSize:size], font);
}

- (void)testRobotoLightWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader lightFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kLightFontName);
  XCTAssertEqualObjects([fontLoader.lightFontResource fontOfSize:size], font);
}

- (void)testRobotoBoldWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader boldFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kBoldFontName);
  XCTAssertEqualObjects([fontLoader.boldFontResource fontOfSize:size], font);
}

- (void)testRobotoItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader italicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kRegularItalicFontName);
  XCTAssertEqualObjects([fontLoader.italicFontResource fontOfSize:size], font);
}

- (void)testRobotoMediumItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader mediumItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kMediumItalicFontName);
  XCTAssertEqualObjects([fontLoader.mediumItalicFontResource fontOfSize:size], font);
}

- (void)testRobotoLightItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader lightItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kLightItalicFontName);
  XCTAssertEqualObjects([fontLoader.lightItalicFontResource fontOfSize:size], font);
}

- (void)testRobotoBoldItalicWithSize {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  GOORobotoFontLoader *fontLoader = [GOORobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader boldItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kBoldItalicFontName);
  XCTAssertEqualObjects([fontLoader.boldItalicFontResource fontOfSize:size], font);
}

@end
