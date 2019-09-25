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
#import "MDCMath.h"

@interface MDCMathTests : XCTestCase

@end

@implementation MDCMathTests

#pragma mark - MDCCeilScaled and MDCFloorScaled

- (void)testMDCFloorScaled {
  CGFloat inputNumber = 1.3f;

  CGFloat scale = 4;
  CGFloat expectedOutputNumber = 1.25f;
  XCTAssertEqualWithAccuracy(MDCFloorScaled(inputNumber, scale), expectedOutputNumber, 0.001f);
}

- (void)testMDCFloorScaledWhenScaleIsZero {
  CGFloat inputNumber = 1.3f;

  CGFloat scale = 0;
  CGFloat expectedOutputNumber = 0;
  XCTAssertEqualWithAccuracy(MDCFloorScaled(inputNumber, scale), expectedOutputNumber, 0.001f);
}

- (void)testMDCFloorScaledWhenScaleIsNegative {
  CGFloat inputNumber = 1.3f;

  CGFloat scale = -2;
  CGFloat expectedOutputNumber = 1.5f;
  XCTAssertEqualWithAccuracy(MDCFloorScaled(inputNumber, scale), expectedOutputNumber, 0.001f);
}

- (void)testMDCCeilScaled {
  CGFloat inputNumber = 1.3f;

  CGFloat scale = 4;
  CGFloat expectedOutputNumber = 1.5f;
  XCTAssertEqualWithAccuracy(MDCCeilScaled(inputNumber, scale), expectedOutputNumber, 0.001f);
}

- (void)testMDCCeilScaledWhenScaleIsZero {
  CGFloat inputNumber = 1.3f;

  CGFloat scale = 0;
  CGFloat expectedOutputNumber = 0;
  XCTAssertEqualWithAccuracy(MDCCeilScaled(inputNumber, scale), expectedOutputNumber, 0.001f);
}

- (void)testMDCCeilScaledWhenScaleIsNegative {
  CGFloat inputNumber = 1.3f;

  CGFloat scale = -2;
  CGFloat expectedOutputNumber = 1;
  XCTAssertEqualWithAccuracy(MDCCeilScaled(inputNumber, scale), expectedOutputNumber, 0.001f);
}

#pragma mark - MDCRect

/**
 Basic test for alignment.
 */
- (void)testMDCRectAlignScale {
  // Given
  CGRect misalignedRect = CGRectMake(0.45f, 0.78f, 1.01f, 5.98f);
  CGRect alignedScale1Rect = CGRectMake(0, 0, 2, 7);
  CGRect alignedScale2Rect = CGRectMake(0, 0.5f, 1.5f, 6.5f);
  CGRect alignedScale3Rect = CGRectMake((CGFloat)(1.0 / 3.0), (CGFloat)(2.0 / 3.0),
                                        (CGFloat)(4.0 / 3.0), (CGFloat)(19.0 / 3.0));

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
  CGRect misalignedRect = CGRectMake((CGFloat)-5.01, (CGFloat)-0.399, 8.35f, 2.65f);
  CGRect alignedScale1Rect = CGRectMake(-6, -1, 10, 4);
  CGRect alignedScale2Rect = CGRectMake((CGFloat)-5.5, (CGFloat)-0.5, 9, 3);
  CGRect alignedScale3Rect = CGRectMake((CGFloat)(-16.0 / 3.0), (CGFloat)(-2.0 / 3.0), 9, 3);

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
  CGRect misalignedRect = CGRectMake(17.9f, (CGFloat)-4.44, (CGFloat)-10.10, (CGFloat)-15.85);
  // Standardized: (7.80, -20.29), (10.10, 15.85)
  CGRect alignedScale1Rect = CGRectMake(7, -21, 11, 17);
  CGRect alignedScale2Rect = CGRectMake(7.5f, (CGFloat)-20.5, 10.5f, 16.5f);
  CGRect alignedScale3Rect =
      CGRectMake((CGFloat)(23.0 / 3.0), (CGFloat)(-61.0 / 3.0), (CGFloat)(31.0 / 3.0), 16);

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
  CGRect alignedScale2Rect = CGRectMake(10.5f, 15.5f, 5.5f, 10.5f);
  CGRect alignedScale3Rect = CGRectMake((CGFloat)(31.0 / 3.0), (CGFloat)(47.0 / 3.0),
                                        (CGFloat)(16.0 / 3.0), (CGFloat)(32.0 / 3.0));

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
 Test that a scale value of zero returns the same as a scale of 1.
 */
- (void)testMDCRectAlignScaleZeroScale {
  // Given
  CGRect rectangle = CGRectMake(1.1f, 2.2f, 3.3f, 4.4f);

  // Then
  XCTAssertTrue(
      CGRectEqualToRect(MDCRectAlignToScale(rectangle, 0), MDCRectAlignToScale(rectangle, 1)));
}

#pragma mark - MDCPoint

- (void)testMDCPointRoundWithScale {
  // Given
  CGPoint misalignedPoint = CGPointMake(0.7f, (CGFloat)-1.3);
  CGPoint alignedScale1Point = CGPointMake(1, -1);
  CGPoint alignedScale2Point = CGPointMake(0.5f, (CGFloat)-1.5);
  CGPoint alignedScale3Point = CGPointMake((CGFloat)(2.0 / 3.0), (CGFloat)(-4.0 / 3.0));

  // Then
  XCTAssertTrue(
      CGPointEqualToPoint(alignedScale1Point, MDCPointRoundWithScale(misalignedPoint, 1)));
  XCTAssertTrue(
      CGPointEqualToPoint(alignedScale2Point, MDCPointRoundWithScale(misalignedPoint, 2)));
  XCTAssertTrue(
      CGPointEqualToPoint(alignedScale3Point, MDCPointRoundWithScale(misalignedPoint, 3)));
}

- (void)testMDCPointRoundScaleZeroScale {
  // Then
  XCTAssertTrue(CGPointEqualToPoint(CGPointZero, MDCPointRoundWithScale(CGPointMake(5.5f, 13), 0)));
}

#pragma mark - MDCCenter

- (void)testMDCRoundCenterWithBoundsAndScale {
  // Given
  CGPoint misalignedCenter = CGPointMake(0.7f, (CGFloat)-1.3);
  CGRect bounds = CGRectMake(0, 0, 20, 21);
  CGPoint alignedScale1Center = CGPointMake(1, (CGFloat)-1.5);
  CGPoint alignedScale2Center = CGPointMake(0.5f, (CGFloat)-1.5);
  CGPoint alignedScale3Center = CGPointMake((CGFloat)(2.0 / 3.0), (CGFloat)(-7.0 / 6.0));

  // Then
  CGPoint outputScale1Center = MDCRoundCenterWithBoundsAndScale(misalignedCenter, bounds, 1);
  XCTAssertTrue(MDCCGFloatEqual(alignedScale1Center.x, outputScale1Center.x));
  XCTAssertTrue(MDCCGFloatEqual(alignedScale1Center.y, outputScale1Center.y));
  CGPoint outputScale2Center = MDCRoundCenterWithBoundsAndScale(misalignedCenter, bounds, 2);
  XCTAssertTrue(MDCCGFloatEqual(alignedScale2Center.x, outputScale2Center.x));
  XCTAssertTrue(MDCCGFloatEqual(alignedScale2Center.y, outputScale2Center.y));
  CGPoint outputScale3Center = MDCRoundCenterWithBoundsAndScale(misalignedCenter, bounds, 3);
  XCTAssertTrue(MDCCGFloatEqual(alignedScale3Center.x, outputScale3Center.x));
  XCTAssertTrue(MDCCGFloatEqual(alignedScale3Center.y, outputScale3Center.y));
}

- (void)testMDCRoundCenterWithBoundsAndScaleRoundingErrors {
  // Given
  const CGFloat acceptableRoundingError = 5E-7f;
  CGPoint misalignedCenter = CGPointMake(0.3f, 9.99f);
  CGRect bounds = CGRectMake(0, 0, 20.1f, 21.9f);
  CGPoint alignedScale1Center = CGPointMake(0.05f, 9.95f);
  CGPoint alignedScale2Center = CGPointMake(0.05f, 9.95f);
  CGPoint alignedScale3Center = CGPointMake(0.05f + 1.0f / 3.0f, 9.95f);

  // Then
  CGPoint outputScale1Center = MDCRoundCenterWithBoundsAndScale(misalignedCenter, bounds, 1);
  XCTAssertLessThan(MDCFabs(alignedScale1Center.x - outputScale1Center.x), acceptableRoundingError);
  XCTAssertLessThan(MDCFabs(alignedScale1Center.y - outputScale1Center.y), acceptableRoundingError);

  CGPoint outputScale2Center = MDCRoundCenterWithBoundsAndScale(misalignedCenter, bounds, 2);
  XCTAssertLessThan(MDCFabs(alignedScale2Center.x - outputScale2Center.x), acceptableRoundingError);
  XCTAssertLessThan(MDCFabs(alignedScale2Center.y - outputScale2Center.y), acceptableRoundingError);

  CGPoint outputScale3Center = MDCRoundCenterWithBoundsAndScale(misalignedCenter, bounds, 3);
  XCTAssertLessThan(MDCFabs(alignedScale3Center.x - outputScale3Center.x), acceptableRoundingError);
  XCTAssertLessThan(MDCFabs(alignedScale3Center.y - outputScale3Center.y), acceptableRoundingError);
}

- (void)testMDCRoundCenterWithBoundsAndScaleZero {
  // Then
  XCTAssertTrue(CGPointEqualToPoint(
      CGPointZero,
      MDCRoundCenterWithBoundsAndScale(CGPointMake(-5, 10), CGRectMake(0, 0, 20, 20), 0)));
}

- (void)testMDCRoundCenterWithBoundsAndScaleNullBounds {
  // Then
  XCTAssertTrue(CGPointEqualToPoint(
      CGPointZero, MDCRoundCenterWithBoundsAndScale(CGPointMake(1, 2), CGRectNull, 1)));
}

- (void)testUIEdgeInsetsEqualToEdgeInsets {
  // Given
  CGFloat epsilon = 0;
#if CGFLOAT_IS_DOUBLE
  epsilon = DBL_EPSILON;
#else
  epsilon = FLT_EPSILON;
#endif

  // When
  UIEdgeInsets insets1 = UIEdgeInsetsMake(1, 1, 1, 1);
  UIEdgeInsets insets2 = UIEdgeInsetsMake(1 + epsilon, 1 + epsilon, 1 + epsilon, 1 + epsilon);

  // Then
  XCTAssertFalse(UIEdgeInsetsEqualToEdgeInsets(insets1, insets2));
}

- (void)testMDCEdgeInsetsEqualToEdgeInsets {
  // Given
  CGFloat epsilon = 0;
#if CGFLOAT_IS_DOUBLE
  epsilon = DBL_EPSILON;
#else
  epsilon = FLT_EPSILON;
#endif

  // When
  UIEdgeInsets insets1 = UIEdgeInsetsMake(1, 1, 1, 1);
  UIEdgeInsets insets2 = UIEdgeInsetsMake(1 + epsilon, 1 + epsilon, 1 + epsilon, 1 + epsilon);

  // Then
  XCTAssertTrue(MDCEdgeInsetsEqualToEdgeInsets(insets1, insets2));
}

@end
