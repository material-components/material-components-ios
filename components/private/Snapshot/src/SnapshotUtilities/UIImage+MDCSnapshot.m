// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "UIImage+MDCSnapshot.h"

static void RenderCheckerboardPatternOfSize(CGSize size) {
  CGFloat quarterWidth = size.width / 4;
  CGFloat quarterHeight = size.height / 4;
  // Create a "checkboard" pattern
  for (int x = 0; x < 4; ++x) {
    for (int y = (x & 0x01); y < 4; y += 2) {
      UIRectFill(CGRectMake(x * quarterWidth, y * quarterHeight, quarterWidth, quarterHeight));
    }
  }
}

static void RenderRectanglesPatternOfSize(CGSize size) {
  CGFloat squareSpacing = 4;
  CGPoint origin = CGPointMake(0, 0);
  while (!CGSizeEqualToSize(size, CGSizeZero)) {
    UIRectFrame(CGRectMake(origin.x, origin.y, size.width, size.height));
    origin = CGPointMake(origin.x + squareSpacing, origin.y + squareSpacing);
    size =
        CGSizeMake(MAX(0, size.width - 2 * squareSpacing), MAX(0, size.height - 2 * squareSpacing));
  }
}

static void RenderEllipsesPatternOfSize(CGSize size) {
  CGFloat spacing = 6;
  CGFloat lineWidth = 2;
  CGPoint origin = CGPointMake(lineWidth, lineWidth);
  size = CGSizeMake(MAX(0, size.width - 2 * lineWidth), MAX(0, size.height - 2 * lineWidth));
  while (size.width >= lineWidth && size.height >= lineWidth) {
    UIBezierPath *path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(origin.x, origin.y, size.width, size.height)];
    path.lineWidth = lineWidth;
    [path stroke];
    origin = CGPointMake(origin.x + spacing, origin.y + spacing);
    size = CGSizeMake(MAX(0, size.width - 2 * spacing), MAX(0, size.height - 2 * spacing));
  }
}

static void RenderDialogLinesPatternOfSize(CGSize size) {
  NSInteger numLines = 3;
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 2);
  for (int i = 0; i < numLines; ++i) {
    CGFloat increment = ((CGFloat)i / numLines) + (CGFloat)1 / (numLines * 2);
    CGContextMoveToPoint(context, size.width * increment, 0);
    CGContextAddLineToPoint(context, 0, size.height * increment);
    CGContextMoveToPoint(context, size.width - size.width * increment, size.height);
    CGContextAddLineToPoint(context, size.width, size.height - size.height * increment);
  }
  CGContextStrokePath(context);
}

static void RenderFramedXOfSize(CGSize size) {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGFloat minDimension = MIN(size.width, size.height);
  CGContextSetLineWidth(context, (CGFloat)ceil(minDimension / 10));
  CGContextMoveToPoint(context, 0, 0);
  CGContextAddLineToPoint(context, size.width, size.height);
  CGContextMoveToPoint(context, 0, size.height);
  CGContextAddLineToPoint(context, size.width, 0);
  CGContextStrokePath(context);
  UIRectFrame(CGRectMake(0, 0, size.width, size.height));
}

@implementation UIImage (MDCSnapshot)

+ (UIImage *)mdc_testImageOfSize:(CGSize)size withStyle:(MDCSnapshotTestImageStyle)imageStyle {
  CGFloat scale = UIScreen.mainScreen.scale;
  if (scale < 1) {
    scale = 2;  // Default to 2x if somehow there is no scale available.
  }
  UIGraphicsBeginImageContextWithOptions(size, NO, scale);
  [UIColor.blackColor setFill];
  switch (imageStyle) {
    case MDCSnapshotTestImageStyleCheckerboard:
      RenderCheckerboardPatternOfSize(size);
      break;
    case MDCSnapshotTestImageStyleRectangles:
      RenderRectanglesPatternOfSize(size);
      break;
    case MDCSnapshotTestImageStyleEllipses:
      RenderEllipsesPatternOfSize(size);
      break;
    case MDCSnapshotTestImageStyleDiagonalLines:
      RenderDialogLinesPatternOfSize(size);
      break;
    case MDCSnapshotTestImageStyleFramedX:
      RenderFramedXOfSize(size);
      break;
  }
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

+ (UIImage *)mdc_testImageOfSize:(CGSize)size {
  return [self mdc_testImageOfSize:size withStyle:MDCSnapshotTestImageStyleCheckerboard];
}

@end
