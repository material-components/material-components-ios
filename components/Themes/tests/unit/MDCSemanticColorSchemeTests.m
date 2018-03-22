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

#import <XCTest/XCTest.h>
#import "MaterialThemes.h"

@interface MDCSemanticColorSchemeTests : XCTestCase

@end

@implementation MDCSemanticColorSchemeTests

- (void)testSecondaryColorUsesPrimaryColorWhenUnspecified {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithPrimaryColor:UIColor.redColor
                                  primaryColorLightVariant:UIColor.blueColor
                                   primaryColorDarkVariant:UIColor.greenColor
                                            secondaryColor:nil
                                                errorColor:UIColor.orangeColor];

  // Then
  XCTAssertEqual(colorScheme.secondaryColor, colorScheme.primaryColor);
}

- (void)testErrorColorUsesDefaultWhenUnspecified {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithPrimaryColor:UIColor.redColor
                                  primaryColorLightVariant:UIColor.blueColor
                                   primaryColorDarkVariant:UIColor.greenColor
                                            secondaryColor:nil
                                                errorColor:nil];

  // Then
  UIColor *expectedErrorColor = [UIColor colorWithRed:1
                                                green:(float)(0x17 / 255.0)
                                                 blue:(float)(0x44 / 255.0)
                                                alpha:1];
  XCTAssertEqualObjects(colorScheme.errorColor, expectedErrorColor);
}

- (void)testPrimaryColorVariantCompatibility {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithPrimaryColor:UIColor.redColor
                                  primaryColorLightVariant:UIColor.blueColor
                                   primaryColorDarkVariant:UIColor.greenColor
                                            secondaryColor:UIColor.orangeColor
                                                errorColor:UIColor.yellowColor];

  // Then
  XCTAssertEqual(colorScheme.primaryLightColor, colorScheme.primaryColorLightVariant);
  XCTAssertEqual(colorScheme.primaryDarkColor, colorScheme.primaryColorDarkVariant);
}

@end
