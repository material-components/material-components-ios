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

#include "MDCPaletteExpansions.h"

// Observed saturation ranges for tints 50, 500, 900.
static const CGFloat kSaturation50Min = 0.06f;
static const CGFloat kSaturation50Max = 0.12f;
static const CGFloat kSaturation500Min = 0.60f;
static const CGFloat kSaturation500Max = 1.00f;
static const CGFloat kSaturation900Min = 0.70f;
static const CGFloat kSaturation900Max = 1.00f;

// Minimum value of saturation to consider a color "colorless" (e.g. white/black/grey).
static const CGFloat kSaturationMinThreshold = 1 / 256.0f;

// A small value for comparing floating point numbers that is appropriate for color components.
static const CGFloat kComponentEpsilon = 0.5f / 256.0f;

// Observed brightness ranges for tints 50, 500, 900.
static const CGFloat kBrightness50Min = 0.95f;
static const CGFloat kBrightness50Max = 1.00f;
static const CGFloat kBrightness500Min = 0.50f;
static const CGFloat kBrightness500Max = 1.00f;

// Observed quadratic brightness coefficients for tints >= 500.
static const CGFloat kBrightnessQuadracticCoeff = -0.00642857142857143f;
static const CGFloat kBrightnessLinearCoeff = -0.03585714285714282f;

// Median saturation and brightness values for A100, A200, A400, A700.
static const CGFloat kAccentSaturation[4] = {0.49f, 0.75f, 1.00f, 1.00f};
static const CGFloat kAccentBrightness[4] = {1.00f, 1.00f, 1.00f, 0.92f};

/** Returns a value Clamped to the range [min, max]. */
static inline CGFloat Clamp(CGFloat value, CGFloat min, CGFloat max) {
  if (value < min) {
    return min;
  } else if (value > max) {
    return max;
  } else {
    return value;
  }
}

/** Returns the linear interpolation of [min, max] at value. */
static inline CGFloat Lerp(CGFloat value, CGFloat min, CGFloat max) {
  return (1 - value) * min + value * max;
}

/** Returns the value t such that Lerp(t, min, max) == value. */
static inline CGFloat InvLerp(CGFloat value, CGFloat min, CGFloat max) {
  return (value - min) / (max - min);
}

/**
 Returns "component > value", but accounting for floating point mathematics. The component is
 expected to be between [0,255].
 */
static inline BOOL IsComponentGreaterThanValue(CGFloat component, CGFloat value) {
  return component + kComponentEpsilon > value;
}

UIColor *MDCTintFromTargetColor(UIColor *targetColor, NSString *tintName) {
  // DO NOT SUBMIT NSCAssert([QTMColorGroup colorToneIsTint:tint], @"");

  // Pre-iOS 8 would not convert greyscale colors to HSB.
  CGFloat hsb[4];
  if (![targetColor getHue:&hsb[0] saturation:&hsb[1] brightness:&hsb[2] alpha:&hsb[3]]) {
    // Greyscale colors have hue and saturation of zero.
    hsb[0] = 0;
    hsb[1] = 0;
    if (![targetColor getWhite:&hsb[2] alpha:&hsb[3]]) {
      NSCAssert(NO, @"Could not extract HSB from target color %@", targetColor);
      return nil;
    }
  }

  // Saturation: select a saturation curve from the input saturation, unless the saturation is so
  // low to be considered 'colorless', e.g. white/black/grey, in which case skip this step.
  CGFloat saturation = hsb[1];
  CGFloat t;
  if (IsComponentGreaterThanValue(hsb[1], kSaturationMinThreshold)) {
    // Limit saturation to observed values.
    hsb[1] = Clamp(hsb[1], kSaturation500Min, kSaturation500Max);

    t = InvLerp(hsb[1], kSaturation500Min, kSaturation500Max);
    if (tint <= kQTMColorTint500) {
      CGFloat saturation50 = Lerp(t, kSaturation50Min, kSaturation50Max);
      CGFloat u = InvLerp(tint, kQTMColorTint50, kQTMColorTint500);
      saturation = Lerp(u, saturation50, hsb[1]);
    } else {
      CGFloat saturation900 = Lerp(t, kSaturation900Min, kSaturation900Max);
      CGFloat u = InvLerp(tint, kQTMColorTint500, kQTMColorTint900);
      saturation = Lerp(u, hsb[1], saturation900);
    }
  }

  // Brightness: select a brightness curve from the input brightness.
  CGFloat brightness;

  // Limit brightness to observed values.
  hsb[2] = Clamp(hsb[2], kBrightness500Min, kBrightness500Max);
  t = InvLerp(hsb[2], kBrightness500Min, kBrightness500Max);

  // The tints 50-500 are nice and linear.
  if (tint <= kQTMColorTint500) {
    CGFloat brightness50 = Lerp(t, kBrightness50Min, kBrightness50Max);
    CGFloat u = InvLerp(tint, kQTMColorTint50, kQTMColorTint500);
    brightness = Lerp(u, brightness50, hsb[2]);

    // The tints > 500 fall off roughly quadratically.
  } else {
    CGFloat u = tint - kQTMColorTint500;
    brightness = hsb[2] + kBrightnessQuadracticCoeff * u * u + kBrightnessLinearCoeff * u;
  }

  return [UIColor colorWithHue:hsb[0] saturation:saturation brightness:brightness alpha:1];
}
