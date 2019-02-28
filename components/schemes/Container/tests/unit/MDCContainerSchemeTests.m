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

#import "MaterialContainerScheme.h"

@interface MDCContainerSchemeTests : XCTestCase
@end

@implementation MDCContainerSchemeTests

- (void)testWithMaterialInit {
  // Given
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // Then
  // Color
  XCTAssertNotNil(containerScheme.colorScheme);
  XCTAssertEqualObjects(containerScheme.colorScheme.primaryColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.primaryColorVariant,
                        colorScheme.primaryColorVariant);
  XCTAssertEqualObjects(containerScheme.colorScheme.secondaryColor, colorScheme.secondaryColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.surfaceColor, colorScheme.surfaceColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.backgroundColor, colorScheme.backgroundColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.onPrimaryColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.onSecondaryColor, colorScheme.onSecondaryColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.onSurfaceColor, colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(containerScheme.colorScheme.onBackgroundColor,
                        colorScheme.onBackgroundColor);
  // Typography
  XCTAssertNotNil(containerScheme.typographyScheme);
  XCTAssertEqualObjects(containerScheme.typographyScheme.headline1, typographyScheme.headline1);
  XCTAssertEqualObjects(containerScheme.typographyScheme.headline2, typographyScheme.headline2);
  XCTAssertEqualObjects(containerScheme.typographyScheme.headline3, typographyScheme.headline3);
  XCTAssertEqualObjects(containerScheme.typographyScheme.headline4, typographyScheme.headline4);
  XCTAssertEqualObjects(containerScheme.typographyScheme.headline5, typographyScheme.headline5);
  XCTAssertEqualObjects(containerScheme.typographyScheme.headline6, typographyScheme.headline6);
  XCTAssertEqualObjects(containerScheme.typographyScheme.subtitle1, typographyScheme.subtitle1);
  XCTAssertEqualObjects(containerScheme.typographyScheme.subtitle2, typographyScheme.subtitle2);
  XCTAssertEqualObjects(containerScheme.typographyScheme.body1, typographyScheme.body1);
  XCTAssertEqualObjects(containerScheme.typographyScheme.body2, typographyScheme.body2);
  XCTAssertEqualObjects(containerScheme.typographyScheme.caption, typographyScheme.caption);
  XCTAssertEqualObjects(containerScheme.typographyScheme.button, typographyScheme.button);
  XCTAssertEqualObjects(containerScheme.typographyScheme.overline, typographyScheme.overline);
  // Shape
  XCTAssertNil(containerScheme.shapeScheme);
}

@end
