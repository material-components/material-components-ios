#import <XCTest/XCTest.h>

#import "GOOFontResource.h"
#import "GOORobotoFontLoader.h"
#import "GOOTypography+Constants.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

@interface GOOFontResourceTests : XCTestCase
@end

@implementation GOOFontResourceTests

- (GOOFontResource *)validResource {
  NSBundle *bundle = [NSBundle bundleForClass:[GOORobotoFontLoader class]];
  return [[GOOFontResource alloc] initWithFontName:kRegularFontName
                                          filename:kRegularFontFilename
                                    bundleFileName:kTypographyBundle
                                        baseBundle:bundle];
}

- (void)testCreatesAFontURL {
  // Given
  GOOFontResource *resource = [self validResource];

  // When

  // Then
  XCTAssertNotNil(resource.fontURL, @"expecting font url to be valid");
  XCTAssertTrue([[resource.fontURL path] containsString:resource.filename],
                @"expecting font to be correct");
  XCTAssertTrue([[resource.fontURL path] containsString:resource.bundleFilename],
                @"expecting font to be correct");
  XCTAssertTrue([[resource.fontURL path] containsString:[resource.baseBundle bundlePath]],
                @"expecting font to be correct");
}

- (void)testRegisterFont {
  // Given
  GOOFontResource *resource = [self validResource];

  // When
  [resource registerFont];

  // Then
  XCTAssertTrue(resource.isRegistered);
}

- (void)testRegisterFontFailure {
  // Given
  GOOFontResource *resource = [self validResource];
  resource.filename = @"some invalid font filename";

  // When
  [resource registerFont];

  // Then
  XCTAssertTrue(resource.hasFailedRegistration);
}

- (void)testProvidesACustomFont {
  // Given
  GOOFontResource *resource = [self validResource];
  CGFloat randomSize = arc4random() * 100 / CGFLOAT_MAX;

  // When
  UIFont *font = [resource fontOfSize:randomSize];

  // Then
  XCTAssertNotNil(font);
  XCTAssertEqualWithAccuracy(font.pointSize, randomSize, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, kRegularFontName);
}

- (void)testProvidesASystemFontWhenTheCustomFontCantBeFound {
  // Given
  GOOFontResource *resource = [self validResource];
  resource.fontName = @"some invalid font name";
  CGFloat randomSize = arc4random() * 100 / CGFLOAT_MAX;

  // When
  UIFont *font = [resource fontOfSize:randomSize];

  // Then
  XCTAssertNotNil(font);
  XCTAssertEqualWithAccuracy(font.pointSize, randomSize, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, [UIFont systemFontOfSize:randomSize].fontName);
}

@end
