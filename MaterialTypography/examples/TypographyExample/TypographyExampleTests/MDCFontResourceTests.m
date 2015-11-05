#import <XCTest/XCTest.h>

#import "MDCFontResource.h"
#import "MDCRobotoFontLoader.h"
#import "MDCTypography+Constants.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

@interface MDCFontResourceTests : XCTestCase
@end

@implementation MDCFontResourceTests

- (MDCFontResource *)validResource {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCRobotoFontLoader class]];
  return [[MDCFontResource alloc] initWithFontName:kRegularFontName
                                          filename:kRegularFontFilename
                                    bundleFileName:kTypographyBundle
                                        baseBundle:bundle];
}

- (void)testCreatesAFontURL {
  // Given
  MDCFontResource *resource = [self validResource];

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
  MDCFontResource *resource = [self validResource];

  // When
  [resource registerFont];

  // Then
  XCTAssertTrue(resource.isRegistered);
}

- (void)testRegisterFontFailure {
  // Given
  MDCFontResource *resource = [self validResource];
  resource.filename = @"some invalid font filename";

  // When
  [resource registerFont];

  // Then
  XCTAssertTrue(resource.hasFailedRegistration);
}

- (void)testProvidesACustomFont {
  // Given
  MDCFontResource *resource = [self validResource];
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
  MDCFontResource *resource = [self validResource];
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
