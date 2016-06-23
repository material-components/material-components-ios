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

// Returns the horizontally flipped version of the given UIImageOrientation.
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

@implementation UIImage (MaterialRTL)

- (UIImage *)mdc_imageFlippedForRightToLeftLayoutDirection {
  // On iOS 9 and above, UIImage supports being prepared for flipping. Otherwise, do the flip
  // manually.
  if ([self respondsToSelector:@selector(imageFlippedForRightToLeftLayoutDirection)]) {
    return [self imageFlippedForRightToLeftLayoutDirection];
  } else {
    // TODO: This is an issue with templated images.
    // https://github.com/google/material-components-ios/issues/592
    return [UIImage imageWithCGImage:self.CGImage
                               scale:self.scale
                         orientation:MDCRTLMirroredOrientation(self.imageOrientation)];
  }
}

@end
