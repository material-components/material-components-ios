/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "MaterialColorScheme.h"

static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [[UIColor alloc] initWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                                green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                                 blue:(CGFloat)((colorValue & 0xFF) / 255.0) alpha:1];
}

@interface MDCSemanticColorSchemeTests : XCTestCase
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation MDCSemanticColorSchemeTests

- (void)setUp {
  [super setUp];
  self.colorScheme = [[MDCSemanticColorScheme alloc] initWithPrimaryColor:UIColor.redColor
                                                      primaryColorVariant:UIColor.blueColor
                                                           secondaryColor:UIColor.orangeColor
                                                               errorColor:UIColor.yellowColor
                                                             surfaceColor:UIColor.cyanColor
                                                          backgroundColor:UIColor.magentaColor
                                                           onPrimaryColor:UIColor.purpleColor
                                                         onSecondaryColor:UIColor.darkGrayColor
                                                           onSurfaceColor:UIColor.darkTextColor
                                                        onBackgroundColor:UIColor.brownColor];
}

- (void)tearDown {
  self.colorScheme = nil;
  [super tearDown];
}

- (void)testInitializerWithAllParameters {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithPrimaryColor:UIColor.redColor
                                       primaryColorVariant:UIColor.blueColor
                                            secondaryColor:UIColor.orangeColor
                                                errorColor:UIColor.yellowColor
                                              surfaceColor:UIColor.cyanColor
                                           backgroundColor:UIColor.magentaColor
                                            onPrimaryColor:UIColor.purpleColor
                                          onSecondaryColor:UIColor.darkGrayColor
                                            onSurfaceColor:UIColor.darkTextColor
                                         onBackgroundColor:UIColor.brownColor];

  // Then
  XCTAssertEqual(colorScheme.primaryColor, UIColor.redColor);
  XCTAssertEqual(colorScheme.primaryColorVariant, UIColor.blueColor);
  XCTAssertEqual(colorScheme.secondaryColor, UIColor.orangeColor);
  XCTAssertEqual(colorScheme.errorColor, UIColor.yellowColor);
  XCTAssertEqual(colorScheme.surfaceColor, UIColor.cyanColor);
  XCTAssertEqual(colorScheme.backgroundColor, UIColor.magentaColor);
  XCTAssertEqual(colorScheme.onPrimaryColor, UIColor.purpleColor);
  XCTAssertEqual(colorScheme.onSecondaryColor, UIColor.darkGrayColor);
  XCTAssertEqual(colorScheme.onSurfaceColor, UIColor.darkTextColor);
  XCTAssertEqual(colorScheme.onBackgroundColor, UIColor.brownColor);
}

- (void)testCoding {
  // When
  NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self.colorScheme];
  MDCSemanticColorScheme *unarchivedColorScheme =
      [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];

  // Then
  XCTAssertTrue([MDCSemanticColorScheme supportsSecureCoding]);

  XCTAssertEqualObjects(unarchivedColorScheme.primaryColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.primaryColorVariant,
                        self.colorScheme.primaryColorVariant);
  XCTAssertEqualObjects(unarchivedColorScheme.secondaryColor, self.colorScheme.secondaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.errorColor, self.colorScheme.errorColor);
  XCTAssertEqualObjects(unarchivedColorScheme.surfaceColor, self.colorScheme.surfaceColor);
  XCTAssertEqualObjects(unarchivedColorScheme.backgroundColor, self.colorScheme.backgroundColor);
  XCTAssertEqualObjects(unarchivedColorScheme.onPrimaryColor, self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.onSecondaryColor, self.colorScheme.onSecondaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.onSurfaceColor, self.colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(unarchivedColorScheme.onBackgroundColor,
                        self.colorScheme.onBackgroundColor);
}

- (void)testInitMatchesInitWithMaterialDefaults {
  // Given
  MDCSemanticColorScheme *initScheme = [[MDCSemanticColorScheme alloc] init];
  MDCSemanticColorScheme *mdDefaultScheme = [[MDCSemanticColorScheme alloc]
                                             initWithMaterialDefaults];

  // Then
  XCTAssertEqualObjects(initScheme.primaryColor, mdDefaultScheme.primaryColor);
  XCTAssertEqualObjects(initScheme.primaryColorVariant, mdDefaultScheme.primaryColorVariant);
  XCTAssertEqualObjects(initScheme.secondaryColor, mdDefaultScheme.secondaryColor);
  XCTAssertEqualObjects(initScheme.errorColor, mdDefaultScheme.errorColor);
  XCTAssertEqualObjects(initScheme.surfaceColor, mdDefaultScheme.surfaceColor);
  XCTAssertEqualObjects(initScheme.backgroundColor, mdDefaultScheme.backgroundColor);
  XCTAssertEqualObjects(initScheme.onPrimaryColor, mdDefaultScheme.onPrimaryColor);
  XCTAssertEqualObjects(initScheme.onSecondaryColor, mdDefaultScheme.onSecondaryColor);
  XCTAssertEqualObjects(initScheme.onSurfaceColor, mdDefaultScheme.onSurfaceColor);
  XCTAssertEqualObjects(initScheme.onBackgroundColor, mdDefaultScheme.onBackgroundColor);
}

- (void)testInitWithMaterialDefaults {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithMaterialDefaults];

  // Then
  XCTAssertEqualObjects(colorScheme.primaryColor, ColorFromRGB(0x6200EE));
  XCTAssertEqualObjects(colorScheme.primaryColorVariant, ColorFromRGB(0x3700B3));
  XCTAssertEqualObjects(colorScheme.secondaryColor, ColorFromRGB(0x03DAC6));
  XCTAssertEqualObjects(colorScheme.errorColor, ColorFromRGB(0xFF1744));
  XCTAssertEqualObjects(colorScheme.surfaceColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.backgroundColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.onPrimaryColor, ColorFromRGB(0xFFFFFF));
  XCTAssertEqualObjects(colorScheme.onSecondaryColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onSurfaceColor, ColorFromRGB(0x000000));
  XCTAssertEqualObjects(colorScheme.onBackgroundColor, ColorFromRGB(0x000000));
}

@end
