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

#import "MDCCatalogTileDataInk.h"

@implementation MDCCatalogTileDataInk

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
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 139.5) * 0.49485 + 0.5),
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 80.1) * 0.32043 - 0.4) + 0.9, 139.5,
      80.1);

  UIBezierPath* rectanglePath =
      [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + 24,
                                                  CGRectGetMinY(frame) + 24, 139.5, 80.1)];
  [fillColor setFill];
  [rectanglePath fill];
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.5);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* clipPath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group), CGRectGetMinY(group), 139.5, 80.1)];
    [clipPath addClip];

    UIBezierPath* ovalPath =
        [UIBezierPath bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group) + 53.65,
                                                          CGRectGetMinY(group) - 5.05, 90.2, 90.2)];
    [fillColor2 setFill];
    [ovalPath fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }
}
#pragma clang diagnostic pop

@end
