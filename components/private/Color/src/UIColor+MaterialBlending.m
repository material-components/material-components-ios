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

#import "UIColor+MaterialBlending.h"

/**
 Helper method to blend a color channel with a background color channel using alpha composition.
 More info about Alpha compositing: https://en.wikipedia.org/wiki/Alpha_compositing

 @params value is the value of color channel
 @params bValue is the value of background color channel
 @params alpha is the alpha of color channel
 @params bAlpha is the alpha of background color channel
 */

static CGFloat blendColorChannel(CGFloat value, CGFloat bValue, CGFloat alpha, CGFloat bAlpha) {
  return ((1 - alpha) * bValue * bAlpha + alpha * value) / (alpha + bAlpha * (1 - alpha));
}

@implementation UIColor (MaterialBlending)

+ (UIColor *)mdc_blendColor:(UIColor *)color withBackgroundColor:(UIColor *)backgroundColor {
  CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
  [color getRed:&red green:&green blue:&blue alpha:&alpha];
  CGFloat bRed = 0.0, bGreen = 0.0, bBlue = 0.0, bAlpha = 0.0;
  [backgroundColor getRed:&bRed green:&bGreen blue:&bBlue alpha:&bAlpha];

  return [UIColor colorWithRed:blendColorChannel(red, bRed, alpha, bAlpha)
                         green:blendColorChannel(green, bGreen, alpha, bAlpha)
                          blue:blendColorChannel(blue, bBlue, alpha, bAlpha)
                         alpha:alpha + bAlpha * (1 - alpha)];
}

@end
