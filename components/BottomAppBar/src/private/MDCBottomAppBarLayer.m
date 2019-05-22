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

#import "MDCBottomAppBarLayer.h"

#import "MDCBottomAppBarAttributes.h"
#import "MaterialMath.h"

@interface MDCBottomAppBarLayer (PathGenerators)
- (UIBezierPath *)drawWithPathToCut:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcRadius:(CGFloat)arcRadius
                         arcCenter1:(CGPoint)arcCenter1
                         arcCenter2:(CGPoint)arcCenter2;
- (UIBezierPath *)drawWithPlainPath:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                         arcCenter1:(CGPoint)arcCenter1
                         arcCenter2:(CGPoint)arcCenter2
                          arcRadius:(CGFloat)arcRadius;
@end

@implementation MDCBottomAppBarLayer

+ (instancetype)layer {
  MDCBottomAppBarLayer *layer = [super layer];
  layer.fillColor = [UIColor whiteColor].CGColor;
  layer.shadowColor = [UIColor blackColor].CGColor;

  // TODO(#2018): These shadow attributes will be updated once specs are finalized.
  CGFloat scale = UIScreen.mainScreen.scale;
  layer.shadowOpacity = (float)0.4;
  layer.shadowRadius = 4;
  layer.shadowOffset = CGSizeMake(0, 2);
  layer.needsDisplayOnBoundsChange = YES;
  layer.contentsScale = scale;
  layer.rasterizationScale = scale;
  layer.shouldRasterize = YES;
  return layer;
}

- (CGPathRef)pathFromRect:(CGRect)rect
           floatingButton:(MDCFloatingButton *)floatingButton
       navigationBarFrame:(CGRect)navigationBarFrame
                shouldCut:(BOOL)shouldCut {
  UIBezierPath *bottomBarPath = [UIBezierPath bezierPath];

  CGFloat yOffset = CGRectGetMinY(navigationBarFrame);

  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  CGFloat arcRadius =
      CGRectGetHeight(floatingButton.bounds) / 2 + kMDCBottomAppBarFloatingButtonRadiusOffset;

  CGPoint arcCenter1 =
      CGPointMake(floatingButton.center.x - CGRectGetWidth(floatingButton.bounds) / 2 + arcRadius -
                      kMDCBottomAppBarFloatingButtonRadiusOffset,
                  floatingButton.center.y);
  CGPoint arcCenter2 =
      CGPointMake(floatingButton.center.x + CGRectGetWidth(floatingButton.bounds) / 2 - arcRadius +
                      kMDCBottomAppBarFloatingButtonRadiusOffset,
                  floatingButton.center.y);

  if (shouldCut) {
    [self drawWithPathToCut:bottomBarPath
                    yOffset:yOffset
                      width:width
                     height:height
                  arcRadius:arcRadius
                 arcCenter1:arcCenter1
                 arcCenter2:arcCenter2];
  } else {
    [self drawWithPlainPath:bottomBarPath
                    yOffset:yOffset
                      width:width
                     height:height
                 arcCenter1:arcCenter1
                 arcCenter2:arcCenter2
                  arcRadius:arcRadius];
  }

  return bottomBarPath.CGPath;
}

#pragma mark - Draw Helpers

- (UIBezierPath *)drawWithPathToCut:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcRadius:(CGFloat)arcRadius
                         arcCenter1:(CGPoint)arcCenter1
                         arcCenter2:(CGPoint)arcCenter2 {
  [bottomBarPath moveToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath addCurveToPoint:CGPointMake(width, yOffset)
                   controlPoint1:CGPointMake(width, yOffset)
                   controlPoint2:CGPointMake(width, yOffset)];

  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + yOffset)];

  [bottomBarPath addLineToPoint:CGPointMake(0, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter1.x - arcRadius, yOffset)];

  [bottomBarPath addArcWithCenter:arcCenter1
                           radius:arcRadius
                       startAngle:-180 * (float)M_PI / 180
                         endAngle:-270 * (float)M_PI / 180
                        clockwise:NO];

  [bottomBarPath addLineToPoint:CGPointMake(arcCenter2.x, arcRadius + yOffset)];

  [bottomBarPath addArcWithCenter:arcCenter2
                           radius:arcRadius
                       startAngle:-270 * (float)M_PI / 180
                         endAngle:-360 * (float)M_PI / 180
                        clockwise:NO];

  [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

- (UIBezierPath *)drawWithPlainPath:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                         arcCenter1:(CGPoint)arcCenter1
                         arcCenter2:(CGPoint)arcCenter2
                          arcRadius:(CGFloat)arcRadius {
  [bottomBarPath moveToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath addCurveToPoint:CGPointMake(width, yOffset)
                   controlPoint1:CGPointMake(width, yOffset)
                   controlPoint2:CGPointMake(width, yOffset)];

  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + yOffset)];

  [bottomBarPath addLineToPoint:CGPointMake(0, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter1.x - arcRadius, yOffset)];

  // draw circle with radius 0 to ensure we have the same number of points as the cut-out path
  [bottomBarPath addArcWithCenter:arcCenter1
                           radius:0
                       startAngle:-180 * (float)M_PI / 180
                         endAngle:-270 * (float)M_PI / 180
                        clockwise:NO];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter2.x, yOffset)];

  // draw circle with radius 0 to ensure we have the same number of points as the cut-out path
  [bottomBarPath addArcWithCenter:arcCenter2
                           radius:0
                       startAngle:-270 * (float)M_PI / 180
                         endAngle:-360 * (float)M_PI / 180
                        clockwise:NO];

  [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

@end
