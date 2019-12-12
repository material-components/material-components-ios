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

#import <MaterialComponents/MaterialTypography.h>

@interface MDCTypographySchemeTests : XCTestCase
@end

@implementation MDCTypographySchemeTests

- (void)testInitializer {
  // Given
  MDCTypographyScheme *latestScheme = [[MDCTypographyScheme alloc] init];
  // The following scheme should be explicitly initialized to the LATEST scheme
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
  MDCTypographyScheme *scheme201804 =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // Then
  XCTAssertNil(scheme201804.headline1.mdc_scalingCurve);
  XCTAssertNil(scheme201804.headline2.mdc_scalingCurve);
  XCTAssertNil(scheme201804.headline3.mdc_scalingCurve);
  XCTAssertNil(scheme201804.headline4.mdc_scalingCurve);
  XCTAssertNil(scheme201804.headline5.mdc_scalingCurve);
  XCTAssertNil(scheme201804.headline6.mdc_scalingCurve);
  XCTAssertNil(scheme201804.subtitle1.mdc_scalingCurve);
  XCTAssertNil(scheme201804.subtitle2.mdc_scalingCurve);
  XCTAssertNil(scheme201804.body1.mdc_scalingCurve);
  XCTAssertNil(scheme201804.body2.mdc_scalingCurve);
  XCTAssertNil(scheme201804.caption.mdc_scalingCurve);
  XCTAssertNil(scheme201804.button.mdc_scalingCurve);
  XCTAssertNil(scheme201804.overline.mdc_scalingCurve);
}

- (void)testTypographyScheme201902DoesHaveCurves {
  // Given
  MDCTypographyScheme *scheme201902 =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // Then
  XCTAssertNotNil(scheme201902.headline1.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.headline2.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.headline3.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.headline4.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.headline5.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.headline6.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.subtitle1.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.subtitle2.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.body1.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.body2.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.caption.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.button.mdc_scalingCurve);
  XCTAssertNotNil(scheme201902.overline.mdc_scalingCurve);
}

- (void)testTypographyScheme201902ReturnsDefaultSizedFonts {
  // Given
  MDCTypographyScheme *scheme201902 =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // Then
  XCTAssert([scheme201902.headline1
      mdc_isSimplyEqual:[scheme201902.headline1 mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.headline2
      mdc_isSimplyEqual:[scheme201902.headline2 mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.headline3
      mdc_isSimplyEqual:[scheme201902.headline3 mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.headline4
      mdc_isSimplyEqual:[scheme201902.headline4 mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.headline5
      mdc_isSimplyEqual:[scheme201902.headline5 mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.headline6
      mdc_isSimplyEqual:[scheme201902.headline6 mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.subtitle1
      mdc_isSimplyEqual:[scheme201902.subtitle1 mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.subtitle2
      mdc_isSimplyEqual:[scheme201902.subtitle2 mdc_scaledFontAtDefaultSize]]);
  XCTAssert(
      [scheme201902.body1 mdc_isSimplyEqual:[scheme201902.body1 mdc_scaledFontAtDefaultSize]]);
  XCTAssert(
      [scheme201902.body2 mdc_isSimplyEqual:[scheme201902.body2 mdc_scaledFontAtDefaultSize]]);
  XCTAssert(
      [scheme201902.caption mdc_isSimplyEqual:[scheme201902.caption mdc_scaledFontAtDefaultSize]]);
  XCTAssert(
      [scheme201902.button mdc_isSimplyEqual:[scheme201902.button mdc_scaledFontAtDefaultSize]]);
  XCTAssert([scheme201902.overline
      mdc_isSimplyEqual:[scheme201902.overline mdc_scaledFontAtDefaultSize]]);
}

- (void)testTypographyScheme201804UseCurrentContentSizeCategoryWhenAppliedIsDisabledByDefault {
  // Given
  MDCTypographyScheme *scheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // Then
  XCTAssertFalse(scheme.useCurrentContentSizeCategoryWhenApplied);
}

- (void)testTypographyScheme201902UseCurrentContentSizeCategoryWhenAppliedIsDisabledByDefault {
  // Given
  MDCTypographyScheme *scheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // Then
  XCTAssertFalse(scheme.useCurrentContentSizeCategoryWhenApplied);
}

@end
