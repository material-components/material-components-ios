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

#import "MDFColorCalculations.h"

/**
 The number of iterations required to find the minimum acceptable alpha is
 ceil(log2(1/kMinAlphaSearchPrecision)), or 7 for a precision of 0.01. If you adjust the precision
 then also adjust the max iterations, which is used as a safety check.
 */
static const CGFloat kMinAlphaSearchPrecision = 0.01f;
static const NSUInteger kMinAlphaSearchMaxIterations = 10;

/** Returns value raised to exponent. */
static inline CGFloat MDFPow(CGFloat value, CGFloat exponent) {
#if CGFLOAT_IS_DOUBLE
  return pow(value, exponent);
#else
  return powf(value, exponent);
#endif
}

/**
 Calculate a linear RGB component from a sRGB component for calculating luminance.
 @see http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
 */
static inline CGFloat LinearRGBComponent(CGFloat component) {
  if (component <= 0.03928f) {
    return component / 12.92f;
  } else {
    return MDFPow(((component + 0.055f) / 1.055f), 2.4f);
  }
}

/**
 Blend a foreground color with alpha on a opaque background color.
 @note The background color must be opaque for this to be valid.
 @see http://en.wikipedia.org/wiki/Alpha_compositing
 */
static inline void BlendColorOnOpaqueBackground(const CGFloat *foregroundColor,
                                                const CGFloat *backgroundColor,
                                                CGFloat *blendedColor) {
  for (int i = 0; i < 3; ++i) {
    blendedColor[i] =
        foregroundColor[i] * foregroundColor[3] + backgroundColor[i] * (1 - foregroundColor[3]);
  }
  blendedColor[3] = 1.0f;
}

static inline CGFloat ContrastRatioOfRGBComponents(const CGFloat *firstComponents,
                                                   const CGFloat *secondComponents) {
  CGFloat firstLuminance = MDFRelativeLuminanceOfRGBComponents(firstComponents);
  CGFloat secondLuminance = MDFRelativeLuminanceOfRGBComponents(secondComponents);

  if (secondLuminance > firstLuminance) {
    CGFloat temp = firstLuminance;
    firstLuminance = secondLuminance;
    secondLuminance = temp;
  }

  return (firstLuminance + 0.05f) / (secondLuminance + 0.05f);
}

CGFloat MDFContrastRatioOfRGBAComponents(const CGFloat *foregroundColorComponents,
                                         const CGFloat *backgroundColorComponents) {
  CGFloat blendedColor[4];
  BlendColorOnOpaqueBackground(foregroundColorComponents, backgroundColorComponents, blendedColor);
  return ContrastRatioOfRGBComponents(blendedColor, backgroundColorComponents);
}

void MDFCopyRGBAComponents(CGColorRef color, CGFloat *rgbaComponents) {
  CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace(color));
  if (!(colorSpaceModel == kCGColorSpaceModelRGB ||
        colorSpaceModel == kCGColorSpaceModelMonochrome)) {
    NSCAssert(NO, @"Can't compute luminance for non-RGB color space model %i.", colorSpaceModel);
    for (int i = 0; i < 4; ++i) {
      rgbaComponents[i] = 0;
    }
    return;
  }

  size_t numComponents = CGColorGetNumberOfComponents(color);
  const CGFloat *components = CGColorGetComponents(color);
  switch (numComponents) {
    // Greyscale + alpha
    case 2:
      for (int i = 0; i < 3; ++i) {
        rgbaComponents[i] = components[0];
      }
      rgbaComponents[3] = components[1];
      break;

    // RGB + alpha
    case 4:
      for (int i = 0; i < 4; ++i) {
        rgbaComponents[i] = components[i];
      }
      break;

    default:
      NSCAssert(NO, @"Unexpected number of color components: %zu.", numComponents);
  }
}

CGFloat MDFRelativeLuminanceOfRGBComponents(const CGFloat *components) {
  CGFloat linearRGB[3];
  for (int i = 0; i < 3; ++i) {
    linearRGB[i] = LinearRGBComponent(components[i]);
  }
  return 0.2126f * linearRGB[0] + 0.7152f * linearRGB[1] + 0.0722f * linearRGB[2];
}

CGFloat MDFMinAlphaOfColorOnBackgroundColor(UIColor *color,
                                            UIColor *backgroundColor,
                                            CGFloat minContrastRatio) {
  CGFloat colorComponents[4];
  CGFloat backgroundColorComponents[4];
  MDFCopyRGBAComponents(color.CGColor, colorComponents);
  MDFCopyRGBAComponents(backgroundColor.CGColor, backgroundColorComponents);

  NSCAssert(backgroundColorComponents[3] == 1,
            @"Background color %@ must be opaque for a valid contrast ratio calculation.",
            backgroundColor);
  backgroundColorComponents[3] = 1;

  NSCAssert(minContrastRatio > 0, @"Invalid min contrast ratio %g.", (double)minContrastRatio);
  CGFloat minAlpha = 0;
  CGFloat maxAlpha = 1;

#if DEBUG && !defined(NS_BLOCK_ASSERTIONS)
  colorComponents[3] = minAlpha;
  CGFloat minAlphaRatio =
      MDFContrastRatioOfRGBAComponents(colorComponents, backgroundColorComponents);
  NSCAssert(minAlphaRatio < minContrastRatio, @"Transparent color cannot be a valid color.");
#endif  // !defined(NS_BLOCK_ASSERTIONS)

  // maxAlphaRatio is the best contrast ratio we can acheive by modifying the alpha of this color.
  // If it's not good enough, then return now and inform the caller.
  colorComponents[3] = maxAlpha;
  CGFloat maxAlphaRatio =
      MDFContrastRatioOfRGBAComponents(colorComponents, backgroundColorComponents);
  if (maxAlphaRatio < minContrastRatio) {
    return -1;
  }

  // Classic binary search of a range.
  NSUInteger numIterations = 0;
  while (numIterations <= kMinAlphaSearchMaxIterations &&
         (maxAlpha - minAlpha) > kMinAlphaSearchPrecision) {
    CGFloat testAlpha = (minAlpha + maxAlpha) / 2;
    colorComponents[3] = testAlpha;
    CGFloat testRatio =
        MDFContrastRatioOfRGBAComponents(colorComponents, backgroundColorComponents);

    if (testRatio < minContrastRatio) {
      minAlpha = testAlpha;
    } else {
      maxAlpha = testAlpha;
    }

    ++numIterations;
  }

  if (numIterations > kMinAlphaSearchMaxIterations) {
    NSCAssert(NO, @"Too many iterations (%i) while finding min alpha of text color %@ on %@.",
              (int)numIterations, color, backgroundColor);
    return -1;
  }

  // Conservatively return the max of the range of possible alphas, which is known to pass.
  return maxAlpha;
}
