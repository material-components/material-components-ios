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

#import "MDCCatalogTileDataButtons.h"

@implementation MDCCatalogTileDataButtons

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 77.75) * 0.22200 + 0.02) + 0.48,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 24.25) * 0.30382 + 0.47) + 0.03, 77.75,
      24.25);
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.95);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group),
                                                           CGRectGetMinY(group), 77.75, 24.25)
                                   cornerRadius:3.4];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  UIBezierPath* ovalPath = [UIBezierPath
      bezierPathWithOvalInRect:CGRectMake(
                                   CGRectGetMinX(frame) +
                                       floor((CGRectGetWidth(frame) - 49.8) * 0.82308 - 0.25) +
                                       0.75,
                                   CGRectGetMinY(frame) +
                                       floor((CGRectGetHeight(frame) - 49.7) * 0.25641 + 0.2) + 0.3,
                                   49.8, 49.7)];
  [fillColor setFill];
  [ovalPath fill];
}

@end
