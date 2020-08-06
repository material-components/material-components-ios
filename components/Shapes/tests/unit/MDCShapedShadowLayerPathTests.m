#import "MaterialShapes.h"

#import <XCTest/XCTest.h>

@interface MDCShapedShadowLayer (UnitTesting)

- (void)setPath:(CGPathRef)path;

@end

@interface MDCShapedShadowLayerPathTests : XCTestCase
@end

@implementation MDCShapedShadowLayerPathTests

- (void)testEmptyFrameWithNonEmptyPathGeneratesColorLayerPathMatchingPath {
  // Given
  MDCShapedShadowLayer *shadowLayer = [[MDCShapedShadowLayer alloc] init];
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];

  // When
  shadowLayer.frame = CGRectZero;
  shadowLayer.path = bezierPath.CGPath;

  // Then
  XCTAssertTrue(CGPathEqualToPath(shadowLayer.colorLayer.path, bezierPath.CGPath));
}

- (void)
    testEmptyFrameWithNonEmptyPathAndPositiveShapedBorderWidthGeneratesColorLayerPathOffsetByHalfOfLineWidth {
  // Given
  MDCShapedShadowLayer *shadowLayer = [[MDCShapedShadowLayer alloc] init];
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];

  // When
  shadowLayer.frame = CGRectZero;
  shadowLayer.shapedBorderWidth = 2;
  shadowLayer.path = bezierPath.CGPath;

  // Then
  // Note that the X and Y values here are shifted by half of the shaped border width.
  UIBezierPath *insetPath = [UIBezierPath bezierPathWithRect:CGRectMake(1, 1, 98, 98)];
  XCTAssertTrue(CGPathEqualToPath(shadowLayer.colorLayer.path, insetPath.CGPath));
}

- (void)testGeneratedColorLayerAndShapeLayerPathsGivenABorderAndShadowLayer {
  // Given
  MDCShapedShadowLayer *shadowLayer = [[MDCShapedShadowLayer alloc] init];
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];

  // When
  shadowLayer.frame = CGRectMake(0, 0, 100, 100);
  shadowLayer.shapedBorderWidth = 6;
  shadowLayer.path = bezierPath.CGPath;

  // Then
  UIBezierPath *halfInsetPath = [UIBezierPath bezierPathWithRect:CGRectMake(3, 3, 94, 94)];
  XCTAssertTrue(CGPathEqualToPath(shadowLayer.colorLayer.path, halfInsetPath.CGPath));
  UIBezierPath *fullInsetPath = [UIBezierPath bezierPathWithRect:CGRectMake(6, 6, 88, 88)];
  XCTAssertTrue(CGPathEqualToPath(shadowLayer.shapeLayer.path, fullInsetPath.CGPath));
}

@end
