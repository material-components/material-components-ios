#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"

#import <XCTest/XCTest.h>

@interface MDCShapeMediator (UnitTesting)

- (void)setPath:(CGPathRef)path;
- (CGPathRef)path;

@end

@interface MDCShapeMediatorTests : XCTestCase
@end

@implementation MDCShapeMediatorTests

- (void)testViewsLayerIsShapeMediatorsViewLayer {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];

  // Then
  XCTAssertEqualObjects(view.layer, shapeMediator.viewLayer);
}

- (void)testSettingShapedBackgroundColorSetsViewsBackgroundColor {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];

  // When
  shapeMediator.shapedBackgroundColor = UIColor.blueColor;

  // Then
  XCTAssertEqualObjects(view.backgroundColor, UIColor.blueColor);
}

- (void)testSettingShapedBorderColorSetsViewsBorderColor {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];

  // When
  shapeMediator.shapedBorderColor = UIColor.blueColor;

  // Then
  XCTAssertTrue(CGColorEqualToColor(view.layer.borderColor, UIColor.blueColor.CGColor));
}

- (void)testSettingShapedBorderWithSetsViewsBorderWidth {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];

  // When
  shapeMediator.shapedBorderWidth = 3.4f;

  // Then
  XCTAssertEqual(view.layer.borderWidth, 3.4f);
}

- (void)testEmptyFrameWithNonEmptyPathGeneratesColorLayerPathMatchingPath {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];

  // When
  shapeMediator.viewLayer.frame = CGRectZero;
  shapeMediator.path = bezierPath.CGPath;

  // Then
  XCTAssertTrue(CGPathEqualToPath(shapeMediator.colorLayer.path, bezierPath.CGPath));
}

- (void)
    testEmptyFrameWithNonEmptyPathAndPositiveShapedBorderWidthGeneratesColorLayerPathOffsetByHalfOfLineWidth {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];

  // When
  shapeMediator.viewLayer.frame = CGRectZero;
  shapeMediator.shapedBorderWidth = 2;
  shapeMediator.path = bezierPath.CGPath;

  // Then
  // Note that the X and Y values here are shifted by half of the shaped border width.
  UIBezierPath *insetPath = [UIBezierPath bezierPathWithRect:CGRectMake(1, 1, 98, 98)];
  XCTAssertTrue(CGPathEqualToPath(shapeMediator.colorLayer.path, insetPath.CGPath));
}

- (void)testGeneratedColorLayerAndShapeLayerPathsGivenABorderAndShadowLayer {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];

  // When
  shapeMediator.viewLayer.frame = CGRectMake(0, 0, 100, 100);
  shapeMediator.shapedBorderWidth = 6;
  shapeMediator.path = bezierPath.CGPath;

  // Then
  UIBezierPath *halfInsetPath = [UIBezierPath bezierPathWithRect:CGRectMake(3, 3, 94, 94)];
  XCTAssertTrue(CGPathEqualToPath(shapeMediator.colorLayer.path, halfInsetPath.CGPath));
  UIBezierPath *fullInsetPath = [UIBezierPath bezierPathWithRect:CGRectMake(6, 6, 88, 88)];
  XCTAssertTrue(CGPathEqualToPath(shapeMediator.shapeLayer.path, fullInsetPath.CGPath));
}

- (void)testSettingShapeGeneratorProvidesCustomPathsToShadowPathAndShapeLayerAndColorLayer {
  // Given
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCShapeMediator *shapeMediator = [[MDCShapeMediator alloc] initWithViewLayer:view.layer];

  // When
  MDCRectangleShapeGenerator *shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  MDCRoundedCornerTreatment *cornerTreatment = [MDCRoundedCornerTreatment cornerWithRadius:10];
  [shapeGenerator setCorners:cornerTreatment];
  shapeMediator.shapeGenerator = shapeGenerator;

  // Then
  XCTAssertFalse(CGPathIsEmpty(shapeMediator.path));
  XCTAssertFalse(CGPathIsEmpty(shapeMediator.colorLayer.path));
  XCTAssertFalse(CGPathIsEmpty(shapeMediator.shapeLayer.path));
  XCTAssertFalse(CGPathIsEmpty(view.layer.shadowPath));
}

@end
