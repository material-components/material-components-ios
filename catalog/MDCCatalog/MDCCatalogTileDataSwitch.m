/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MDCCatalogTileDataSwitch.h"

@implementation MDCCatalogTileDataSwitch

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.119 green:0.63 blue:0.95 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 56.43) * 0.59180 - 0.37) + 0.87,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 31.91) * 0.38869 + 0.25) + 0.25, 56.43,
      31.91);
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.3);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 40.47, CGRectGetMinY(group) + 31.91)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 56.43, CGRectGetMinY(group) + 15.96)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 49.28, CGRectGetMinY(group) + 31.91)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 56.43, CGRectGetMinY(group) + 24.77)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 40.47, CGRectGetMinY(group))
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 56.43, CGRectGetMinY(group) + 7.14)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 49.28, CGRectGetMinY(group))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 31.91)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 40.47, CGRectGetMinY(group) + 31.91)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  UIBezierPath* ovalPath = [UIBezierPath
      bezierPathWithOvalInRect:CGRectMake(
                                   CGRectGetMinX(frame) +
                                       floor((CGRectGetWidth(frame) - 43.3) * 0.37111 - 0.2) + 0.7,
                                   CGRectGetMinY(frame) +
                                       floor((CGRectGetHeight(frame) - 43.3) * 0.37735 - 0.05) +
                                       0.55,
                                   43.3, 43.3)];
  [fillColor2 setFill];
  [ovalPath fill];
}

@end
