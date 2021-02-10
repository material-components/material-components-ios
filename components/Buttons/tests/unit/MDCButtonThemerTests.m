// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons+ButtonThemer.h"
#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kEpsilonAccuracy = (CGFloat)0.001;

@interface MDCButtonThemerTests : XCTestCase
@end

@implementation MDCButtonThemerTests

- (void)testTextButtonThemer {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  MDCButtonScheme *scheme = [[MDCButtonScheme alloc] init];

  // When
  [MDCTextButtonThemer applyScheme:scheme toButton:button];

  // Then
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  XCTAssertEqualWithAccuracy(button.minimumSize.height, 36, kEpsilonAccuracy);
  XCTAssertEqualObjects(button.backgroundColor, [UIColor clearColor]);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateNormal], colorScheme.primaryColor);
  XCTAssertEqualObjects([button imageTintColorForState:UIControlStateNormal],
                        colorScheme.primaryColor);
  XCTAssertEqualWithAccuracy(button.layer.cornerRadius, 4, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateNormal], 0, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateHighlighted], 0,
                             kEpsilonAccuracy);
  XCTAssertEqualObjects([button titleFontForState:UIControlStateNormal], typographyScheme.button);
  XCTAssertEqualObjects(button.inkColor,
                        [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.16]);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
  XCTAssertEqualObjects([button imageTintColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
}

- (void)testContainedButtonThemer {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  MDCButtonScheme *scheme = [[MDCButtonScheme alloc] init];

  // When
  [MDCContainedButtonThemer applyScheme:scheme toButton:button];

  // Then
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  XCTAssertEqualWithAccuracy(button.minimumSize.height, 36, kEpsilonAccuracy);
  XCTAssertEqualObjects(button.backgroundColor, colorScheme.primaryColor);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateNormal],
                        colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([button imageTintColorForState:UIControlStateNormal],
                        colorScheme.onPrimaryColor);
  XCTAssertEqualWithAccuracy(button.layer.cornerRadius, 4, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateNormal], 2, kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateHighlighted], 8,
                             kEpsilonAccuracy);
  XCTAssertEqualWithAccuracy([button elevationForState:UIControlStateDisabled], 0,
                             kEpsilonAccuracy);
  XCTAssertEqualObjects([button titleFontForState:UIControlStateNormal], typographyScheme.button);
  XCTAssertEqualObjects(button.inkColor,
                        [colorScheme.onPrimaryColor colorWithAlphaComponent:(CGFloat)0.32]);
  XCTAssertEqualObjects([button backgroundColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12]);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
  XCTAssertEqualObjects([button imageTintColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
}

@end
