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

static const CGFloat MDCTextFieldBorderHeight = 1.f;
static const CGFloat MDCTextFieldBorderVerticalPadding = 8.f;
static const CGFloat MDCTextFieldFullWidthHorizontalPadding = 16.f;
static const NSTimeInterval MDCTextFieldDividerOutAnimationDuration = 0.266666f;
static const CGFloat MDCTextFieldHintTextOpacity = 0.54f;

static inline UIColor *MDCTextFieldBorderColor() {
  return [UIColor lightGrayColor];
}

static inline UIColor *MDCTextFieldPlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextFieldHintTextOpacity];
}

static inline UIColor *MDCTextFieldTextErrorColor() {
  // Material Design color palette red at tint 500.
  return [UIColor colorWithRed:211.0f / 255.0f
                         green:67.0f / 255.0f
                          blue:54.0f / 255.0f
                         alpha:[MDCTypography body1FontOpacity]];
}

static inline UIColor *MDCTextFieldTextColor() {
  return [UIColor colorWithWhite:0 alpha:[MDCTypography body1FontOpacity]];
}
