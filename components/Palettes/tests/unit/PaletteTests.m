// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <XCTest/XCTest.h>

#import "MaterialPalettes.h"

static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [UIColor colorWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                         green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                          blue:(CGFloat)((colorValue & 0xFF) / 255.0)
                         alpha:1];
}

@interface PaletteTests : XCTestCase

@end

@implementation PaletteTests

- (void)testBasics {
  UIColor *color = MDCPalette.redPalette.tint50;
  XCTAssertEqualObjects(color, ColorFromRGB(0xFFEBEE));
}

- (void)testCaching {
  MDCPalette *first = MDCPalette.redPalette;
  MDCPalette *second = MDCPalette.redPalette;
  XCTAssertTrue(first == second);
}

- (void)testAccentlessPalette {
  MDCPalette *brownPalette = MDCPalette.brownPalette;
  XCTAssertNil(brownPalette.accent100);
}

- (void)testGeneratedPalette {
  MDCPalette *palette = [MDCPalette paletteGeneratedFromColor:[UIColor colorWithRed:(CGFloat)1
                                                                              green:(CGFloat)0
                                                                               blue:(CGFloat)0
                                                                              alpha:(CGFloat)1]];
  XCTAssertNotNil(palette.tint50);
  XCTAssertNotNil(palette.tint100);
  XCTAssertNotNil(palette.tint200);
  XCTAssertNotNil(palette.tint300);
  XCTAssertNotNil(palette.tint400);
  XCTAssertNotNil(palette.tint500);
  XCTAssertNotNil(palette.tint600);
  XCTAssertNotNil(palette.tint700);
  XCTAssertNotNil(palette.tint800);
  XCTAssertNotNil(palette.tint900);
  XCTAssertNotNil(palette.accent100);
  XCTAssertNotNil(palette.accent200);
  XCTAssertNotNil(palette.accent400);
  XCTAssertNotNil(palette.accent700);
}

- (void)testCustomPalette {
  NSDictionary<MDCPaletteTint, UIColor *> *tints = @{
    MDCPaletteTint50Name : [UIColor colorWithWhite:(CGFloat)0 alpha:(CGFloat)1],
    MDCPaletteTint100Name : [UIColor colorWithWhite:(CGFloat)0.1 alpha:(CGFloat)1],
    MDCPaletteTint200Name : [UIColor colorWithWhite:(CGFloat)0.2 alpha:(CGFloat)1],
    MDCPaletteTint300Name : [UIColor colorWithWhite:(CGFloat)0.3 alpha:(CGFloat)1],
    MDCPaletteTint400Name : [UIColor colorWithWhite:(CGFloat)0.4 alpha:(CGFloat)1],
    MDCPaletteTint500Name : [UIColor colorWithWhite:(CGFloat)0.5 alpha:(CGFloat)1],
    MDCPaletteTint600Name : [UIColor colorWithWhite:(CGFloat)0.6 alpha:(CGFloat)1],
    MDCPaletteTint700Name : [UIColor colorWithWhite:(CGFloat)0.7 alpha:(CGFloat)1],
    MDCPaletteTint800Name : [UIColor colorWithWhite:(CGFloat)0.8 alpha:(CGFloat)1],
    MDCPaletteTint900Name : [UIColor colorWithWhite:(CGFloat)0.9 alpha:(CGFloat)1],
  };
  NSDictionary<MDCPaletteAccent, UIColor *> *accents = @{
    MDCPaletteAccent100Name : [UIColor colorWithWhite:(CGFloat)1 alpha:(CGFloat)0],
    MDCPaletteAccent200Name : [UIColor colorWithWhite:(CGFloat)1 alpha:(CGFloat)0.25],
    MDCPaletteAccent400Name : [UIColor colorWithWhite:(CGFloat)1 alpha:(CGFloat)0.75],
    MDCPaletteAccent700Name : [UIColor colorWithWhite:(CGFloat)1 alpha:(CGFloat)1],
  };
  MDCPalette *palette = [MDCPalette paletteWithTints:tints accents:accents];

  XCTAssertEqual(palette.tint50, tints[MDCPaletteTint50Name]);
  XCTAssertEqual(palette.tint100, tints[MDCPaletteTint100Name]);
  XCTAssertEqual(palette.tint200, tints[MDCPaletteTint200Name]);
  XCTAssertEqual(palette.tint300, tints[MDCPaletteTint300Name]);
  XCTAssertEqual(palette.tint400, tints[MDCPaletteTint400Name]);
  XCTAssertEqual(palette.tint500, tints[MDCPaletteTint500Name]);
  XCTAssertEqual(palette.tint600, tints[MDCPaletteTint600Name]);
  XCTAssertEqual(palette.tint700, tints[MDCPaletteTint700Name]);
  XCTAssertEqual(palette.tint800, tints[MDCPaletteTint800Name]);
  XCTAssertEqual(palette.tint900, tints[MDCPaletteTint900Name]);
  XCTAssertEqual(palette.accent100, accents[MDCPaletteAccent100Name]);
  XCTAssertEqual(palette.accent200, accents[MDCPaletteAccent200Name]);
  XCTAssertEqual(palette.accent400, accents[MDCPaletteAccent400Name]);
  XCTAssertEqual(palette.accent700, accents[MDCPaletteAccent700Name]);
}

@end
