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

#import "MaterialThemes.h"

@interface MDCSemanticColorSchemeTests : XCTestCase
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation MDCSemanticColorSchemeTests

- (void)setUp {
  [super setUp];
  self.colorScheme = [[MDCSemanticColorScheme alloc] initWithPrimaryColor:UIColor.redColor
                                                 primaryColorLightVariant:UIColor.blueColor
                                                  primaryColorDarkVariant:UIColor.greenColor
                                                           secondaryColor:UIColor.orangeColor
                                                               errorColor:UIColor.yellowColor
                                                           onPrimaryColor:UIColor.purpleColor
                                                         onSecondaryColor:UIColor.darkGrayColor
                                                          backgroundColor:UIColor.blackColor];
}

- (void)tearDown {
  self.colorScheme = nil;
  [super tearDown];
}

- (void)testInitializerWithAllParameters {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithPrimaryColor:UIColor.redColor
                                  primaryColorLightVariant:UIColor.blueColor
                                   primaryColorDarkVariant:UIColor.greenColor
                                            secondaryColor:UIColor.orangeColor
                                                errorColor:UIColor.yellowColor
                                            onPrimaryColor:UIColor.purpleColor
                                          onSecondaryColor:UIColor.darkGrayColor
                                           backgroundColor:UIColor.blackColor];

  // Then
  XCTAssertEqual(colorScheme.primaryColor, UIColor.redColor);
  XCTAssertEqual(colorScheme.primaryColorLightVariant, UIColor.blueColor);
  XCTAssertEqual(colorScheme.primaryColorDarkVariant, UIColor.greenColor);
  XCTAssertEqual(colorScheme.secondaryColor, UIColor.orangeColor);
  XCTAssertEqual(colorScheme.errorColor, UIColor.yellowColor);
  XCTAssertEqual(colorScheme.onPrimaryColor, UIColor.purpleColor);
  XCTAssertEqual(colorScheme.onSecondaryColor, UIColor.darkGrayColor);
  XCTAssertEqual(colorScheme.backgroundColor, UIColor.blackColor);
}

- (void)testCoding {
  // When
  NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self.colorScheme];
  MDCSemanticColorScheme *unarchivedColorScheme =
      [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];

  // Then
  XCTAssertTrue([MDCSemanticColorScheme supportsSecureCoding]);

  XCTAssertEqualObjects(unarchivedColorScheme.primaryColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.primaryColorLightVariant,
                        self.colorScheme.primaryLightColor);
  XCTAssertEqualObjects(unarchivedColorScheme.primaryColorDarkVariant,
                        self.colorScheme.primaryColorDarkVariant);
  XCTAssertEqualObjects(unarchivedColorScheme.secondaryColor, self.colorScheme.secondaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.errorColor, self.colorScheme.errorColor);
  XCTAssertEqualObjects(unarchivedColorScheme.onPrimaryColor, self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.onSecondaryColor, self.colorScheme.onSecondaryColor);
  XCTAssertEqualObjects(unarchivedColorScheme.backgroundColor, self.colorScheme.backgroundColor);
  XCTAssertEqualObjects(unarchivedColorScheme.primaryLightColor,
                        self.colorScheme.primaryLightColor);
  XCTAssertEqualObjects(unarchivedColorScheme.primaryDarkColor, self.colorScheme.primaryDarkColor);
}

- (void)testPrimaryColorVariantCompatibility {
  // Then
  XCTAssertEqual(self.colorScheme.primaryLightColor, self.colorScheme.primaryColorLightVariant);
  XCTAssertEqual(self.colorScheme.primaryDarkColor, self.colorScheme.primaryColorDarkVariant);
}

@end
