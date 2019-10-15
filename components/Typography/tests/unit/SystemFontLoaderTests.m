// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

@interface SystemFontLoaderTests : XCTestCase

@end

@implementation SystemFontLoaderTests

- (void)testWeights {
  // Given
  CGFloat size = 10.0;
  MDCSystemFontLoader *fontLoader = [[MDCSystemFontLoader alloc] init];

  // Then
  XCTAssertEqual([fontLoader lightFontOfSize:size], [UIFont systemFontOfSize:size
                                                                      weight:UIFontWeightLight]);
  XCTAssertEqual([fontLoader regularFontOfSize:size],
                 [UIFont systemFontOfSize:size weight:UIFontWeightRegular]);
  XCTAssertEqual([fontLoader mediumFontOfSize:size], [UIFont systemFontOfSize:size
                                                                       weight:UIFontWeightMedium]);
  XCTAssertEqual([fontLoader boldFontOfSize:size], [UIFont systemFontOfSize:size
                                                                     weight:UIFontWeightSemibold]);
  UIFontDescriptor *fontDescriptorWithBoldItalic = [[UIFont systemFontOfSize:size].fontDescriptor
      fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold | UIFontDescriptorTraitItalic];
  XCTAssertEqual([fontLoader boldItalicFontOfSize:size],
                 [UIFont fontWithDescriptor:fontDescriptorWithBoldItalic size:size]);
  XCTAssertEqual([fontLoader italicFontOfSize:size], [UIFont italicSystemFontOfSize:size]);
}

- (void)testIsLargeForContrastRatio {
  // Given
  CGFloat smallSize = 10;
  CGFloat largeIfBoldSize = 15;
  CGFloat largeSize = 18;
  MDCSystemFontLoader *fontLoader = [[MDCSystemFontLoader alloc] init];

  // Then
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[UIFont systemFontOfSize:smallSize]]);
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[UIFont boldSystemFontOfSize:smallSize]]);
  XCTAssertTrue(
      [fontLoader isLargeForContrastRatios:[UIFont boldSystemFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[UIFont systemFontOfSize:largeSize]]);

  // Light
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader lightFontOfSize:smallSize]]);
  XCTAssertFalse(
      [fontLoader isLargeForContrastRatios:[fontLoader lightFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader lightFontOfSize:largeSize]]);

  // Regular
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader regularFontOfSize:smallSize]]);
  XCTAssertFalse(
      [fontLoader isLargeForContrastRatios:[fontLoader regularFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader regularFontOfSize:largeSize]]);

  // Medium
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader mediumFontOfSize:smallSize]]);
  // We treat medium as large for MDC accesibility.
  XCTAssertTrue(
      [fontLoader isLargeForContrastRatios:[fontLoader mediumFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader mediumFontOfSize:largeSize]]);

  // Bold
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader boldFontOfSize:smallSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader boldFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader boldFontOfSize:largeSize]]);

  // Italic
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader italicFontOfSize:smallSize]]);
  XCTAssertFalse(
      [fontLoader isLargeForContrastRatios:[fontLoader italicFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader italicFontOfSize:largeSize]]);

  // Bold Italic
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader boldItalicFontOfSize:smallSize]]);
  XCTAssertTrue(
      [fontLoader isLargeForContrastRatios:[fontLoader boldItalicFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader boldItalicFontOfSize:largeSize]]);
}

- (void)testUIFontWeightMediumValue {
  // Given
  CGFloat MDCFontWeightMedium = (CGFloat)0.23;
  // Ensure that our placehold value for UIFontWeightMedium matches the real value.
  // We are defining it for < iOS 8.2 in MDCTypography.m
  // TODO(#2651): Remove the pragmas and pointer check below
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
#pragma clang diagnostic ignored "-Wtautological-compare"
  if (&UIFontWeightMedium != NULL) {
    XCTAssertEqualWithAccuracy(UIFontWeightMedium, MDCFontWeightMedium, FLT_EPSILON);
  }
#pragma clang diagnostic pop
}

@end
