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

@implementation MDCBottomAppBarLayer

+ (instancetype)layer {
  MDCBottomAppBarLayer *layer = [super layer];
  layer.fillColor = [UIColor whiteColor].CGColor;
  layer.shadowColor = [UIColor blackColor].CGColor;

  // TODO(#2018): These shadow attributes will be updated once specs are finalized.
  CGFloat scale = UIScreen.mainScreen.scale;
  layer.shadowOpacity = 0.4f;
  layer.shadowRadius = 4.f;
  layer.shadowOffset = CGSizeMake(0, 2.f);
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

  CGFloat arcRadius =
      CGRectGetHeight(floatingButton.bounds) / 2 + kMDCBottomAppBarFloatingButtonRadiusOffset;
  CGFloat navigationBarYOffset = CGRectGetMinY(navigationBarFrame);
  CGFloat halfAngle = acosf((float)((navigationBarYOffset - floatingButton.center.y) / arcRadius));
  CGFloat startAngle = (float)M_PI / 2.0f + halfAngle;
  CGFloat endAngle = (float)M_PI / 2.0f - halfAngle;
  CGFloat halfOfHypotenuseLength = sinf((float)halfAngle) * arcRadius;

  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);

  if (shouldCut) {
    [self drawWithPathToCut:bottomBarPath
                    yOffset:navigationBarYOffset
                      width:width
                     height:height
                  arcCenter:floatingButton.center
                  arcRadius:arcRadius
                 startAngle:startAngle
                   endAngle:endAngle];
  } else {
    [self drawWithPlainPath:bottomBarPath
                    yOffset:navigationBarYOffset
                      width:width
                     height:height
                  arcCenter:floatingButton.center
           hypotenuseLength:halfOfHypotenuseLength * 2];
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

- (UIBezierPath *)drawWithPlainPath:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcCenter:(CGPoint)arcCenter
                   hypotenuseLength:(CGFloat)hypotenuseLength {
  CGFloat halfOfHypotenuseLength = hypotenuseLength / 2;
  [bottomBarPath moveToPoint:CGPointMake(0, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter.x - halfOfHypotenuseLength, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter.x, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(arcCenter.x + halfOfHypotenuseLength, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + yOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + yOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

@end
