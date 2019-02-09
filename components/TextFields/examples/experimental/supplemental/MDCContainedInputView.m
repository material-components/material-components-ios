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

#import "MDCContainedInputView.h"

@implementation MDCContainedInputViewColorScheme

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCContainedInputViewColorSchemeInit];
  }
  return self;
}

- (void)commonMDCContainedInputViewColorSchemeInit {
  UIColor *textColor = [UIColor blackColor];
  UIColor *underlineLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *placeholderLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *errorColor = [UIColor redColor];
  UIColor *clearButtonTintColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.20];
  self.textColor = textColor;
  self.underlineLabelColor = underlineLabelColor;
  self.placeholderLabelColor = placeholderLabelColor;
  self.clearButtonTintColor = clearButtonTintColor;
  self.errorColor = errorColor;
}

@end

@implementation MDCContainerStyleBase

- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state {
  MDCContainedInputViewColorScheme *colorScheme = [[MDCContainedInputViewColorScheme alloc] init];

  UIColor *placeholderLabelColor = colorScheme.placeholderLabelColor;
  UIColor *underlineLabelColor = colorScheme.underlineLabelColor;
  UIColor *textColor = colorScheme.underlineLabelColor;

  switch (state) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      placeholderLabelColor = [placeholderLabelColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateErrored:
      textColor = colorScheme.errorColor;
      underlineLabelColor = colorScheme.errorColor;
      placeholderLabelColor = colorScheme.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      placeholderLabelColor = [UIColor blackColor];
      break;
    default:
      break;
  }

  colorScheme.textColor = textColor;
  colorScheme.underlineLabelColor = underlineLabelColor;
  colorScheme.placeholderLabelColor = placeholderLabelColor;

  return colorScheme;
}

- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)inputView
    withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme {
}

- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView {
}

- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight {
  return 10;
}

- (CGFloat)textAreaTopPaddingWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY
                                          textAreaHeight:(CGFloat)textAreaHeight {
  return floatingPlaceholderMaxY + 10;
}

- (CGFloat)normalTextAreaTopPaddingWithTextAreaHeight:(CGFloat)textAreaHeight {
  return [self verticalPaddingWithTextAreaHeight:textAreaHeight];
}

- (CGFloat)normalTextAreaBottomPaddingWithTextAreaHeight:(CGFloat)textAreaHeight {
  return [self verticalPaddingWithTextAreaHeight:textAreaHeight];
}

- (CGFloat)floatingPlaceholderFontSizeScaleFactor {
  return (CGFloat)0.33;
}

- (CGFloat)verticalPaddingWithTextAreaHeight:(CGFloat)textAreaHeight {
  return (((CGFloat)textAreaHeight * (CGFloat)3) * (CGFloat)(0.5)) -
         ((CGFloat)textAreaHeight * (CGFloat)0.5);
}












- (MDCContainedInputViewState)containedInputViewStateWithIsEnabled:(BOOL)isEnabled
                                                         isErrored:(BOOL)isErrored
                                                         isEditing:(BOOL)isEditing
                                                        isSelected:(BOOL)isSelected
                                                       isActivated:(BOOL)isActivated {
  if (isEnabled) {
    if (isErrored) {
      return MDCContainedInputViewStateErrored;
    } else {
      if (isEditing) {
        return MDCContainedInputViewStateFocused;
      } else {
        if (isSelected || isActivated) {
          return MDCContainedInputViewStateActivated;
        } else {
          return MDCContainedInputViewStateNormal;
        }
      }
    }
  } else {
    return MDCContainedInputViewStateDisabled;
  }
}

- (MDCContainedInputViewPlaceholderState)placeholderStateWithPlaceholder:(NSString *)placeholder
                                                                    text:(NSString *)text
                                                     canPlaceholderFloat:(BOOL)canPlaceholderFloat
                                                               isEditing:(BOOL)isEditing {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;
  if (hasPlaceholder) {
    if (canPlaceholderFloat) {
      if (isEditing) {
        return MDCContainedInputViewPlaceholderStateFloating;
      } else {
        if (hasText) {
          return MDCContainedInputViewPlaceholderStateFloating;
        } else {
          return MDCContainedInputViewPlaceholderStateNormal;
        }
      }
    } else {
      if (hasText) {
        return MDCContainedInputViewPlaceholderStateNone;
      } else {
        return MDCContainedInputViewPlaceholderStateNormal;
      }
    }
  } else {
    return MDCContainedInputViewPlaceholderStateNone;
  }
}





@end
