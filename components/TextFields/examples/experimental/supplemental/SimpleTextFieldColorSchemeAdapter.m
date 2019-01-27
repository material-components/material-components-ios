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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SimpleTextFieldColorSchemeAdapter.h"

@implementation SimpleTextFieldColorScheme

//+ (instancetype)defaultSimpleTextFieldColorScheme {
//  UIColor *onSurfaceColor = [UIColor blackColor];
//  UIColor *textColor = onSurfaceColor;
//  UIColor *underlineLabelColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
//  UIColor *placeholderLabelColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
//  UIColor *outlineColor = onSurfaceColor;
//  UIColor *filledSublayerUnderlineFillColor = onSurfaceColor;
//  UIColor *filledSublayerFillColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.15];
//  UIColor *clearButtonTintColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];
//
//  SimpleTextFieldColorScheme *simpleTextFieldColorScheme =
//  [[SimpleTextFieldColorScheme alloc] init];
//  simpleTextFieldColorScheme.textColor = textColor;
////  simpleTextFieldColorScheme.filledSublayerFillColor = filledSublayerFillColor;
////  simpleTextFieldColorScheme.filledSublayerUnderlineFillColor = filledSublayerUnderlineFillColor;
//  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
////  simpleTextFieldColorScheme.outlineColor = outlineColor;
//  simpleTextFieldColorScheme.placeholderLabelColor = placeholderLabelColor;
//  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
//  return simpleTextFieldColorScheme;
//}


//
//+ (instancetype)defaultSimpleTextFieldColorScheme {
//  UIColor *onSurfaceColor = [UIColor blackColor];
//  UIColor *textColor = onSurfaceColor;
//  UIColor *underlineLabelColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
//  UIColor *placeholderLabelColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
//  UIColor *outlineColor = onSurfaceColor;
//  UIColor *filledSublayerUnderlineFillColor = onSurfaceColor;
//  UIColor *filledSublayerFillColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.15];
//  UIColor *clearButtonTintColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];
//  
//  SimpleTextFieldColorScheme *simpleTextFieldColorScheme =
//  [[SimpleTextFieldColorScheme alloc] init];
//  simpleTextFieldColorScheme.textColor = textColor;
//  simpleTextFieldColorScheme.filledSublayerFillColor = filledSublayerFillColor;
//  simpleTextFieldColorScheme.filledSublayerUnderlineFillColor = filledSublayerUnderlineFillColor;
//  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
//  simpleTextFieldColorScheme.outlineColor = outlineColor;
//  simpleTextFieldColorScheme.placeholderLabelColor = placeholderLabelColor;
//  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
//  return simpleTextFieldColorScheme;
//}

//+ (instancetype)defaultSimpleTextFieldColorSchemeWithState:(TextFieldState)textFieldState {
//  SimpleTextFieldColorSchemeAdapter *scheme = [self defaultSimpleTextFieldColorScheme];
//  switch (textFieldState) {
//    case TextFieldStateNormal:
//      break;
//    case TextFieldStateActivated:
//      break;
//    case TextFieldStateDisabled:
//      scheme.placeholderLabelColor = [UIColor
//                                      blueColor];  //[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
//      break;
//    case TextFieldStateErrored:
//      scheme.placeholderLabelColor = [UIColor redColor];
//      scheme.underlineLabelColor = [UIColor redColor];
//      scheme.filledSublayerUnderlineFillColor = [UIColor redColor];
//      scheme.outlineColor = [UIColor redColor];
//      break;
//    case TextFieldStateFocused:
//      //      scheme.outlineColor = colorScheme.primaryColor;
//      //      scheme.placeholderLabelColor = colorScheme.primaryColor;
//      //      scheme.filledSublayerUnderlineFillColor = colorScheme.primaryColor;
//      break;
//    default:
//      break;
//  }
//  return scheme;
//}
//
@end

@implementation SimpleTextFieldColorSchemeFilled
@end

@implementation SimpleTextFieldColorSchemeOutlined
@end


@implementation SimpleTextFieldColorSchemeAdapter

+ (instancetype)defaultSimpleTextFieldColorScheme {
  UIColor *onSurfaceColor = [UIColor blackColor];
  UIColor *textColor = onSurfaceColor;
  UIColor *underlineLabelColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *placeholderLabelColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *outlineColor = onSurfaceColor;
  UIColor *filledSublayerUnderlineFillColor = onSurfaceColor;
  UIColor *filledSublayerFillColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.15];
  UIColor *clearButtonTintColor = [onSurfaceColor colorWithAlphaComponent:(CGFloat)0.20];

  SimpleTextFieldColorSchemeAdapter *simpleTextFieldColorScheme =
      [[SimpleTextFieldColorSchemeAdapter alloc] init];
  simpleTextFieldColorScheme.textColor = textColor;
  simpleTextFieldColorScheme.filledSublayerFillColor = filledSublayerFillColor;
  simpleTextFieldColorScheme.filledSublayerUnderlineFillColor = filledSublayerUnderlineFillColor;
  simpleTextFieldColorScheme.underlineLabelColor = underlineLabelColor;
  simpleTextFieldColorScheme.outlineColor = outlineColor;
  simpleTextFieldColorScheme.placeholderLabelColor = placeholderLabelColor;
  simpleTextFieldColorScheme.clearButtonTintColor = clearButtonTintColor;
  return simpleTextFieldColorScheme;
}

+ (instancetype)defaultSimpleTextFieldColorSchemeWithState:(TextFieldState)textFieldState {
  SimpleTextFieldColorSchemeAdapter *scheme = [self defaultSimpleTextFieldColorScheme];
  switch (textFieldState) {
    case TextFieldStateNormal:
      break;
    case TextFieldStateActivated:
      break;
    case TextFieldStateDisabled:
      scheme.placeholderLabelColor = [UIColor
          blueColor];  //[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case TextFieldStateErrored:
      scheme.placeholderLabelColor = [UIColor redColor];
      scheme.underlineLabelColor = [UIColor redColor];
      scheme.filledSublayerUnderlineFillColor = [UIColor redColor];
      scheme.outlineColor = [UIColor redColor];
      break;
    case TextFieldStateFocused:
      //      scheme.outlineColor = colorScheme.primaryColor;
      //      scheme.placeholderLabelColor = colorScheme.primaryColor;
      //      scheme.filledSublayerUnderlineFillColor = colorScheme.primaryColor;
      break;
    default:
      break;
  }
  return scheme;
}

@end
