// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCSliderColorThemer.h"
#import "MaterialPalettes.h"

static const CGFloat kSliderThemerLightAlpha = 0.26f;
static const CGFloat kSliderThemerDarkAlpha = 0.3f;
static const CGFloat kSliderBaselineDisabledFillAlpha = 0.32f;
static const CGFloat kSliderBaselineEnabledBackgroundAlpha = 0.24f;
static const CGFloat kSliderBaselineDisabledBackgroundAlpha = 0.12f;
static const CGFloat kSliderBaselineEnabledTicksAlpha = 0.54f;
static const CGFloat kSliderBaselineDisabledTicksAlpha = 0.12f;

@implementation MDCSliderColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toSlider:(nonnull MDCSlider *)slider {
  UIColor *disabledFillColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kSliderBaselineDisabledFillAlpha];
  UIColor *enabledBackgroundColor =
      [colorScheme.primaryColor colorWithAlphaComponent:kSliderBaselineEnabledBackgroundAlpha];
  
  if (slider.statefulAPIEnabled) {
    [slider setTrackFillColor:colorScheme.primaryColor forState:UIControlStateNormal];
    [slider setTrackFillColor:disabledFillColor forState:UIControlStateDisabled];
    [slider setTrackBackgroundColor:enabledBackgroundColor forState:UIControlStateNormal];
    UIColor *disabledBackgroundColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:kSliderBaselineDisabledBackgroundAlpha];
    [slider setTrackBackgroundColor:disabledBackgroundColor forState:UIControlStateDisabled];
    UIColor *enabledTickFillColor =
        [colorScheme.onPrimaryColor colorWithAlphaComponent:kSliderBaselineEnabledTicksAlpha];
    [slider setFilledTrackTickColor:enabledTickFillColor forState:UIControlStateNormal];
    UIColor *disabledTickFillColor =
        [colorScheme.onPrimaryColor colorWithAlphaComponent:kSliderBaselineDisabledTicksAlpha];
    [slider setFilledTrackTickColor:disabledTickFillColor forState:UIControlStateDisabled];
    UIColor *enabledTickBackgroundColor =
        [colorScheme.primaryColor colorWithAlphaComponent:kSliderBaselineEnabledTicksAlpha];
    [slider setBackgroundTrackTickColor:enabledTickBackgroundColor forState:UIControlStateNormal];
    UIColor *disabledTickBackgroundColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:kSliderBaselineDisabledTicksAlpha];
    [slider setBackgroundTrackTickColor:disabledTickBackgroundColor
                               forState:UIControlStateDisabled];
    [slider setThumbColor:colorScheme.primaryColor forState:UIControlStateNormal];
    [slider setThumbColor:disabledFillColor forState:UIControlStateDisabled];
  } else {
    slider.color = colorScheme.primaryColor;
    slider.disabledColor = disabledFillColor;
    slider.trackBackgroundColor = enabledBackgroundColor;
  }

  slider.valueLabelTextColor = colorScheme.onPrimaryColor;
  slider.valueLabelBackgroundColor = colorScheme.primaryColor;
}

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
                toSlider:(MDCSlider *)slider {
  if ([colorScheme respondsToSelector:@selector(primaryLightColor)]) {
    slider.trackBackgroundColor = colorScheme.primaryLightColor;
  }
  slider.color = colorScheme.primaryColor;
  if ([colorScheme respondsToSelector:@selector(primaryDarkColor)]) {
    slider.disabledColor = colorScheme.primaryDarkColor;
  }
}

#pragma mark - Default color schemes

+ (MDCBasicColorScheme *)defaultSliderLightColorScheme {
  UIColor *lightTrackOffColor =
      [[UIColor blackColor] colorWithAlphaComponent:kSliderThemerLightAlpha];
  UIColor *lightDisabledColor =
      [[UIColor blackColor] colorWithAlphaComponent:kSliderThemerLightAlpha];

  MDCBasicColorScheme *lightScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:MDCPalette.bluePalette.tint500
                                      primaryLightColor:lightTrackOffColor
                                       primaryDarkColor:lightDisabledColor];
  return lightScheme;
}

+ (MDCBasicColorScheme *)defaultSliderDarkColorScheme {
  UIColor *darkTrackOffColor =
      [[UIColor whiteColor] colorWithAlphaComponent:kSliderThemerDarkAlpha];
  UIColor *darkDisabledColor =
      [[UIColor whiteColor] colorWithAlphaComponent:kSliderThemerDarkAlpha];

  MDCBasicColorScheme *darkScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:MDCPalette.bluePalette.tint500
                                      primaryLightColor:darkTrackOffColor
                                       primaryDarkColor:darkDisabledColor];
  return darkScheme;
}

@end
