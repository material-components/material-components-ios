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

#import "MDCRectangleShapeGenerator.h"

#import "MDCCornerTreatment.h"
#import "MDCEdgeTreatment.h"
#import "MDCPathGenerator.h"
#import "MaterialMath.h"

static inline CGFloat CGPointDistanceToPoint(CGPoint a, CGPoint b) {
  return MDCHypot(a.x - b.x, a.y - b.y);
}

// Edges in clockwise order
typedef enum : NSUInteger {
  MDCShapeEdgeTop = 0,
  MDCShapeEdgeRight,
  MDCShapeEdgeBottom,
  MDCShapeEdgeLeft,
} MDCShapeEdgePosition;

// Corners in clockwise order
typedef enum : NSUInteger {
  MDCShapeCornerTopLeft = 0,
  MDCShapeCornerTopRight,
  MDCShapeCornerBottomRight,
  MDCShapeCornerBottomLeft,
} MDCShapeCornerPosition;

@implementation MDCRectangleShapeGenerator

- (instancetype)init {
  if (self = [super init]) {
    [self setEdges:[[MDCEdgeTreatment alloc] init]];
    [self setCorners:[[MDCCornerTreatment alloc] init]];
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  MDCRectangleShapeGenerator *copy = [[[self class] alloc] init];

  copy.topLeftCorner = [copy.topLeftCorner copyWithZone:zone];
  copy.topRightCorner = [copy.topRightCorner copyWithZone:zone];
  copy.bottomRightCorner = [copy.bottomRightCorner copyWithZone:zone];
  copy.bottomLeftCorner = [copy.bottomLeftCorner copyWithZone:zone];

  copy.topLeftCornerOffset = copy.topLeftCornerOffset;
  copy.topRightCornerOffset = copy.topRightCornerOffset;
  copy.bottomRightCornerOffset = copy.bottomRightCornerOffset;
  copy.bottomLeftCornerOffset = copy.bottomLeftCornerOffset;

  copy.topEdge = [copy.topEdge copyWithZone:zone];
  copy.rightEdge = [copy.rightEdge copyWithZone:zone];
  copy.bottomEdge = [copy.bottomEdge copyWithZone:zone];
  copy.leftEdge = [copy.leftEdge copyWithZone:zone];

  return copy;
}

- (void)setCorners:(MDCCornerTreatment *)cornerShape {
  self.topLeftCorner = [cornerShape copy];
  self.topRightCorner = [cornerShape copy];
  self.bottomRightCorner = [cornerShape copy];
  self.bottomLeftCorner = [cornerShape copy];
}

- (void)setEdges:(MDCEdgeTreatment *)edgeShape {
  self.topEdge = [edgeShape copy];
  self.rightEdge = [edgeShape copy];
  self.bottomEdge = [edgeShape copy];
  self.leftEdge = [edgeShape copy];
}

- (MDCCornerTreatment *)cornerTreatmentForPosition:(MDCShapeCornerPosition)position {
  switch (position) {
    case MDCShapeCornerTopLeft:
      return self.topLeftCorner;
    case MDCShapeCornerTopRight:
      return self.topRightCorner;
    case MDCShapeCornerBottomLeft:
      return self.bottomLeftCorner;
    case MDCShapeCornerBottomRight:
      return self.bottomRightCorner;
  }
}

- (CGPoint)cornerOffsetForPosition:(MDCShapeCornerPosition)position {
  switch (position) {
    case MDCShapeCornerTopLeft:
      return self.topLeftCornerOffset;
    case MDCShapeCornerTopRight:
      return self.topRightCornerOffset;
    case MDCShapeCornerBottomLeft:
      return self.bottomLeftCornerOffset;
    case MDCShapeCornerBottomRight:
      return self.bottomRightCornerOffset;
  }
}

- (MDCEdgeTreatment *)edgeTreatmentForPosition:(MDCShapeEdgePosition)position {
  switch (position) {
    case MDCShapeEdgeTop:
      return self.topEdge;
    case MDCShapeEdgeLeft:
      return self.leftEdge;
    case MDCShapeEdgeRight:
      return self.rightEdge;
    case MDCShapeEdgeBottom:
      return self.bottomEdge;
  }
}

- (CGPathRef)pathForSize:(CGSize)size {
  CGMutablePathRef path = CGPathCreateMutable();
  MDCPathGenerator *cornerPaths[4];
  CGAffineTransform cornerTransforms[4];
  CGAffineTransform edgeTransforms[4];
  CGFloat edgeAngles[4];
  CGFloat edgeLengths[4];

  // Start by getting the path of each corner and calculating edge angles.
  for (NSInteger i = 0; i < 4; i++) {
    MDCCornerTreatment *cornerShape = [self cornerTreatmentForPosition:i];
    CGFloat cornerAngle = [self angleOfCorner:i forViewSize:size];
    if (cornerShape.valueType == MDCCornerTreatmentValueTypeAbsolute) {
      cornerPaths[i] = [cornerShape pathGeneratorForCornerWithAngle:cornerAngle];
    } else if (cornerShape.valueType == MDCCornerTreatmentValueTypePercentage) {
      cornerPaths[i] = [cornerShape pathGeneratorForCornerWithAngle:cornerAngle forViewSize:size];
    }
    edgeAngles[i] = [self angleOfEdge:i forViewSize:size];
  }

  // Create transformation matrices for each corner and edge
  for (NSInteger i = 0; i < 4; i++) {
    CGPoint cornerCoords = [self cornerCoordsForPosition:i forViewSize:size];
    CGAffineTransform cornerTransform =
        CGAffineTransformMakeTranslation(cornerCoords.x, cornerCoords.y);
    CGFloat prevEdgeAngle = edgeAngles[(i + 4 - 1) % 4];
    // We add 90 degrees (M_PI_2) here because the corner starts rotated from the edge.
    cornerTransform = CGAffineTransformRotate(cornerTransform, prevEdgeAngle + (CGFloat)M_PI_2);
    cornerTransforms[i] = cornerTransform;

    CGPoint edgeStartPoint =
        CGPointApplyAffineTransform(cornerPaths[i].endPoint, cornerTransforms[i]);
    CGAffineTransform edgeTransform =
        CGAffineTransformMakeTranslation(edgeStartPoint.x, edgeStartPoint.y);
    CGFloat edgeAngle = edgeAngles[i];
    edgeTransform = CGAffineTransformRotate(edgeTransform, edgeAngle);
    edgeTransforms[i] = edgeTransform;
  }

  // Calculate the length of each edge using the transformed corner paths.
  for (NSInteger i = 0; i < 4; i++) {
    NSInteger next = (i + 1) % 4;
    CGPoint edgeStartPoint =
        CGPointApplyAffineTransform(cornerPaths[i].endPoint, cornerTransforms[i]);
    CGPoint edgeEndPoint =
        CGPointApplyAffineTransform(cornerPaths[next].startPoint, cornerTransforms[next]);
    edgeLengths[i] = CGPointDistanceToPoint(edgeStartPoint, edgeEndPoint);
  }

  // Draw the first corner manually because we have to MoveToPoint to start the path.
  CGPathMoveToPoint(path, &cornerTransforms[0], cornerPaths[0].startPoint.x,
                    cornerPaths[0].startPoint.y);
  [cornerPaths[0] appendToCGPath:path transform:&cornerTransforms[0]];

  // Draw the remaining three corners joined by edges.
  for (NSInteger i = 1; i < 4; i++) {
    // draw the edge from the previous point to the current point
    MDCEdgeTreatment *edge = [self edgeTreatmentForPosition:(i - 1)];
    MDCPathGenerator *edgePath = [edge pathGeneratorForEdgeWithLength:edgeLengths[i - 1]];
    [edgePath appendToCGPath:path transform:&edgeTransforms[i - 1]];

    MDCPathGenerator *cornerPath = cornerPaths[i];
    [cornerPath appendToCGPath:path transform:&cornerTransforms[i]];
  }

  // Draw final edge back to first point.
  MDCEdgeTreatment *edge = [self edgeTreatmentForPosition:3];
  MDCPathGenerator *edgePath = [edge pathGeneratorForEdgeWithLength:edgeLengths[3]];
  [edgePath appendToCGPath:path transform:&edgeTransforms[3]];

  CGPathCloseSubpath(path);

  return CFAutorelease(path);
}

- (CGFloat)angleOfCorner:(MDCShapeCornerPosition)cornerPosition forViewSize:(CGSize)size {
  CGPoint prevCornerCoord = [self cornerCoordsForPosition:(cornerPosition - 1 + 4) % 4
                                              forViewSize:size];
  CGPoint nextCornerCoord = [self cornerCoordsForPosition:(cornerPosition + 1) % 4
                                              forViewSize:size];
  CGPoint cornerCoord = [self cornerCoordsForPosition:cornerPosition forViewSize:size];
  CGPoint prevVector =
      CGPointMake(prevCornerCoord.x - cornerCoord.x, prevCornerCoord.y - cornerCoord.y);
  CGPoint nextVector =
      CGPointMake(nextCornerCoord.x - cornerCoord.x, nextCornerCoord.y - cornerCoord.y);
  CGFloat prevAngle = MDCAtan2(prevVector.y, prevVector.x);
  CGFloat nextAngle = MDCAtan2(nextVector.y, nextVector.x);
  CGFloat angle = prevAngle - nextAngle;
  if (angle < 0)
    angle += (CGFloat)(2 * M_PI);
  return angle;
}

- (CGFloat)angleOfEdge:(MDCShapeEdgePosition)edgePosition forViewSize:(CGSize)size {
  MDCShapeCornerPosition startCornerPosition = (MDCShapeCornerPosition)edgePosition;
  MDCShapeCornerPosition endCornerPosition = (startCornerPosition + 1) % 4;
  CGPoint startCornerCoord = [self cornerCoordsForPosition:startCornerPosition forViewSize:size];
  CGPoint endCornerCoord = [self cornerCoordsForPosition:endCornerPosition forViewSize:size];

  CGPoint edgeVector =
      CGPointMake(endCornerCoord.x - startCornerCoord.x, endCornerCoord.y - startCornerCoord.y);
  return MDCAtan2(edgeVector.y, edgeVector.x);
}

- (CGPoint)cornerCoordsForPosition:(MDCShapeCornerPosition)cornerPosition
                       forViewSize:(CGSize)viewSize {
  CGPoint offset = [self cornerOffsetForPosition:cornerPosition];
  CGPoint translation;
  switch (cornerPosition) {
    case MDCShapeCornerTopLeft:
      translation = CGPointMake(0, 0);
      break;
    case MDCShapeCornerTopRight:
      translation = CGPointMake(viewSize.width, 0);
      break;
    case MDCShapeCornerBottomLeft:
      translation = CGPointMake(0, viewSize.height);
      break;
    case MDCShapeCornerBottomRight:
      translation = CGPointMake(viewSize.width, viewSize.height);
      break;
  }

  return CGPointMake(offset.x + translation.x, offset.y + translation.y);
}

@end
