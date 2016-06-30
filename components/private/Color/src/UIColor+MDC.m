/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "UIColor+MDC.h"

// Export a nonsense symbol to suppress a libtool warning when this is linked alone in a static lib.
__attribute__((visibility("default"))) char MDCColorExportToSuppressLibToolWarning = 0;

@implementation UIColor (MDC)

+ (UIColor *)mdc_colorInterpolatedFromColor:(UIColor *)fromColor
                                    toColor:(UIColor *)toColor
                                    percent:(CGFloat)percent {
  // Clamp percent to [0.0, 1.0]
  percent = MAX(0, percent);
  percent = MIN(1, percent);

  CGFloat r1, g1, b1, a1;
  r1 = g1 = b1 = a1 = 1;
  if (![fromColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1]) {
    [fromColor getWhite:&r1 alpha:&a1];
    g1 = b1 = r1;
  };

  CGFloat r2, g2, b2, a2;
  r2 = g2 = b2 = a2 = 1;
  if (![toColor getRed:&r2 green:&g2 blue:&b2 alpha:&a2]) {
    [toColor getWhite:&r2 alpha:&a2];
    g2 = b2 = r2;
  }

  CGFloat rfinal = r1 * (1 - percent) + r2 * percent;
  CGFloat gfinal = g1 * (1 - percent) + g2 * percent;
  CGFloat bfinal = b1 * (1 - percent) + b2 * percent;
  CGFloat afinal = a1 * (1 - percent) + a2 * percent;

  return [UIColor colorWithRed:rfinal green:gfinal blue:bfinal alpha:afinal];
}

@end
