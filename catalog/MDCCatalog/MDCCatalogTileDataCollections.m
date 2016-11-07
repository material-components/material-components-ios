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

#import "MDCCatalogTileDataCollections.h"

@implementation MDCCatalogTileDataCollections

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconversion"
#pragma clang diagnostic ignored "-Wassign-enum"
+ (void)draw:(CGRect)frame {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* white40 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
  UIColor* blue60 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.6];
  UIColor* white60 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
  UIColor* white80 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
  UIColor* white30 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];

  CGRect group2 =
      CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.13021 + 0.02) + 0.48,
                 CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.15484 - 0.38) + 0.88,
                 floor(CGRectGetWidth(frame) * 0.86984 - 0.03) -
                     floor(CGRectGetWidth(frame) * 0.13021 + 0.02) + 0.05,
                 floor(CGRectGetHeight(frame) * 0.67177 + 0.5) -
                     floor(CGRectGetHeight(frame) * 0.15484 - 0.38) - 0.88);

  {
    UIBezierPath* collectionsPath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00018 + 0.48) + 0.02,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.02,
                                      floor(CGRectGetWidth(group2) * 0.99982 + 0.47) -
                                          floor(CGRectGetWidth(group2) * 0.00018 + 0.48),
                                      floor(CGRectGetHeight(group2) * 0.99969 + 0.38) -
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.1)];
    [fillColor setFill];
    [collectionsPath fill];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.6);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* rectangle2Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                            floor(CGRectGetWidth(group2) * 0.00036 + 0.45) + 0.05,
                                        CGRectGetMinY(group2) +
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.02,
                                        floor(CGRectGetWidth(group2) * 0.66667 - 0.2) -
                                            floor(CGRectGetWidth(group2) * 0.00036 + 0.45) + 0.65,
                                        floor(CGRectGetHeight(group2) * 0.99969 + 0.38) -
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.1)];
      [white60 setFill];
      [rectangle2Path fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle3Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05,
                                      floor(CGRectGetWidth(group2) * 0.33333 + 0.15) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.35,
                                      floor(CGRectGetHeight(group2) * 0.50016 + 0.4) -
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05)];
    [white80 setFill];
    [rectangle3Path fill];

    UIBezierPath* rectangle4Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.33333 + 0.15) + 0.35,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.50016 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.66667 - 0.2) -
                                          floor(CGRectGetWidth(group2) * 0.33333 + 0.15) + 0.35,
                                      floor(CGRectGetHeight(group2) * 1.00000 + 0.45) -
                                          floor(CGRectGetHeight(group2) * 0.50016 + 0.5) + 0.05)];
    [blue60 setFill];
    [rectangle4Path fill];

    UIBezierPath* rectangle5Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.66667 - 0.2) + 0.7,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05,
                                      floor(CGRectGetWidth(group2) * 1.00000 + 0.45) -
                                          floor(CGRectGetWidth(group2) * 0.66667 - 0.2) - 0.65,
                                      floor(CGRectGetHeight(group2) * 0.50016 + 0.4) -
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05)];
    [white30 setFill];
    [rectangle5Path fill];

    UIBezierPath* rectangle6Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.16667 + 0.32) + 0.18,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.24992 + 0.45) + 0.05,
                                      floor(CGRectGetWidth(group2) * 0.85203 + 0.02) -
                                          floor(CGRectGetWidth(group2) * 0.16667 + 0.32) + 0.3,
                                      floor(CGRectGetHeight(group2) * 0.74977 + 0.4) -
                                          floor(CGRectGetHeight(group2) * 0.24992 + 0.45) + 0.05)];
    [white40 setFill];
    [rectangle6Path fill];
  }
}
#pragma clang diagnostic pop

@end
