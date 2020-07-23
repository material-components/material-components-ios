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
    testEmptyFrameWithNonEmptyPathAndPositiveShapedBorderWidthGeneratesColorLayerPathInsetByHalfOfLineWidth {
  // Given
  MDCShapedShadowLayer *shadowLayer = [[MDCShapedShadowLayer alloc] init];
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];

  // When
  shadowLayer.frame = CGRectZero;
  shadowLayer.shapedBorderWidth = 2;
  shadowLayer.path = bezierPath.CGPath;

  // Then
  // TODO(b/161932830): This should not return NULL. The path assignment above is causing a runtime
  // failure to a divide by zero, with the following error message:
  // "[Unknown process name] Error: this application, or a library it uses, has passed an invalid
  // numeric value (NaN, or not-a-number) to CoreGraphics API and this value is being ignored.
  // Please fix this problem."
  XCTAssertTrue(shadowLayer.colorLayer.path == NULL);
}

@end
