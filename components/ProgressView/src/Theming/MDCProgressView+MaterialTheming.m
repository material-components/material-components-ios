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

#import "MDCProgressView+MaterialTheming.h"

// The ratio by which to desaturate the progress tint color to obtain the default track tint color.
static const CGFloat MDCProgressViewTrackColorDesaturation = (CGFloat)0.3;

@implementation MDCProgressView (MaterialTheming)

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  [self applyThemeWithColorScheme:scheme.colorScheme];
}

- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.trackTintColor =
      [[self class] mdcThemingDefaultTrackTintColorForProgressTintColor:colorScheme.primaryColor];
  self.progressTintColor = colorScheme.primaryColor;
}

+ (UIColor *)mdcThemingDefaultTrackTintColorForProgressTintColor:(UIColor *)progressTintColor {
  CGFloat hue, saturation, brightness, alpha;
  if ([progressTintColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
    CGFloat newSaturation = MIN(saturation * MDCProgressViewTrackColorDesaturation, 1);
    return [UIColor colorWithHue:hue saturation:newSaturation brightness:brightness alpha:alpha];
  }
  return [UIColor clearColor];
}

@end
