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

  CGFloat navigationBarYOffset = CGRectGetMinY(navigationBarFrame);

  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);

  if (shouldCut) {
    if (floatingButton.mode == MDCFloatingButtonModeExpanded) {
      CGFloat arcRadius =
      CGRectGetHeight(floatingButton.bounds) / 2 + kMDCBottomAppBarFloatingButtonRadiusOffset;

      CGPoint arcCenter1 = CGPointMake(floatingButton.center.x - CGRectGetWidth(floatingButton.bounds) / 2 + arcRadius - kMDCBottomAppBarFloatingButtonRadiusOffset, floatingButton.center.y);
      CGFloat startAngle1 = (float)M_PI;
      CGFloat endAngle1 = (float)M_PI_2;

      CGPoint arcCenter2 = CGPointMake(floatingButton.center.x + CGRectGetWidth(floatingButton.bounds) / 2 - arcRadius + kMDCBottomAppBarFloatingButtonRadiusOffset, floatingButton.center.y);
      CGFloat startAngle2 = (float)M_PI_2;
      CGFloat endAngle2 = 0;


      [self drawWithPathToCut:bottomBarPath
                      yOffset:navigationBarYOffset
                        width:width
                       height:height
                    arcRadius:arcRadius
                   arcCenter1:arcCenter1
                  startAngle1:startAngle1
                    endAngle1:endAngle1
                   arcCenter2:arcCenter2
                  startAngle2:startAngle2
                    endAngle2:endAngle2];
    }
    else {
      CGFloat arcRadius =
      CGRectGetHeight(floatingButton.bounds) / 2 + kMDCBottomAppBarFloatingButtonRadiusOffset;
      CGFloat halfAngle = acosf((float)((navigationBarYOffset - floatingButton.center.y) / arcRadius));
      CGFloat startAngle = (float)M_PI / 2 + halfAngle;
      CGFloat endAngle = (float)M_PI / 2 - halfAngle;

      [self drawWithPathToCut:bottomBarPath
                      yOffset:navigationBarYOffset
                        width:width
                       height:height
                    arcCenter:floatingButton.center
                    arcRadius:arcRadius
                   startAngle:startAngle
                     endAngle:endAngle];
    }
  } else {
    CGFloat arcRadius =
    CGRectGetHeight(floatingButton.bounds) / 2 + kMDCBottomAppBarFloatingButtonRadiusOffset;
    [self drawWithPlainPath:bottomBarPath
                    yOffset:navigationBarYOffset
                      width:width
                     height:height
                  arcCenter:floatingButton.center
                  arcRadius:arcRadius];
  }

  return bottomBarPath.CGPath;
}

#pragma mark - Draw Helpers

- (UIBezierPath *)drawWithPathToCut:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcCenter:(CGPoint)arcCenter
                          arcRadius:(CGFloat)arcRadius
                         startAngle:(CGFloat)startAngle
                           endAngle:(CGFloat)endAngle {
  [bottomBarPath moveToPoint:CGPointMake(0, yOffset)];
  [bottomBarPath addArcWithCenter:arcCenter
                           radius:arcRadius
                       startAngle:startAngle
                         endAngle:endAngle
                        clockwise:NO];
  [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + yOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

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
                          endAngle2:(CGFloat)endAngle2 {

  [bottomBarPath moveToPoint:CGPointMake(0, yOffset)];
  [bottomBarPath addArcWithCenter:arcCenter1
                           radius:arcRadius
                       startAngle:startAngle1
                         endAngle:endAngle1
                        clockwise:NO];

  [bottomBarPath addArcWithCenter:arcCenter2
                           radius:arcRadius
                       startAngle:startAngle2
                         endAngle:endAngle2
                        clockwise:NO];
  [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + yOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}


- (UIBezierPath *)drawWithPlainPath:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcCenter:(CGPoint)arcCenter
                          arcRadius:(CGFloat)arcRadius {
  [bottomBarPath moveToPoint:CGPointMake(0, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter.x - arcRadius, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter.x, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter.x + arcRadius, yOffset)];
  // The extra line is needed to have the same number of control points in boths paths.
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter.x + arcRadius, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + yOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

@end
