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

#import "MDCTextControlGradientManager.h"

#import <UIKit/UIKit.h>

@interface MDCTextControlGradientManager ()
@end

@implementation MDCTextControlGradientManager

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCTextControlGradientManagerInit];
  }
  return self;
}

- (void)commonMDCTextControlGradientManagerInit {
  UIColor *outer = (id)UIColor.clearColor.CGColor;
  UIColor *inner = (id)UIColor.blackColor.CGColor;
  NSArray *colors = @[ outer, outer, inner, inner, outer, outer ];
  self.horizontalGradient = [CAGradientLayer layer];
  self.horizontalGradient.colors = colors;
  self.horizontalGradient.startPoint = CGPointMake(0.0, 0.5);
  self.horizontalGradient.endPoint = CGPointMake(1.0, 0.5);

  self.verticalGradient = [CAGradientLayer layer];
  self.verticalGradient.colors = colors;
  self.verticalGradient.startPoint = CGPointMake(0.5, 0.0);
  self.verticalGradient.endPoint = CGPointMake(0.5, 1.0);
}

- (CALayer *)combinedGradientMaskLayer {
  return [self layerCombiningHorizontalGradient:self.horizontalGradient
                           withVerticalGradient:self.verticalGradient];
}

- (CALayer *)layerCombiningHorizontalGradient:(CAGradientLayer *)horizontalGradient
                         withVerticalGradient:(CAGradientLayer *)verticalGradient {
  horizontalGradient.mask = verticalGradient;
  UIImage *image = [self createImageWithLayer:horizontalGradient];
  CALayer *layer = [self createLayerWithImage:image];
  return layer;
}

- (UIImage *)createImageWithLayer:(CALayer *)layer {
  UIGraphicsBeginImageContext(layer.frame.size);
  [layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

- (CALayer *)createLayerWithImage:(UIImage *)image {
  CALayer *layer = [[CALayer alloc] init];
  layer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
  layer.contents = (__bridge id _Nullable)(image.CGImage);
  return layer;
}

@end
