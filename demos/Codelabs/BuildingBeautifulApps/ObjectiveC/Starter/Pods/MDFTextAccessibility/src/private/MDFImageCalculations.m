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

#import "MDFImageCalculations.h"

UIColor *MDFAverageColorOfOpaqueImage(UIImage *image, CGRect region) {
  CGImageRef imageRef = image.CGImage;
  CGImageRef cropped = CGImageCreateWithImageInRect(imageRef, region);

  // Empty/null regions will cause cropped to be nil.
  if (!cropped) {
    return nil;
  }

  UIGraphicsBeginImageContext(CGSizeMake(1, 1));

  uint8_t argb[4];
  CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context =
      CGBitmapContextCreate(argb,  // data
                            1,     // width
                            1,     // height
                            8,     // Bits per component
                            4,     // Bytes per row
                            colorspace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big);
  CGColorSpaceRelease(colorspace);
  CGContextSetInterpolationQuality(context, kCGInterpolationMedium);
  CGContextSetBlendMode(context, kCGBlendModeCopy);
  CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), cropped);
  CGContextRelease(context);
  CGImageRelease(cropped);

  CGFloat alpha = argb[0] / (CGFloat)255;
  CGFloat scale = alpha > 0 ? 1 / (alpha * 255) : 0;
  UIColor *color =
      [UIColor colorWithRed:scale * argb[1] green:scale * argb[2] blue:scale * argb[3] alpha:alpha];
  UIGraphicsEndImageContext();
  return color;
}
