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
  CGFloat inputNumber = (CGFloat)1.3;

  CGFloat scale = 4;
  CGFloat expectedOutputNumber = (CGFloat)1.25;
  XCTAssertEqualWithAccuracy(MDCFloorScaled(inputNumber, scale), expectedOutputNumber,
                             (CGFloat)0.001);
}

- (void)testMDCFloorScaledWhenScaleIsZero {
  CGFloat inputNumber = (CGFloat)1.3;

  CGFloat scale = 0;
  CGFloat expectedOutputNumber = 0;
  XCTAssertEqualWithAccuracy(MDCFloorScaled(inputNumber, scale), expectedOutputNumber,
                             (CGFloat)0.001);
}

- (void)testMDCFloorScaledWhenScaleIsNegative {
  CGFloat inputNumber = (CGFloat)1.3;

  CGFloat scale = -2;
  CGFloat expectedOutputNumber = (CGFloat)1.5;
  XCTAssertEqualWithAccuracy(MDCFloorScaled(inputNumber, scale), expectedOutputNumber,
                             (CGFloat)0.001);
}

- (void)testMDCCeilScaled {
  CGFloat inputNumber = (CGFloat)1.3;

  CGFloat scale = 4;
  CGFloat expectedOutputNumber = (CGFloat)1.5;
  XCTAssertEqualWithAccuracy(MDCCeilScaled(inputNumber, scale), expectedOutputNumber,
                             (CGFloat)0.001);
}

- (void)testMDCCeilScaledWhenScaleIsZero {
  CGFloat inputNumber = (CGFloat)1.3;

  CGFloat scale = 0;
  CGFloat expectedOutputNumber = 0;
  XCTAssertEqualWithAccuracy(MDCCeilScaled(inputNumber, scale), expectedOutputNumber,
                             (CGFloat)0.001);
}

- (void)testMDCCeilScaledWhenScaleIsNegative {
  CGFloat inputNumber = (CGFloat)1.3;

  CGFloat scale = -2;
  CGFloat expectedOutputNumber = 1;
  XCTAssertEqualWithAccuracy(MDCCeilScaled(inputNumber, scale), expectedOutputNumber,
                             (CGFloat)0.001);
}

#pragma mark - MDCRect

/**
 Basic test for alignment.
 */
- (void)testMDCRectAlignScale {
  // Given
  CGRect misalignedRect = CGRectMake((CGFloat)0.45, (CGFloat)0.78, (CGFloat)1.01, (CGFloat)5.98);
  CGRect alignedScale1Rect = CGRectMake(0, 0, 2, 7);
  CGRect alignedScale2Rect = CGRectMake(0, (CGFloat)0.5, (CGFloat)1.5, (CGFloat)6.5);
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
  CGRect misalignedRect = CGRectMake((CGFloat)-5.01, (CGFloat)-0.399, (CGFloat)8.35, (CGFloat)2.65);
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
  CGRect misalignedRect =
      CGRectMake((CGFloat)17.9, (CGFloat)-4.44, (CGFloat)-10.10, (CGFloat)-15.85);
  // Standardized: (7.80, -20.29), (10.10, 15.85)
  CGRect alignedScale1Rect = CGRectMake(7, -21, 11, 17);
  CGRect alignedScale2Rect = CGRectMake((CGFloat)7.5, (CGFloat)-20.5, (CGFloat)10.5, (CGFloat)16.5);
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
  CGRect alignedScale2Rect = CGRectMake((CGFloat)10.5, (CGFloat)15.5, (CGFloat)5.5, (CGFloat)10.5);
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
  CGRect rectangle = CGRectMake((CGFloat)1.1, (CGFloat)2.2, (CGFloat)3.3, (CGFloat)4.4);

  // Then
  XCTAssertTrue(
      CGRectEqualToRect(MDCRectAlignToScale(rectangle, 0), MDCRectAlignToScale(rectangle, 1)));
}

#pragma mark - MDCPoint

- (void)testMDCPointRoundWithScale {
  // Given
  CGPoint misalignedPoint = CGPointMake((CGFloat)0.7, (CGFloat)-1.3);
  CGPoint alignedScale1Point = CGPointMake(1, -1);
  CGPoint alignedScale2Point = CGPointMake((CGFloat)0.5, (CGFloat)-1.5);
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
  XCTAssertTrue(
      CGPointEqualToPoint(CGPointZero, MDCPointRoundWithScale(CGPointMake((CGFloat)5.5, 13), 0)));
}

#pragma mark - MDCCenter

- (void)testMDCRoundCenterWithBoundsAndScale {
  // Given
  CGPoint misalignedCenter = CGPointMake((CGFloat)0.7, (CGFloat)-1.3);
  CGRect bounds = CGRectMake(0, 0, 20, 21);
  CGPoint alignedScale1Center = CGPointMake(1, (CGFloat)-1.5);
  CGPoint alignedScale2Center = CGPointMake((CGFloat)0.5, (CGFloat)-1.5);
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
#if CGFLOAT_IS_DOUBLE
  const CGFloat acceptableRoundingError = 5E-15;
#else
  const CGFloat acceptableRoundingError = 5E-7f;
#endif
  CGPoint misalignedCenter = CGPointMake((CGFloat)0.3, (CGFloat)9.99);
  CGRect bounds = CGRectMake(0, 0, (CGFloat)20.1, (CGFloat)21.9);
  CGPoint alignedScale1Center = CGPointMake((CGFloat)0.05, (CGFloat)9.95);
  CGPoint alignedScale2Center = CGPointMake((CGFloat)0.05, (CGFloat)9.95);
  CGPoint alignedScale3Center = CGPointMake((CGFloat)(0.05 + 1.0 / 3.0), (CGFloat)9.95);

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
