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

#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"
#import "MDCTextButtonThemer.h"
#import "MDCContainedButtonThemer.h"

static const CGFloat kEpsilonAccuracy = 0.001f;

@interface ButtonThemerTests : XCTestCase
@end

@implementation ButtonThemerTests

- (void)testTextButtonThemer {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  MDCButtonScheme *scheme = [[MDCButtonScheme alloc] init];

  // When
  [MDCTextButtonThemer applyScheme:scheme toButton:button];

  // Then
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  XCTAssertEqualWithAccuracy(button.minimumSize.height, 36, kEpsilonAccuracy);
  XCTAssertEqualObjects(button.backgroundColor, [UIColor clearColor]);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateNormal], colorScheme.primaryColor);
  XCTAssertEqualWithAccuracy(button.layer.cornerRadius, 4, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateNormal], 0, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateHighlighted], 0,
                             kEpsilonAccuracy);
  XCTAssertEqualObjects([button titleFontForState:UIControlStateNormal], typographyScheme.button);
  XCTAssertEqualObjects(button.inkColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.16f]);
}

- (void)testContainedButtonThemer {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  MDCButtonScheme *scheme = [[MDCButtonScheme alloc] init];

  // When
  [MDCContainedButtonThemer applyScheme:scheme toButton:button];

  // Then
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  XCTAssertEqualWithAccuracy(button.minimumSize.height, 36, kEpsilonAccuracy);
  XCTAssertEqualObjects(button.backgroundColor, colorScheme.primaryColor);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateNormal],
                        colorScheme.onPrimaryColor);
  XCTAssertEqualWithAccuracy(button.layer.cornerRadius, 4, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateNormal], 2, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateHighlighted], 8,
                             kEpsilonAccuracy);
  XCTAssertEqualObjects([button titleFontForState:UIControlStateNormal], typographyScheme.button);
}

@end
