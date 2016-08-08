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

#import "MDCFontDiskLoader.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

// We use the bundle from MDCRobotoFontLoader to test loading functionality
static NSString *MDCRobotoFontLoaderClassname = @"MDCRobotoFontLoader";
static NSString *MDCRobotoRegularFontName = @"Roboto-Regular";
static NSString *MDCRobotoRegularFontFilename = @"Roboto-Regular.ttf";
static NSString *MDCRobotoBundle = @"MaterialRobotoFontLoader.bundle";

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

@interface MDCFontDiskLoader (Testing)
@property(nonatomic, assign) BOOL disableSanityChecks;
@end

@interface FontDiskLoaderTests : XCTestCase
@end

@implementation FontDiskLoaderTests

- (MDCFontDiskLoader *)validFontLoader {
  NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(MDCRobotoFontLoaderClassname)];
  return [[MDCFontDiskLoader alloc] initWithFontName:MDCRobotoRegularFontName
                                            filename:MDCRobotoRegularFontFilename
                                      bundleFileName:MDCRobotoBundle
                                          baseBundle:bundle];
}

- (MDCFontDiskLoader *)invalidFontLoader {
  NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(MDCRobotoFontLoaderClassname)];
  // This attempts to use a png asset instead of a valid font file.
  return [[MDCFontDiskLoader alloc] initWithFontName:@"some invalid font name"
                                            filename:@"ic_arrow_back.png"
                                      bundleFileName:@"MaterialIcons_ic_arrow_back.bundle"
                                          baseBundle:bundle];
}

- (void)testConvenienceInitCreatesAFontURL {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];

  // Then
  XCTAssertNotNil(loader.fontURL, @"The font URL must not be nil when using the convenience init.");
  XCTAssertTrue([[loader.fontURL path] containsString:MDCRobotoRegularFontFilename],
                @"The font URL's path must contain %@", MDCRobotoRegularFontFilename);
  XCTAssertTrue([[loader.fontURL path] containsString:MDCRobotoBundle],
                @"The font URL's path must contain %@", MDCRobotoBundle);
}

- (void)testload {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];

  // When
  [loader load];

  // Then
  XCTAssertTrue(loader.loaded, @"Loading a valid font must mark its state loaded.");
}

- (void)testUnload {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];
  [loader load];
  XCTAssertTrue(loader.loaded, @"Loading a valid font must mark its state loaded.");

  // When
  BOOL success = [loader unload];

  // Then
  XCTAssertFalse(loader.loaded, @"Unloading a loaded font must not mark its state loaded.");
  XCTAssertTrue(success, @"Unloading a loaded font must return success.");
}

- (void)testUnloadFailedRegistration {
  // Given
  MDCFontDiskLoader *loader = [self invalidFontLoader];
  [loader load];

  // When
  [loader unload];

  // Then
  XCTAssertFalse(loader.loaded,
                 @"Unloading a previously failed fontloader must not mark it loaded");
  XCTAssertFalse(loader.loadFailed,
                 @"Unloading a previously failed fontloader must reset its loadFailed.");
}

- (void)testUnloadNotloaded {
  // Given
  MDCFontDiskLoader *loader = [self invalidFontLoader];

  // When
  [loader unload];

  // Then
  XCTAssertFalse(loader.loaded,
                 @"Unloading a fontLoader that was never loaded must not mark it loaded.");
  XCTAssertFalse(loader.loadFailed, @"Unloading a fontloader must reset its loadFailed flag.");
}

- (void)testloadFailure {
  // Given
  MDCFontDiskLoader *loader = [self invalidFontLoader];
  loader.disableSanityChecks = YES;

  // When
  [loader load];

  // Then
  XCTAssertNil([loader fontOfSize:10],
               @"Asking for a font with an invalid font url must not return a UIFont.");
  XCTAssertTrue(loader.loadFailed,
                @"Asking for a font with an invalid font url must set the loadFailed flag to YES");
}

- (void)testCopy {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];

  // When
  MDCFontDiskLoader *secondFontLoader = [loader copy];

  // Then
  XCTAssertEqualObjects(loader, secondFontLoader,
                        @"A copy of a fontloader must equal the original");
}

- (void)testloadedOfSecondFontLoader {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];
  MDCFontDiskLoader *secondFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:loader.fontName fontURL:loader.fontURL];

  // When
  [loader load];

  // Then
  XCTAssertEqual(loader.loaded, secondFontLoader.loaded, @"Loading the fontloader with the same "
                                                         @"url and name must also update the "
                                                         @"loaded state of both fontloader.");
}

- (void)testProvidesACustomFont {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];
  CGFloat randomSize = arc4random() * 100 / CGFLOAT_MAX;

  // When
  UIFont *font = [loader fontOfSize:randomSize];

  // Then
  XCTAssertNotNil(
      font, @"Asking for a font of any size of a valid font url and name must return a font.");
  XCTAssertEqualWithAccuracy(font.pointSize, randomSize, kEpsilonAccuracy,
                             @"The font size of the font returned from fontOfSize: must match ");
  XCTAssertEqualObjects(font.fontName, MDCRobotoRegularFontName);
}

- (void)testReturnNilWhenTheCustomFontCanNotBeFound {
  // Given
  MDCFontDiskLoader *validLoader = [self validFontLoader];
  MDCFontDiskLoader *loader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"some invalid font name" fontURL:validLoader.fontURL];
  loader.disableSanityChecks = YES;
  CGFloat randomSize = arc4random() * 100 / CGFLOAT_MAX;

  // When
  UIFont *font = [loader fontOfSize:randomSize];

  // Then
  XCTAssertNil(font, @"Asking for a font must not return a font when the font name is not found.");
}

- (void)testDescriptionNotloaded {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];
  [loader unload];
  NSString *expected =
      [NSString stringWithFormat:@"font name: %@; font url: %@;", loader.fontName, loader.fontURL];

  // When
  NSString *actual = [loader description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected],
                @"When not loaded the description of the font loader `%@` must end with: `%@`",
                actual, expected);
}

- (void)testDescriptionloaded {
  // Given
  MDCFontDiskLoader *loader = [self validFontLoader];
  [loader load];
  NSString *expected = [NSString stringWithFormat:@"font name: %@; loaded = YES; font url: %@;",
                                                  loader.fontName, loader.fontURL];
  UIView *view = [UIView new];
  view.userInteractionEnabled = NO;

  // When
  NSString *actual = [loader description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected],
                @"When loaded the description of the font loader `%@` must end with: %@", actual,
                expected);
}

- (void)testDescriptionFailedRegistration {
  // Given
  MDCFontDiskLoader *loader = [self invalidFontLoader];
  [loader load];
  NSString *expected = [NSString stringWithFormat:@"font name: %@; failed registration = YES; "
                                                  @"font url: %@;",
                                                  loader.fontName, loader.fontURL];
  UIView *view = [UIView new];
  view.userInteractionEnabled = NO;

  // When
  NSString *actual = [loader description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected],
                @"When load fails the description of the font loader %@ must end with: %@", actual,
                expected);
}

- (void)testNotEquals {
  // Given
  NSString *name = @"some name";
  NSString *otherName = @"some other name";
  NSURL *url = [NSURL fileURLWithPath:@"some url string"];
  NSURL *otherUrl = [NSURL fileURLWithPath:@"some other url string"];
  MDCFontDiskLoader *loader = [[MDCFontDiskLoader alloc] initWithFontName:name fontURL:url];
  MDCFontDiskLoader *secondLoader = [[MDCFontDiskLoader alloc] initWithFontName:otherName fontURL:url];
  MDCFontDiskLoader *thirdLoader = [[MDCFontDiskLoader alloc] initWithFontName:name fontURL:otherUrl];
  NSObject *object = [[NSObject alloc] init];

  // Then
  XCTAssertNotEqualObjects(loader, secondLoader,
                           @"Fontloaders with different font names must not equal eachother.");
  XCTAssertNotEqual([loader hash], [secondLoader hash],
                    @"Fontloaders with different font names must not have equal hashes.");
  XCTAssertNotEqualObjects(loader, thirdLoader,
                           @"Fontloaders with different font urls must not equal eachother.");
  XCTAssertNotEqual([loader hash], [secondLoader hash],
                    @"Fontloaders with different font urls must not have equal hashes.");
  XCTAssertNotEqualObjects(
      secondLoader, thirdLoader,
      @"Fontloaders with different font names and different names must not equal eachother.");
  XCTAssertNotEqual(
      [loader hash], [secondLoader hash],
      @"Fontloaders with different font names and different names must not have equal hashes.");
  XCTAssertNotEqualObjects(loader, object, @"A fontloader must not equal a object instance.");
  XCTAssertNotEqual([loader hash], [object hash],
                    @"A fontloader must not have the same hash as a object instance.");
  XCTAssertNotEqualObjects(loader, nil, @"A font loader must not equal nil");
}

- (void)testEquals {
  // Given
  NSURL *url = [NSURL fileURLWithPath:@"some url string"];
  MDCFontDiskLoader *loader = [[MDCFontDiskLoader alloc] initWithFontName:@"some name" fontURL:url];
  MDCFontDiskLoader *secondLoader = [[MDCFontDiskLoader alloc] initWithFontName:@"some name" fontURL:url];

  // Then
  XCTAssertEqualObjects(
      loader, secondLoader,
      @"Fontloaders with the same font names and font urls must equal eachother.");
  XCTAssertEqual([loader hash], [secondLoader hash],
                 @"Fontloaders with the same font name and font urls must have the same hash.");
}

@end
