/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTextInputControllerTextFieldBox.h"

#import "private/MDCTextInputControllerDefault+Subclassing.h"

#import "MaterialMath.h"

/**
 Note: Right now this is a subclass of MDCTextInputControllerDefault since they share a vast
 majority of code. If the designs diverge further, this would make a good candidate for its own
 class.
 */

#pragma mark - Constants

static const CGFloat MDCTextInputTextFieldBoxFullPadding = 8.f;
static const CGFloat MDCTextInputTextFieldBoxHalfPadding = 8.f;
static const CGFloat MDCTextInputTextFieldBoxNormalPlaceholderPadding = 20.f;

static inline UIColor *MDCTextInputDefaultBorderFillColorDefault() {
  return [UIColor colorWithWhite:0 alpha:.06f];
}

#pragma mark - Class Properties

static UIColor *_borderFillColorDefault;

static UIRectCorner _cornersRoundedDefault = UIRectCornerAllCorners;

@interface MDCTextInputControllerTextFieldBox()

@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;

@end

@implementation MDCTextInputControllerTextFieldBox

#pragma mark - Properties Implementations

+ (UIColor *)borderFillColorDefault {
  if (!_borderFillColorDefault) {
    _borderFillColorDefault = MDCTextInputDefaultBorderFillColorDefault();
  }
  return _borderFillColorDefault;
}

+ (UIRectCorner)cornersRoundedDefault {
  return _cornersRoundedDefault;
}

+ (void)setCornersRoundedDefault:(UIRectCorner)cornersRoundedDefault {
  _cornersRoundedDefault = cornersRoundedDefault;
}

#pragma mark - MDCTextInputPositioningDelegate

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];
  if (self.isFloatingEnabled) {
    textInsets.top = MDCTextInputTextFieldBoxHalfPadding + MDCRint(self.textInput.placeholderLabel.font.lineHeight *
                                                                   (CGFloat)self.floatingPlaceholderScale.floatValue) + MDCTextInputTextFieldBoxHalfPadding;
  } else {
    textInsets.top = MDCTextInputTextFieldBoxNormalPlaceholderPadding;
  }

  // The amount of space underneath the underline depends on whether there is content in the
  // underline labels.
  CGFloat underlineLabelsOffset = 0;
  if (self.textInput.leadingUnderlineLabel.text.length) {
    underlineLabelsOffset =
    MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * 2.f) / 2.f;
  }
  if (self.textInput.trailingUnderlineLabel.text.length || self.characterCountMax) {
    underlineLabelsOffset =
    MAX(underlineLabelsOffset,
        MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * 2.f) / 2.f);
  }

  CGFloat underlineOffset = underlineLabelsOffset;

  if (!MDCCGFloatEqual(underlineLabelsOffset, 0)) {
    underlineOffset += MDCTextInputTextFieldBoxHalfPadding;
  }

  if (self.isFloatingEnabled) {
    underlineOffset += MDCTextInputTextFieldBoxHalfPadding;
  } else {
    underlineOffset += MDCTextInputTextFieldBoxNormalPlaceholderPadding;
  }

  // .bottom = underlineOffset + the half padding above the line but below the text field and any
  // space needed for the labels and / or line.
  // Legacy has an additional half padding here but this version does not.
  textInsets.bottom = underlineOffset;
  textInsets.left = MDCTextInputTextFieldBoxFullPadding;
  textInsets.right = MDCTextInputTextFieldBoxHalfPadding;

  return textInsets;
}

#pragma mark - Layout

- (void)updateLayout {
  if (!self.textInput) {
    return;
  }

  [super updateLayout];
}

- (void)updatePlaceholder {
  if (!self.placeholderTop) {
    self.placeholderTop = [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.textInput
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1
                                                        constant:MDCTextInputTextFieldBoxNormalPlaceholderPadding];
    self.placeholderTop.priority = UILayoutPriorityDefaultHigh;
    self.placeholderTop.active = YES;
  }
}

@end
