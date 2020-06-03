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

#import "UIColor+MaterialDynamic.h"

#import "MaterialAvailability.h"

@implementation UIColor (MaterialDynamic)

+ (UIColor *)colorWithUserInterfaceStyleDarkColor:(UIColor *)darkColor
                                     defaultColor:(UIColor *)defaultColor {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    return [UIColor
        colorWithDynamicProvider:^UIColor *_Nonnull(UITraitCollection *_Nonnull traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return darkColor;
          } else {
            return defaultColor;
          }
        }];
  } else {
    return defaultColor;
  }
#else
  return defaultColor;
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

+ (UIColor *)colorWithAccessibilityContrastHigh:(UIColor *)highContrastColor
                                         normal:(UIColor *)normalContrastColor {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    return [UIColor
        colorWithDynamicProvider:^UIColor *_Nonnull(UITraitCollection *_Nonnull traitCollection) {
          if (traitCollection.accessibilityContrast == UIAccessibilityContrastHigh) {
            return highContrastColor;
          } else {
            return normalContrastColor;
          }
        }];
  } else {
    return normalContrastColor;
  }
#else
  return normalContrastColor;
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (UIColor *)mdc_resolvedColorWithTraitCollection:(UITraitCollection *)traitCollection {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    return [self resolvedColorWithTraitCollection:traitCollection];
  } else {
    return self;
  }
#else
  return self;
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

@end
