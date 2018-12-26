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
#import "MaterialTypography.h"

@interface UIFont_MaterialTypographyTests : XCTestCase

@end

@implementation UIFont_MaterialTypographyTests

- (void)testMDC_standardFontForMaterialTextStyleReturnsEquivalentFonts {
  // Given
  NSArray<NSNumber *> *textStyles = @[
    @(MDCFontTextStyleTitle), @(MDCFontTextStyleBody1), @(MDCFontTextStyleBody2),
    @(MDCFontTextStyleButton), @(MDCFontTextStyleCaption), @(MDCFontTextStyleDisplay1),
    @(MDCFontTextStyleDisplay2), @(MDCFontTextStyleDisplay3), @(MDCFontTextStyleDisplay4),
    @(MDCFontTextStyleHeadline), @(MDCFontTextStyleSubheadline)
  ];

  for (NSNumber *textStyleNumber in textStyles) {
    MDCFontTextStyle textStyle = [textStyleNumber integerValue];

    // When
    UIFont *font1 = [UIFont mdc_standardFontForMaterialTextStyle:textStyle];
    UIFont *font2 = [UIFont mdc_standardFontForMaterialTextStyle:textStyle];

    // Then
    XCTAssertEqualObjects(font1, font2);
  }
}

@end
