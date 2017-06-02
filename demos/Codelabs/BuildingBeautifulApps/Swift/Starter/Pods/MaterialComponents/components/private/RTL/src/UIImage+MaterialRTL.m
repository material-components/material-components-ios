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

#import "UIImage+MaterialRTL.h"

/** Returns the horizontally flipped version of the given UIImageOrientation. */
static UIImageOrientation MDCRTLMirroredOrientation(UIImageOrientation sourceOrientation) {
  switch (sourceOrientation) {
    case UIImageOrientationUp:
      return UIImageOrientationUpMirrored;
    case UIImageOrientationDown:
      return UIImageOrientationDownMirrored;
    case UIImageOrientationLeft:
      return UIImageOrientationLeftMirrored;
    case UIImageOrientationRight:
      return UIImageOrientationRightMirrored;
    case UIImageOrientationUpMirrored:
      return UIImageOrientationUp;
    case UIImageOrientationDownMirrored:
      return UIImageOrientationDown;
    case UIImageOrientationLeftMirrored:
      return UIImageOrientationLeft;
    case UIImageOrientationRightMirrored:
      return UIImageOrientationRight;
  }
  NSCAssert(NO, @"Invalid enumeration value %i.", (int)sourceOrientation);
  return UIImageOrientationUpMirrored;
}

/**
 Returns a copy of the image actually flipped. The orientation and scale are consumed, while the
 rendering mode is ported to the new image.
 On iOS 9 and above, use `-[UIView imageFlippedForRightToLeftLayoutDirection]` instead.
 */
static UIImage *MDCRTLFlippedImage(UIImage *image) {
  NSCAssert(![image respondsToSelector:@selector(imageFlippedForRightToLeftLayoutDirection)],
            @"Do not call this method on iOS 9 and above.");
  CGSize size = [image size];
  CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);

  UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetShouldAntialias(context, true);
  CGContextSetInterpolationQuality(context, kCGInterpolationHigh);

  // Note: UIKit's and CoreGraphics coordinates systems are flipped vertically (UIKit's Y axis goes
  // down, while CoreGraphics' goes up).
  switch (image.imageOrientation) {
    case UIImageOrientationUp:
      CGContextScaleCTM(context, -1, -1);
      CGContextTranslateCTM(context, -rect.size.width, -rect.size.height);
      break;
    case UIImageOrientationDown:
      // Orientation down is equivalent to a 180º rotation. The difference in coordinates systems is
      // thus sufficient and nothing needs to be down to flip the image.
      break;
    case UIImageOrientationLeft:
      CGContextRotateCTM(context, -(CGFloat)M_PI / 2.f);
      CGContextTranslateCTM(context, -rect.size.width, 0);
      break;
    case UIImageOrientationRight:
      CGContextRotateCTM(context, (CGFloat)M_PI / 2);
      CGContextTranslateCTM(context, 0, -rect.size.width);
      break;
    case UIImageOrientationUpMirrored:
      CGContextScaleCTM(context, 1, -1);
      CGContextTranslateCTM(context, 0, -rect.size.height);
      break;
    case UIImageOrientationDownMirrored:
      CGContextScaleCTM(context, -1, 1);
      CGContextTranslateCTM(context, -rect.size.width, 0);
      break;
    case UIImageOrientationLeftMirrored:
      CGContextRotateCTM(context, -(CGFloat)M_PI / 2);
      CGContextTranslateCTM(context, -rect.size.width, 0);
      CGContextScaleCTM(context, -1, 1);
      CGContextTranslateCTM(context, -rect.size.width, 0);
      break;
    case UIImageOrientationRightMirrored:
      CGContextRotateCTM(context, (CGFloat)M_PI / 2);
      CGContextTranslateCTM(context, 0, -rect.size.width);
      CGContextScaleCTM(context, -1, 1);
      CGContextTranslateCTM(context, -rect.size.width, 0);
      break;
    default:
      NSCAssert(NO, @"Invalid enumeration value %i.", (int)image.imageOrientation);
  }

  CGContextDrawImage(context, rect, image.CGImage);

  UIImage *flippedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  // Port the rendering mode.
  flippedImage = [flippedImage imageWithRenderingMode:image.renderingMode];
  return flippedImage;
}

@implementation UIImage (MaterialRTL)

- (UIImage *)mdc_imageFlippedForRightToLeftLayoutDirection {
  // On iOS 9 and above, UIImage supports being prepared for flipping. Otherwise, do the flip
  // manually.
  if ([self respondsToSelector:@selector(imageFlippedForRightToLeftLayoutDirection)]) {
    return [self imageFlippedForRightToLeftLayoutDirection];
  } else {
    // -[UIImage imageWithCGImage:scale:orientation:] looses the rendering mode.
    // If the image has a default rendering mode (i.e. UIImageRenderingModeAutomatic), it is fine to
    // use it.
    //
    if (self.renderingMode == UIImageRenderingModeAutomatic) {
      return [[self class] imageWithCGImage:self.CGImage
                                      scale:self.scale
                                orientation:MDCRTLMirroredOrientation(self.imageOrientation)];
    } else {  // Otherwise, flip the image manually.
      return MDCRTLFlippedImage(self);
    }
  }
}

@end
