/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MDCMath.h"

@interface MDCMathTests : XCTestCase

@end

@implementation MDCMathTests

/**
 Basic test for alignment.
 */
- (void)testMDCRectAlignScale {
  // Given
  CGRect misalignedRect = CGRectMake(0.45, 0.78, 1.01, 5.98);
  CGRect alignedScale1Rect = CGRectMake(0, 0, 2, 7);
  CGRect alignedScale2Rect = CGRectMake(0, 0.5, 1.5, 6.5);
  CGRect alignedScale3Rect = CGRectMake(1.0 / 3.0, 2.0 / 3.0, 4.0 / 3.0, 19.0 / 3.0);

  // Then
  CGRect outputScale1Rect = MDCRectAlignToScale(misalignedRect, 1);
  XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, outputScale1Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale1Rect, misalignedRect));

  CGRect outputScale2Rect = MDCRectAlignToScale(misalignedRect, 2);
  XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, outputScale2Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale2Rect, misalignedRect));

  CGRect outputScale3Rect = MDCRectAlignToScale(misalignedRect, 3);
  XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, outputScale3Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale3Rect, misalignedRect));
}

/**
 Basic test of rectangle alignment when the origin has negative values.
 */
- (void)testMDCRectAlignScaleNegativeRectangle {
  // Given
  CGRect misalignedRect = CGRectMake(-5.01, -0.399, 8.35, 2.65);
  CGRect alignedScale1Rect = CGRectMake(-6, -1, 10, 4);
  CGRect alignedScale2Rect = CGRectMake(-5.5, -0.5, 9, 3);
  CGRect alignedScale3Rect = CGRectMake(-16.0 / 3.0, -2.0 / 3.0, 9, 3);

  // Then
  CGRect outputScale1Rect = MDCRectAlignToScale(misalignedRect, 1);
  XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, outputScale1Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale1Rect, misalignedRect));

  CGRect outputScale2Rect = MDCRectAlignToScale(misalignedRect, 2);
  XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, outputScale2Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale2Rect, misalignedRect));

  CGRect outputScale3Rect = MDCRectAlignToScale(misalignedRect, 3);
  XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, outputScale3Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale3Rect, misalignedRect));
}

/**
 Test of a non-standardized rectangle (height/width are negative)
 */
- (void)testMDCRectAlignScaleNonStandardRectangle {
  // Given
  CGRect misalignedRect = CGRectMake(17.9, -4.44, -10.10, -15.85);
  // Standardized: (7.80, -20.29), (10.10, 15.85)
  CGRect alignedScale1Rect = CGRectMake(7, -21, 11, 17);
  CGRect alignedScale2Rect = CGRectMake(7.5, -20.5, 10.5, 16.5);
  CGRect alignedScale3Rect = CGRectMake(23.0 / 3.0, -61.0 / 3.0, 31.0 / 3.0, 16);

  // Then
  CGRect outputScale1Rect = MDCRectAlignToScale(misalignedRect, 1);
  XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, outputScale1Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale1Rect, misalignedRect));

  CGRect outputScale2Rect = MDCRectAlignToScale(misalignedRect, 2);
  XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, outputScale2Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale2Rect, misalignedRect));

  CGRect outputScale3Rect = MDCRectAlignToScale(misalignedRect, 3);
  XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, outputScale3Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale3Rect, misalignedRect));
}

/**
 Test that an already-aligned rectangle will not be changed.
 */
- (void)testMDCRectAlignScaleAlreadyAligned {
  // Given
  CGRect alignedScale1Rect = CGRectMake(10, 15, 5, 10);
  CGRect alignedScale2Rect = CGRectMake(10.5, 15.5, 5.5, 10.5);
  CGRect alignedScale3Rect = CGRectMake(31.0 / 3.0, 47.0 / 3.0, 16.0 / 3.0, 32.0 / 3.0);

  // Then
  CGRect outputScale1Rect = MDCRectAlignToScale(alignedScale1Rect, 1);
  XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, outputScale1Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale1Rect, alignedScale1Rect));

  CGRect outputScale2Rect = MDCRectAlignToScale(alignedScale2Rect, 2);
  XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, outputScale2Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale2Rect, alignedScale2Rect));

  CGRect outputScale3Rect = MDCRectAlignToScale(alignedScale3Rect, 3);
  XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, outputScale3Rect));
  XCTAssertTrue(CGRectContainsRect(outputScale3Rect, alignedScale3Rect));
}

/**
 Test that a null rectangle returns CGRectNull.
 */
- (void)testMDCRectAlignScaleNullRectangle {
  // Then
  XCTAssertTrue(CGRectIsNull(MDCRectAlignToScale(CGRectNull, 1)));
  XCTAssertTrue(CGRectIsNull(MDCRectAlignToScale(CGRectNull, 2)));
  XCTAssertTrue(CGRectIsNull(MDCRectAlignToScale(CGRectNull, 3)));
}

/**
 Test that a scale value of zero returns CGRectNull.
 */
- (void)testMDCRectAlignScaleZeroScale {
  // Then
  XCTAssertTrue(CGRectIsNull(MDCRectAlignToScale(CGRectZero, 0)));
}

@end
