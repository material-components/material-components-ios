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
#import "MDCRobotoFontLoader.h"
// TODO(iangordon): Re-add 'private/' to the path below once our Podspec specfically defines our
// header search paths instead of flattening our header files into a single directory.
#import "MDCRoboto+Constants.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

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
@interface RobotoFontLoaderTests : XCTestCase
@end

@interface MDCFontDiskLoader (Testing)
@property(nonatomic, assign) BOOL disableSanityChecks;
@end

@interface MDCRobotoFontLoader (Testing)
@property(nonatomic, strong) MDCFontDiskLoader *lightFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *regularFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *mediumFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *boldFontLoader;

@property(nonatomic, strong) MDCFontDiskLoader *lightItalicFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *italicFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *mediumItalicFontLoader;
@property(nonatomic, strong) MDCFontDiskLoader *boldItalicFontLoader;

@property(nonatomic, strong, null_resettable) NSBundle *baseBundle;
@property(nonatomic, assign) BOOL disableSanityChecks;

+ (NSBundle *)baseBundle;

- (instancetype)initInternal;

@end

@implementation RobotoFontLoaderTests

- (void)testRobotoRegularWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader regularFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The regular font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoRegularFontName,
                        @"The font name must match the regular font.");
}

- (void)testRobotoMediumWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader mediumFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The medium font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoMediumFontName,
                        @"The font name must match the medium font.");
}

- (void)testRobotoLightWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader lightFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The light font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoLightFontName,
                        @"The font name must match the light font.");
}

- (void)testRobotoBoldWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader boldFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The bold font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoBoldFontName,
                        @"The font name must match the bold font.");
}

- (void)testRobotoItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader italicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoRegularItalicFontName,
                        @"The font name must match the italic font.");
}

- (void)testRobotoMediumItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader mediumItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The medium italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoMediumItalicFontName,
                        @"The font name must match the medium italic font.");
}

- (void)testRobotoLightItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader lightItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The light italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoLightItalicFontName,
                        @"The font name must match the light italic font.");
}

- (void)testRobotoBoldItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [MDCRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader boldItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The bold italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDCRobotoBoldItalicFontName,
                        @"The font name must match the bold italic font.");
}

- (void)testLightFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.lightFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.lightFontLoader.fontURL];
  fontLoader.lightFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader lightFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:size],
                        @"The system font must be returned when the fontloader fails to load a"
                        @"font.");
}

- (void)testFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.regularFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.regularFontLoader.fontURL];
  fontLoader.regularFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader regularFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:size],
                        @"The system font must be returned when the fontloader fails to load a"
                        @"font.");
}

- (void)testMediumFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.mediumFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.mediumFontLoader.fontURL];
  fontLoader.mediumFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader mediumFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:size],
                        @"The bold system font must be returned when the fontloader fails to load a"
                        @"medium font.");
}

- (void)testBoldFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.boldFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.boldFontLoader.fontURL];
  fontLoader.boldFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader boldFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:size],
                        @"The bold system font must be returned when the fontloader fails to load a"
                        @"bold font.");
}

- (void)testLightItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.lightItalicFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.lightItalicFontLoader.fontURL];
  fontLoader.lightItalicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader lightItalicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to load"
                        @"an italic font.");
}

- (void)testItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.italicFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.italicFontLoader.fontURL];
  fontLoader.italicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader italicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to load"
                        @"an italic font.");
}

- (void)testMediumItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.mediumItalicFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.mediumItalicFontLoader.fontURL];
  fontLoader.mediumItalicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader mediumItalicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to "
                        @"load a medium italic font.");
}

- (void)testBoldItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.boldItalicFontLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.boldItalicFontLoader.fontURL];
  fontLoader.boldItalicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader boldItalicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to "
                        @"load a bold italic font.");
}

- (void)testSettingBaseBundleResetsLoader {
  // Given
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  NSArray *existingFontLoaders = @[
    fontLoader.regularFontLoader, fontLoader.lightFontLoader, fontLoader.mediumFontLoader,
    fontLoader.boldFontLoader, fontLoader.italicFontLoader, fontLoader.lightItalicFontLoader,
    fontLoader.mediumItalicFontLoader, fontLoader.boldItalicFontLoader
  ];

  // When
  fontLoader.baseBundle = nil;
  fontLoader.baseBundle = [MDCRobotoFontLoader baseBundle];
  NSArray *newFontLoaders = @[
    fontLoader.regularFontLoader, fontLoader.lightFontLoader, fontLoader.mediumFontLoader,
    fontLoader.boldFontLoader, fontLoader.italicFontLoader, fontLoader.lightItalicFontLoader,
    fontLoader.mediumItalicFontLoader, fontLoader.boldItalicFontLoader
  ];

  // Then
  for (NSUInteger index = 0; index < existingFontLoaders.count; ++index) {
    MDCFontDiskLoader *exisitngFontLoader = existingFontLoaders[index];
    MDCFontDiskLoader *newFontLoader = newFontLoaders[index];
    XCTAssertNotEqual(newFontLoader, exisitngFontLoader,  // Check that pointers are different.
                      @"Fontloader must be new objects when the base bundle gets set.");
  }
}

- (void)testResetingBaseBundle {
  // Given
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];

  // When
  fontLoader.baseBundle = nil;

  // Then
  XCTAssertNotNil(fontLoader.baseBundle, @"The baseBundle must always have a value.");
}

- (void)testDescription {
  // Given
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  NSArray *expected = @[
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(lightFontLoader)),
                               fontLoader.lightFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(regularFontLoader)),
                               fontLoader.regularFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(mediumFontLoader)),
                               fontLoader.mediumFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(boldFontLoader)),
                               fontLoader.boldFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(lightItalicFontLoader)),
                               fontLoader.lightItalicFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(italicFontLoader)),
                               fontLoader.italicFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(mediumItalicFontLoader)),
                               fontLoader.mediumItalicFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(boldItalicFontLoader)),
                               fontLoader.boldItalicFontLoader],
  ];

  // When
  NSString *actual = [fontLoader description];

  // Then
  for (NSString *LoaderDescriptoin in expected) {
    XCTAssertTrue([actual rangeOfString:LoaderDescriptoin].location != NSNotFound,
                  @"actual %@ does not end with: %@", actual, expected);
  }
}

- (void)testDescriptionWithNoLoaderMustBeMostlyEmpty {
  // Given
  MDCRobotoFontLoader *fontLoader = [[MDCRobotoFontLoader alloc] initInternal];
  NSString *expected = @" (\n)\n";

  // When
  NSString *actual = [fontLoader description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected], @"Description %@ must end with: %@", actual, expected);
}

#pragma mark private

- (CGFloat)randomNumber {
  return arc4random_uniform(1000) / (CGFloat)(arc4random_uniform(9) + 1);
}

@end
