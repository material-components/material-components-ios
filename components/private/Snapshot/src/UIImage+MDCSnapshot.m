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

@implementation UIImage (MDCSnapshot)

+ (UIImage *)mdc_testImageOfSize:(CGSize)size {
  UIGraphicsBeginImageContext(size);
  [UIColor.blackColor setFill];
  CGFloat quarterWidth = size.width / 4;
  CGFloat quarterHeight = size.height / 4;
  // Create a "checkboard" pattern
  for (int x = 0; x < 4; ++x) {
    for (int y = (x & 0x01); y < 4; y += 2) {
      UIRectFill(CGRectMake(x * quarterWidth, y * quarterHeight, quarterWidth, quarterHeight));
    }
  }
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@end
