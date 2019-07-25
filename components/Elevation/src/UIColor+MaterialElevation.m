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

#import "UIColor+MaterialElevation.h"

#import <CoreGraphics/CoreGraphics.h>

#import "MaterialMath.h"
#import "UIColor+MaterialBlending.h"

@implementation UIColor (MaterialElevation)

- (UIColor *)mdc_resolvedColorWithTraitCollection:(UITraitCollection *)traitCollection
                                        elevation:(CGFloat)elevation {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    UIColor *resolvedColor = [self resolvedColorWithTraitCollection:traitCollection];
    if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
      return [resolvedColor mdc_resolvedColorWithElevation:elevation];
    } else {
      return resolvedColor;
    }
  } else {
    return [self mdc_resolvedColorWithElevation:elevation];
  }
#else
  return [self mdc_resolvedColorWithElevation:elevation];
#endif
}

- (UIColor *)mdc_resolvedColorWithElevation:(CGFloat)elevation {
  UIColor *overlayColor = UIColor.whiteColor;
  return [self mdc_resolvedColorWithElevation:elevation overlayColor:overlayColor];
}

- (UIColor *)mdc_resolvedColorWithElevation:(CGFloat)elevation
                               overlayColor:(UIColor *)overlayColor {
  if (CGColorGetPattern(self.CGColor)) {
    [NSException
         raise:NSGenericException
        format:@"Pattern-Base Color %@ is not supported in %@", self, NSStringFromSelector(_cmd)];
  }
  elevation = MAX(elevation, 0);
  CGFloat alphaValue = 0;
  if (!MDCCGFloatEqual(elevation, 0)) {
    alphaValue = 4.5 * log(elevation + 1) + 2;
  }
  return [UIColor mdc_blendColor:[overlayColor colorWithAlphaComponent:alphaValue * 0.01]
             withBackgroundColor:self];
}

@end
