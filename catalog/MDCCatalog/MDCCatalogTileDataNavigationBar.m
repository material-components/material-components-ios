/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCatalogTileDataNavigationBar.h"

@implementation MDCCatalogTileDataNavigationBar

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconversion"
+ (void)draw:(CGRect)frame {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  UIColor* fillColor = [UIColor colorWithRed:0.184 green:0.571 blue:0.828 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:0.994 green:0.994 blue:0.994 alpha:1];
  UIColor* textForeground = [UIColor colorWithRed:0.996 green:0.996 blue:0.996 alpha:0.2];
  UIColor* gradientColor2 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];

  CGFloat gradientLocations[] = {0.14, 0.5, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef) @[
        (id)gradientColor2.CGColor, (id)[gradientColor2 colorWithAlphaComponent:0.5].CGColor,
        (id)gradientColor.CGColor
      ],
      gradientLocations);
  {
    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.1);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangleRect =
          CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 48.38, 139, 55.65);
      UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
      CGContextSaveGState(context);
      [rectanglePath addClip];
      CGContextDrawLinearGradient(
          context, gradient,
          CGPointMake(
              CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
              CGRectGetMidY(rectangleRect) + -16.12 * CGRectGetHeight(rectangleRect) / 55.65),
          CGPointMake(
              CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
              CGRectGetMidY(rectangleRect) + 25.22 * CGRectGetHeight(rectangleRect) / 55.65),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + 24.5,
                                                    CGRectGetMinY(frame) + 24, 139, 29)];
    [fillColor setFill];
    [rectangle2Path fill];

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 147.88, CGRectGetMinY(frame) + 42.73)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 145.07, CGRectGetMinY(frame) + 40.19)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 38.51)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 146.21, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 34.77)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 144.54, CGRectGetMinY(frame) + 33.45)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 34.59)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 147.16, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 148.07, CGRectGetMinY(frame) + 33.89)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 151.12, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 149.26, CGRectGetMinY(frame) + 33.89)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 150.17, CGRectGetMinY(frame) + 33.45)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 152.8, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 34.77)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 149.46, CGRectGetMinY(frame) + 42.74)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 38.51)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 152.26, CGRectGetMinY(frame) + 40.19)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezierPath closePath];
    [fillColor2 setFill];
    [bezierPath fill];

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 147.88, CGRectGetMinY(frame) + 42.73)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 145.07, CGRectGetMinY(frame) + 40.19)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 38.51)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 146.21, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 34.77)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 144.54, CGRectGetMinY(frame) + 33.45)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 34.59)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 147.16, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 148.07, CGRectGetMinY(frame) + 33.89)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 151.12, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 149.26, CGRectGetMinY(frame) + 33.89)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 150.17, CGRectGetMinY(frame) + 33.45)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 152.8, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 34.77)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 149.46, CGRectGetMinY(frame) + 42.74)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 38.51)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 152.26, CGRectGetMinY(frame) + 40.19)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezier2Path closePath];
    [fillColor2 setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 36.27)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 36.27)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 35.18)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 35.18)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 36.27)];
    [bezier3Path closePath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 39)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 39)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 37.91)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 37.91)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 39)];
    [bezier3Path closePath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 41.72)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 41.72)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 40.63)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 40.63)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 41.72)];
    [bezier3Path closePath];
    [fillColor2 setFill];
    [bezier3Path fill];

    CGRect labelRect =
        CGRectMake(CGRectGetMinX(frame) + 57, CGRectGetMinY(frame) + 29.86, 36.21, 17);
    {
      NSString* textContent = @"AppBar";
      NSMutableParagraphStyle* labelStyle = [NSMutableParagraphStyle new];
      labelStyle.alignment = NSTextAlignmentCenter;

      NSDictionary* labelFontAttributes = @{
        NSFontAttributeName : [UIFont fontWithName:@"Roboto-Medium" size:11],
        NSForegroundColorAttributeName : textForeground,
        NSParagraphStyleAttributeName : labelStyle
      };

      CGFloat labelTextHeight =
          [textContent boundingRectWithSize:CGSizeMake(labelRect.size.width, INFINITY)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:labelFontAttributes
                                    context:nil]
              .size.height;
      CGContextSaveGState(context);
      CGContextClipToRect(context, labelRect);
      [textContent drawInRect:CGRectMake(CGRectGetMinX(labelRect),
                                         CGRectGetMinY(labelRect) +
                                             (CGRectGetHeight(labelRect) - labelTextHeight) / 2,
                                         CGRectGetWidth(labelRect), labelTextHeight)
               withAttributes:labelFontAttributes];
      CGContextRestoreGState(context);
    }
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}
#pragma clang diagnostic pop

@end
