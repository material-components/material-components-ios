// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "InputChipViewColorSchemeAdapter.h"

//#import <MDFInternationalization/MDFInternationalization.h>
//#import <MaterialComponents/MDCMath.h>
//#import "MDCInputViewContainerStyler.h"
//#import "SimpleTextFieldLayout.h"
//#import "SimpleTextFieldLayoutUtils.h"

#import <Foundation/Foundation.h>

@implementation InputChipViewColorSchemeAdapter

- (instancetype)initWithColorScheme:(MDCSemanticColorScheme *)colorScheme {
//                     textFieldState:(TextFieldState)textFieldState {
  self = [super init];
  if (self) {
    [self assignPropertiesWithColorScheme:colorScheme];
//                           textFieldState:textFieldState];
  }
  return self;
}

- (void)assignPropertiesWithColorScheme:(MDCSemanticColorScheme *)colorScheme {
//                         textFieldState:(TextFieldState)textFieldState {
  UIColor *textColor = colorScheme.onSurfaceColor;
  UIColor *underlineLabelColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *placeholderLabelColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *outlineColor = colorScheme.onSurfaceColor;
  UIColor *filledSublayerUnderlineFillColor = colorScheme.onSurfaceColor;
  UIColor *filledSublayerFillColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.15];
  UIColor *clearButtonTintColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];

//  switch (textFieldState) {
//    case TextFieldStateNormal:
//      break;
//    case TextFieldStateActivated:
//      break;
//    case TextFieldStateDisabled:
//      placeholderLabelColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
//      break;
//    case TextFieldStateErrored:
//      placeholderLabelColor = colorScheme.errorColor;
//      underlineLabelColor = colorScheme.errorColor;
//      filledSublayerUnderlineFillColor = colorScheme.errorColor;
//      outlineColor = colorScheme.errorColor;
//      break;
//    case TextFieldStateFocused:
//      outlineColor = colorScheme.primaryColor;
//      placeholderLabelColor = colorScheme.primaryColor;
//      filledSublayerUnderlineFillColor = colorScheme.primaryColor;
//      break;
//    default:
//      break;
//  }

  outlineColor = colorScheme.primaryColor;
  placeholderLabelColor = colorScheme.primaryColor;
  filledSublayerUnderlineFillColor = colorScheme.primaryColor;

  self.textColor = textColor;
  self.filledSublayerFillColor = filledSublayerFillColor;
  self.filledSublayerUnderlineFillColor = filledSublayerUnderlineFillColor;
  self.underlineLabelColor = underlineLabelColor;
  self.outlineColor = outlineColor;
  self.placeholderLabelColor = placeholderLabelColor;
  self.clearButtonTintColor = clearButtonTintColor;
}

@end

