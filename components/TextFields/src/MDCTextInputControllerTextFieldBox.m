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

static const CGFloat MDCTextInputTextFieldBoxFullPadding = 16.f;

// The guidelines have 8 points of padding but since the fonts on iOS are slightly smaller, we need
// to add points to keep the versions at the same height.
static const CGFloat MDCTextInputTextFieldBoxHalfPadding = 9.f;
static const CGFloat MDCTextInputTextFieldBoxNormalPlaceholderPadding = 20.f;

static inline UIColor *MDCTextInputDefaultBorderFillColorDefault() {
  return [UIColor colorWithWhite:0 alpha:.06f];
}

#pragma mark - Class Properties

static UIColor *_borderFillColorDefault;

static UIRectCorner _cornersRoundedDefault = UIRectCornerAllCorners;

@interface MDCTextInputControllerTextFieldBox()

@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *underlineY;

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

  // .bottom = underlineOffset + the half padding above the line but below the text field and any
  // space needed for the labels and / or line.
  // Legacy has an additional half padding here but this version does not.
  CGFloat underlineOffset = [self underlineOffset];
  textInsets.bottom = underlineOffset;
  textInsets.left = MDCTextInputTextFieldBoxFullPadding;
  textInsets.right = MDCTextInputTextFieldBoxHalfPadding;

  return textInsets;
}

#pragma mark - Layout

- (void)updatePlaceholder {
  [super updatePlaceholder];
  
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

  UIEdgeInsets textInsets = [self textInsets:UIEdgeInsetsZero];
  CGFloat underlineYConstant = textInsets.top + [self estimatedTextHeight] +
      [self beneathInputPadding];
  // When floating placeholders are turned off, the underline will drift up unless this is set. Even
  // tho it is redundant when floating is on, we just keep it on always for simplicity.
  // Note: This is an issue only on singleline text fields.
  if (![self.textInput isKindOfClass:[MDCMultilineTextField class]] && !self.underlineY) {
    self.underlineY = [NSLayoutConstraint constraintWithItem:self.textInput.underline
                                                   attribute:NSLayoutAttributeBottom
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.textInput
                                                   attribute:NSLayoutAttributeTop
                                                  multiplier:1
                                                    constant:underlineYConstant];
    self.underlineY.active = YES;
  }
  self.underlineY.constant = underlineYConstant;
}

// The measurement from bottom to underline center Y.
- (CGFloat)underlineOffset {
  // The amount of space underneath the underline depends on whether there is content in the
  // underline labels.
  CGFloat underlineLabelsOffset = 0;
  if (self.textInput.leadingUnderlineLabel.text.length) {
    underlineLabelsOffset =
    MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * 2.f) / 2.f;
  }
  if (self.textInput.trailingUnderlineLabel.text.length || self.characterCountMax) {
    underlineLabelsOffset = MAX(underlineLabelsOffset,
        MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * 2.f) / 2.f);
  }

  CGFloat underlineOffset = underlineLabelsOffset;
  underlineOffset += [self beneathInputPadding];

  if (!MDCCGFloatEqual(underlineLabelsOffset, 0)) {
    underlineOffset += MDCTextInputTextFieldBoxHalfPadding;
  }

  return underlineOffset;
}

- (CGFloat)estimatedTextHeight {
  CGFloat estimatedTextHeight = MDCCeil(self.textInput.font.lineHeight * 2.f) / 2.f;

  return estimatedTextHeight;
}

// The space above the underline but under the text input area.
- (CGFloat)beneathInputPadding {
  if (self.isFloatingEnabled) {
    return MDCTextInputTextFieldBoxHalfPadding;
  } else {
    return MDCTextInputTextFieldBoxNormalPlaceholderPadding;
  }
}

@end
