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

#import "MDCFontResource.h"
#import "MDCRobotoFontLoader.h"
#import "privateWasCapitalPrivate/MDCTypography+Constants.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

@interface MDCFontResourceTests : XCTestCase
@end

@implementation MDCFontResourceTests

- (MDCFontResource *)validResource {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCRobotoFontLoader class]];
  return [[MDCFontResource alloc] initWithFontName:MDCTypographyRegularFontName
                                          filename:MDCTypographyRegularFontFilename
                                    bundleFileName:MDCTypographyBundle
                                        baseBundle:bundle];
}

- (MDCFontResource *)invalidResource {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCRobotoFontLoader class]];
  return [[MDCFontResource alloc] initWithFontName:MDCTypographyRegularFontName
                                          filename:@"some invalid filename"
                                    bundleFileName:MDCTypographyBundle
                                        baseBundle:bundle];
}

- (void)testCreatesAFontURL {
  // Given
  MDCFontResource *resource = [self validResource];

  // When

  // Then
  XCTAssertNotNil(resource.fontURL, @"expecting font url to be valid");
  XCTAssertTrue([[resource.fontURL path] containsString:MDCTypographyRegularFontFilename],
                @"expecting font to be correct");
  XCTAssertTrue([[resource.fontURL path] containsString:MDCTypographyBundle],
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
  MDCFontResource *resource = [self invalidResource];

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
  XCTAssertEqualObjects(font.fontName, MDCTypographyRegularFontName);
}

- (void)testReturnNilWhenTheCustomFontCanNotBeFound {
  // Given
  MDCFontResource *resource = [self validResource];
  resource.fontName = @"some invalid font name";
  CGFloat randomSize = arc4random() * 100 / CGFLOAT_MAX;

  // When
  UIFont *font = [resource fontOfSize:randomSize];

  // Then
  XCTAssertNil(font);
}
@end
