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

@interface FontDiskLoaderTests : XCTestCase
@end

@implementation FontDiskLoaderTests

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

- (void)testDescriptionNotRegistered {
  // Given
  MDCFontDiskLoader *resource = [self validResource];
  NSString *expected = [NSString stringWithFormat:@"font name: %@; font url: %@;",
                                                  resource.fontName, resource.fontURL];

  // When
  NSString *actual = [resource description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected], @"actual %@ does not end with: %@", actual, expected);
}

- (void)testDescriptionRegistered {
  // Given
  MDCFontDiskLoader *resource = [self validResource];
  [resource registerFont];
  NSString *expected = [NSString stringWithFormat:@"font name: %@; registered = YES; font url: %@;",
                                                  resource.fontName, resource.fontURL];
  UIView *view = [UIView new];
  view.userInteractionEnabled = NO;

  // When
  NSString *actual = [resource description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected], @"actual %@ does not end with: %@", actual, expected);
}

- (void)testDescriptionFailedRegistration {
  // Given
  MDCFontDiskLoader *resource = [self invalidResource];
  [resource registerFont];
  NSString *expected = [NSString stringWithFormat:@"font name: %@; failed registration = YES; "
                                                  @"font url: %@;",
                                                  resource.fontName, resource.fontURL];
  UIView *view = [UIView new];
  view.userInteractionEnabled = NO;

  // When
  NSString *actual = [resource description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected], @"actual %@ does not end with: %@", actual, expected);
}

- (void)testNotEquals {
  // Given
  NSString *name = @"some name";
  NSString *otherName = @"some other name";
  NSURL *url = [NSURL fileURLWithPath:@"some url string"];
  NSURL *otherUrl = [NSURL fileURLWithPath:@"some other url string"];
  MDCFontDiskLoader *loader = [[MDCFontDiskLoader alloc] initWithName:name URL:url];
  MDCFontDiskLoader *secondLoader = [[MDCFontDiskLoader alloc] initWithName:otherName URL:url];
  MDCFontDiskLoader *thirdLoader = [[MDCFontDiskLoader alloc] initWithName:name URL:otherUrl];
  NSObject *object = [[NSObject alloc] init];

  // When

  // Then
  XCTAssertNotEqualObjects(loader, secondLoader);
  XCTAssertNotEqual([loader hash], [secondLoader hash]);
  XCTAssertNotEqualObjects(loader, thirdLoader);
  XCTAssertNotEqual([loader hash], [secondLoader hash]);
  XCTAssertNotEqualObjects(secondLoader, thirdLoader);
  XCTAssertNotEqual([loader hash], [secondLoader hash]);
  XCTAssertNotEqualObjects(loader, object);
  XCTAssertNotEqual([loader hash], [object hash]);
  XCTAssertNotEqualObjects(loader, nil);
}

- (void)testEquals {
  // Given
  NSURL *url = [NSURL fileURLWithPath:@"some url string"];
  MDCFontDiskLoader *loader = [[MDCFontDiskLoader alloc] initWithName:@"some name" URL:url];
  MDCFontDiskLoader *secondLoader = [[MDCFontDiskLoader alloc] initWithName:@"some name" URL:url];

  // When

  // Then
  XCTAssertEqualObjects(loader, secondLoader);
  XCTAssertEqual([loader hash], [secondLoader hash]);
}
@end
