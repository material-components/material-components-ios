/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

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

- (CGPathRef)pathWithCutFromRect:(CGRect)rect
          floatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition
                 layoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  UIBezierPath *bottomBarPath = [UIBezierPath bezierPath];

  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  CGFloat midX = CGRectGetMidX(rect);

  CGFloat startAngle = MDCDegreesToRadians(kMDCBottomAppBarFloatingButtonStartAngle);
  CGFloat endAngle = MDCDegreesToRadians(kMDCBottomAppBarFloatingButtonEndAngle);

  // Paths generated below differ based on the placement of the floating button.
  switch (floatingButtonPosition) {
    case MDCBottomAppBarFloatingButtonPositionLeading: {
      if (layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        [self pathWithCutRight:bottomBarPath
                         width:width
                        height:height
                    startAngle:startAngle
                      endAngle:endAngle];
      } else {
        [self pathWithCutLeft:bottomBarPath
                        width:width
                       height:height
                   startAngle:startAngle
                     endAngle:endAngle];
      }
      break;
    }
    case MDCBottomAppBarFloatingButtonPositionCenter: {
      [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
      CGPoint centerPath = CGPointMake(midX,
                                       kMDCBottomAppBarYOffset -
                                       kMDCBottomAppBarFloatingButtonPositionY);
      [bottomBarPath addArcWithCenter:centerPath
                               radius:kMDCBottomAppBarFloatingButtonRadius
                           startAngle:startAngle
                             endAngle:endAngle
                            clockwise:NO];
      [bottomBarPath addLineToPoint:CGPointMake(width, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(width, height * 2)];
      [bottomBarPath addLineToPoint:CGPointMake(0, height * 2)];
      [bottomBarPath closePath];
      break;
    }
    case MDCBottomAppBarFloatingButtonPositionTrailing: {
      if (layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        [self pathWithCutLeft:bottomBarPath
                         width:width
                        height:height
                    startAngle:startAngle
                      endAngle:endAngle];
      } else {
        [self pathWithCutRight:bottomBarPath
                         width:width
                        height:height
                    startAngle:startAngle
                      endAngle:endAngle];
      }
      break;
    }
    default: {

      // The default path does not contain a cut for the floating button. However, it is necessary
      // to include the same number of points as the cut path version so there is a smooth
      // transition between cut and without cut paths.
      [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(height, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(height,
                                                height * 2 + kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + kMDCBottomAppBarYOffset)];
      [bottomBarPath closePath];
      break;
    }
  }
  return bottomBarPath.CGPath;
}

- (UIBezierPath *)pathWithCutLeft:(UIBezierPath *)bottomBarPath
                            width:(CGFloat)width
                           height:(CGFloat)height
                       startAngle:(CGFloat)startAngle
                         endAngle:(CGFloat)endAngle {
  [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
  CGPoint centerPath = CGPointMake(kMDCBottomAppBarFloatingButtonPositionX,
                                   kMDCBottomAppBarYOffset -
                                   kMDCBottomAppBarFloatingButtonPositionY);
  [bottomBarPath addArcWithCenter:centerPath
                           radius:kMDCBottomAppBarFloatingButtonRadius
                       startAngle:startAngle
                         endAngle:endAngle
                        clockwise:NO];
  [bottomBarPath addLineToPoint:CGPointMake(width, kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width,
                                            height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

- (UIBezierPath *)pathWithCutRight:(UIBezierPath *)bottomBarPath
                             width:(CGFloat)width
                            height:(CGFloat)height
                        startAngle:(CGFloat)startAngle
                          endAngle:(CGFloat)endAngle {
  [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
  CGPoint centerPath = CGPointMake(width - kMDCBottomAppBarFloatingButtonPositionX,
                                   kMDCBottomAppBarYOffset -
                                   kMDCBottomAppBarFloatingButtonPositionY);
  [bottomBarPath addArcWithCenter:centerPath
                           radius:kMDCBottomAppBarFloatingButtonRadius
                       startAngle:startAngle
                         endAngle:endAngle
                        clockwise:NO];
  [bottomBarPath addLineToPoint:CGPointMake(width, kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

- (CGPathRef)pathWithoutCutFromRect:(CGRect)rect
             floatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition
                    layoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {

  CGFloat height = CGRectGetHeight(rect);
  CGFloat width = CGRectGetWidth(rect);
  CGFloat midX = CGRectGetMidX(rect);

  UIBezierPath *bottomBarPath = [UIBezierPath bezierPath];
  switch (floatingButtonPosition) {
    case MDCBottomAppBarFloatingButtonPositionLeading: {
      if (layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        [self pathWithoutCutRight:bottomBarPath width:width height:height];
      } else {
        [self pathWithoutCutLeft:bottomBarPath width:width height:height];
      }
      break;
    }
    case MDCBottomAppBarFloatingButtonPositionCenter: {
      CGFloat offsetRadiusDiff = kMDCBottomAppBarYOffset - kMDCBottomAppBarFloatingButtonRadius;
      [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(midX - offsetRadiusDiff,
                                                kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(midX, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(midX + offsetRadiusDiff,
                                                kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(width, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + kMDCBottomAppBarYOffset)];
      [bottomBarPath closePath];
      break;
    }
    case MDCBottomAppBarFloatingButtonPositionTrailing: {
      if (layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        [self pathWithoutCutLeft:bottomBarPath width:width height:height];
      } else {
        [self pathWithoutCutRight:bottomBarPath width:width height:height];
      }
      break;
    }
    default: {
      [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(height, kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(height,
                                                height * 2 + kMDCBottomAppBarYOffset)];
      [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + kMDCBottomAppBarYOffset)];
      [bottomBarPath closePath];
      break;
    }
  }
  return bottomBarPath.CGPath;
}

- (UIBezierPath *)pathWithoutCutLeft:(UIBezierPath *)bottomBarPath
                               width:(CGFloat)width
                              height:(CGFloat)height {
  CGFloat offsetRadiusDiff = kMDCBottomAppBarYOffset - kMDCBottomAppBarFloatingButtonRadius;
  [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(kMDCBottomAppBarFloatingButtonPositionX -
                                            offsetRadiusDiff,
                                            kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(kMDCBottomAppBarFloatingButtonPositionX,
                                            kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(kMDCBottomAppBarFloatingButtonPositionX +
                                            offsetRadiusDiff,
                                            kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

- (UIBezierPath *)pathWithoutCutRight:(UIBezierPath *)bottomBarPath
                                width:(CGFloat)width
                               height:(CGFloat)height {
  CGFloat offsetRadiusDiff = kMDCBottomAppBarYOffset - kMDCBottomAppBarFloatingButtonRadius;
  [bottomBarPath moveToPoint:CGPointMake(0, kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width - kMDCBottomAppBarFloatingButtonPositionX -
                                            offsetRadiusDiff,
                                            kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width - kMDCBottomAppBarFloatingButtonPositionX,
                                            kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width - kMDCBottomAppBarFloatingButtonPositionX +
                                            offsetRadiusDiff,
                                            kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(width, height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath addLineToPoint:CGPointMake(0, height * 2 + kMDCBottomAppBarYOffset)];
  [bottomBarPath closePath];
  return bottomBarPath;
}

@end
