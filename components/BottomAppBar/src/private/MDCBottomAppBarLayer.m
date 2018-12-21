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

#import "MaterialMath.h"
#import "MDCBottomAppBarAttributes.h"

@interface MDCBottomAppBarLayer (PathGenerators)
- (UIBezierPath *)drawWithPathToCut:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcCenter:(CGPoint)arcCenter
                          arcRadius:(CGFloat)arcRadius
                         startAngle:(CGFloat)startAngle
                           endAngle:(CGFloat)endAngle;
- (UIBezierPath *)drawWithPathToCut:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcRadius:(CGFloat)arcRadius
                         arcCenter1:(CGPoint)arcCenter1
                        startAngle1:(CGFloat)startAngle1
                          endAngle1:(CGFloat)endAngle1
                         arcCenter2:(CGPoint)arcCenter2
                        startAngle2:(CGFloat)startAngle2
                          endAngle2:(CGFloat)endAngle2;
- (UIBezierPath *)drawWithPlainPath:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcCenter:(CGPoint)arcCenter
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
    [bottomBarPath moveToPoint:CGPointMake(width, yOffset)];
    [bottomBarPath addCurveToPoint:CGPointMake(width, yOffset)
                     controlPoint1:CGPointMake(width, yOffset)
                     controlPoint2:CGPointMake(width, yOffset)];

    [bottomBarPath addLineToPoint:CGPointMake(width, height)];

    [bottomBarPath addLineToPoint:CGPointMake(0, height)];

    [bottomBarPath addLineToPoint:CGPointMake(0, yOffset)];
    [bottomBarPath addLineToPoint:CGPointMake(arcCenter1.x - arcRadius, yOffset)];

    [bottomBarPath addCurveToPoint:CGPointMake(arcCenter1.x - arcRadius, yOffset)
                     controlPoint1:CGPointMake(arcCenter1.x - arcRadius, yOffset)
                     controlPoint2:CGPointMake(arcCenter1.x - arcRadius, yOffset)];
    [bottomBarPath addCurveToPoint:CGPointMake(arcCenter1.x, arcRadius + yOffset)
                     controlPoint1:CGPointMake(arcCenter1.x - arcRadius, arcRadius / 2 + yOffset)
                     controlPoint2:CGPointMake(arcCenter1.x - arcRadius / 2, arcRadius + yOffset)];

    [bottomBarPath addLineToPoint:CGPointMake(arcCenter2.x, arcRadius + yOffset)];

    [bottomBarPath
        addCurveToPoint:CGPointMake(arcCenter2.x + arcRadius, yOffset)
          controlPoint1:CGPointMake(arcCenter2.x + arcRadius - arcRadius / 2, yOffset + arcRadius)
          controlPoint2:CGPointMake(arcCenter2.x + arcRadius, yOffset + arcRadius / 2)];
    [bottomBarPath addCurveToPoint:CGPointMake(arcCenter2.x + arcRadius, yOffset)
                     controlPoint1:CGPointMake(arcCenter2.x + arcRadius, yOffset)
                     controlPoint2:CGPointMake(arcCenter2.x + arcRadius, yOffset)];

    [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
    [bottomBarPath closePath];
  } else {
    [bottomBarPath moveToPoint:CGPointMake(width, yOffset)];
    [bottomBarPath addCurveToPoint:CGPointMake(width, yOffset)
                     controlPoint1:CGPointMake(width, yOffset)
                     controlPoint2:CGPointMake(width, yOffset)];
    [bottomBarPath addLineToPoint:CGPointMake(width, height)];
    [bottomBarPath addLineToPoint:CGPointMake(0, height)];
    [bottomBarPath addLineToPoint:CGPointMake(0, yOffset)];
    [bottomBarPath addLineToPoint:CGPointMake(arcCenter1.x - arcRadius, yOffset)];

    [bottomBarPath addCurveToPoint:CGPointMake(arcCenter1.x - arcRadius, yOffset)
                     controlPoint1:CGPointMake(arcCenter1.x - arcRadius, yOffset)
                     controlPoint2:CGPointMake(arcCenter1.x - arcRadius, yOffset)];
    [bottomBarPath addCurveToPoint:CGPointMake(arcCenter1.x, yOffset)
                     controlPoint1:CGPointMake(arcCenter1.x - arcRadius, yOffset)
                     controlPoint2:CGPointMake(arcCenter1.x - arcRadius / 2, yOffset)];

    [bottomBarPath addLineToPoint:CGPointMake(arcCenter2.x, yOffset)];

    [bottomBarPath addCurveToPoint:CGPointMake(arcCenter2.x + arcRadius, yOffset)
                     controlPoint1:CGPointMake(arcCenter2.x + arcRadius - arcRadius / 2, yOffset)
                     controlPoint2:CGPointMake(arcCenter2.x + arcRadius, yOffset)];
    [bottomBarPath addCurveToPoint:CGPointMake(arcCenter2.x + arcRadius, yOffset)
                     controlPoint1:CGPointMake(arcCenter2.x + arcRadius, yOffset)
                     controlPoint2:CGPointMake(arcCenter2.x + arcRadius, yOffset)];

    [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
    [bottomBarPath closePath];
  }

  return bottomBarPath.CGPath;
}

@end
