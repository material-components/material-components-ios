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

#import "MaterialTypography.h"

#import "MaterialMath.h"
#import "../../src/private/UIContentSizeCategory+Material.h"

@interface UIFont_MaterialScalableTests : XCTestCase

@end

@implementation UIFont_MaterialScalableTests

- (void)testScaledFontsReturnEquivalentFonts {
  // Given
  NSArray<MDCTextStyle> *textStyles = @[
    MDCTextStyleHeadline1,
    MDCTextStyleHeadline2,
    MDCTextStyleHeadline3,
    MDCTextStyleHeadline4,
    MDCTextStyleHeadline5,
    MDCTextStyleHeadline6,
    MDCTextStyleSubtitle1,
    MDCTextStyleSubtitle2,
    MDCTextStyleBody1,
    MDCTextStyleBody2,
    MDCTextStyleButton,
    MDCTextStyleCaption,
    MDCTextStyleOverline,
  ];

  for (MDCTextStyle textStyle in textStyles) {
    // When
    UIFont *font1 = [UIFont systemFontOfSize:18.0];
    UIFont *font2 = [UIFont systemFontOfSize:18.0];

    MDCFontScaler *scaler1 = [[MDCFontScaler alloc] initForMaterialTextStyle:textStyle];
    MDCFontScaler *scaler2 = [[MDCFontScaler alloc] initForMaterialTextStyle:textStyle];

    UIFont *scaledFont1 = [scaler1 scalableFontWithFont:font1];
    UIFont *scaledFont2 = [scaler2 scalableFontWithFont:font2];

    // Then
    XCTAssert([font1 mdc_isSimplyEqual:font2]);
    XCTAssert([scaledFont1 mdc_isSimplyEqual:scaledFont2]);
  }
}

- (void)testScalingCurvesIncrease {
  // Given
  NSArray<MDCTextStyle> *textStyles = @[
    MDCTextStyleHeadline1,
    MDCTextStyleHeadline2,
    MDCTextStyleHeadline3,
    MDCTextStyleHeadline4,
    MDCTextStyleHeadline5,
    MDCTextStyleHeadline6,
    MDCTextStyleSubtitle1,
    MDCTextStyleSubtitle2,
    MDCTextStyleBody1,
    MDCTextStyleBody2,
    MDCTextStyleButton,
    MDCTextStyleCaption,
    MDCTextStyleOverline,
  ];

  // The following array MUST be ordered from smallest to largest
  NSArray<UIContentSizeCategory> *sizeCategories = @[
    UIContentSizeCategoryExtraSmall,
    UIContentSizeCategorySmall,
    UIContentSizeCategoryMedium,
    UIContentSizeCategoryLarge,
    UIContentSizeCategoryExtraLarge,
    UIContentSizeCategoryExtraExtraLarge,
    UIContentSizeCategoryExtraExtraExtraLarge,
    UIContentSizeCategoryAccessibilityMedium,
    UIContentSizeCategoryAccessibilityLarge,
    UIContentSizeCategoryAccessibilityExtraLarge,
    UIContentSizeCategoryAccessibilityExtraExtraLarge,
    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge,
  ];

  for (MDCTextStyle textStyle in textStyles) {
    // When
    UIFont *font = [UIFont systemFontOfSize:18.0];

    MDCFontScaler *scaler = [[MDCFontScaler alloc] initForMaterialTextStyle:textStyle];

    UIFont *scalableFont = [scaler scalableFontWithFont:font];

    for (unsigned long ii = 0; ii < sizeCategories.count - 1; ++ii) {
      UIContentSizeCategory smallerSizeCategory = sizeCategories[ii];
      UIContentSizeCategory largerSizeCategory = sizeCategories[ii + 1];

      UIFont *smallerFont = [scalableFont mdc_scaledFontForSizeCategory:smallerSizeCategory];
      UIFont *largerFont = [scalableFont mdc_scaledFontForSizeCategory:largerSizeCategory];

      // Then
      XCTAssert(smallerFont.pointSize <= largerFont.pointSize);
    }
  }
}

- (void)testScaledFontDefaultEqualsLarge {
  // Given
  NSArray<MDCTextStyle> *textStyles = @[
    MDCTextStyleHeadline1,
    MDCTextStyleHeadline2,
    MDCTextStyleHeadline3,
    MDCTextStyleHeadline4,
    MDCTextStyleHeadline5,
    MDCTextStyleHeadline6,
    MDCTextStyleSubtitle1,
    MDCTextStyleSubtitle2,
    MDCTextStyleBody1,
    MDCTextStyleBody2,
    MDCTextStyleButton,
    MDCTextStyleCaption,
    MDCTextStyleOverline,
  ];

  for (MDCTextStyle textStyle in textStyles) {
    // When
    UIFont *font = [UIFont systemFontOfSize:18.0];

    MDCFontScaler *scaler = [[MDCFontScaler alloc] initForMaterialTextStyle:textStyle];

    UIFont *scalabledFont = [scaler scalableFontWithFont:font];

    UIFont *defaultFont = [scalabledFont mdc_scaledFontAtDefaultSize];
    UIFont *largeFont = [scalabledFont mdc_scaledFontForSizeCategory:UIContentSizeCategoryLarge];

    // Then
    XCTAssert([defaultFont mdc_isSimplyEqual:largeFont]);
  }
}

- (void)testInvalidStyleFallback {
  // Given
  UIFont *font = [UIFont systemFontOfSize:18.0];

  MDCFontScaler *scaler1 = [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleBody1];
  MDCFontScaler *scaler2 =
      [[MDCFontScaler alloc] initForMaterialTextStyle:@"IntentionallyNonTextStyleString"];

  UIFont *scalableFont1 = [scaler1 scalableFontWithFont:font];
  UIFont *scalableFont2 = [scaler2 scalableFontWithFont:font];

  UIFont *scaledFont1 = [scalableFont1 mdc_scaledFontAtDefaultSize];
  UIFont *scaledFont2 = [scalableFont2 mdc_scaledFontAtDefaultSize];

  // Then
  XCTAssert([scaledFont1 mdc_isSimplyEqual:scaledFont2]);
}

- (void)testNonScaledFontReturnsSelf {
  // Given
  UIFont *font = [UIFont systemFontOfSize:18.0];

  // Note that no scaling curve has been attached to the font, so it will NOT scale
  UIFont *nonScaledFont1 = [font mdc_scaledFontForSizeCategory:UIContentSizeCategoryExtraLarge];

  // Then
  XCTAssert([font mdc_isSimplyEqual:nonScaledFont1]);
}

- (void)testNegativeAndZeroScalingCurve {
  // Given
  UIFont *font = [UIFont systemFontOfSize:18.0];

  NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
    UIContentSizeCategoryExtraSmall : @0,
    UIContentSizeCategorySmall : @0,
    UIContentSizeCategoryMedium : @0,
    UIContentSizeCategoryLarge : @0,
    UIContentSizeCategoryExtraLarge : @0,
    UIContentSizeCategoryExtraExtraLarge : @0,
    UIContentSizeCategoryExtraExtraExtraLarge : @0,
    UIContentSizeCategoryAccessibilityMedium : @-1,
    UIContentSizeCategoryAccessibilityLarge : @-1,
    UIContentSizeCategoryAccessibilityExtraLarge : @-1,
    UIContentSizeCategoryAccessibilityExtraExtraLarge : @-1,
    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @-1,
  };

  font.mdc_scalingCurve = scalingCurve;

  // Note that scaling curve is 0 @ UIContentSizeCategoryExtraExtraExtraLarge so this font should be
  // the same size.
  UIFont *zeroScaledFont =
      [font mdc_scaledFontForSizeCategory:UIContentSizeCategoryExtraExtraExtraLarge];

  // Note that scaling curve is -1 @ UIContentSizeCategoryAccessibilityExtraExtraExtraLarge so this
  // font should be the same size.
  UIFont *negativeScaledFont =
      [font mdc_scaledFontForSizeCategory:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];

  // Then
  XCTAssert([font mdc_isSimplyEqual:zeroScaledFont]);
  XCTAssert([font mdc_isSimplyEqual:negativeScaledFont]);
}

- (void)testIncompleteScalingCurve {
  // Given
  UIFont *font = [UIFont systemFontOfSize:20.0];

  const CGFloat curvePointSize = 12.0;

  // This curve is missing all values over Medius
  NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
    UIContentSizeCategoryExtraSmall : @(curvePointSize),
    UIContentSizeCategorySmall : @(curvePointSize),
    UIContentSizeCategoryMedium : @(curvePointSize),
  };

  font.mdc_scalingCurve = scalingCurve;

  UIFont *mediumScaledFont = [font mdc_scaledFontForSizeCategory:UIContentSizeCategoryMedium];

  UIFont *missingCurveScaledFont =
      [font mdc_scaledFontForSizeCategory:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];

  // Then
  XCTAssertTrue(MDCCGFloatEqual(mediumScaledFont.pointSize, curvePointSize));
  XCTAssert([font mdc_isSimplyEqual:missingCurveScaledFont]);
}

- (void)testValueScaling {
  // Given
  UIFont *originalFont = [UIFont systemFontOfSize:20.0];
  CGFloat originalValue = 10.0;

  MDCFontScaler *scaler = [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleHeadline1];
  UIFont *scalableFont = [scaler scalableFontWithFont:originalFont];

  // When
  UIFont *defaultFont = [scalableFont mdc_scaledFontAtDefaultSize];
  UIFont *currentFont = [scalableFont mdc_scaledFontForCurrentSizeCategory];

  CGFloat scalerScaledValue = [scaler scaledValueForValue:originalValue];
  CGFloat fontScaledValue = [scalableFont mdc_scaledValueForValue:originalValue];

  CGFloat sizeScaleFactor = currentFont.pointSize / defaultFont.pointSize;
  CGFloat scalerScaleFactor = scalerScaledValue / originalValue;
  CGFloat fontScaleFactor = fontScaledValue / originalValue;

  //Then
  XCTAssertTrue(MDCCGFloatEqual(sizeScaleFactor, scalerScaleFactor));
  XCTAssertTrue(MDCCGFloatEqual(scalerScaleFactor, fontScaleFactor));
}

@end
