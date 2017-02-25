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

#import "MaterialTypography.h"

#import "MaterialPalettes.h"

static const CGFloat MDCTextInputUnderlineHeight = 1.f;
static const CGFloat MDCTextInputUnderlineVerticalPadding = 8.f;
static const CGFloat MDCTextInputFullWidthHorizontalPadding = 16.f;
static const NSTimeInterval MDCTextInputDividerOutAnimationDuration = 0.266666f;
static const CGFloat MDCTextInputHintTextOpacity = 0.54f;

static inline UIColor *MDCTextInputCursorColor() {
  return [MDCPalette indigoPalette].tint500;
}

static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

static inline UIColor *MDCTextInputInlinePlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}

static inline UIColor *MDCTextInputTextErrorColor() {
  // Material Design color palette red at tint 500.
  return [UIColor colorWithRed:211.0f / 255.0f
                         green:67.0f / 255.0f
                          blue:54.0f / 255.0f
                         alpha:[MDCTypography body1FontOpacity]];
}

static inline UIColor *MDCTextInputTextColor() {
  return [UIColor colorWithWhite:0 alpha:[MDCTypography body1FontOpacity]];
}

static inline CGFloat MDCCeil(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return ceil(value);
#else
  return ceilf(value);
#endif
}
