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

@interface UIFont_MaterialScalableTests : XCTestCase

@end

@implementation UIFont_MaterialScalableTests

- (void)testMDC_scaledFontForMaterialTextStyleReturnsEquivalentFonts {
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

- (void)testMDC_scaledFontForMaterialTextStyleCurvesIncrease {
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

    UIFont *scalabledFont = [scaler scalableFontWithFont:font];

    for (unsigned long ii = 0; ii != sizeCategories.count - 1; ++ii) {
      UIContentSizeCategory smallerSizeCategory = sizeCategories[ii];
      UIContentSizeCategory largerSizeCategory = sizeCategories[ii + 1];

      UIFont *smallerFont = [scalabledFont mdc_scaledFontForSizeCategory:smallerSizeCategory];
      UIFont *largerFont = [scalabledFont mdc_scaledFontForSizeCategory:largerSizeCategory];

      // Then
      XCTAssert(smallerFont.pointSize <= largerFont.pointSize);
    }
  }
}

- (void)testMDC_scaledFontDefaultEqualsLarge {
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

@end
