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

#import "MDCFontDiskLoader.h"
#import "MDCRobotoFontLoader.h"
#import "private/MDCRoboto+Constants.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

@interface MDCFontDiskLoaderTests : XCTestCase
@end

@implementation MDCFontDiskLoaderTests

- (MDCFontDiskLoader *)validResource {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCRobotoFontLoader class]];
  return [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoRegularFontName
                                            filename:MDCRobotoRegularFontFilename
                                      bundleFileName:MDCRobotoBundle
                                          baseBundle:bundle];
}

- (MDCFontDiskLoader *)invalidResource {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCRobotoFontLoader class]];
  return [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoRegularFontName
                                            filename:@"some invalid filename"
                                      bundleFileName:MDCRobotoBundle
                                          baseBundle:bundle];
}

- (void)testCreatesAFontURL {
  // Given
  MDCFontDiskLoader *resource = [self validResource];

  // When

  // Then
  XCTAssertNotNil(resource.fontURL, @"expecting font url to be valid");
  XCTAssertTrue([[resource.fontURL path] containsString:MDCRobotoRegularFontFilename],
                @"expecting font to be correct");
  XCTAssertTrue([[resource.fontURL path] containsString:MDCRobotoBundle],
                @"expecting font to be correct");
}

- (void)testRegisterFont {
  // Given
  MDCFontDiskLoader *resource = [self validResource];

  // When
  [resource registerFont];

  // Then
  XCTAssertTrue(resource.isRegistered);
}

- (void)testRegisterFontFailure {
  // Given
  MDCFontDiskLoader *resource = [self invalidResource];

  // When
  [resource registerFont];

  // Then
  XCTAssertTrue(resource.hasFailedRegistration);
}

- (void)testProvidesACustomFont {
  // Given
  MDCFontDiskLoader *resource = [self validResource];
  CGFloat randomSize = arc4random() * 100 / CGFLOAT_MAX;

  // When
  UIFont *font = [resource fontOfSize:randomSize];

  // Then
  XCTAssertNotNil(font);
  XCTAssertEqualWithAccuracy(font.pointSize, randomSize, kEpsilonAccuracy);
  XCTAssertEqualObjects(font.fontName, MDCRobotoRegularFontName);
}

- (void)testReturnNilWhenTheCustomFontCanNotBeFound {
  // Given
  MDCFontDiskLoader *resource = [self validResource];
  resource.fontName = @"some invalid font name";
  CGFloat randomSize = arc4random() * 100 / CGFLOAT_MAX;

  // When
  UIFont *font = [resource fontOfSize:randomSize];

  // Then
  XCTAssertNil(font);
}
@end
