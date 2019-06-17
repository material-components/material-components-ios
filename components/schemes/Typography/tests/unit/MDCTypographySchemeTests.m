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

- (void)
    testMdc_adjustsFontForContentSizeCategoryIsMappedToUseCurrentContentSizeCategoryWhenApplied {
  // Given
  MDCTypographyScheme *scheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // When
  scheme.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertTrue(scheme.useCurrentContentSizeCategoryWhenApplied);

  // When
  scheme.mdc_adjustsFontForContentSizeCategory = NO;

  // Then
  XCTAssertFalse(scheme.useCurrentContentSizeCategoryWhenApplied);

  // When (just in case the initial "truth" equality was a coincidence)
  scheme.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertTrue(scheme.useCurrentContentSizeCategoryWhenApplied);
}

- (void)test201902ScalesOniOS10AndUpWhenTraitEnvironmentIsProvided {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCTypographyScheme *schemeWithNoTraitCollection =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

    // When
    UITraitCollection *traitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraExtraLarge];
    id<MDCTypographyScheming> scheme =
        [MDCTypographyScheme resolveScheme:schemeWithNoTraitCollection
                        forTraitCollection:traitCollection];

    // Then
    XCTAssertGreaterThanOrEqual(scheme.headline1.pointSize,
                                schemeWithNoTraitCollection.headline1.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.headline2.pointSize,
                                schemeWithNoTraitCollection.headline2.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.headline3.pointSize,
                                schemeWithNoTraitCollection.headline3.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.headline4.pointSize,
                                schemeWithNoTraitCollection.headline4.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.headline5.pointSize,
                                schemeWithNoTraitCollection.headline5.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.headline6.pointSize,
                                schemeWithNoTraitCollection.headline6.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.subtitle1.pointSize,
                                schemeWithNoTraitCollection.subtitle1.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.subtitle2.pointSize,
                                schemeWithNoTraitCollection.subtitle2.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.body1.pointSize,
                                schemeWithNoTraitCollection.body1.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.body2.pointSize,
                                schemeWithNoTraitCollection.body2.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.caption.pointSize,
                                schemeWithNoTraitCollection.caption.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.button.pointSize,
                                schemeWithNoTraitCollection.button.pointSize);
    XCTAssertGreaterThanOrEqual(scheme.overline.pointSize,
                                schemeWithNoTraitCollection.overline.pointSize);
  }
}

- (void)test201804DoesNotScaleOniOS10AndUpWhenTraitEnvironmentIsProvided {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCTypographyScheme *schemeWithNoTraitCollection =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

    // When
    UITraitCollection *traitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraLarge];
    id<MDCTypographyScheming> scheme =
        [MDCTypographyScheme resolveScheme:schemeWithNoTraitCollection
                        forTraitCollection:traitCollection];

    // Then
    XCTAssertEqual(scheme.headline1.pointSize, schemeWithNoTraitCollection.headline1.pointSize);
    XCTAssertEqual(scheme.headline2.pointSize, schemeWithNoTraitCollection.headline2.pointSize);
    XCTAssertEqual(scheme.headline3.pointSize, schemeWithNoTraitCollection.headline3.pointSize);
    XCTAssertEqual(scheme.headline4.pointSize, schemeWithNoTraitCollection.headline4.pointSize);
    XCTAssertEqual(scheme.headline5.pointSize, schemeWithNoTraitCollection.headline5.pointSize);
    XCTAssertEqual(scheme.headline6.pointSize, schemeWithNoTraitCollection.headline6.pointSize);
    XCTAssertEqual(scheme.subtitle1.pointSize, schemeWithNoTraitCollection.subtitle1.pointSize);
    XCTAssertEqual(scheme.subtitle2.pointSize, schemeWithNoTraitCollection.subtitle2.pointSize);
    XCTAssertEqual(scheme.body1.pointSize, schemeWithNoTraitCollection.body1.pointSize);
    XCTAssertEqual(scheme.body2.pointSize, schemeWithNoTraitCollection.body2.pointSize);
    XCTAssertEqual(scheme.caption.pointSize, schemeWithNoTraitCollection.caption.pointSize);
    XCTAssertEqual(scheme.button.pointSize, schemeWithNoTraitCollection.button.pointSize);
    XCTAssertEqual(scheme.overline.pointSize, schemeWithNoTraitCollection.overline.pointSize);
  }
}

@end
