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

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "MaterialTypographyScheme.h"

#import "MaterialTypography.h"

@interface MDCTypographySchemeTests : XCTestCase
@end

@implementation MDCTypographySchemeTests

- (void)testInitializer {
  // Given
  MDCTypographyScheme *latestScheme = [[MDCTypographyScheme alloc] init];
  MDCTypographyScheme *scheme201902 =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // Then
  XCTAssertEqual(latestScheme.headline1, scheme201902.headline1);
  XCTAssertEqual(latestScheme.headline2, scheme201902.headline2);
  XCTAssertEqual(latestScheme.headline3, scheme201902.headline3);
  XCTAssertEqual(latestScheme.headline4, scheme201902.headline4);
  XCTAssertEqual(latestScheme.headline5, scheme201902.headline5);
  XCTAssertEqual(latestScheme.headline6, scheme201902.headline6);
  XCTAssertEqual(latestScheme.subtitle1, scheme201902.subtitle1);
  XCTAssertEqual(latestScheme.subtitle2, scheme201902.subtitle2);
  XCTAssertEqual(latestScheme.body1, scheme201902.body1);
  XCTAssertEqual(latestScheme.body2, scheme201902.body2);
  XCTAssertEqual(latestScheme.caption, scheme201902.caption);
  XCTAssertEqual(latestScheme.button, scheme201902.button);
  XCTAssertEqual(latestScheme.overline, scheme201902.overline);
}

- (void)testTypographySchemeCopy {
  // Given
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];

  // When
  MDCTypographyScheme *typographySchemeCopy = [typographyScheme copy];

  // Then
  XCTAssertNotEqual(typographyScheme, typographySchemeCopy);
  XCTAssertEqualObjects(typographyScheme.headline1, typographySchemeCopy.headline1);
  XCTAssertEqualObjects(typographyScheme.headline2, typographySchemeCopy.headline2);
  XCTAssertEqualObjects(typographyScheme.headline3, typographySchemeCopy.headline3);
  XCTAssertEqualObjects(typographyScheme.headline4, typographySchemeCopy.headline4);
  XCTAssertEqualObjects(typographyScheme.headline5, typographySchemeCopy.headline5);
  XCTAssertEqualObjects(typographyScheme.headline6, typographySchemeCopy.headline6);
  XCTAssertEqualObjects(typographyScheme.subtitle1, typographySchemeCopy.subtitle1);
  XCTAssertEqualObjects(typographyScheme.subtitle2, typographySchemeCopy.subtitle2);
  XCTAssertEqualObjects(typographyScheme.body1, typographySchemeCopy.body1);
  XCTAssertEqualObjects(typographyScheme.body2, typographySchemeCopy.body2);
  XCTAssertEqualObjects(typographyScheme.caption, typographySchemeCopy.caption);
  XCTAssertEqualObjects(typographyScheme.button, typographySchemeCopy.button);
  XCTAssertEqualObjects(typographyScheme.overline, typographySchemeCopy.overline);
}

// In order to avoid unintended consequences for our clients, ensure that our earlier typography
// scheme does NOT return fonts with associated scaling curves.
- (void)testTypographyScheme201804DoesNotHaveCurves {
  // Given
  MDCTypographyScheme *scheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // Then
  XCTAssertNil(scheme.headline1.mdc_scalingCurve);
  XCTAssertNil(scheme.headline2.mdc_scalingCurve);
  XCTAssertNil(scheme.headline3.mdc_scalingCurve);
  XCTAssertNil(scheme.headline4.mdc_scalingCurve);
  XCTAssertNil(scheme.headline5.mdc_scalingCurve);
  XCTAssertNil(scheme.headline6.mdc_scalingCurve);
  XCTAssertNil(scheme.subtitle1.mdc_scalingCurve);
  XCTAssertNil(scheme.subtitle2.mdc_scalingCurve);
  XCTAssertNil(scheme.body1.mdc_scalingCurve);
  XCTAssertNil(scheme.body2.mdc_scalingCurve);
  XCTAssertNil(scheme.caption.mdc_scalingCurve);
  XCTAssertNil(scheme.button.mdc_scalingCurve);
  XCTAssertNil(scheme.overline.mdc_scalingCurve);
}

- (void)testTypographyScheme201902HasCurves {
  // Given
  MDCTypographyScheme *scheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // Then
  XCTAssertNotNil(scheme.headline1.mdc_scalingCurve);
  XCTAssertNotNil(scheme.headline2.mdc_scalingCurve);
  XCTAssertNotNil(scheme.headline3.mdc_scalingCurve);
  XCTAssertNotNil(scheme.headline4.mdc_scalingCurve);
  XCTAssertNotNil(scheme.headline5.mdc_scalingCurve);
  XCTAssertNotNil(scheme.headline6.mdc_scalingCurve);
  XCTAssertNotNil(scheme.subtitle1.mdc_scalingCurve);
  XCTAssertNotNil(scheme.subtitle2.mdc_scalingCurve);
  XCTAssertNotNil(scheme.body1.mdc_scalingCurve);
  XCTAssertNotNil(scheme.body2.mdc_scalingCurve);
  XCTAssertNotNil(scheme.caption.mdc_scalingCurve);
  XCTAssertNotNil(scheme.button.mdc_scalingCurve);
  XCTAssertNotNil(scheme.overline.mdc_scalingCurve);
}

@end
