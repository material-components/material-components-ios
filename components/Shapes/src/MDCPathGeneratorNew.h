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

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

/**
 MDCPathGenerator is a factory for creating CGPaths. Describe your path with the
 lineTo and addArc... methods, then call appendToCGPath to append them to a
 CGPath.

 @note MDCPathGenerators always start at (0, 0) and end at @c endPoint.
 */
@interface MDCPathGenerator : NSObject

/**
 The start point of the generated paths.
 */
@property(nonatomic, readonly) CGPoint startPoint;

/**
 The end point of the generated paths.
 */
@property(nonatomic, readonly) CGPoint endPoint;

/**
 Returns an initialized MDCPathGenerator instance with a startPoint of CGPointZero.
 */
+ (nonnull instancetype)pathGenerator;

/**
 Returns an initialized MDCPathGenerator instance.

 @param startPoint The start point of the generated paths.
 */
+ (nonnull instancetype)pathGeneratorWithStartPoint:(CGPoint)startPoint;

/**
 Appends a straight line segment to the path generator. Analogous to
 CGPathAddLineToPoint.

 @param point The end point of the line segment.
 */
- (void)addLineToPoint:(CGPoint)point;

/**
 Appends an arc to the path generator, possibly preceded by a straight line
 segment. Analogous to CGPathAddArc.

 @param center The center of the arc.
 @param radius The radius of the arc.
 @param startAngle The start angle of the arc.
 @param endAngle The end angle of the arc.
 @param clockwise Whether the arc is clockwise (YES) or counterclockwise (NO).
 */
- (void)addArcWithCenter:(CGPoint)center
                  radius:(CGFloat)radius
              startAngle:(CGFloat)startAngle
                endAngle:(CGFloat)endAngle
               clockwise:(BOOL)clockwise;

/**
 Appends an arc to the path generator, possibly preceded by a straight line
 segment. Analogous to CGPathAddArcToPoint. The arc will be drawn inside the
 corner created by the start of the arc, tangentPoint and toPoint.

 @param tangentPoint The corner of the arc.
 @param toPoint The final point of the arc.
 @param radius The radius inside of the arc.
 */
- (void)addArcWithTangentPoint:(CGPoint)tangentPoint
                       toPoint:(CGPoint)toPoint
                        radius:(CGFloat)radius;

/**
 Appends a cubic Bézier curve to the path generator.

 @param controlPoint1 The first control point
 @param controlPoint2 The second control point
 @param toPoint The end of the curve
 */
- (void)addCurveWithControlPoint1:(CGPoint)controlPoint1
                    controlPoint2:(CGPoint)controlPoint2
                          toPoint:(CGPoint)toPoint;

/**
 Appends a quadratic Bézier curve to the path generator.

 @param controlPoint The control point
 @param toPoint The end of the curve
 */
- (void)addQuadCurveWithControlPoint:(CGPoint)controlPoint toPoint:(CGPoint)toPoint;

/**
 Appends the recorded path operations to a CGPath using the provided transform.

 @param cgPath A mutable CGPath to which the saved path operations will be
 appended.
 @param transform The transform applied ot each path operation before appending
 them to the CGPath.
 */
- (void)appendToCGPath:(nonnull CGMutablePathRef)cgPath
             transform:(nullable CGAffineTransform *)transform;

@end
