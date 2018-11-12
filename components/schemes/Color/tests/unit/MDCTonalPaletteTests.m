// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#import "MaterialPalettes.h"
#import "MaterialColorScheme.h"

@interface MDCTonalPaletteTests : XCTestCase

@end

@implementation MDCTonalPaletteTests

- (void)testTonalPaletteEncodingDecoding {

  // These tests are commented out because of precision bug on apple side when archiving.
  // TODO: (#2931) Uncomment this colors array to test double precision.
//  NSArray<UIColor *> *tonalColors = @[ [MDCPalette purplePalette].tint50,
//                                       [MDCPalette purplePalette].tint100,
//                                       [MDCPalette purplePalette].tint200,
//                                       [MDCPalette purplePalette].tint300,
//                                       [MDCPalette purplePalette].tint400,
//                                       [MDCPalette purplePalette].tint500,
//                                       [MDCPalette purplePalette].tint600,
//                                       [MDCPalette purplePalette].tint700,
//                                       [MDCPalette purplePalette].tint800,
//                                       [MDCPalette purplePalette].tint900 ];

  // Given
  NSArray<UIColor *> *tonalColors = @[
    [UIColor colorWithRed:(float)0.6 green:(float)0.2 blue:(float)0.3 alpha:1],
    [UIColor colorWithRed:1 green:(float)0.5 blue:0 alpha:1],
    [UIColor colorWithRed:(float)0.2 green:(float)0.3 blue:(float)0.3 alpha:1],
    [UIColor colorWithRed:(float)0.5 green:(float)0.8 blue:(float)0.6 alpha:1],
    [UIColor colorWithRed:(float)0.4 green:(float)0.7 blue:(float)0.4 alpha:1],
    [UIColor colorWithRed:(float)0.8 green:(float)0.3 blue:(float)0.9 alpha:1],
    [UIColor colorWithRed:(float)0.6 green:(float)0.2 blue:(float)0.3 alpha:1],
    [UIColor colorWithRed:0 green:(float)0.8 blue:1 alpha:1],
    [UIColor colorWithRed:(float)0.1 green:(float)0.8 blue:(float)0.3 alpha:1],
    [UIColor colorWithRed:1 green:0 blue:1 alpha:1]
  ];

  MDCTonalPalette *tonalPalette =
      [[MDCTonalPalette alloc] initWithColors:tonalColors
                               mainColorIndex:5
                              lightColorIndex:1
                               darkColorIndex:7];

  // When
  NSMutableData *data = [NSMutableData data];

  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver encodeObject:tonalPalette forKey:@"tonalPalette"];
  [archiver finishEncoding];

  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  MDCTonalPalette *decodedTonalPalette = [unarchiver decodeObjectForKey:@"tonalPalette"];
  [unarchiver finishDecoding];

  // Then
  XCTAssertEqual(decodedTonalPalette.colors.count, tonalPalette.colors.count);
  XCTAssertEqual(decodedTonalPalette.mainColorIndex, tonalPalette.mainColorIndex);
  XCTAssertEqual(decodedTonalPalette.darkColorIndex, tonalPalette.darkColorIndex);
  XCTAssertEqual(decodedTonalPalette.lightColorIndex, tonalPalette.lightColorIndex);

  XCTAssertTrue([decodedTonalPalette.colors isEqualToArray:tonalPalette.colors]);
  XCTAssertTrue(CGColorEqualToColor(decodedTonalPalette.lightColor.CGColor,
                                    tonalPalette.lightColor.CGColor));
  XCTAssertTrue(CGColorEqualToColor(decodedTonalPalette.mainColor.CGColor,
                                    tonalPalette.mainColor.CGColor));
  XCTAssertTrue(CGColorEqualToColor(decodedTonalPalette.darkColor.CGColor,
                                    tonalPalette.darkColor.CGColor));
}

@end
